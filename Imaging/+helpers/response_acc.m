function resp_var = response_acc(stim,include)
%% Get averaged responses to the SP stimulation - Averaged accross stimuli, accrcross cells, and both

if isfield(stim,'sumnet')
    %% average over cells to get the response per AP presentation
    resptemp = stim.resp(:,include,:);
    alltemp = cat(1,resptemp,stim.nr.resp(:,include,:));
    alltemp = mean(alltemp,1);
    alltemp = permute(alltemp,[2 3 1]);
    all = alltemp;

    resptemp = nanmean(resptemp,1);
    resptemp = permute(resptemp,[2 3 1]);
    resp = resptemp;
    
    nresptemp = permute(mean(stim.nr.resp(:,include,:),1),[2 3 1]);
    nresp = nresptemp;  

    resptempC = stim.resp(:,~include,:);
    resptempC = mean(resptempC,1);
    resptempC = permute(resptempC,[2 3 1]);
    respC = resptempC;

    nresptempC = permute(mean(stim.nr.resp(:,~include,:),1),[2 3 1]);
    nrespC = nresptempC;
    
    %% Average over stimuli to get the mean reponse per cell
    if sum(include)>0
        resptemp = stim.resp(:,include,:);
        alltemp = cat(1,resptemp,stim.nr.resp(:,include,:));
        alltemp = mean(alltemp,2);
        alltemp = permute(alltemp,[1 3 2]);
        all_cells = alltemp;
        
        resptemp = nanmean(resptemp,2);
        resptemp = permute(resptemp,[1 3 2]);
        resp_cells = resptemp;
        
        nresptemp = mean(stim.nr.resp(:,include,:),2);
        nresptemp = permute(nresptemp,[1 3 2]);
        nresp_cells = nresptemp;  

        all_tot = mean(alltemp,1);
        resp_tot = mean(resptemp,1);
        nresp_tot = mean(nresptemp,1);
    else
        all_cells = nan(size(stim.resp,1)+size(stim.nr.resp,1),size(stim.resp,3));
        resp_cells = nan(size(stim.resp,1),size(stim.resp,3));
        nresp_cells = nan(size(stim.nr.resp,1),size(stim.resp,3));

        all_tot = nan(1,size(stim.resp,3));
        resp_tot = nan(1,size(stim.resp,3));
        nresp_tot = nan(1,size(stim.resp,3));
    end
    if sum(~include)>0
        resptempC = stim.resp(:,~include,:);
        resptempC = mean(resptempC,2);
        resptempC = permute(resptempC,[1 3 2]);
        respC_cells = resptempC;
    
        nresptempC = mean(stim.nr.resp(:,~include,:),2);
        nresptempC = permute(nresptempC,[1 3 2]);
        nrespC_cells = nresptempC;

        respC_tot = mean(resptempC,1);
        nrespC_tot = mean(nresptempC,1);
    else
        respC_cells = nan(size(stim.resp,1),size(stim.resp,3));
        nrespC_cells = nan(size(stim.nr.resp,1),size(stim.resp,3));

        respC_tot = nan(1,size(stim.resp,3));
        nrespC_tot = nan(1,size(stim.resp,3));
    end
else
    resp = [];
    nresp = []; 
    respC = [];
    all_cells = [];
    resp_cells =  [];
    nresp_cells = [];
    respC_cells = [];
    nrespC_cells = [];
end

speedtemp = stim.speed(include,:);
speedtemp(speedtemp>20) = nan;
speedtemp(speedtemp<0) = 0;
speed = speedtemp;

if isfield(stim,'pupil')  
    pupil = stim.pupil(include,:);
else
    pupil = [];
end

if isfield(stim,'bulktime')
    bulk = stim.bulkresp(include,:);
else 
    bulk = [];
end 

resp_var.all = all;
resp_var.resp = resp;
resp_var.nresp = nresp;
resp_var.respC = respC;
resp_var.nrespC = nrespC;
resp_var.speed = speed;
resp_var.pupil = pupil;
resp_var.bulk = bulk;

resp_var.all_cells = all_cells;
resp_var.resp_cells = resp_cells;
resp_var.nresp_cells = nresp_cells;
resp_var.respC_cells = respC_cells;
resp_var.nrespC_cells = nrespC_cells;

resp_var.all_tot = all_tot;
resp_var.resp_tot = resp_tot;
resp_var.nresp_tot = nresp_tot;
resp_var.respC_tot = respC_tot;
resp_var.nrespC_tot = nrespC_tot;
end

