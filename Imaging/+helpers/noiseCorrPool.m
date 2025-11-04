function [traces,ALLCELLS,OTHERCELLS,SHUFFLE] = noiseCorrPool(CAIM,Df_f,DoPlot,numshuf)
% Choose animals
mouse = [6 8 10];
% Choose session
ses = 1;
% time window in s
T = 1;
% number of shuffles
% numshuf = 10;

ALLCELLS_corr = [];
ALLCELLS_corr_val = [];
ALLCELLS_Noise_corr = [];
ALLCELLS_Noise_corr_val = [];
ALLCELLS_Signal_corr = [];
ALLCELLS_Noise_Signal_corr = [];
ALLCELLS_Mean_corr = [];
ALLCELLS_Mean_corr_val = [];
mean_MPP = [];
mean_epochGC = [];
mean_MPP_noise = [];
mean_epochGC_noise = [];

SHUFFLE_corr = [];
SHUFFLE_corr_val = [];
SHUFFLE_Noise_corr = [];
SHUFFLE_Noise_corr_val = [];
mean_MPP_shuf = [];
mean_epochGC_shuf = [];

OTHERCELLS_corr = [];
OTHERCELLS_corr_val = [];
OTHERCELLS_Noise_corr = [];
OTHERCELLS_Noise_corr_val = [];
OTHERCELLS_Signal_corr = [];
OTHERCELLS_Noise_Signal_corr = [];
OTHERCELLS_Mean_corr = [];
OTHERCELLS_Mean_corr_val = [];
mean_otherGC = [];

for i = 1:length(mouse)
    % read out timestamps  
    dt = CAIM(ses,mouse(i)).behave.tsscn';  % 5 sess, 10 mice, dt is vector of time
%     % read out GC Df/f traces cell x time (in frames)
%     GCtr = CAIM(ses,mouse(i)).Y;
%     % read out baselines
%     GCbaseline = CAIM(ses,mouse(i)).Df;
    % transfer traces to Df/f
%     GCtr = GCtr./GCbaseline;
    % Use df/f traces
    GCtr = Df_f{1,mouse(i)};
    % binary traces of the events:
    % GCbin = CAIM(ses,mouse(i)).S;
    GCbin = CAIM(ses,mouse(i)).Sraw;
    AmpShift = 4;
    GCbin = GCbin.*[GCtr(:,AmpShift+1:end) GCtr(:,1:AmpShift)];
    GCbin = GCtr;
    % GCbin = Events{ses,mouse(i)};
%     GCbin(isnan(GCbin))= 0;
%     GCbin(GCbin<1) = 0;

%     % read out MPP bulk trace (The first entry is the Df/F. The other entries in that matrix are highpass,
%     % bandpass and lowpass filtered)
%     IND = 1; % the others are  different filtered versions of the imaged. 
%     MPPbulk = CAIM(ses,mouse(i)).bulk.trace(:,IND)';
    MPPbulk = CAIM(ses,mouse(i)).bulk.decon.Y';
    MPPbin = CAIM(ses,mouse(i)).bulk.decon.S';
    MPPbin = MPPbulk;
%     MPPbin(MPPbin>0) = 1;

    % Airpuff times (Logical)
    APtime = CAIM(ses,mouse(i)).airpuff.stimon;
    
    % Significantly responding cells
    isAp = false(size(GCbin,1),1);
    isAp(CAIM(ses,mouse(i)).airpuff.cellID(:,1)) = true;
%     isAp = ~isAp;
    % Chosse the signal thats to be used as input and output
    in = MPPbin;
    out = GCbin(isAp,:);

    [CorrOut,MPPout,GCout,MPPoutNoise,GCoutNoise,dtt,lagnoise] = helpers.noiseCorr(in,out,APtime,dt,T,0);
    
    ALLCELLS_corr = [ALLCELLS_corr;CorrOut.Corr];
    ALLCELLS_corr_val = [ALLCELLS_corr_val; CorrOut.CorrVal'];
    ALLCELLS_Noise_corr = [ALLCELLS_Noise_corr;CorrOut.NoiseCorr];
    ALLCELLS_Noise_corr_val = [ALLCELLS_Noise_corr_val; CorrOut.NoiseCorrVal'];
    ALLCELLS_Signal_corr = [ALLCELLS_Signal_corr;CorrOut.SignalCorr];
    ALLCELLS_Noise_Signal_corr = [ALLCELLS_Noise_Signal_corr;CorrOut.SignalNoiseCorr];
    ALLCELLS_Mean_corr = [ALLCELLS_Mean_corr;CorrOut.Mean_Corr];
    ALLCELLS_Mean_corr_val = [ALLCELLS_Mean_corr_val;CorrOut.Mean_Corr_val];
    mean_MPP = [mean_MPP;MPPout];
    mean_epochGC = [mean_epochGC;GCout];
    mean_MPP_noise = [mean_MPP_noise;MPPoutNoise];
    mean_epochGC_noise = [mean_epochGC_noise;GCoutNoise];

    % Shuffle
    corr_shuff = [];
    corr_val_shuff = [];
    noise_corr_shuff = [];
    noise_corr_val_shuff = [];
    MPP_shuff = [];
    GC_shuff = [];
    for j = 1:numshuf
        shift = round(rand * length(APtime));
        APshuf = APtime;%[APtime(shift+1:end); APtime(1:shift)];%
        inshuf = [in(shift+1:end); in(1:shift)];%in;%
        [ShuffleOut,mean_shuf_epochMPP,ALLCELLS_mean_shuf_epochGC,~,~] = helpers.noiseCorr(inshuf,out,APshuf,dt,T,0);
        corr_shuff = cat(3,corr_shuff, ShuffleOut.Corr);
        corr_val_shuff = [corr_val_shuff ShuffleOut.CorrVal'];
        noise_corr_shuff = cat(3,noise_corr_shuff, ShuffleOut.NoiseCorr);
        noise_corr_val_shuff = [noise_corr_val_shuff ShuffleOut.NoiseCorrVal'];
        MPP_shuff = [MPP_shuff;mean_shuf_epochMPP];
        GC_shuff = [GC_shuff;ALLCELLS_mean_shuf_epochGC];
    end
    
    SHUFFLE_corr = cat(1,SHUFFLE_corr,corr_shuff);
    SHUFFLE_corr_val = [SHUFFLE_corr_val; corr_val_shuff];
    SHUFFLE_Noise_corr = cat(1,SHUFFLE_Noise_corr,noise_corr_shuff);
    SHUFFLE_Noise_corr_val =  [SHUFFLE_Noise_corr_val; noise_corr_val_shuff];

    mean_MPP_shuf = [mean_MPP_shuf;MPP_shuff];
    mean_epochGC_shuf = [mean_epochGC_shuf;GC_shuff];
    
    % Analysis for non-responder
    out = GCbin(~isAp,:);
    [CorrOut,MPPout,GCout,MPPoutNoise,GCoutNoise,~,~] = helpers.noiseCorr(in,out,APtime,dt,T,0);
    OTHERCELLS_corr = [OTHERCELLS_corr;CorrOut.Corr];
    OTHERCELLS_corr_val = [OTHERCELLS_corr_val; CorrOut.CorrVal'];
    OTHERCELLS_Noise_corr = [OTHERCELLS_Noise_corr;CorrOut.NoiseCorr];
    OTHERCELLS_Noise_corr_val = [OTHERCELLS_Noise_corr_val; CorrOut.NoiseCorrVal'];
    OTHERCELLS_Signal_corr = [OTHERCELLS_Signal_corr;CorrOut.SignalCorr];
    OTHERCELLS_Noise_Signal_corr = [OTHERCELLS_Noise_Signal_corr;CorrOut.SignalNoiseCorr];
    OTHERCELLS_Mean_corr = [OTHERCELLS_Mean_corr;CorrOut.Mean_Corr];
    OTHERCELLS_Mean_corr_val = [OTHERCELLS_Mean_corr_val;CorrOut.Mean_Corr_val];
    mean_otherGC = [mean_otherGC;GCout];

%     x = [0:1:length(mean_All_epochMPP)-1]*dtt-T;
%     XLim = [-1 1];
%     figure
%     subplot(3,1,1);
%     plot(x,(mean_All_epochMPP),'r', 'linewidth',2);
%     hold on;
%     plot(x,mean(ALLCELLS_mean_All_epochGC,1),'g', 'linewidth',2);
%     title('MPP mean AP response')
%     xlabel('Time(S)')
%     xlim(XLim)
% 
%     subplot(3,1,2);
%     hold on;
%     plot(x,(ALLCELLS_mean_All_epochGC));
%     plot(x,mean(ALLCELLS_mean_All_epochGC,1),'g', 'linewidth',2);
%     plot(x,mean(GC_shuff,1),'k', 'linewidth',2);
%     title('GCs mean AP response')
%     xlabel('Time(S)')
%     xlim(XLim)
% 
%     subplot(3,1,3);
%     hold on
%     plot(lagnoise*dtt,ALLCELLS_now_corr)
%     plot(lagnoise*dtt,nanmean(ALLCELLS_now_corr,1),'c', 'linewidth',2)
%     plot(lagnoise*dtt,nanmean(corr_shuff,1),'k', 'linewidth',2)
%     title('Noise correlatoion')
%     xlabel('Lag (S), relative to MPP, peak at negative time indicates that GCs are lagging')
%     xlim(XLim)
end

%% Output variables


traces = struct;
traces.mean_MPP = mean_MPP;
traces.mean_epochGC = mean_epochGC;
traces.mean_MPP_noise = mean_MPP_noise;
traces.mean_epochGC_noise = mean_epochGC_noise;
traces.mean_otherGC = mean_otherGC;
traces.dtt = dtt;
traces.T = T;
traces.x = [0:1:length(MPPout)-1]*dtt-T;
traces.lagnoise = lagnoise;

ALLCELLS = struct;
ALLCELLS.corr =ALLCELLS_corr;
ALLCELLS.corr_val = ALLCELLS_corr_val;
ALLCELLS.Noise_corr = ALLCELLS_Noise_corr;
ALLCELLS.Noise_corr_val = ALLCELLS_Noise_corr_val;
ALLCELLS.Signal_corr = ALLCELLS_Signal_corr;
ALLCELLS.Noise_Signal_corr = ALLCELLS_Noise_Signal_corr;
ALLCELLS.ALLCELLS_Mean_corr = ALLCELLS_Mean_corr;
ALLCELLS.ALLCELLS_Mean_corr_val = ALLCELLS_Mean_corr_val;

OTHERCELLS = struct;
OTHERCELLS.corr = OTHERCELLS_corr;
OTHERCELLS.corr_val = OTHERCELLS_corr_val;
OTHERCELLS.Noise_corr = OTHERCELLS_Noise_corr;
OTHERCELLS.Noise_corr_val = OTHERCELLS_Noise_corr_val;
OTHERCELLS.Signal_corr = OTHERCELLS_Signal_corr;
OTHERCELLS.Noise_Signal_corr = OTHERCELLS_Noise_Signal_corr;
OTHERCELLS.ALLCELLS_Mean_corr = OTHERCELLS_Mean_corr;
OTHERCELLS.ALLCELLS_Mean_corr_val = OTHERCELLS_Mean_corr_val;

SHUFFLE.corr = SHUFFLE_corr;
SHUFFLE.corr_val = SHUFFLE_corr_val;
SHUFFLE.Noise_corr = SHUFFLE_Noise_corr;
SHUFFLE.Noise_corr_val = SHUFFLE_Noise_corr_val;
SHUFFLE.mean_MPP_shuf = mean_MPP_shuf;
SHUFFLE.mean_epochGC_shuf = mean_epochGC_shuf;
%%
if DoPlot == 1
    XLim = [-1 1];
    x = [0:1:length(MPPout)-1]*dtt-T;
    
    figure('color',[1 1 1],...
        'renderer','painters',...   
        'Units','centimeters',...
        'position',[3 4 50 20],...
        'PaperUnits','centimeters',...
        'PaperSize',[50 20],...
        'visible','on')
    
    %%%
    subplot(2,6,1);
    hold on
    % plot(x,mean_MPP)
    
    % y = mean(mean_MPP_shuf,1);
    % yerr = nanstd(mean_MPP_shuf,1)/sqrt(size(mean_MPP,1));
    % plot(x,y,'k', 'linewidth',2);
    % fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    % title('MPP mean AP response')
    % xlabel('time(s)')
    % xlim(XLim)
    
    y = nanmean(mean_epochGC,1);
    yerr = nanstd(mean_epochGC,1)/sqrt(size(mean_epochGC,1));
    plot(x,y,'g', 'linewidth',2);
    fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[0 1 0],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    y = nanmean(mean_otherGC,1);
    yerr = nanstd(mean_otherGC,1)/sqrt(size(mean_otherGC,1));
    plot(x,y,'color',[0 1 1], 'linewidth',2);
    fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[0 1 1],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    
    y = mean(mean_MPP,1);
    yerr = nanstd(mean_MPP,1)/sqrt(size(mean_MPP,1));
    plot(x,y,'r', 'linewidth',2);
    fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[1 0 0],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    % y = mean(mean_epochGC_shuf,1);
    % yerr = nanstd(mean_epochGC_shuf,1)/sqrt(size(mean_epochGC,1));
    % plot(x,y,'k', 'linewidth',2);
    % fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    
    legend({'responding GCs','','other GCs','','MPP'},'Location','northwest')
    legend('boxoff')
    
    title('Mean responses after AP')
    xlabel('time(s)')
    xlim(XLim)
    
    %%%
    subplot(2,6,2);
    hold on
    % y = nanmean(ALLCELLS_corr_shuf,1);
    % yerr = nanstd(ALLCELLS_corr_shuf,1)/sqrt(size(ALLCELLS_corr,1));
    % fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    % plot(lagnoise*dtt,y,'k','linewidth',2);
    
    
    y = nanmean(ALLCELLS_corr,1);
    yerr = nanstd(ALLCELLS_corr,1)/sqrt(size(ALLCELLS_corr,1));
    plot(lagnoise*dtt,y,'c', 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    y = nanmean(OTHERCELLS_corr,1);
    yerr = nanstd(OTHERCELLS_corr,1)/sqrt(size(OTHERCELLS_corr,1));
    plot(lagnoise*dtt,y,'color',[1 0 1], 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    legend({'responding GCs','','other GCs'},'Location','northwest')
    legend('boxoff')
    
    title('Cross correlation')
    xlabel('Lag (s)')
    xlim(XLim)
    
    %%%
    subplot(2,6,3);
    
    ALLCELLS_sort = ALLCELLS_corr(:,:);
    % ALLCELLS_sort = ALLCELLS_sort(~isnan(ALLCELLS_sort(:,1)),:);
    % ALLCELLS_sort = ALLCELLS_sort(sum(ALLCELLS_sort,2)>0,:);
    [tempMax,tempMaxPos] = max(ALLCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    ALLCELLS_sort = ALLCELLS_sort(temp,:);
    
    OTHERCELLS_sort = OTHERCELLS_corr(:,:);
    OTHERCELLS_sort = OTHERCELLS_sort(~isnan(OTHERCELLS_sort(:,1)),:);
    [tempMax,tempMaxPos] = max(OTHERCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    OTHERCELLS_sort = OTHERCELLS_sort(temp,:);
    
    ALLCELLS_sort = [ALLCELLS_sort;OTHERCELLS_sort];
    
    imagesc(lagnoise*dtt,1:size(ALLCELLS_sort,1),ALLCELLS_sort)
    xlim(XLim)
    title('Individual correlations')
    xlabel('Lag (s)')
    ylabel('cell ID')
    % colorbar()
    
    
    %%%
    subplot(2,6,4);
    hold on
    % y = nanmean(ALLCELLS_corr_shuf,1);
    % yerr = nanstd(ALLCELLS_corr_shuf,1)/sqrt(size(ALLCELLS_corr,1));
    % fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    % plot(lagnoise*dtt,y,'k','linewidth',2);
    
    
    y = nanmean(ALLCELLS_Signal_corr,1);
    yerr = nanstd(ALLCELLS_Signal_corr,1)/sqrt(size(ALLCELLS_Signal_corr,1));
    plot(lagnoise*dtt,y,'c', 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    y = nanmean(OTHERCELLS_Signal_corr,1);
    yerr = nanstd(OTHERCELLS_Signal_corr,1)/sqrt(size(OTHERCELLS_Signal_corr,1));
    plot(lagnoise*dtt,y,'color',[1 0 1], 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    legend({'responding GCs','','other GCs'},'Location','northwest')
    legend('boxoff')
    
    title('Signal correlation')
    xlabel('Lag (s)')
    xlim(XLim)
    
    %%%
    subplot(2,6,5);
    
    ALLCELLS_sort = ALLCELLS_Signal_corr(:,:);
    % ALLCELLS_sort = ALLCELLS_sort(~isnan(ALLCELLS_sort(:,1)),:);
    % ALLCELLS_sort = ALLCELLS_sort(sum(ALLCELLS_sort,2)>0,:);
    [tempMax,tempMaxPos] = max(ALLCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    ALLCELLS_sort = ALLCELLS_sort(temp,:);
    
    OTHERCELLS_sort = OTHERCELLS_Signal_corr(:,:);
    OTHERCELLS_sort = OTHERCELLS_sort(~isnan(OTHERCELLS_sort(:,1)),:);
    [tempMax,tempMaxPos] = max(OTHERCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    OTHERCELLS_sort = OTHERCELLS_sort(temp,:);
    
    ALLCELLS_sort = [ALLCELLS_sort;OTHERCELLS_sort];
    
    imagesc(lagnoise*dtt,1:size(ALLCELLS_sort,1),ALLCELLS_sort)
    xlim(XLim)
    xlabel('Lag (s)')
    ylabel('cell ID')
    title('Individiual signal correlations')
    
    %%%
    subplot(2,6,6);
    g = cell(length(ALLCELLS_corr_val),1);
    g(:) = {'responder'};
    g(end+1:end+length(OTHERCELLS_corr_val)) = {'non-responder'} ;
    boxplot([ALLCELLS_corr_val;OTHERCELLS_corr_val],g)
    title('Individiual correlations of response Amplitudes')
    ylabel('r-values')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(2,6,7);
    hold on
    
    y = nanmean(mean_epochGC_noise,1);
    yerr = nanstd(mean_epochGC_noise,1)/sqrt(size(mean_epochGC_noise,1));
    plot(x,y,'g', 'linewidth',2);
    fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[0 1 0],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    y = mean(mean_MPP_noise,1);
    yerr = nanstd(mean_MPP_noise,1)/sqrt(size(mean_MPP_noise,1));
    plot(x,y,'r', 'linewidth',2);
    fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[1 0 0],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    % y = mean(mean_MPP_shuf,1);
    % yerr = nanstd(mean_MPP_shuf,1)/sqrt(size(mean_MPP,1));
    % plot(x,y,'k', 'linewidth',2);
    % fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    % title('MPP mean AP response')
    % xlabel('time(s)')
    % xlim(XLim)
    
    % plot(x,(mean_epochGC));
    % y = nanmean(mean_otherGC,1);
    % yerr = nanstd(mean_otherGC,1)/sqrt(size(mean_otherGC,1));
    % plot(x,y,'color',[0 1 1], 'linewidth',2);
    % fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[0 1 1],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    
    
    % y = mean(mean_epochGC_shuf,1);
    % yerr = nanstd(mean_epochGC_shuf,1)/sqrt(size(mean_epochGC,1));
    % plot(x,y,'k', 'linewidth',2);
    % fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    
    legend({'responding GCs','','MPP'},'Location','northwest')
    legend('boxoff')
    
    title('Mean subtracted response')
    xlabel('time(s)')
    xlim(XLim)
    
    %%%
    subplot(2,6,8);
    hold on
    % y = nanmean(ALLCELLS_corr_shuf,1);
    % yerr = nanstd(ALLCELLS_corr_shuf,1)/sqrt(size(ALLCELLS_corr,1));
    % fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    % plot(lagnoise*dtt,y,'k','linewidth',2);
    
    
    y = nanmean(ALLCELLS_Noise_corr,1);
    yerr = nanstd(ALLCELLS_Noise_corr,1)/sqrt(size(ALLCELLS_Noise_corr,1));
    plot(lagnoise*dtt,y,'c', 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    y = nanmean(OTHERCELLS_Noise_corr,1);
    yerr = nanstd(OTHERCELLS_Noise_corr,1)/sqrt(size(OTHERCELLS_Noise_corr,1));
    plot(lagnoise*dtt,y,'color',[1 0 1], 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    legend({'responding GCs','','other GCs'},'Location','northwest')
    legend('boxoff')
    
    title('Noise correlation')
    xlabel('Lag (s)')
    xlim(XLim)
    
    %%%
    subplot(2,6,9);
    
    ALLCELLS_sort = ALLCELLS_Noise_corr(:,:);
    % ALLCELLS_sort = ALLCELLS_sort(~isnan(ALLCELLS_sort(:,1)),:);
    % ALLCELLS_sort = ALLCELLS_sort(sum(ALLCELLS_sort,2)>0,:);
    [tempMax,tempMaxPos] = max(ALLCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    ALLCELLS_sort = ALLCELLS_sort(temp,:);
    
    OTHERCELLS_sort = OTHERCELLS_Noise_corr(:,:);
    OTHERCELLS_sort = OTHERCELLS_sort(~isnan(OTHERCELLS_sort(:,1)),:);
    [tempMax,tempMaxPos] = max(OTHERCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    OTHERCELLS_sort = OTHERCELLS_sort(temp,:);
    
    ALLCELLS_sort = [ALLCELLS_sort;OTHERCELLS_sort];
    
    imagesc(lagnoise*dtt,1:size(ALLCELLS_sort,1),ALLCELLS_sort)
    xlim(XLim)
    title('Individual noise correlations')
    xlabel('Lag (s)')
    ylabel('cell ID')
    
    %%%
    subplot(2,6,10);
    hold on
    % y = nanmean(ALLCELLS_corr_shuf,1);
    % yerr = nanstd(ALLCELLS_corr_shuf,1)/sqrt(size(ALLCELLS_corr,1));
    % fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[.5 .5 .5],...
    %     'EdgeColor',[1 1 1],...
    %     'EdgeAlpha',0,...
    %     'FaceAlpha',.3)
    % plot(lagnoise*dtt,y,'k','linewidth',2);
    
    
    y = nanmean(ALLCELLS_Noise_Signal_corr,1);
    yerr = nanstd(ALLCELLS_Noise_Signal_corr,1)/sqrt(size(ALLCELLS_Noise_Signal_corr,1));
    plot(lagnoise*dtt,y,'c', 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    y = nanmean(OTHERCELLS_Noise_Signal_corr,1);
    yerr = nanstd(OTHERCELLS_Noise_Signal_corr,1)/sqrt(size(OTHERCELLS_Noise_Signal_corr,1));
    plot(lagnoise*dtt,y,'color',[1 0 1], 'linewidth',2)
    fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],[0 .5 .5],...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    legend({'responding GCs','','other GCs'},'Location','northwest')
    legend('boxoff')
    
    title('Noise (Signal) correlation')
    xlabel('Lag (s)')
    xlim(XLim)
    
    %%%
    subplot(2,6,11);
    
    ALLCELLS_sort = ALLCELLS_Noise_Signal_corr(:,:);
    % ALLCELLS_sort = ALLCELLS_sort(~isnan(ALLCELLS_sort(:,1)),:);
    % ALLCELLS_sort = ALLCELLS_sort(sum(ALLCELLS_sort,2)>0,:);
    [tempMax,tempMaxPos] = max(ALLCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    ALLCELLS_sort = ALLCELLS_sort(temp,:);
    
    OTHERCELLS_sort = OTHERCELLS_Noise_Signal_corr(:,:);
    OTHERCELLS_sort = OTHERCELLS_sort(~isnan(OTHERCELLS_sort(:,1)),:);
    [tempMax,tempMaxPos] = max(OTHERCELLS_sort(:,25:31),[],2);
    [~,temp] = sort(tempMax, 'descend');
    OTHERCELLS_sort = OTHERCELLS_sort(temp,:);
    
    ALLCELLS_sort = [ALLCELLS_sort;OTHERCELLS_sort];
    
    imagesc(lagnoise*dtt,1:size(ALLCELLS_sort,1),ALLCELLS_sort)
    xlim(XLim)
    xlabel('Lag (s)')
    ylabel('cell ID')
    title('Individual noise(signal) correlations')
    % colorbar()
    
    %%%
    subplot(2,6,12);
    g = cell(length(ALLCELLS_Noise_corr_val),1);
    g(:) = {'responder'};
    g(end+1:end+length(OTHERCELLS_Noise_corr_val)) = {'non-responder'} ;
    boxplot([ALLCELLS_corr_val;OTHERCELLS_Noise_corr_val],g)
    title('Individiual correlations of response Amplitudes')
    ylabel('r-values')
    
    %%%
    % print(gcf, '-dpdf', '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/noise correlation/noiseCorr.pdf); 
    % print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\noise correlation\NoiseSignalCorr.pdf')
end