function [resp,values,RecValues,RecResp] = qtf_response(CAIM,numexp,numice,stdsig,mouse_id,stim_id)

if nargin < 6
    stim_id = 'airpuff';
end

% Quantify response strengths 

mouse = [];
distance = [];
waittime = [];
runtrig = [];
Ca = [];
Ca_Pre = [];
Ca_Post = []; 
CaResp = [];
CaNonResp = [];
Resp_pre = [];
Resp_post = [];
NonResp_pre = [];
NonResp_post = []; 
pupil = [];
Pupil_post = [];
Pupil_pre = [];
Pupil_pre_pre = [];
blink = [];
bulk = [];
Bulk_pre = [];
Bulk_post = [];
bulkNrun = [];
has_bulk = [];
aporder = [];
values = [];
RecValues = struct;
RecResp = zeros(9,length(numice),length(numexp));

for i = 1:length(numexp)
for j = 1:length(numice)
    % if isfield(CAIM(numexp(i),numice(j)),'airpuff') && ~isempty(CAIM(numexp(i),numice(j)).airpuff)
    if strcmp(stim_id,'airpuff')
        stim = CAIM(numexp(i),numice(j)).airpuff;
    elseif strcmp(stim_id,'runonset')
        stim = CAIM(numexp(i),numice(j)).runonset;
    end
    numstim = size(stim.timepnt,1)/2;
    mouse_temp = cell(numstim,1);
    mouse_temp(:) = mouse_id(numice(j));
    runtime = stim.runtime;
    waittimetemp = stim.waittime;

    apordertemp = (1:numstim)';
    if isfield(stim,'blink')
        blinktemp = nansum(stim.blink(:,31:36),2);
        blinktemp = blinktemp>0;
    else
        blinktemp = false(numstim,1);
    end
    pupiltemp = stim.pupil;
    pupil_pre_pre = nanmean(pupiltemp(:,6:15),2);
    pupil_pre = nanmean(pupiltemp(:,16:25),2);
    pupil_post = nanmean(pupiltemp(:,31:40),2);
    pupil_std = nanstd(nanmean(pupiltemp(:,1:15),1),[],2);
    % c = nanstd(pupiltemp(:,1:15),[],2); 
    pupiltemp = (pupil_post-pupil_pre)./pupil_std;
    % pupiltemp(isnan(pupiltemp)) = [];
    % pupiltemp = abs(pupiltemp)>stdsig;       

    runtrigtemp = sum(stim.speed(:,31:60),2) > 0;
    runtime = runtime(apordertemp,:);
    waittimetemp = waittimetemp(apordertemp,:);
    runtime(:,2) = runtime(:,2)./max(runtime(:,2)); 

    if isfield(stim,'resp')
        % ensembles

        % All cells
        resptemp = cat(1,stim.resp,stim.nr.resp);
        resptemp = nanmean(resptemp,1);
        resptemp = permute(resptemp,[2 3 1]);
        ca_pre = nanmean(resptemp(:,1:15),2);
        ca_post = nanmean(resptemp(:,31:46),2);
        Ca_std = nanstd(nanmean(resptemp(:,1:15),1),[],2);
        Ca_temp = (ca_post-ca_pre)./Ca_std;
        % CaResptemp = abs(CaResptemp)>stdsig;
        Ca = [Ca; Ca_temp];
        Ca_Pre = [Ca_Pre; ca_pre];
        Ca_Post = [Ca_Post; ca_post]; 
        
        % Responder
        resptemp = stim.resp;
        resptemp = nanmean(resptemp,1);
        resptemp = permute(resptemp,[2 3 1]);
        CaResp_pre = nanmean(resptemp(:,1:15),2);
        CaResp_post = nanmean(resptemp(:,31:46),2);
        CaResp_std = nanstd(nanmean(resptemp(:,1:15),1),[],2);
        if CaResp_std == 0;CaResp_std = 1;end
        CaResptemp = (CaResp_post-CaResp_pre)./CaResp_std;
        % CaResptemp = abs(CaResptemp)>stdsig;
        CaResp = [CaResp; CaResptemp];
        Resp_pre = [Resp_pre; CaResp_pre];
        Resp_post = [Resp_post; CaResp_post]; 
        
        % Non-Responder
        resptemp = stim.nr.resp;
        resptemp = nanmean(resptemp,1);
        resptemp = permute(resptemp,[2 3 1]);
        CaNonResp_pre = nanmean(resptemp(:,1:15),2);
        CaNonResp_post = nanmean(resptemp(:,31:46),2);
        CaNonResp_std = nanstd(nanmean(resptemp(:,1:15),1),[],2);
        CaNonResptemp = (CaNonResp_post-CaNonResp_pre)./CaNonResp_std;
        % CaResptemp = CaResptemp < - stdsig;
        CaNonResp = [CaNonResp; CaNonResptemp];
        NonResp_pre = [NonResp_pre; CaNonResp_pre];
        NonResp_post = [NonResp_post; CaNonResp_post]; 
        
        RecValues(i,j).Ca = Ca_temp;
        RecValues(i,j).Ca_pre = ca_pre;
        RecValues(i,j).Ca_post = ca_post;

        RecValues(i,j).CaResp = CaResptemp;
        RecValues(i,j).CaResp_pre = CaResp_pre;
        RecValues(i,j).CaResp_post = CaResp_post;
        
        RecValues(i,j).CaNonResp = CaNonResptemp;
        RecValues(i,j).CaNonResp_pre = CaNonResp_pre;
        RecValues(i,j).CaNonResp_post = CaNonResp_post;

        %% individual cells
        resptemp = stim.resp;
        RecValues(i,j).resppre_ind = nansum(resptemp(:,:,1:15),3);
        RecValues(i,j).resppost_ind = nansum(resptemp(:,:,31:46),3);

        resptemp = stim.nr.resp;
        RecValues(i,j).non_resppre_ind = nansum(resptemp(:,:,1:15),3);
        RecValues(i,j).non_resppost_ind = nansum(resptemp(:,:,31:46),3);

        ind_resp = RecValues(i,j).resppost_ind>0;
        run_frac = zeros(size(ind_resp,1),1);
        for k = 1 : size(ind_resp,1)
            run_frac(k) = sum(ind_resp(k,:) & runtrigtemp')/sum(ind_resp(k,:));
        end
        RecValues(i,j).run_frac = run_frac;
    else
        RecValues(i,j).CaResp = [];
        RecValues(i,j).CaNonResp = [];
    end 

    

    
    if isfield(stim,'bulkresp')       
        bulktemp = stim.bulkresp;
        bulk_pre = nanmean(bulktemp(:,1:15),2);
        bulk_post = nanmean(bulktemp(:,35:38),2);
        bulk_std = nanstd(nanmean(bulktemp(:,1:15),1),[],2);
        bulktemp = (bulk_post-bulk_pre)./bulk_std;
        % bulktemp = bulktemp >stdsig;
        bulk = [bulk; bulktemp];
        Bulk_pre = [Bulk_pre;bulk_pre];
        Bulk_post = [Bulk_post;bulk_post];
        % bulkNtemp =  bulktemp & runtrigtemp;%          
        % bulkNrun = [bulkNrun; bulkNtemp];
        has_bulk_temp = ones(size(bulktemp));
        
    else
        has_bulk_temp = zeros(size(runtrigtemp));
        bulktemp = [];
        bulk_post = [];
        bulk_pre = [];
    end
    has_bulk = [has_bulk; has_bulk_temp];

    RecValues(i,j).pupil = pupiltemp;
    RecValues(i,j).pupil_pre_pre = pupil_pre_pre;
    RecValues(i,j).pupil_pre = pupil_pre;
    RecValues(i,j).pupil_post = pupil_post;
    RecValues(i,j).distance = runtime;
    RecValues(i,j).speed = mean(stim.speed(:,40:60),2);
    RecValues(i,j).runtrig = runtrigtemp;
    RecValues(i,j).bulk = bulktemp;
    RecValues(i,j).bulk_pre = bulk_pre;
    RecValues(i,j).bulk_post = bulk_post;
    
    has_bulk_temp    = has_bulk_temp == 1;
    runtrig_temp     = runtrigtemp == 1;
    pupil_bin        = abs(pupiltemp(~isnan(pupiltemp)))>stdsig;
    bulk_bin         = bulktemp > stdsig;
    bulkNrun_bin     = runtrig_temp(has_bulk_temp) & bulk_bin;
    CaResp_bin       = abs(CaResptemp) > stdsig;
    CaNonResp_bin    = abs(CaNonResptemp) > stdsig;
    ExnIn_bin        = CaResp_bin & CaNonResp_bin;
    
    RecResp(1,j,i) = sum(runtrig_temp)/length(runtrig_temp);
    RecResp(2,j,i) = sum(pupil_bin)/length(pupil_bin);
    RecResp(3,j,i) = sum(bulk_bin)/length(bulk_bin);
    RecResp(4,j,i) = sum(bulkNrun_bin)/length(bulkNrun_bin);
    RecResp(5,j,i) = sum(CaResp_bin)/length(CaResp_bin);
    RecResp(6,j,i) = sum(CaNonResp_bin)/length(CaNonResp_bin);
    RecResp(7,j,i) = sum(ExnIn_bin)/length(ExnIn_bin);
    RecResp(8,j,i) = sum(CaResp_bin & ~runtrig_temp)/length(CaResp_bin);
    RecResp(9,j,i) = sum(CaResp_bin & runtrig_temp)/length(CaResp_bin);
    RecResp(10,j,i) = sum(~CaResp_bin & runtrig_temp)/length(CaResp_bin);
    RecResp(11,j,i) = sum(~CaResp_bin & ~runtrig_temp)/length(CaResp_bin);


    aporder         = [aporder; apordertemp];
    pupil           = [pupil; pupiltemp];
    Pupil_post      = [Pupil_post; pupil_post];
    Pupil_pre       = [Pupil_pre; pupil_pre];
    Pupil_pre_pre   = [Pupil_pre_pre; pupil_pre_pre];
    blink           = [blink;blinktemp];
    distance        = [distance; runtime];
    waittime        = [waittime; waittimetemp];
    runtrig         = [runtrig; runtrigtemp];
    mouse           = [mouse; mouse_temp];

end   
end

values.mouse            = mouse;
values.has_bulk         = has_bulk == 1;
values.runtrig          = runtrig == 1;
values.pupil            = pupil;
values.pupil_pre        = Pupil_pre;
values.pupil_pre_pre    = Pupil_pre_pre;
values.pupil_post       = Pupil_post;
values.bulk             = bulk;
values.bulk_pre         = Bulk_pre;
values.bulk_post        = Bulk_post;
values.Ca               = Ca;
values.Ca_post          = Ca_Post;
values.Ca_pre           = Ca_Pre;
values.CaResp           = CaResp;
values.CaResp_post      = Resp_post;
values.CaResp_pre       = Resp_pre;
values.CaNonResp        = CaNonResp;
values.CaNonResp_post   = NonResp_post;
values.CaNonResp_pre    = NonResp_pre;
values.distance         = distance;
values.waittime         = waittime;

has_bulk         = has_bulk == 1;
runtrig          = runtrig == 1;
pupil_bin        = abs(pupil(~isnan(pupil)))>stdsig;
bulk_bin         = bulk > stdsig;
bulkNrun_bin     = runtrig(has_bulk) & bulk_bin;
CaResp_bin       = abs(CaResp) > stdsig;
CaNonResp_bin    = abs(CaNonResp) > stdsig;
ExnIn_bin        = CaResp_bin & CaNonResp_bin;

resp = sum(runtrig)/length(runtrig);
resp(2) = sum(pupil_bin)/length(pupil_bin);
resp(3) = sum(bulk_bin)/length(bulk_bin);
resp(4) = sum(bulkNrun_bin)/length(bulkNrun_bin);
resp(5) = sum(CaResp_bin)/length(CaResp_bin);
resp(6) = sum(CaNonResp_bin)/length(CaNonResp_bin);
resp(7) = sum(ExnIn_bin)/length(ExnIn_bin);
resp(8) = sum(CaResp_bin & runtrig)/length(CaResp_bin);

end