function [CAIM,Shuf,GLM,INFO,ID,ROC] = APshuffle(CAIM,thresh_in,percentile,re_define,do_plot,do_save,shuf_crit,info_crit,glm_crit,thresh_crit,roc_crit,mouse_id,stim_id)
%%
if nargin < 13
    stim_id = 'airpuff';
end
mice        = [1:8 10];
numit       = 1000;
win         = -2*15:8*15;
respwin     = 0 : 14; 
thresh_out  = zeros(length(mice),1);
[~,~,RecValues] = helpers.qtf_response(CAIM,1,mice,1,mouse_id,stim_id);

ID = [];
ROC.ROC_resp = [];
ROC.auc = [];

Shuf.All = [];
Shuf.Resp = [];
Shuf.NResp = [];
Shuf.Pupil = [];
Shuf.Speed = [];
Shuf.Bulk = [];
Shuf.Fresp = [];


for j = 1 : length(mice)
    % Shuffling
    if strcmp(stim_id,'airpuff')
        stim = CAIM(1,mice(j)).airpuff;
    elseif strcmp(stim_id, 'runonset')
        stim = CAIM(1,mice(j)).runonset;
    end

    S = CAIM(1,mice(j)).S;
    numstim = length(stim.timepnt)/2;
    running = CAIM(1,mice(j)).behave.running;
    speed_in = CAIM(1,mice(j)).behave.speed;
    pupil_in = CAIM(1,mice(j)).behave.pupil(:,1);
    blink = CAIM(1,mice(j)).behave.pupil(:,4);
    pupil_in(blink==1) = nan;
    numcells = size(S,1);
    bulk_in = nan(size(speed_in));
    if ~isempty(CAIM(1,mice(j)).bulk)
        bulk_in = CAIM(1,mice(j)).bulk.trace(:,1);
    end
    
    % Adjust the threshold for minimal responded APS
    if thresh_in>0 && thresh_in<1
        thresh_out(j) = ceil(thresh_in*numstim);
    else
        thresh_out(j) = thresh_in;
    end

    AP  = diff(stim.stimon)==1;
    AP(end+1) = 0;
    stimNum = sum(AP);
    stimInd = find(AP);
    
    resp = false(numcells,numstim,length(win),numit);
    is_resp = false(numcells,numstim,numit);
    pupil = nan(numstim,length(win),numit);
    speed = nan(numstim,length(win),numit);
    bulk = nan(numstim,length(win),numit);
    
    APblock = AP;
    for i = 1:stimNum
        APblock(stimInd(i)+win) = 1;
    end
    APblock(running==1) = 1;
    APblock([1:abs(win(1)) end-(win(end)):end])= 1;

    parfor k = 1:numit        
        APtemp = APblock;
        APmock = zeros(1,stimNum);
        for i = 1:stimNum
            APmock(i) = randsample(find(APtemp==0),1);
            APtemp(APmock(i)) = 1;
        end
        APmock = sort(APmock);
   
        for i = 1:numstim
            resp_temp      = S(:,APmock(i)+win);
            is_resp(:,i,k) = logical(sum(resp_temp(:,15+respwin),2));
            % is_resp(:,i,k) = sum(resp_temp(:,15+respwin),2);
            resp(:,i,:,k)  = resp_temp;
            pupil(i,:,k)   = pupil_in(APmock(i)+win)/pupil_in(APmock(i)+win(1));
            speed(i,:,k)   = speed_in(APmock(i)+win);
            bulk(i,:,k)    = bulk_in(APmock(i)+win);
            
        end      
    end
    
    F_resp = permute(sum(is_resp,1)./size(is_resp,1),[2 3 1]);
    %% Information score between AP and every cell
    max_delay = 5;                % Maximum delay to consider
    bins = 3;                     % Bins for the information score
    downsample = 3;               % Sample down traces before score calculation
    max_info = zeros(1,size(S,1));
    parfor i = 1:size(S,1)
        [~, mutual_infos] = helpers.calculate_mutual_information_with_delay(S(i,:), AP, max_delay,bins,downsample);
        max_info(i) = max(mutual_infos);
    end

    thresh_info = prctile(max_info,percentile);
    INFO(mice(j)).thresh_info = thresh_info;
    INFO(mice(j)).max_info = max_info;
    %% Fit a linear classifier to indetify cells that contribute to AP prediction
    
    Resps = zeros(numstim*2,numcells);
    Resps(:,stim.cellID(:,1)) = [RecValues(j).resppre_ind RecValues(j).resppost_ind]';
    Resps(:,stim.nr.cellID(:,1)) = [RecValues(j).non_resppre_ind RecValues(j).non_resppost_ind]';
    APs = [zeros(size(RecValues(j).CaResp));ones(size(RecValues(j).CaResp));];
    prediction_model = fitclinear(Resps(1:2:end,:), APs(1:2:end));
    % data_matrix_with_intercept = [ones(size(Resps, 1), 1), Resps];
    % prediction_model = fitclinear(data_matrix_with_intercept(1:2:end,:), APs(1:2:end));
    % predicted_stimulus = predict(prediction_model, data_matrix_with_intercept(2:2:end,:));
    predicted_stimulus = predict(prediction_model, Resps(2:2:end,:));
    model_accuracy = sum((1-abs(predicted_stimulus-APs(2:2:end))))/(length(APs)/2);
    contributions = prediction_model.Beta;
    thresh_glm = prctile(contributions,percentile);
    GLM(mice(j)).contributions = contributions; 
    GLM(mice(j)).model_accuracy = model_accuracy;

    %% ROC analysis
    Resps = zeros(numstim,numcells,2);
    Resps(:,stim.cellID(:,1),1)     = [RecValues(j).resppre_ind]';
    Resps(:,stim.cellID(:,1),2)     = [RecValues(j).resppost_ind]';
    Resps(:,stim.nr.cellID(:,1),1)  = [RecValues(j).non_resppre_ind]';
    Resps(:,stim.nr.cellID(:,1),2)  = [RecValues(j).non_resppost_ind]';
    
    roc_auc = zeros(numcells,1);
    roc_auc_shuffle = zeros(numcells,numit);
    roc_resp = cell(1,numcells);
    for i = 1:numcells
        resp_temp = permute(Resps(:,i,:),[1 3 2]);
        num_steps = [];
        [roc_auc(i),roc_auc_shuffle(i,:),roc_resp{i}] = helpers.roc_ap(resp_temp,num_steps,numit,do_plot);       
    end
    thresh_roc = prctile(roc_auc,percentile);
    thresh_roc_shuffle = prctile(roc_auc_shuffle,percentile,2);
    % testing neg responder
    % thresh_roc_shuffle = prctile(roc_auc_shuffle,5,2);
    %% Output for responder ID
    is_resp = sum(is_resp,2);
    is_resp = permute(is_resp,[1 3 2]);
    num_respPerc = round(prctile(is_resp,percentile,2));
    num_resp = zeros(size(num_respPerc));
    num_resp(stim.cellID(:,1)) = stim.cellID(:,3);
    num_resp(stim.nr.cellID(:,1)) = stim.nr.cellID(:,3);

    id = false(numcells,5);
    id(:,1) = num_resp>thresh_out(j);
    id(:,2) = max_info(:)>thresh_info;
    id(:,3) = num_resp>num_respPerc;
    id(:,4) = contributions>thresh_glm;
    id(:,5) = roc_auc>thresh_roc_shuffle;
    ID = [ID;id];
    responder = true(numcells,1);

    %% Re-define responders 
    if re_define == true
        %%       
        if thresh_crit == true
            responder(num_resp<thresh_out(j)) = false;
        end
        if info_crit == true
            responder(max_info(:)<thresh_info) = false;
        end
        if shuf_crit == true
            responder(num_resp<num_respPerc) = false;
        end
        if glm_crit == true
            responder(contributions<thresh_glm) = false;
        end
        if roc_crit == true
            responder(roc_auc<=thresh_roc_shuffle) = false;
            % testing neg responder
            % responder(roc_auc>=thresh_roc_shuffle) = false;
        end

        stim = resort(stim,responder);
        if strcmp(stim_id,'airpuff')
            CAIM(1,mice(j)).airpuff = stim;
        elseif strcmp(stim_id, 'runonset')
            CAIM(1,mice(j)).runonset = stim;
        end

        if do_plot == true
            %
            figure
            subplot(2,2,1)
            plot(num_resp,'color',[0 0.4470 0.7410])
            hold on
            plot(num_respPerc,'color',[0.8500 0.3250 0.0980])
            % plot(num_resp99)
            % plot([1,length(num_resp)],[thresh(j,1),thresh(j,1)],'yellow')
            plot([1,length(num_resp)],[thresh_out(j),thresh_out(j)],'color',[0.4660 0.6740 0.1880])
            scatter(stim.cellID(:,1),num_resp(stim.cellID(:,1)),'MarkerEdgeColor',[0.3010 0.7450 0.9330])
            scatter(find(responder), num_resp(responder)+1,'MarkerEdgeColor',[0.6350 0.0780 0.1840])
            title(['Old def: ' num2str(length(stim.cellID(:,1))) ', new def: ' num2str(sum(responder))])

            subplot(2,2,2)
            scatter(num_resp,contributions)
            hold on
            scatter(num_resp(responder),contributions(responder))
            plot([min(num_resp) max(num_resp)],[thresh_glm thresh_glm])
            xlabel('# responses')
            ylabel('GLM contribution')
            title(['Model accuracy: ' num2str(round(model_accuracy *100)) ' %'])

            subplot(2,2,3) 
            scatter(num_resp,max_info)
            hold on
            scatter(num_resp(responder),max_info(responder))
            plot([min(num_resp) max(num_resp)],[thresh_info thresh_info])
            xlabel('# responses')
            ylabel('Mutual information')
            
            subplot(2,2,4) 
            scatter(num_resp,roc_auc)
            hold on
            scatter(num_resp(responder),roc_auc(responder))
            plot([min(num_resp) max(num_resp)],[thresh_roc thresh_roc])
            xlabel('# responses')
            ylabel('ROC-auc')
            
            % subplot(2,2,4) 
            % scatter(contributions,max_info)
            % hold on
            % scatter(contributions(responder),max_info(responder))
            % xlabel('GLM contribution')
            % ylabel('Mutual information')
        end
    end

    % resp: numcells, numstimm, time, numit
    all = resp;
    all = nanmean(all,1);
    all = permute(all, [2 3 4 1]);

    nresp = resp(stim.nr.cellID(:,1),:,:,:);
    nresp = nanmean(nresp,1);
    nresp = permute(nanmean(nresp,1),[2 3 4 1]);
    
    resp = resp(stim.cellID(:,1),:,:,:);
    resp = nanmean(resp,1);
    resp = permute(nanmean(resp,1),[2 3 4 1]);
       
    % pooling
    Shuf.All = cat(1,Shuf.All,all);
    Shuf.Resp = cat(1,Shuf.Resp,resp);
    Shuf.NResp = cat(1,Shuf.NResp,nresp);
    Shuf.Pupil = cat(1,Shuf.Pupil,pupil);
    Shuf.Speed = cat(1,Shuf.Speed,speed);
    Shuf.Bulk = cat(1,Shuf.Bulk,bulk);
    Shuf.Fresp = cat(1,Shuf.Fresp,F_resp);
    
    ROC(j).ROC_resp = roc_resp(responder);
    ROC(j).auc = roc_auc(responder);
end



%%
if do_save == true
   save('C:\Users\martipof\IEECR Dropbox\Martin Pofahl\Matlab\Shuf','Shuf','-v7.3')
   % save('/Users/martinpofahl/Dropbox (IEECR)/Matlab/Shuf','Shuf')
end


    
end

function stim = resort(stim,responder)
%%
    cellID      = zeros(length(responder),size(stim.cellID,2));
    resp        = zeros([length(responder),size(stim.resp,[2,3])]);
    respCa      = zeros([length(responder),size(stim.respCa,[2,3])]);
    maxresppost = zeros([length(responder),size(stim.maxresppost,2)]);
    maxresppre  = zeros([length(responder),size(stim.maxresppost,2)]);

    cellID(stim.cellID(:,1),:)          = stim.cellID;
    resp(stim.cellID(:,1),:,:)          = stim.resp;
    respCa(stim.cellID(:,1),:,:)        = stim.respCa;
    maxresppost(stim.cellID(:,1),:)     = stim.maxresppost;
    maxresppre(stim.cellID(:,1),:)      = stim.maxresppost;

    cellID(stim.nr.cellID(:,1),:)       = stim.nr.cellID;
    resp(stim.nr.cellID(:,1),:,:)       = stim.nr.resp;
    respCa(stim.nr.cellID(:,1),:,:)     = stim.nr.respCa;
    maxresppost(stim.nr.cellID(:,1),:)  = stim.nr.maxresppost;
    maxresppre(stim.nr.cellID(:,1),:)   = stim.nr.maxresppost;

    stim.cellID         = cellID(responder==1,:);
    stim.resp           = resp(responder==1,:,:);
    stim.respCa         = respCa(responder==1,:,:) ;
    stim.maxresppost    = maxresppost(responder==1,:) ;
    stim.maxresppost    = maxresppre(responder==1,:);

    stim.nr.cellID      = cellID(responder==0,:);
    stim.nr.resp        = resp(responder==0,:,:);
    stim.nr.respCa      = respCa(responder==0,:,:) ;
    stim.nr.maxresppost = maxresppost(responder==0,:) ;
    stim.nr.maxresppost = maxresppre(responder==0,:);
end