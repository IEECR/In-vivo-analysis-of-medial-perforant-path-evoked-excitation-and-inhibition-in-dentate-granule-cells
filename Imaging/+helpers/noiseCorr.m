function [CorrOut,MPPout,GCout,MPPoutNoise,GCoutNoise,dtt,lagnoise] = noiseCorr(MPPtr,GCtr,APtime,dt,T,DoPlot)
%% analysis of noise correlations between each cell and the MPP signal 

% collect all AP events that have enough time before and after with width o
% of T time in sec. 

sCELL = size(GCtr);
Ncells = sCELL(1);

% define time constants
dtt = mean(diff(dt))/1000;
Ti = round(T/dtt);

% Intervall for reading out the response amplitude
mean_int = 10:15;

% Find AP indicies
APtime([1:Ti+4 end-Ti-4:end]) = 0;
APtime_indices = find(diff(APtime)==1);

% Read out MPP input
All_epochMPP = zeros(length(APtime_indices),2*Ti+1);
for kk = 1:length(APtime_indices)
    epochMPP = MPPtr(APtime_indices(kk)-Ti:APtime_indices(kk)+Ti);
    All_epochMPP(kk,:) = (epochMPP);
end

mean_All_epochMPP = mean(All_epochMPP,1);%./std(All_epochMPP(:));
epochMPP_forNoise = zeros(size(All_epochMPP));
meanIn = zeros(1,length(APtime_indices));
meanInNoise = zeros(1,length(APtime_indices));

for kk = 1:length(APtime_indices)
    % Calculate the mean corrected MPP input signal for noise corr
    epochMPP_forNoise(kk,:) = All_epochMPP(kk,:)-mean_All_epochMPP;
    epochMPP_forNoise(kk,:) = epochMPP_forNoise(kk,:)-mean(epochMPP_forNoise(kk,:));
    
    % Calculate the amplitude of the noise MPP signal after stim
    meanInNoise(kk) = mean(epochMPP_forNoise(kk,ceil(end/2)+mean_int));
    
    % Subtract the individual mean from raw input for normal xcorr later on
    All_epochMPP(kk,:) = All_epochMPP(kk,:) - mean(All_epochMPP(kk,:));
    
    % Calculate the amplitude of the raw MPP signal after stim
    meanIn(kk) = mean(All_epochMPP(kk,ceil(end/2)+mean_int));
end

MPPout = nanmean(All_epochMPP,1);
MPPoutNoise = nanmean(epochMPP_forNoise,1);

%% Loop through all cells to calculate noise correlations
GCout = zeros(Ncells,2*Ti+1);
GCoutNoise = zeros(Ncells,2*Ti+1);
CorrOut = struct();
meanOutNoise = zeros(Ncells,length(APtime_indices));
CorrVal = zeros(Ncells,1);

for ii = 1:Ncells  
%     Read out GC signal after AP
    All_epochGC= zeros(length(APtime_indices),2*Ti+1);
    for kk = 1:length(APtime_indices)
        epochGC = GCtr(ii,APtime_indices(kk)-Ti:APtime_indices(kk)+Ti);
        All_epochGC(kk,:) = (epochGC);
    end
    
    mean_All_epochGC = mean(All_epochGC,1);%./std(All_epochGC(:));
    epochGC_forNoise = zeros(size(All_epochGC));
    All_noise_corr = zeros(length(APtime_indices),4*Ti+1);
    All_corr = zeros(length(APtime_indices),4*Ti+1);
    for kk = 1:length(APtime_indices)
        % Calculate the the mean corrected GC signal for noise corr
        epochGC_forNoise(kk,:) = All_epochGC(kk,:)-mean_All_epochGC;
        epochGC_forNoise(kk,:) = epochGC_forNoise(kk,:)-mean(epochGC_forNoise(kk,:));
        
        % Calculate the noise correlation between the mean corrected MPP
        % input and the mean corrected GC signal
        [noise_corr,lagnoise] = xcorr(epochMPP_forNoise(kk,:),epochGC_forNoise(kk,:),'coeff');
        All_noise_corr(kk,:) = noise_corr;
        
        % Calculate the amplitude of the noise GC signal
        meanOutNoise(ii,kk) = mean(epochGC_forNoise(kk,ceil(end/2)+mean_int));

        % Substract the individual mean from GC input for normal xcorr
        All_epochGC(kk,:) = All_epochGC(kk,:) - mean(All_epochGC(kk,:));

        % Calculate the noise correlation between the mean corrected MPP
        % input and the mean corrected GC signal
        [now_corr,lagnoise] = xcorr(All_epochMPP(kk,:),All_epochGC(kk,:),'coeff');
        All_corr(kk,:) = now_corr;

        % Calculate the amplitude of the raw GC signal
        meanOut(ii,kk) = mean(All_epochGC(kk,ceil(end/2)+mean_int));
    end
    
    GCout(ii,:) = nanmean(All_epochGC,1);

    GCoutNoise(ii,:) = nanmean(epochGC_forNoise,1);
    
    CorrOut.Corr(ii,:)= nanmean(All_corr);
        
    CorrOut.NoiseCorr(ii,:)= nanmean(All_noise_corr);
    
    CorrOut.SignalCorr(ii,:) = xcorr(MPPout,GCout(ii,:) ,'coeff');

    CorrOut.SignalNoiseCorr(ii,:) = xcorr(MPPoutNoise,GCoutNoise(ii,:) ,'coeff');

    CorrOut.CorrVal(ii) = corr(MPPout',GCout(ii,:)');
    
    win = 16:21;
    y = mean(epochGC_forNoise(:,win),2);
    x = mean(epochMPP_forNoise(:,win),2);

    CorrOut.NoiseCorrVal(ii) = corr(x,y);

    if DoPlot == 1
        x = [1:1:length(MPPout)]*dtt-T;
        figure
        subplot(4,1,1);
        plot(lagnoise*dtt,nanmean(All_noise_corr));
        title('noise correlation, mean')
        subplot(4,1,2);
        plot(x,GCout(ii,:));
        title('GC signal, mean')
        subplot(4,1,3);
        plot(x,MPPout);
        title('MPP signal, mean')
        subplot(4,1,4);
        scatter(meanIn,meanOut(ii,:));
        title(['In against Out, r = ' num2str(CorrVal(ii))])
    end
end
CorrOut.Mean_Corr = xcorr(MPPout',mean(GCout,1)','coeff')';
CorrOut.Mean_Corr_val = corr(MPPout',mean(GCout,1)');
end
