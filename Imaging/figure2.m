% Figure 2
%% open figure

figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 45 29],...
    'PaperUnits','centimeters',...
    'PaperSize',[45 29],...
    'visible','on')

plota = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotb = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotbb = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotc = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotcc = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotd = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotdd = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plote= [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotf1 = axes('Units','centimeter');
plotf2 = axes('Units','centimeter');

plotg1 = axes('Units','centimeter');
plotg2 = axes('Units','centimeter');

ploth1 = axes('Units','centimeter');
ploth2 = axes('Units','centimeter');

ploti1 = axes('Units','centimeter');
ploti2 = axes('Units','centimeter');

plotj1 = axes('Units','centimeter');
plotj2 = axes('Units','centimeter');

plotk1 = axes('Units','centimeter');
plotk2 = axes('Units','centimeter');
plotk3 = axes('Units','centimeter');

plotl = [axes('Units','centimeter');
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotm1 = axes('Units','centimeter');
plotm2 = axes('Units','centimeter');
plotm3 = axes('Units','centimeter');
plotm4 = axes('Units','centimeter');
plotm5 = axes('Units','centimeter');
plotm6 = axes('Units','centimeter');
plotm7 = axes('Units','centimeter');
plotm8 = axes('Units','centimeter');

plotn1 = axes('Units','centimeter');
plotn2 = axes('Units','centimeter');

ploto = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];
plotoo = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotp = [axes('Units','centimeter')
    axes('Units','centimeter')];


plotq = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotr = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];
%%
% Effects for all APS
set(plota,'Position',[1 25 2.5 2]);
for i = 1:length(plota)
    temppos = get(plota(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plota(i),"Position",temppos);
end

% APS that NOT triggered running
set(plotb,'Position',[10 25 2.5 2]);
for i = 1:length(plotb)
    temppos = get(plotb(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plotb(i),"Position",temppos);
end

% APs that trigge run
set(plotbb,'Position',[7 25 2.5 2]);
for i = 1:length(plotbb)
    temppos = get(plotbb(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plotbb(i),"Position",temppos);
end

% Percentages of effects
set(plotc,'Position',[5 25 .7 2]);
for i = 1:length(plotc)
    temppos = get(plotc(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plotc(i),"Position",temppos);
end

% bar graphs for response quantification
set(plotcc,'Position',[32 25 2.5 2]);
for i = 1:length(plotcc)
    temppos = get(plotcc(i),"Position");
    temppos(2) = temppos(2)-(i-1)*3;
    set(plotcc(i),"Position",temppos);
end
% APs that trigger MPPs
set(plotd,'Position',[13 25 2.5 2]);
for i = 1:length(plotd)
    temppos = get(plotd(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plotd(i),"Position",temppos);
end

% APs that NOT trigger MPPs
set(plotdd,'Position',[16 25 2.5 2]);
for i = 1:length(plotdd)
    temppos = get(plotdd(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plotdd(i),"Position",temppos);
end

% Running onsets
set(plote,'Position',[19 25 2.5 2]);
for i = 1:length(plote)
    temppos = get(plote(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plote(i),"Position",temppos);
end

% Stats run trig vs non-trig
set(plotf1,'Position',[5 4.5 1.5 2]);
set(plotf2,'Position',[5 1 1.5 2]);

% Stats MPP trig vs non-trig
set(plotg1,'Position',[11 4.5 1.5 2]);
set(plotg2,'Position',[11 1 1.5 2]);

% Stats AP vs only run onset
set(ploth1,'Position',[8 4.5 1.5 2]);
set(ploth2,'Position',[8 1 1.5 2]);

% Stats run onset vs non sonset vs only run
set(ploti1,'Position',[14 4.5 1.5 2]);
set(ploti2,'Position',[14 1 1.5 2]);

% %same as above with violin plot
set(plotj1,'Position',[17 4.5 1.5 2]);
set(plotj2,'Position',[17 1 1.5 2]);

%same as above with cummulativ plot
set(plotk1,'Position',[20 4.5 1.5 2]);
set(plotk2,'Position',[20 1 1.5 2]);
set(plotk3,'Position',[20 8 1 1.2]);

% Only shuffled data
set(plotl,'Position',[28 25 2.5 2]);
for i = 1:length(plotl)
    temppos = get(plotl(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plotl(i),"Position",temppos);
end

%one on one shuffle comparissons
set(plotm1,'Position',[23 4.5 1.5 2]);
set(plotm2,'Position',[23 1 1.5 2]);
set(plotm3,'Position',[25 4.5 1.5 2]);
set(plotm4,'Position',[25 1 1.5 2]);
set(plotm5,'Position',[27 4.5 1.5 2]);
set(plotm6,'Position',[27 1 1.5 2]);
set(plotm7,'Position',[29 4.5 1.5 2]);
set(plotm8,'Position',[29 1 1.5 2]);

% all in one shuffle comparissons
set(plotn1,'Position',[1 4.5 2.5 2]);
set(plotn2,'Position',[1 1 2.5 2]);

% only pupil responder
set(ploto,'Position',[22 25 2.5 2]);
for i = 1:length(ploto)
    temppos = get(ploto(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(ploto(i),"Position",temppos);
end

% only pupil responder
set(plotoo,'Position',[25 25 2.5 2]);
for i = 1:length(plotoo)
    temppos = get(plotoo(i),"Position");
    temppos(2) = temppos(2)-(i-1)*2.5;
    set(plotoo(i),"Position",temppos);
end

% bar graphs for response quantification
set(plotp,'Position',[35 25 2.5 2]);
for i = 1:length(plotp)
    temppos = get(plotp(i),"Position");
    temppos(2) = temppos(2)-(i-1)*3;
    set(plotp(i),"Position",temppos);
end

% scatter plots for cell responses
set(plotq,'Position',[38 25 1.5 2]);
for i = 1:length(plotq)
    temppos = get(plotq(i),"Position");
    temppos(2) = temppos(2)-(i-1)*3;
    set(plotq(i),"Position",temppos);
end

% bar graphs for mouse contribution
set(plotr,'Position',[41 25 2.5 2]);
for i = 1:length(plotr)
    temppos = get(plotr(i),"Position");
    temppos(2) = temppos(2)-(i-1)*3;
    set(plotr(i),"Position",temppos);
end
%% All Airpuff stimuli
% for response estimations
resp_win_ex = 31:36;
resp_win_inh = 40:45;
bs_win = 16:30;

XLim    = [-1 3];
numice  = [1:8 10];%[6 8 10];%
numexp  = 1;
resp    = [];
nresp   = [];
all     = [];
speed   = [];
pupil   = [];
bulk    = [];
all_cells    = [];
resp_cells   = [];
nresp_cells  = [];
respC_cells  = [];
nrespC_cells = [];
resp_cells_mouse = [];
nresp_cells_mouse = [];
respC_cells_mouse = [];
nrespC_cells_mouse = [];
all_ainmal    = [];
resp_animal   = [];
nresp_animal  = [];

i = 1;
for j = 1:length(numice)
    stim = CAIM(numexp(i),numice(j)).airpuff;
    if ~isempty(stim)
        % include all APs
        include = 1:size(stim.speed,1);
        resp_var = helpers.response_acc(stim,include);
        all = [all; resp_var.all];
        resp = [resp; resp_var.resp];
        nresp = [nresp; resp_var.nresp];
        % respC = [respC; resp_var.respC];
        % nrespC = [nrespC; resp_var.nrespC];
        speed = [speed; resp_var.speed];
        pupil = [pupil; resp_var.pupil];
        bulk = [bulk; resp_var.bulk];
        all_cells           = [all_cells;    resp_var.all_cells];
        resp_cells          = [resp_cells;   resp_var.resp_cells];
        nresp_cells         = [nresp_cells;  resp_var.nresp_cells];
        respC_cells         = [respC_cells;  resp_var.respC_cells];
        nrespC_cells        = [nrespC_cells; resp_var.nrespC_cells];
        resp_cells_mouse    = [resp_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.resp_cells,1),1)];
        nresp_cells_mouse   = [nresp_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.nresp_cells,1),1)];
        respC_cells_mouse   = [respC_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.respC_cells,1),1)];
        nrespC_cells_mouse  = [nrespC_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.nrespC_cells,1),1)];
        all_ainmal          = [all_ainmal;    resp_var.all_tot];
        resp_animal         = [resp_animal;   resp_var.resp_tot];
        nresp_animal        = [nresp_animal;  resp_var.nresp_tot];
    end      
end

% fit trajectories to the reponse traces
x = stim.times(1,:)/1000;
dyn_fit = helpers.resp_fit(x,resp,nresp);

% qunatify responses cell wise
Resp_cells = [];
RespG_cells = []; 
RespG_cells_mouse = [];
NResp_cells = [];
NRespG_cells = []; 
NRespG_cells_mouse = [];

resp_temp = helpers.response_fct(resp_cells,resp_win_ex,bs_win);
Resp_cells = [Resp_cells; resp_temp];
RespG_cells = [RespG_cells; repmat({'AP'},size(resp_temp,1),1)];
RespG_cells_mouse = [RespG_cells_mouse;resp_cells_mouse];

resp_temp = helpers.response_fct(nresp_cells,resp_win_ex,bs_win);
NResp_cells = [NResp_cells; resp_temp];
NRespG_cells = [NRespG_cells; repmat({'AP'},size(resp_temp,1),1)];
NRespG_cells_mouse = [NRespG_cells_mouse;nresp_cells_mouse];

% Quantify responses mouse wise

Resp_animals = [];
RespG_animals = [];
NResp_animals = [];
NRespG_animals = [];

resp_temp = helpers.response_fct(resp_animal,resp_win_ex,bs_win);
Resp_animals = [Resp_animals; resp_temp];
RespG_animals = [RespG_animals; repmat({'AP'},size(resp_temp,1),1)];

resp_temp = helpers.response_fct(nresp_animal,resp_win_ex,bs_win);
NResp_animals = [NResp_animals; resp_temp];
NRespG_animals = [NRespG_animals; repmat({'AP'},size(resp_temp,1),1)];


% filename = '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/fig1 - stats.xlsx';
% writematrix(cf_resp,filename,'Sheet',1,'Range','b10:e12')
% writematrix(fwhm_exc,filename,'Sheet',1,'Range','a16:c16')
% writematrix(cf_non_resp,filename,'Sheet',1,'Range','b21:e23')
% writematrix(fwhm_inh,filename,'Sheet',1,'Range','a27:c27')

%%
helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plota,my_plt,Shuf,dyn_fit)

% Resp = mean(resp(:,35:38),2)-mean(resp(:,16:30),2)./(1+std(resp(:,35:38),[],2));
Resp = helpers.response_fct(resp,resp_win_ex,bs_win);
RespG = {};
RespG(1:size(Resp,1),1) = {'AP'};
% NResp = mean(nresp(:,35:38),2)-mean(nresp(:,16:30),2)./(1+std(nresp(:,35:38),[],2));
NResp = helpers.response_fct(nresp,resp_win_inh,bs_win);
NRespG = {};
NRespG(1:size(NResp,1),1) = {'AP'};    


%% non-running triggered

% numexp = 1;
% numice = [1:8 10];
i = 1;
resp         = [];
nresp        = [];
all          = [];
respC        = [];
nrespC       = [];
speed        = [];
pupil        = [];
bulk         = [];
all_cells    = [];
resp_cells   = [];
nresp_cells  = [];
respC_cells  = [];
nrespC_cells = [];
resp_cells_mouse = [];
nresp_cells_mouse = [];
respC_cells_mouse = [];
nrespC_cells_mouse = [];
all_ainmal    = [];
resp_animal   = [];
nresp_animal  = [];
respC_animal  = [];
nrespC_animal = [];

for j = 1:length(numice)
    stim = CAIM(numexp(i),numice(j)).airpuff;
    if ~isempty(stim)
        % include only AP that did not trigger running
        include = (sum(stim.speed(:,31:60),2) <= 0);
        resp_var = helpers.response_acc(stim,include);
        all                 = [all; resp_var.all];
        resp                = [resp; resp_var.resp];
        nresp               = [nresp; resp_var.nresp];
        respC               = [respC; resp_var.respC];
        nrespC              = [nrespC; resp_var.nrespC];
        speed               = [speed; resp_var.speed];
        pupil               = [pupil; resp_var.pupil];
        bulk                = [bulk; resp_var.bulk];
        all_cells           = [all_cells;    resp_var.all_cells];
        resp_cells          = [resp_cells;   resp_var.resp_cells];
        nresp_cells         = [nresp_cells;  resp_var.nresp_cells];
        respC_cells         = [respC_cells;  resp_var.respC_cells];
        nrespC_cells        = [nrespC_cells; resp_var.nrespC_cells];
        resp_cells_mouse    = [resp_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.resp_cells,1),1)];
        nresp_cells_mouse   = [nresp_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.nresp_cells,1),1)];
        respC_cells_mouse   = [respC_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.respC_cells,1),1)];
        nrespC_cells_mouse  = [nrespC_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.nrespC_cells,1),1)];
        all_ainmal          = [all_ainmal;    resp_var.all_tot];
        resp_animal         = [resp_animal;   resp_var.resp_tot];
        nresp_animal        = [nresp_animal;  resp_var.nresp_tot];
        respC_animal        = [respC_animal;  resp_var.respC_tot];
        nrespC_animal       = [nrespC_animal; resp_var.nrespC_tot];
    end      
end

% qunatify responses cell wise

resp_temp = helpers.response_fct(respC_cells,resp_win_ex,bs_win);
Resp_cells = [Resp_cells; resp_temp];
RespG_cells = [RespG_cells; repmat({'with run'},size(resp_temp,1),1)];
RespG_cells_mouse = [RespG_cells_mouse;respC_cells_mouse];

resp_temp = helpers.response_fct(resp_cells,resp_win_ex,bs_win);
Resp_cells = [Resp_cells; resp_temp];
RespG_cells = [RespG_cells; repmat({'w/o run'},size(resp_temp,1),1)];
RespG_cells_mouse = [RespG_cells_mouse;resp_cells_mouse];

resp_temp = helpers.response_fct(nrespC_cells,resp_win_ex,bs_win);
NResp_cells = [NResp_cells; resp_temp];
NRespG_cells = [NRespG_cells; repmat({'with run'},size(resp_temp,1),1)];
NRespG_cells_mouse = [NRespG_cells_mouse;nrespC_cells_mouse];

resp_temp = helpers.response_fct(nresp_cells,resp_win_ex,bs_win);
NResp_cells = [NResp_cells; resp_temp];
NRespG_cells = [NRespG_cells; repmat({'w/o run'},size(resp_temp,1),1)];
NRespG_cells_mouse = [NRespG_cells_mouse;nresp_cells_mouse];

% Quantify responses mouse wise

resp_temp = helpers.response_fct(resp_animal,resp_win_ex,bs_win);
Resp_animals = [Resp_animals; resp_temp];
RespG_animals = [RespG_animals; repmat({'with run'},size(resp_temp,1),1)];

resp_temp = helpers.response_fct(respC_animal,resp_win_ex,bs_win);
Resp_animals = [Resp_animals; resp_temp];
RespG_animals = [RespG_animals; repmat({'w/o run'},size(resp_temp,1),1)];

resp_temp = helpers.response_fct(nresp_animal,resp_win_ex,bs_win);
NResp_animals = [NResp_animals; resp_temp];
NRespG_animals = [NRespG_animals; repmat({'with run'},size(resp_temp,1),1)];

resp_temp = helpers.response_fct(nrespC_animal,resp_win_ex,bs_win);
NResp_animals = [NResp_animals; resp_temp];
NRespG_animals = [NRespG_animals; repmat({'w/o run'},size(resp_temp,1),1)];

%%
x = stim.times(1,:)/1000;
dyn_fit_non_run = helpers.resp_fit(x,resp,nresp);

helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plotb,my_plt,Shuf,dyn_fit_non_run )
axes(plotb(1));
title('w/o triggered run')

respC = helpers.response_fct(respC,resp_win_ex,bs_win);
Resp = [Resp; respC];
respCG = {};
respCG(1:size(respC,1),1) = {'with run'};
RespG(end+(1:size(respC,1))) = {'with run'};

resp = helpers.response_fct(resp,resp_win_ex,bs_win);
Resp = [Resp; resp];
respG = {};
respG(1:size(resp,1),1) = {'w/o run'};
RespG(end+(1:size(resp,1))) = {'w/o run'};

nrespC = helpers.response_fct(nrespC,resp_win_inh,bs_win);
NResp = [NResp; nrespC];
nrespCG = {};
nrespCG(1:size(nrespC,1),1) = {'with run'};
NRespG(end+(1:size(nrespC,1))) = {'with run'};

nresp = helpers.response_fct(nresp,resp_win_inh,bs_win);
NResp = [NResp; nresp];
nrespG = {};
nrespG(1:size(nresp,1),1) = {'w/o run'};
NRespG(end+(1:size(nresp,1))) = {'w/o run'};

delete(plotf1.Children)
axes(plotf1);

boxplot([respC; resp],[respCG; respG])
% [p,h] = ranksum(respC,resp);
[h,p] = ttest2(respC,resp);

box off

hold on
% axis tight
ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,2))])

delete(plotf2.Children)
axes(plotf2);

boxplot([nrespC; nresp],[nrespCG; nrespG])
% [p,h,stats] = ranksum(nrespC,nresp);
[h,p] = ttest2(nrespC,nresp);
box off

hold on
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,2))])


%% running triggered

resp = [];
nresp = [];
all = [];
respC = [];
nrespC = [];
speed = [];
pupil = [];
bulk = [];
for j = 1:length(numice)
    % i =4;j=1;
    stim = CAIM(numexp,numice(j)).airpuff;
    if ~isempty(stim)
        % include only AP that did not trigger running
        include = (sum(stim.speed(:,31:60),2) > 0);
        resp_var = helpers.response_acc(stim,include);
        all = [all; resp_var.all];
        resp = [resp; resp_var.resp];
        nresp = [nresp; resp_var.nresp];
        respC = [respC; resp_var.respC];
        nrespC = [nrespC; resp_var.nrespC];
        speed = [speed; resp_var.speed];
        pupil = [pupil; resp_var.pupil];
        bulk = [bulk; resp_var.bulk];
    end      
end

x = stim.times(1,:)/1000;
dyn_fit_run = helpers.resp_fit(x,resp,nresp);

helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plotbb,my_plt,Shuf,dyn_fit_run)
axes(plotbb(1));
title('triggered run')

%% only MPP triggered 
XLim = [-1 3];

numexp = 1;
MPPmice = [6 8 10];
resp = [];
nresp = [];
all = [];
respC = [];
nrespC = [];
speed = [];
pupil = [];
bulk = [];
for j = 1:length(MPPmice)
    % i =4;j=1;
    stim = CAIM(numexp,MPPmice(j)).airpuff;
    if ~isempty(stim)
        bulktemp = stim.bulkresp;
        a = nanmean(bulktemp(:,1:15),2);
        b = nanmean(bulktemp(:,35:38),2);
        c = nanstd(nanmean(bulktemp(:,1:15),1),[],2);
        bulktemp = (b-a)./c;
        include = abs(bulktemp)>stdsig;
        resp_var = helpers.response_acc(stim,include);
        all = [all; resp_var.all];
        resp = [resp; resp_var.resp];
        nresp = [nresp; resp_var.nresp];
        respC = [respC; resp_var.respC];
        nrespC = [nrespC; resp_var.nrespC];
        speed = [speed; resp_var.speed];
        pupil = [pupil; resp_var.pupil];
        bulk = [bulk; resp_var.bulk];
    end      
end

x = stim.times(1,:)/1000;
dyn_fit_MPP = helpers.resp_fit(x,resp,nresp);

helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plotd,my_plt,Shuf,dyn_fit_MPP)
axes(plotd(1));
title('triggered MPP')

% respC = (mean(respC(:,35:38),2)-mean(nrespC(:,16:30),2))./(1+std(nrespC(:,35:38),[],2));
respC = helpers.response_fct(respC,resp_win_ex,bs_win);
Resp = [Resp; respC];
respCG = {};
respCG(1:size(respC,1),1) = {'non - MPP trig'};
RespG(end+(1:size(respC,1)),1) = {'non - MPP trig'};

% resp = (mean(resp(:,35:38),2)-mean(resp(:,16:30),2))./(1+std(resp(:,35:38),[],2));
resp = helpers.response_fct(resp,resp_win_ex,bs_win);
Resp = [Resp; resp];
respG = {};
respG(1:size(resp,1),1) = {'MPP trig'};
RespG(end+(1:size(resp,1)),1) = {'MPP trig'};

% nresp = (mean(nresp(:,35:38),2)-mean(nresp(:,16:30),2))./(1+std(nresp(:,35:38),[],2));
nresp = helpers.response_fct(nresp,resp_win_inh,bs_win);
NResp = [NResp; nresp];
nrespG = {};
nrespG(1:size(nresp,1),1) = {'MPP trig'};
NRespG(end+(1:size(nresp,1)),1) = {'MPP trig'};

% nrespC = (mean(nrespC(:,35:38),2)-mean(nrespC(:,16:30),2))./(1+std(nrespC(:,35:38),[],2));
nrespC = helpers.response_fct(nrespC,resp_win_inh,bs_win);
NResp = [NResp; nrespC];
nrespCG = {};
nrespCG(1:size(nrespC,1),1) = {'non - MPP trig'};
NRespG(end+(1:size(nrespC,1)),1) = {'non - MPP trig'};


delete(plotg1.Children)
axes(plotg1);

boxplot([respC; resp],[respCG; respG])
% [p,h] = ranksum(respC,resp);
[h,p] = ttest2(respC,resp);
box off

hold on
% axis tight
ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,2))])

delete(plotg2.Children)
axes(plotg2);

boxplot([nrespC; nresp],[nrespCG; nrespG])
% [p,h] = ranksum(nrespC,nresp);
[h,p] = ttest2(nrespC,nresp);
box off

hold on
% axis tight
ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,2))])

%% AP did NOT trigger MPP 
XLim = [-1 3];

numexp = 1;
MPPmice = [6 8 10];
i = 1;
resp = [];
nresp = [];
all = [];
respC = [];
nrespC = [];
speed = [];
pupil = [];
bulk = [];
for j = 1:length(MPPmice)
    % i =4;j=1;
    stim = CAIM(numexp(i),MPPmice(j)).airpuff;
    if ~isempty(stim)
        % include all APs
%         include = 1:size(stim.resp,2);
        % include only AP that did not trigger running
%         include = find(sum(stim.speed(:,31:60),2) <= 0);
        bulktemp = stim.bulkresp;
        a = nanmean(bulktemp(:,1:15),2);
        b = nanmean(bulktemp(:,35:38),2);
        c = nanstd(nanmean(bulktemp(:,1:15),1),[],2);
        bulktemp = (b-a)./c;
        include = abs(bulktemp)<=stdsig;
        resp_var = helpers.response_acc(stim,include);
        all = [all; resp_var.all];
        resp = [resp; resp_var.resp];
        nresp = [nresp; resp_var.nresp];
        respC = [respC; resp_var.respC];
        nrespC = [nrespC; resp_var.nrespC];
        speed = [speed; resp_var.speed];
        pupil = [pupil; resp_var.pupil];
        bulk = [bulk; resp_var.bulk];
    end      
end

x = stim.times(1,:)/1000;
dyn_fit_non_MPP = helpers.resp_fit(x,resp,nresp);

helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plotdd,my_plt,Shuf,dyn_fit_non_MPP)
axes(plotdd(1));
title('w/o triggered MPP')
%% With pupil response

i = 1;
resp = [];
nresp = [];
all = [];
respC = [];
nrespC = [];
speed = [];
pupil = [];
bulk = [];
for j = 1:length(numice)
    % i =4;j=1;
    stim = CAIM(numexp(i),numice(j)).airpuff;
    if ~isempty(stim)
        % include only AP that did trigger pupil constriction
        pupiltemp = stim.pupil;
        a = nanmean(pupiltemp(:,1:15),2);
        b = nanmean(pupiltemp(:,31:46),2);
        c = nanstd(nanmean(pupiltemp(:,1:15),1),[],2);
        % c = nanstd(pupiltemp(:,1:15),[],2); 
        pupiltemp = (b-a)./c;
        include = abs(pupiltemp)>stdsig;% | isnan(pupiltemp);
        resp_var = helpers.response_acc(stim,include);
        all = [all; resp_var.all];
        resp = [resp; resp_var.resp];
        nresp = [nresp; resp_var.nresp];
        respC = [respC; resp_var.respC];
        nrespC = [nrespC; resp_var.nrespC];
        speed = [speed; resp_var.speed];
        pupil = [pupil; resp_var.pupil];
        bulk = [bulk; resp_var.bulk];
    end      
end

x = stim.times(1,:)/1000;
dyn_fit_pup = helpers.resp_fit(x,resp,nresp);
helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,ploto,my_plt,Shuf,dyn_fit_pup)
axes(ploto(1));
title('triggered pupil')
%% Without pupil response

i = 1;
resp = [];
nresp = [];
all = [];
respC = [];
nrespC = [];
speed = [];
pupil = [];
bulk = [];
for j = 1:length(numice)
    % i =4;j=1;
    stim = CAIM(numexp(i),numice(j)).airpuff;
    if ~isempty(stim)
        % include only AP that did trigger pupil constriction
        pupiltemp = stim.pupil;
        a = nanmean(pupiltemp(:,1:15),2);
        b = nanmean(pupiltemp(:,31:46),2);
        c = nanstd(nanmean(pupiltemp(:,1:15),1),[],2);
        % c = nanstd(pupiltemp(:,1:15),[],2);
        pupiltemp = (b-a)./c;
        include = abs(pupiltemp)<stdsig | isnan(pupiltemp);
        resp_var = helpers.response_acc(stim,include);
        all = [all; resp_var.all];
        resp = [resp; resp_var.resp];
        nresp = [nresp; resp_var.nresp];
        respC = [respC; resp_var.respC];
        nrespC = [nrespC; resp_var.nrespC];
        speed = [speed; resp_var.speed];
        pupil = [pupil; resp_var.pupil];
        bulk = [bulk; resp_var.bulk];
    end      
end

helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plotoo,my_plt,Shuf,[])
axes(plotoo(1));
title('w/o triggered pupil')
 % ploto(10).YLim = [0 2.5];
%% Run onset responses

i = 1;
resp = [];
nresp = [];
all = [];
speed = [];
pupil = [];
bulk = [];
all_cells    = [];
resp_cells   = [];
nresp_cells  = [];
respC_cells  = [];
nrespC_cells = [];
resp_cells_mouse = [];
nresp_cells_mouse = [];
respC_cells_mouse = [];
nrespC_cells_mouse = [];
n_cells = zeros(length(numice),2);
all_ainmal    = [];
resp_animal   = [];
nresp_animal  = [];

for j = 1:length(numice)
    % i =4;j=1;
    stim = CUE(numexp(i),numice(j)).runonset;
    if ~isempty(stim)
        % include all APs
        include = 1:size(stim.speed,1);
        resp_var = helpers.response_acc(stim,include);
        all = [all; resp_var.all];
        resp = [resp; resp_var.resp];
        nresp = [nresp; resp_var.nresp];
        respC = [respC; resp_var.respC];
        nrespC = [nrespC; resp_var.nrespC];
        speed = [speed; resp_var.speed];
        pupil = [pupil; resp_var.pupil];
        bulk = [bulk; resp_var.bulk];
        all_cells           = [all_cells; resp_var.all_cells];
        resp_cells          = [resp_cells; resp_var.resp_cells];
        nresp_cells         = [nresp_cells; resp_var.nresp_cells];
        respC_cells         = [respC_cells; resp_var.respC_cells];
        nrespC_cells        = [nrespC_cells; resp_var.nrespC_cells];
        resp_cells_mouse    = [resp_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.resp_cells,1),1)];
        nresp_cells_mouse   = [nresp_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.nresp_cells,1),1)];
        respC_cells_mouse   = [respC_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.respC_cells,1),1)];
        nrespC_cells_mouse  = [nrespC_cells_mouse; repmat(mouse_id(numice(j)),size(resp_var.nrespC_cells,1),1)];
        all_ainmal          = [all_ainmal;    resp_var.all_tot];
        resp_animal         = [resp_animal;   resp_var.resp_tot];
        nresp_animal        = [nresp_animal;  resp_var.nresp_tot];
    end      
end

% qunatify responses cell wise

resp_temp = helpers.response_fct(resp_cells,resp_win_ex,bs_win);
Resp_cells = [Resp_cells; resp_temp];
RespG_cells = [RespG_cells; repmat({'Run onset'},size(resp_temp,1),1)];
RespG_cells_mouse = [RespG_cells_mouse;resp_cells_mouse];

resp_temp = helpers.response_fct(nresp_cells,resp_win_ex,bs_win);
NResp_cells = [NResp_cells; resp_temp];
NRespG_cells = [NRespG_cells; repmat({'Run onset'},size(resp_temp,1),1)];
NRespG_cells_mouse = [NRespG_cells_mouse;nresp_cells_mouse];

% Quantify responses mouse wise

resp_temp = helpers.response_fct(resp_animal,resp_win_ex,bs_win);
Resp_animals = [Resp_animals; resp_temp];
RespG_animals = [RespG_animals; repmat({'Run onset'},size(resp_temp,1),1)];

resp_temp = helpers.response_fct(nresp_animal,resp_win_ex,bs_win);
NResp_animals = [NResp_animals; resp_temp];
NRespG_animals = [NRespG_animals; repmat({'Run onset'},size(resp_temp,1),1)];
%%
n_cells_fraq = n_cells(:,1)./sum(n_cells,2);
n_cells_stat = [mean(n_cells_fraq) std(n_cells_fraq)/sqrt(length(n_cells_fraq))];
x = stim.times(1,:)/1000;
dyn_fit_run = helpers.resp_fit(x,resp,nresp);
helpers.APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plote,my_plt,Shuf,dyn_fit_run)
axes(plote(1));
title('running onset w/o AP')

% resp = (mean(resp(:,35:38),2)-mean(resp(:,16:30),2))./(1+std(resp(:,35:38),[],2));
resp = helpers.response_fct(resp,resp_win_ex,bs_win);
Resp = [Resp; resp];
respG(1:size(resp,1)) = {'Run onset'};
RespG(end+(1:size(resp,1))) = {'Run onset'};

% nresp = (mean(nresp(:,35:38),2)-mean(nresp(:,16:30),2))./(1+std(nresp(:,35:38),[],2));
nresp = helpers.response_fct(nresp,resp_win_inh,bs_win);
NResp = [NResp; nresp];
nrespG(1:size(nresp,1)) = {'Run onset'};
NRespG(end+(1:size(nresp,1))) = {'Run onset'};

delete(ploth1.Children)
axes(ploth1);

boxplot([Resp(strcmp(RespG,'AP')); resp],[RespG(strcmp(RespG,'AP')); respG])
% [p,h] = kruskalwallis([Resp(strcmp(RespG,'AP')); resp],[RespG(strcmp(RespG,'AP')); respG],'off');
[p] = anova1([Resp(strcmp(RespG,'AP')); resp],[RespG(strcmp(RespG,'AP')); respG],'off');
box off

hold on
% axis tight
ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,2))])

delete(ploth2.Children)
axes(ploth2);

boxplot([NResp(strcmp(NRespG,'AP')); nresp],[NRespG(strcmp(NRespG,'AP')); nrespG])
% [p,h] = kruskalwallis([NResp(strcmp(NRespG,'AP')); nresp],[NRespG(strcmp(NRespG,'AP')); nrespG],'off');
[p] = anova1([NResp(strcmp(NRespG,'AP')); nresp],[NRespG(strcmp(NRespG,'AP')); nrespG],'off');
box off

hold on
% axis tight
ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,2))])

%% Quantify probability of AP presentation
standTime = 0;
airpuff = 0;
for i = 1:length(numice)
    standing = sum(CAIM(1,numice(i)).behave.running==0);
    dt = mean(diff(CAIM(1,numice(i)).behave.tsscn));
    standTime = standTime+standing*dt/1000;
    airpuff = airpuff + size(CAIM(1,numice(i)).airpuff.resp,2);
end
airpuff/(standTime)
%% Quantify triggered reponses


[resp, values,RecValues,RecResp] = helpers.qtf_response(CAIM,numexp,numice,stdsig,mouse_id,'airpuff');

delete(plotcc(1).Children)
axes(plotcc(1));

b = bar(100*resp);
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = lnwd ;
b.CData(1,:) = my_plt.mycol(3,:);%[0 .9 .9];
b.CData(2,:) = my_plt.mycol(4,:);%[.5 .5 .5];
b.CData(3,:) = my_plt.mycol(5,:);%[.9 0 0];

ylabel('fraction (%)')
ax = gca;
ax.LineWidth  = my_plt.lnwd;
ax.FontSize   = my_plt.ftsz-3;
ax.XTickLabel = {'run init' 'pupil response' 'MPP response' 'run init & MPP' 'GC resp' 'GC non resp' 'GC & GC-non' 'GC & run'};
ax.XTickLabelRotation = -45;
box off

for i = 1:6
    delete(plotcc(i+1).Children)
    axes(plotcc(i+1));
    
    b(i) = bar(100*RecResp(i,:));
    b(i).BarWidth = 0.6;
    b(i).FaceColor = 'flat';
    b(i).LineStyle = 'none';
    % b.LineWidth = lnwd ;
    % b(i).CData = my_plt.mycol(3,:);%[0 .9 .9];
    
    ylabel('fraction (%)')
    ax = gca;
    ax.LineWidth  = my_plt.lnwd;
    ax.FontSize   = my_plt.ftsz-3;
    ax.XTickLabel = mouse_id(numice);
    ax.XTickLabelRotation = -90;
    ax.YLim = [0 100];
    box off
end
b(1).CData = my_plt.mycol(3,:);
b(2).CData = my_plt.mycol(4,:);
b(3).CData = my_plt.mycol(5,:);
b(4).CData = my_plt.mycol(5,:);
b(5).CData = my_plt.mycol(2,:);
b(6).CData = my_plt.mycol(1,:);

RecRespPerc = zeros(size(RecResp,1),2);
for i = 1:size(RecResp,1)
    RecRespPerc(i,:) = [nanmean(RecResp(i,:)) nanstd(RecResp(i,:))./sqrt(sum(~isnan(RecResp(i,:))))];
end

delete(plotcc(8).Children)
axes(plotcc(8));

b = bar(100*RecResp(8:11,:)','stacked');
for i = 1:4
    b(i).BarWidth = 0.6;
    b(i).FaceColor = 'flat';
    b(i).LineStyle = 'none';
% b.LineWidth = lnwd ;
end
b(1).CData = my_plt.mycol(2,:);%[0 .9 .9];
b(2).CData = mean(my_plt.mycol(2:3,:),1);%[0 .9 .9];
b(3).CData = my_plt.mycol(3,:);%[0 .9 .9];
b(4).CData = my_plt.mycol(6,:);%[0 .9 .9];

ylabel('fraction (%)')
ax = gca;
ax.LineWidth  = my_plt.lnwd;
ax.FontSize   = my_plt.ftsz-3;
ax.XTickLabel = mouse_id(numice);
ax.XTickLabelRotation = -90;
box off

%%

delete(plotc(1).Children)
axes(plotc(1));

b = bar(100*resp(5));
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData(1,:) = my_plt.mycol(2,:);

ylabel('fraction (%)')
ax = gca;
ax.LineWidth  = my_plt.lnwd;
ax.FontSize   = my_plt.ftsz-3;
ax.YLim = [0 100];
% ax.XTickLabel = {'run init' 'pupil response' 'MPP response' 'run init & MPP'};
% ax.XTickLabelRotation = -45;
box off

delete(plotc(2).Children)
axes(plotc(2));

b = bar(100*resp(6));
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData(1,:) = my_plt.mycol(1,:);

ylabel('fraction (%)')
ax = gca;
ax.LineWidth  = my_plt.lnwd;
ax.FontSize   = my_plt.ftsz-3;
ax.YLim = [0 100];
% ax.XTickLabel = {'run init' 'pupil response' 'MPP response' 'run init & MPP'};
% ax.XTickLabelRotation = -45;
box off

delete(plotc(3).Children)
axes(plotc(3));

b = bar(100*resp(1));
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = lnwd ;
b.CData(1,:) = my_plt.mycol(3,:);

ylabel('fraction (%)')
ax = gca;
ax.LineWidth  = my_plt.lnwd;
ax.FontSize   = my_plt.ftsz-3;
ax.YLim = [0 100];
% ax.XTickLabel = {'run init' 'pupil response' 'MPP response' 'run init & MPP'};
% ax.XTickLabelRotation = -45;
box off

delete(plotc(4).Children)
axes(plotc(4));

b = bar(100*resp(2));
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData(1,:) = my_plt.mycol(4,:);

ylabel('fraction (%)')
ax = gca;
ax.LineWidth  = my_plt.lnwd;
ax.FontSize   = my_plt.ftsz-3;
ax.YLim = [0 100];
% ax.XTickLabel = {'run init' 'pupil response' 'MPP response' 'run init & MPP'};
% ax.XTickLabelRotation = -45;
box off

delete(plotc(5).Children)
axes(plotc(5));

b = bar(100*resp(3));
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData(1,:) = my_plt.mycol(5,:);

ylabel('fraction (%)')
ax = gca;
ax.LineWidth  = my_plt.lnwd;
ax.FontSize   = my_plt.ftsz-3;
ax.YLim = [0 100];
% ax.XTickLabel = {'run init' 'pupil response' 'MPP response' 'run init & MPP'};
% ax.XTickLabelRotation = -45;
box off
%% Boxplot for all running conditions

delete(ploti1.Children)
axes(ploti1);


boxplot([Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'w/o run'));Resp(strcmp(RespG,'Run onset'))],[RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'w/o run'));RespG(strcmp(RespG,'Run onset'))])


n_resp = [sum(strcmp(RespG,'with run')); sum(strcmp(RespG,'w/o run'));sum(strcmp(RespG,'Run onset'))];
[p,tbl,stats] = kruskalwallis([Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'w/o run'));Resp(strcmp(RespG,'Run onset'))],[RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'w/o run'));RespG(strcmp(RespG,'Run onset'))],...
    'off');
% [p,tbl,stats] = anova1([Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'w/o run'));Resp(strcmp(RespG,'Run onset'))],[RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'w/o run'));RespG(strcmp(RespG,'Run onset'))],...
%     'on');

% figure
[pMult,~,~,nms] = multcompare(stats,'CriticalValueType','dunn-sidak','Display','off');

% filename = '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/fig2 - stats.xlsx';
% filename = 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\fig2 - stats.xlsx';
% writecell(tbl,filename,'Sheet',1,'Range','A3:J8')
% writecell([nms(pMult(:,1)) nms(pMult(:,2))],filename,'Sheet',1,'Range','A9:B14')
% writematrix(pMult(:,6),filename,'Sheet',1,'Range','C9:C14')

box off

hold on
% axis tight
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.05 .1]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

% delete(ploti2.Children)
axes(ploti2);

boxplot([NResp(strcmp(NRespG,'with run')); NResp(strcmp(NRespG,'w/o run'));NResp(strcmp(NRespG,'Run onset'))],[NRespG(strcmp(NRespG,'with run')); NRespG(strcmp(NRespG,'w/o run'));NRespG(strcmp(NRespG,'Run onset'))])

n_non_resp = [sum(strcmp(NRespG,'with run')); sum(strcmp(NRespG,'w/o run'));sum(strcmp(NRespG,'Run onset'))];
[p,tblNr,stats] = kruskalwallis([NResp(strcmp(NRespG,'with run')); NResp(strcmp(NRespG,'w/o run'));NResp(strcmp(NRespG,'Run onset'))],[NRespG(strcmp(NRespG,'with run')); NRespG(strcmp(NRespG,'w/o run'));NRespG(strcmp(NRespG,'Run onset'))],...
    'off');
% [p,tblNr,stats] = anova1([NResp(strcmp(NRespG,'with run')); NResp(strcmp(NRespG,'w/o run'));NResp(strcmp(NRespG,'Run onset'))],[NRespG(strcmp(NRespG,'with run')); NRespG(strcmp(NRespG,'w/o run'));NRespG(strcmp(NRespG,'Run onset'))],...
%     'off');
% figure
pMultNr = multcompare(stats,'CriticalValueType','dunn-sidak','Display','off');

% writecell(tblNr,filename,'Sheet',1,'Range','A15:F18')
% writecell([nms(pMultNr(:,1)) nms(pMultNr(:,2))],filename,'Sheet',1,'Range','A21:B23')
% writematrix(pMultNr(:,6),filename,'Sheet',1,'Range','C21:C23')
%
box off

hold on
% axis tight
ax = gca;
% ax.XLim = XLim;  
% ax.YLim = [-.01 .01];  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

%% Sawrmchart plot for all running conditions

delete(plotj1.Children)
axes(plotj1);

swarmchart(categorical([RespG(strcmp(RespG,'w/o run'));RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'Run onset'))],["w/o run","with run",'Run onset']),...
    [Resp(strcmp(RespG,'w/o run'));Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'Run onset'))],...
    1,my_plt.mycol(2,:),'filled')

% hold on
% x = 1:3;
% y = [mean(Resp(strcmp(RespG,'with run'))); 
%     mean(Resp(strcmp(RespG,'w/o run')));
%     mean(Resp(strcmp(RespG,'Run onset')))];
% 
% yerr = [std(Resp(strcmp(RespG,'with run')))/sqrt(sum(strcmp(RespG,'with run'))); 
%     std(Resp(strcmp(RespG,'w/o run')))/sqrt(sum(strcmp(RespG,'w/o run')));
%     std(Resp(strcmp(RespG,'Run onset')))/sqrt(sum(strcmp(RespG,'Run onset')))];
% 
% errorbar(x,y,yerr,'.',...
%             'Marker','none',...
%             'Color',[0 0 0],...
%             'LineWidth',my_plt.lnwd)

% axis tight
ax = gca;
ax.YLim = [-50 50]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
%
delete(plotj2.Children)
axes(plotj2);


% figure
swarmchart(categorical([NRespG(strcmp(NRespG,'w/o run'));NRespG(strcmp(NRespG,'with run')); NRespG(strcmp(NRespG,'Run onset'))],["w/o run","with run",'Run onset']),...
    [NResp(strcmp(NRespG,'w/o run'));NResp(strcmp(NRespG,'with run')); NResp(strcmp(NRespG,'Run onset'))],...
    1,my_plt.mycol(1,:),'filled')


% hold on
% x = 1:3;
% y = [mean(NResp(strcmp(NRespG,'with run'))); 
%     mean(NResp(strcmp(NRespG,'w/o run')));
%     mean(NResp(strcmp(NRespG,'Run onset')))];
% 
% yerr = [std(NResp(strcmp(NRespG,'with run')))/sqrt(sum(strcmp(NRespG,'with run'))); 
%     std(NResp(strcmp(NRespG,'w/o run')))/sqrt(sum(strcmp(NRespG,'w/o run')));
%     std(NResp(strcmp(NRespG,'Run onset')))/sqrt(sum(strcmp(NRespG,'Run onset')))];
% 
% errorbar(x,y,yerr,'.',...
%             'Marker','none',...
%             'Color',[0 0 0],...
%             'LineWidth',my_plt.lnwd)

ax = gca;
ax.YLim = [-50 50];    
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off

%% Cumulative plot for all running conditions

delete(plotk1.Children)
axes(plotk1);


y1 = Resp(strcmp(RespG,'with run'));
y2 = Resp(strcmp(RespG,'w/o run'));
y3 = Resp(strcmp(RespG,'Run onset'));

y1 = y1(~isnan(y1));
y2 = y2(~isnan(y2));
y3 = y3(~isnan(y3));

num_steps = 50;
step_size = (max([y1;y2;y3]) - min([y1;y2;y3]))/num_steps;
bins = min([y1;y2;y3]) : step_size: max([y1;y2;y3]);% -0.1:0.0001:0.2;
y1 = histcounts(y1,bins,'normalization','probability');
y2 = histcounts(y2,bins,'normalization','probability');
y3 = histcounts(y3,bins,'normalization','probability');

y1 = cumsum(y1);
y2 = cumsum(y2);
y3 = cumsum(y3);

x = bins(2:end);
plot(x,y1,'color',my_plt.mycol(3,:))
hold on
plot(x,y2,'color',[0 0 0])
plot(x,y3,'color',[0 0 .8])
hold off

ax = gca;
ax.YLim = [0 1];   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% ax.XTickLabelRotation = -35;
box off
xlabel('response')
ylabel('cum. prob.')
legend({'with run' 'w/o run' 'run onset'},'location','southwest','fontsize',my_plt.ftsz-3)
legend('boxoff')

delete(plotk2.Children)
axes(plotk2);

y1 = NResp(strcmp(NRespG,'with run'));
y2 = NResp(strcmp(NRespG,'w/o run'));
y3 = NResp(strcmp(NRespG,'Run onset'));

num_steps = 50;
step_size = (max([y1;y2;y3]) - min([y1;y2;y3]))/num_steps;
bins = min([y1;y2;y3]) : step_size: max([y1;y2;y3]);%-0.01:0.0001:0.01;
y1 = histcounts(y1,bins,'normalization','probability');
y2 = histcounts(y2,bins,'normalization','probability');
y3 = histcounts(y3,bins,'normalization','probability');

y1 = cumsum(y1);
y2 = cumsum(y2);
y3 = cumsum(y3);

x = bins(2:end);
plot(x,y1,'color',my_plt.mycol(3,:))
hold on
plot(x,y2,'color',[0 0 0])
plot(x,y3,'color',[0 0 .8])
hold off

ax = gca;
ax.YLim = [0 1];   
% ax.XLim = [-50 50];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% ax.XTickLabelRotation = -35;
box off
xlabel('response')
ylabel('cum. prob.')
legend({'with run' 'w/o run' 'run onset'},'location','southwest','fontsize',my_plt.ftsz-3)
legend('boxoff')

delete(plotk3.Children)
axes(plotk3);

x = bins(2:end);
plot(x,y1,'color',my_plt.mycol(3,:))
hold on
plot(x,y2,'color',[0 0 0])
plot(x,y3,'color',[0 0 .8])
hold off

ax = gca;
% ax.XLim = [-50 50]; 
ax.YLim = [0 .3]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% ax.XTickLabelRotation = -35;
box off
xlabel('response')
ylabel('cum. prob.')

%%
delete(plotl(1).Children)
axes(plotl(1));

x = stim.times(1,:)/1000;
y = nanmean(nanmean(Shuf.Resp,1),3);
b = 2*nanstd(nanmean(Shuf.Resp,1),[],3);

fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(2,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on
plot(x,y,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd)
axis tight
ax = gca;
ax.XLim = my_plt.XLim;
ax.XAxis.Visible = 'off';   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
% YLimEx = ax.YLim;
plot([0 0],my_plt.YLimEx,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimEx;
box off

delete(plotl(2).Children)
axes(plotl(2));


y = nanmean(nanmean(Shuf.NResp,1),3);
b = 2*nanstd(nanmean(Shuf.NResp,1),[],3);
fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(1,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on
plot(x,y,'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
hold on
axis tight
ax = gca;
ax.XLim = XLim;
ax.XAxis.Visible = 'off';   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
% YLimIn = [.6 2.2]*10^-3;%ax.YLim;
plot([0 0],my_plt.YLimIn,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimIn;
box off

delete(plotl(3).Children)
axes(plotl(3));

y = nanmean(nanmean(Shuf.Speed,1),3);
b = 2*nanstd(nanmean(Shuf.Speed,1),[],3);%/sqrt(size(Shuf.Speed,1));
fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(3,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on
plot(x,y,'color',my_plt.mycol(3,:),'linewidth',my_plt.lnwd)
ax = gca;
ax.XLim = my_plt.XLim;
ax.XAxis.Visible = 'off';   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
YLimSp = [0 .13];
plot([0 0],my_plt.YLimSp,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimSp;
box off

delete(plotl(4).Children)
axes(plotl(4));

y = nanmean(nanmean(Shuf.Pupil,1),3);
b = nanstd(nanmean(Shuf.Pupil,1),[],3);
fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(4,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on
plot(x,y,'color',my_plt.mycol(4,:),'linewidth',my_plt.lnwd)
ax = gca;
ax.XLim = XLim;
ax.XAxis.Visible = 'off';   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3; 
YLim = ax.YLim;
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
box off

delete(plotl(5).Children)
axes(plotl(5));

y = nanmean(nanmean(Shuf.Bulk,1),3);
b = 2*nanstd(nanmean(Shuf.Bulk,1),[],3);%/sqrt(sum(~isnan(Shuf.Bulk(:,1,1))));
fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(5,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on
plot(x,y,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
hold on
ax = gca;
ax.XLim = my_plt.XLim;
ax.XAxis.Visible = 'on';   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
% YLimMPP = [.8 1.3];%ax.YLim;
plot([0 0],my_plt.YLimMPP,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimMPP;
xlabel('time (s)')
box off

%% Individual cells running responsivness

Run_frac = [];
group = {};
group_all = {};
for i = 1 : size(RecValues,2)
    % ind_resp = RecValues(i).resppost_ind>0;
    % runtrig = RecValues(i).runtrig;
    % sum(runtrig)/length(runtrig)
    % include = sum(runtrig)/length(runtrig)<.75 && sum(runtrig)/length(runtrig)>.25
    include = RecResp(8,i)>0 && RecResp(9,i)>0;
    if include
        run_frac = RecValues(i).run_frac;    
        Run_frac = [Run_frac; run_frac];
        group(end+1:end+length(run_frac)) = mouse_id(numice(i));
        group_all(end+1:end+length(run_frac)) = {'all'};
    end
    
end

delete(plotp(1).Children)
axes(plotp(1));

swarmchart(categorical(group),Run_frac,5,my_plt.mycol(2,:),'filled')
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3; 
box off

delete(plotp(2).Children)
axes(plotp(2));

[run_counts,run_bins] = histcounts(Run_frac,10);
b = bar(run_bins(2:end)-.05,run_counts);
b.BarWidth = .9;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData = my_plt.mycol(2,:);
box off
axis tight
ax = gca;
ax.XTick = 0:.25:1;
ax.XLim = [0 1];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3; 
%% Compare shuffle to all groups individually 

% resp = mean(Shuf.Resp(:,35:38),2)-mean(Shuf.Resp(:,16:30),2)./(1+std(Shuf.Resp(:,35:38),[],2));
resp = helpers.response_fct(Shuf.Resp,resp_win_ex,bs_win);
Resp = [Resp; resp];
respG(1:size(resp,1)) = {'Shuffle'};
RespG(end+(1:size(resp,1))) = {'Shuffle'};

% nresp = mean(Shuf.NResp(:,35:38),2)-mean(Shuf.NResp(:,16:30),2)./(1+std(Shuf.NResp(:,35:38),[],2));
nresp = helpers.response_fct(Shuf.NResp,resp_win_inh,bs_win);
NResp = [NResp; nresp];
nrespG(1:size(nresp,1)) = {'Shuffle'};
NRespG(end+(1:size(nresp,1))) = {'Shuffle'};

%%
delete(plotm1.Children)
axes(plotm1);

boxplot([Resp(strcmp(RespG,'AP')); Resp(strcmp(RespG,'Shuffle'))],[RespG(strcmp(RespG,'AP')); RespG(strcmp(RespG,'Shuffle'))])
% [p,h] = ranksum(Resp(strcmp(RespG,'AP')), Resp(strcmp(RespG,'Shuffle')));
[h,p] = ttest2(Resp(strcmp(RespG,'AP')), Resp(strcmp(RespG,'Shuffle')));
% [h,p] = kstest(Resp(strcmp(RespG,'AP')));
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.05 .1]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotm3.Children)
axes(plotm3);

boxplot([Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'Shuffle'))],[RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'Shuffle'))])
% [p,h] = ranksum(Resp(strcmp(RespG,'with run')), Resp(strcmp(RespG,'Shuffle')));
[h,p] = ttest2(Resp(strcmp(RespG,'with run')), Resp(strcmp(RespG,'Shuffle')));
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.05 .1]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotm5.Children)
axes(plotm5);

boxplot([Resp(strcmp(RespG,'w/o run')); Resp(strcmp(RespG,'Shuffle'))],[RespG(strcmp(RespG,'w/o run')); RespG(strcmp(RespG,'Shuffle'))])
% [p,h] = ranksum(Resp(strcmp(RespG,'w/o run')), Resp(strcmp(RespG,'Shuffle')));
[h,p] = ttest2(Resp(strcmp(RespG,'w/o run')), Resp(strcmp(RespG,'Shuffle')));
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.05 .1]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotm7.Children)
axes(plotm7);

boxplot([Resp(strcmp(RespG,'Run onset')); Resp(strcmp(RespG,'Shuffle'))],[RespG(strcmp(RespG,'Run onset')); RespG(strcmp(RespG,'Shuffle'))])
% [p,h] = ranksum(Resp(strcmp(RespG,'Run onset')), Resp(strcmp(RespG,'Shuffle')));
[h,p] = ttest2(Resp(strcmp(RespG,'Run onset')), Resp(strcmp(RespG,'Shuffle')));

box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.05 .1]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])



% [p,tbl,stats] = kruskalwallis([Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'w/o run'));Resp(strcmp(RespG,'Run onset'));Resp(strcmp(RespG,'Shuffle'))],[RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'w/o run'));RespG(strcmp(RespG,'Run onset')); RespG(strcmp(RespG,'Shuffle'))],...
%     'off');
% %%figure
% [pMult,~,~,nms] = multcompare(stats,'Display','off');
% 

% filename = 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\fig2 - stats.xlsx';
% filename = '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/fig2 - stats.xlsx';
% writecell(tbl,filename,'Sheet',1,'Range','A3:J8')
% writecell([nms(pMult(:,1)) nms(pMult(:,2))],filename,'Sheet',1,'Range','A9:B14')
% writematrix(pMult(:,6),filename,'Sheet',1,'Range','C9:C14')

delete(plotm2.Children)
axes(plotm2);

boxplot([NResp(strcmp(NRespG,'AP')); NResp(strcmp(NRespG,'Shuffle'))],[NRespG(strcmp(NRespG,'AP')); NRespG(strcmp(NRespG,'Shuffle'))])
[p,h] = ranksum(NResp(strcmp(NRespG,'AP')), NResp(strcmp(NRespG,'Shuffle')));
% [h,p] = ttest2(NResp(strcmp(NRespG,'AP')), NResp(strcmp(NRespG,'Shuffle')));
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.01 .01]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotm4.Children)
axes(plotm4);

boxplot([NResp(strcmp(NRespG,'with run')); NResp(strcmp(NRespG,'Shuffle'))],[NRespG(strcmp(NRespG,'with run')); NRespG(strcmp(NRespG,'Shuffle'))])
% [p,h] = ranksum(NResp(strcmp(NRespG,'with run')), NResp(strcmp(NRespG,'Shuffle')));
[h,p] = ttest2(NResp(strcmp(NRespG,'with run')), NResp(strcmp(NRespG,'Shuffle')));
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.01 .01];  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotm6.Children)
axes(plotm6);

boxplot([NResp(strcmp(NRespG,'w/o run')); NResp(strcmp(NRespG,'Shuffle'))],[NRespG(strcmp(NRespG,'w/o run')); NRespG(strcmp(NRespG,'Shuffle'))])
% [p,h] = ranksum(NResp(strcmp(NRespG,'w/o run')), NResp(strcmp(NRespG,'Shuffle')));
[h,p] = ttest2(NResp(strcmp(NRespG,'w/o run')), NResp(strcmp(NRespG,'Shuffle')));
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.01 .01]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotm8.Children)
axes(plotm8);

boxplot([NResp(strcmp(NRespG,'Run onset')); NResp(strcmp(NRespG,'Shuffle'))],[NRespG(strcmp(NRespG,'Run onset')); NRespG(strcmp(NRespG,'Shuffle'))])
% [p,h] = ranksum(NResp(strcmp(NRespG,'Run onset')), NResp(strcmp(NRespG,'Shuffle')));
[h,p] = ttest2(NResp(strcmp(NRespG,'Run onset')), NResp(strcmp(NRespG,'Shuffle')));
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.01 .01]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

%%
delete(plotn1.Children)
axes(plotn1);

[p,tblNr,stats] = anova1([Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'w/o run'));Resp(strcmp(RespG,'Run onset'));Resp(strcmp(RespG,'Shuffle'))],[RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'w/o run'));RespG(strcmp(RespG,'Run onset'));RespG(strcmp(RespG,'Shuffle'))],...
    'off');
% figure
pMultNr = multcompare(stats,'Display','off');

boxplot([Resp(strcmp(RespG,'with run')); Resp(strcmp(RespG,'w/o run'));Resp(strcmp(RespG,'Run onset'));Resp(strcmp(RespG,'Shuffle'))],[RespG(strcmp(RespG,'with run')); RespG(strcmp(RespG,'w/o run'));RespG(strcmp(RespG,'Run onset'));RespG(strcmp(RespG,'Shuffle'))])
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.05 .1]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotn2.Children)
axes(plotn2);

[p,tblNr,stats] = kruskalwallis([NResp(strcmp(NRespG,'with run')); NResp(strcmp(NRespG,'w/o run'));NResp(strcmp(NRespG,'Run onset'));NResp(strcmp(NRespG,'Shuffle'))],[NRespG(strcmp(NRespG,'with run')); NRespG(strcmp(NRespG,'w/o run'));NRespG(strcmp(NRespG,'Run onset'));NRespG(strcmp(NRespG,'Shuffle'))],...
    'off');
% figure
pMultNr = multcompare(stats,'Display','off');

boxplot([NResp(strcmp(NRespG,'with run')); NResp(strcmp(NRespG,'w/o run'));NResp(strcmp(NRespG,'Run onset'));NResp(strcmp(NRespG,'Shuffle'))],[NRespG(strcmp(NRespG,'with run')); NRespG(strcmp(NRespG,'w/o run'));NRespG(strcmp(NRespG,'Run onset'));NRespG(strcmp(NRespG,'Shuffle'))])
box off
ax = gca;
% ax.XLim = XLim; 
% ax.YLim = [-.01 .01]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% swarmchart(categorical([RespG_cells(strcmp(RespG_cells,'w/o run'));RespG_cells(strcmp(RespG_cells,'with run')); RespG_cells(strcmp(RespG_cells,'Run onset'))],["w/o run","with run",'Run onset']),...
%     [Resp_cells(strcmp(RespG_cells,'w/o run'));Resp_cells(strcmp(RespG_cells,'with run')); Resp_cells(strcmp(RespG_cells,'Run onset'))],...
%     100,my_plt.mycol(2,:),'filled')
% 
% figure
% swarmchart(categorical([NRespG_cells(strcmp(NRespG_cells,'w/o run'));NRespG_cells(strcmp(NRespG_cells,'with run')); NRespG_cells(strcmp(NRespG_cells,'Run onset'))],["w/o run","with run",'Run onset']),...
%     [NResp_cells(strcmp(NRespG_cells,'w/o run'));NResp_cells(strcmp(NRespG_cells,'with run')); NResp_cells(strcmp(NRespG_cells,'Run onset'))],...
%     10,my_plt.mycol(1,:),'filled')


%% Linear Mixed Model Responder 
% % Responder - AP without run onset vs AP with run onset

delete(plotq(1).Children)
axes(plotq(1));

[p, h, stats] = signrank(Resp_cells(strcmp(RespG_cells,'w/o run')),Resp_cells(strcmp(RespG_cells,'with run')));
% [h, p, stats] = ttest(Resp_cells(strcmp(RespG_cells,'w/o run')),Resp_cells(strcmp(RespG_cells,'with run')));

paired = true;
condition1 = 'w/o run';
condition2 = 'with run';
out = helpers.LMM_AP(Resp_cells,RespG_cells,RespG_cells_mouse,condition1,condition2,paired);
anova(out.lme_obs)       % tests fixed effects
% p = coefTest(out.lme_obs);   % tests Condition coefficient
p = out.p_perm;

% Extract random effects (conditional modes)
% ranefTable = dataset2table(randomEffects(out.lme_obs));
[~,~,ranefTable] = randomEffects(out.lme_obs);
ranefTable = dataset2table(ranefTable);

% Filter for the random intercepts of the Animal grouping
r_animal = ranefTable(strcmp(ranefTable.Group, 'Animal') & ...
                      strcmp(ranefTable.Name, '(Intercept)'), :);

% plot([Resp_cells(strcmp(RespG_cells,'w/o run')),Resp_cells(strcmp(RespG_cells,'with run'))]','color',[.5 .5 .5])
% hold on
% boxplot([Resp_cells(strcmp(RespG_cells,'w/o run'));Resp_cells(strcmp(RespG_cells,'with run'))],...
%     [RespG_cells(strcmp(RespG_cells,'w/o run'));RespG_cells(strcmp(RespG_cells,'with run'))])
swarmchart(categorical([RespG_cells(strcmp(RespG_cells,'w/o run'));RespG_cells(strcmp(RespG_cells,'with run'))],["w/o run","with run"]),...
    [Resp_cells(strcmp(RespG_cells,'w/o run'));Resp_cells(strcmp(RespG_cells,'with run'))],...
    5,my_plt.mycol(2,:),'filled')
hold on 
plot([Resp_cells(strcmp(RespG_cells,'w/o run')),Resp_cells(strcmp(RespG_cells,'with run'))]','color',[.5 .5 .5])
y = nanmean(Resp_cells(strcmp(RespG_cells,'w/o run')));
plot([.7 1.3],[y y],'color',[0 0 0])
y = nanmean(Resp_cells(strcmp(RespG_cells,'with run')));
plot([1.7 2.3],[y y],'color',[0 0 0])


ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])


delete(plotr(1).Children)
axes(plotr(1));

b = bar(categorical(r_animal.Level), r_animal.Estimate);
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
b.CData = my_plt.mycol(2,:);

ax = gca;
% ax.XLim = XLim;  
ax.YLim = [-.1 .1]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% ax.XTickLabelRotation = -35;
box off
% xlabel('Animal');
ylabel('Random intercept (rank units)');
% title('Per-animal random effects from LME');


[animalVar,residVar,v]  = covarianceParameters(out.lme_obs);
animalVar = animalVar{1};
% v = dataset2table(v{2});
% animalVar   = v{1, 'Estimate'};   
ICC = animalVar / (animalVar + residVar);
fprintf('Intraclass correlation (animal-level) = %.2f\n', ICC);

%% Responder - AP with run vs run w/o AP
delete(plotq(2).Children)
axes(plotq(2));

% n_resp = [sum(strcmp(RespG_cells,'with run')); sum(strcmp(RespG_cells,'Run onset'))];
% [p,h,stats] = ranksum(Resp_cells(strcmp(RespG_cells,'with run')), Resp_cells(strcmp(RespG_cells,'Run onset')));
% [h,p,stats] = ttest2(Resp_cells(strcmp(RespG_cells,'with run')), Resp_cells(strcmp(RespG_cells,'Run onset')));

% n_resp = [sum(strcmp(RespG_cells,'AP')); sum(strcmp(RespG_cells,'Run onset'))];
% [p,h,stats] = ranksum(Resp_cells(strcmp(RespG_cells,'AP')), Resp_cells(strcmp(RespG_cells,'Run onset')));
% [h,p,stats] = ttest2(Resp_cells(strcmp(RespG_cells,'with run')), Resp_cells(strcmp(RespG_cells,'Run onset')));

paired = false;
condition1 = 'AP';%'with run';
condition2 = 'Run onset';
out = helpers.LMM_AP(Resp_cells,RespG_cells,RespG_cells_mouse,condition1,condition2,paired);
anova(out.lme_obs)       % tests fixed effects
% coefTest(out.lme_obs)    % tests Condition coefficient
p = out.p_perm;

% Extract random effects (conditional modes)
[~,~,ranefTable] = randomEffects(out.lme_obs);
ranefTable = dataset2table(ranefTable);

% Filter for the random intercepts of the Animal grouping
r_animal = ranefTable(strcmp(ranefTable.Group, 'Animal') & ...
                      strcmp(ranefTable.Name, '(Intercept)'), :);

    
% boxplot([Resp_cells(strcmp(RespG_cells,'with run'));Resp_cells(strcmp(RespG_cells,'Run onset'))],...
%     [RespG_cells(strcmp(RespG_cells,'with run'));RespG_cells(strcmp(RespG_cells,'Run onset'))])

% swarmchart(categorical([RespG_cells(strcmp(RespG_cells,'with run')); RespG_cells(strcmp(RespG_cells,'Run onset'))],["with run",'Run onset']),...
%     [Resp_cells(strcmp(RespG_cells,'with run')); Resp_cells(strcmp(RespG_cells,'Run onset'))],...
%     5,my_plt.mycol(2,:),'filled')

% % boxplot([Resp_cells(strcmp(RespG_cells,'with run'));Resp_cells(strcmp(RespG_cells,'Run onset'))],...
% %     [RespG_cells(strcmp(RespG_cells,'with run'));RespG_cells(strcmp(RespG_cells,'Run onset'))])
swarmchart(categorical([RespG_cells(strcmp(RespG_cells,'AP')); RespG_cells(strcmp(RespG_cells,'Run onset'))],["AP",'Run onset']),...
    [Resp_cells(strcmp(RespG_cells,'AP')); Resp_cells(strcmp(RespG_cells,'Run onset'))],...
    5,my_plt.mycol(2,:),'filled')
hold on
y = nanmean(Resp_cells(strcmp(RespG_cells,'AP')));
plot([.7 1.3],[y y],'color',[0 0 0])
y = nanmean(Resp_cells(strcmp(RespG_cells,'Run onset')));
plot([1.7 2.3],[y y],'color',[0 0 0])

ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotr(2).Children)
axes(plotr(2));

b = bar(categorical(r_animal.Level), r_animal.Estimate);
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
b.CData = my_plt.mycol(2,:);

ax = gca;
% ax.XLim = XLim; 
ax.YLim = [-.1 .1];  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% ax.XTickLabelRotation = -35;
box off

% xlabel('Animal');
ylabel('Random intercept (rank units)');
% title('Per-animal random effects from LME');


[animalVar,residVar,v]  = covarianceParameters(out.lme_obs);
animalVar = animalVar{1};
% v = dataset2table(v{2});
% animalVar   = v{1, 'Estimate'};   
ICC = animalVar / (animalVar + residVar);
fprintf('Intraclass correlation (animal-level) = %.2f\n', ICC);


%% Non-responder - run triggered vs non run triggered AP
delete(plotq(3).Children)
axes(plotq(3));

% [p, h, stats] = signrank(NResp_cells(strcmp(NRespG_cells,'w/o run')),NResp_cells(strcmp(NRespG_cells,'with run')));
% [h, p, stats] = ttest(NResp_cells(strcmp(NRespG_cells,'w/o run')),NResp_cells(strcmp(NRespG_cells,'with run')));

Group1 = NResp_cells(strcmp(NRespG_cells,'w/o run'));
Group2 = NResp_cells(strcmp(NRespG_cells,'with run'));     

nIterations = 1000;
pVals = zeros(nIterations,1);

nSmall = 50;

rng(42);  % for reproducibility

for i = 1:nIterations
    % Subsample from large group
    idx = randperm(length(Group1), nSmall);
    subsample1 = Group1(idx);
    subsample2 = Group2(idx);
    p = signrank(subsample1, subsample2);
    pVals(i) = p;
end



paired = true;
condition1 = 'w/o run';
condition2 = 'with run';
out = helpers.LMM_AP(NResp_cells,NRespG_cells,NRespG_cells_mouse,condition1,condition2,paired);
anova(out.lme_obs)       % tests fixed effects
% coefTest(out.lme_obs)    % tests Condition coefficient
p = out.p_perm;

% Extract random effects (conditional modes)
% ranefTable = dataset2table(randomEffects(out.lme_obs));
[~,~,ranefTable] = randomEffects(out.lme_obs);
ranefTable = dataset2table(ranefTable);

% Filter for the random intercepts of the Animal grouping
r_animal = ranefTable(strcmp(ranefTable.Group, 'Animal') & ...
                      strcmp(ranefTable.Name, '(Intercept)'), :);

% boxplot([NResp_cells(strcmp(NRespG_cells,'w/o run'));NResp_cells(strcmp(NRespG_cells,'with run'))],...
%     [NRespG_cells(strcmp(NRespG_cells,'w/o run'));NRespG_cells(strcmp(NRespG_cells,'with run'))]) 

swarmchart(categorical([NRespG_cells(strcmp(NRespG_cells,'w/o run'));NRespG_cells(strcmp(NRespG_cells,'with run'))],["w/o run","with run"]),...
    [NResp_cells(strcmp(NRespG_cells,'w/o run'));NResp_cells(strcmp(NRespG_cells,'with run'))],...
    1,my_plt.mycol(1,:),'filled')
hold on
plot([NResp_cells(strcmp(NRespG_cells,'w/o run')),NResp_cells(strcmp(NRespG_cells,'with run'))]','color',[.5 .5 .5])
y = nanmean(NResp_cells(strcmp(NRespG_cells,'w/o run')));
plot([.7 1.3],[y y],'color',[0 0 0])
y = nanmean(NResp_cells(strcmp(NRespG_cells,'with run')));
plot([1.7 2.3],[y y],'color',[0 0 0])

ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])

delete(plotr(3).Children)
axes(plotr(3));

b = bar(categorical(r_animal.Level), r_animal.Estimate);
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
b.CData = my_plt.mycol(1,:);

ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% ax.XTickLabelRotation = -35;
box off
ax.YLim = [-.01 .01]; 
% xlabel('Animal');
ylabel('Random intercept (rank units)');


[animalVar,residVar,v]  = covarianceParameters(out.lme_obs);
animalVar = animalVar{1};
% v = dataset2table(v{2});
% animalVar   = v{1, 'Estimate'};   
ICC = animalVar / (animalVar + residVar);
fprintf('Intraclass correlation (animal-level) = %.2f\n', ICC);

%% Non-responding cells - AP with run onset vs pure run onset 

delete(plotq(4).Children)
axes(plotq(4));

n_non_resp = [sum(strcmp(NRespG_cells,'with run'));sum(strcmp(NRespG_cells,'Run onset'))];
% [p,h,stats] = ranksum(NResp_cells(strcmp(NRespG_cells,'with run')), NResp_cells(strcmp(NRespG_cells,'Run onset')));

%%subsampling
% correaltion values
Group1 = NResp_cells(strcmp(NRespG_cells,'Run onset'));
Group2 = NResp_cells(strcmp(NRespG_cells,'AP'));     

nIterations = 1000;
pVals = zeros(nIterations,1);

nSmall = 50;

rng(42);  % for reproducibility

for i = 1:nIterations
    % Subsample from large group
    idx = randperm(length(Group1), nSmall);
    subsample1 = Group1(idx);
    subsample2 = Group2(idx);

    p = ranksum(subsample1, subsample2);
    
    pVals(i) = p;
end

% % Non-responding cells -  All AP vs pure runnign onset
% n_non_resp = [sum(strcmp(NRespG_cells,'AP'));sum(strcmp(NRespG_cells,'Run onset'))];
% 
% % [p,h,stats] = ranksum(NResp_cells(strcmp(NRespG_cells,'with run')), NResp_cells(strcmp(NRespG_cells,'Run onset')));
% 
% % [p,tblNr,stats] = kruskalwallis([NResp_cells(strcmp(NRespG_cells,'with run')); NResp_cells(strcmp(NRespG_cells,'w/o run'));NResp_cells(strcmp(NRespG_cells,'Run onset'))],[NRespG_cells(strcmp(NRespG_cells,'with run')); NRespG_cells(strcmp(NRespG_cells,'w/o run'));NRespG_cells(strcmp(NRespG_cells,'Run onset'))],...
% %     'on');
% 
% %%subsampling
% % correaltion values
% Group1 = NResp_cells(strcmp(NRespG_cells,'Run onset'));
% Group2 = NResp_cells(strcmp(NRespG_cells,'AP'));     
% 
% nIterations = 1000;
% pVals = zeros(nIterations,1);
% 
% nSmall = 50;
% 
% rng(42);  % for reproducibility
% 
% for i = 1:nIterations
%     % Subsample from large group
%     idx = randperm(length(Group1), nSmall);
%     subsample1 = Group1(idx);
%     subsample2 = Group2(idx);
% 
%     p = ranksum(subsample1, subsample2);
% 
%     pVals(i) = p;
% end
% 
% % Report summary
% % fprintf('Median p-value: %.4f\n', median(pVals));
% % fprintf('Proportion of p < 0.05: %.2f%%\n', mean(pVals < 0.05) * 100);



paired = false;
condition1 = 'AP';
condition2 = 'Run onset';
out = helpers.LMM_AP(NResp_cells,NRespG_cells,NRespG_cells_mouse,condition1,condition2,paired);
anova(out.lme_obs)       % tests fixed effects
% coefTest(out.lme_obs)    % tests Condition coefficient
p = out.p_perm;

% Extract random effects (conditional modes)
% ranefTable = dataset2table(randomEffects(out.lme_obs));
[~,~,ranefTable] = randomEffects(out.lme_obs);
ranefTable = dataset2table(ranefTable);

% Filter for the random intercepts of the Animal grouping
r_animal = ranefTable(strcmp(ranefTable.Group, 'Animal') & ...
                      strcmp(ranefTable.Name, '(Intercept)'), :);

% swarmchart(categorical([NRespG_cells(strcmp(NRespG_cells,'with run')); NRespG_cells(strcmp(NRespG_cells,'Run onset'))],["with run",'Run onset']),...
%     [NResp_cells(strcmp(NRespG_cells,'with run')); NResp_cells(strcmp(NRespG_cells,'Run onset'))],...
%     1,my_plt.mycol(1,:),'filled')

swarmchart(categorical([NRespG_cells(strcmp(NRespG_cells,'AP')); NRespG_cells(strcmp(NRespG_cells,'Run onset'))],["AP","Run onset"]),...
    [NResp_cells(strcmp(NRespG_cells,'AP')); NResp_cells(strcmp(NRespG_cells,'Run onset'))],...
    1,my_plt.mycol(1,:),'filled')
hold on
y = nanmean(NResp_cells(strcmp(NRespG_cells,'AP')));
plot([.7 1.3],[y y],'color',[0 0 0])
y = nanmean(NResp_cells(strcmp(NRespG_cells,'Run onset')));
plot([1.7 2.3],[y y],'color',[0 0 0])

ax = gca;
% ax.XLim = XLim;  
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabelRotation = -35;
box off
title(['p = ' num2str(round(p,3))])


delete(plotr(4).Children)
axes(plotr(4))

b = bar(categorical(r_animal.Level), r_animal.Estimate);
b.BarWidth = 0.6;
b.FaceColor = 'flat';
b.LineStyle = 'none';
b.CData = my_plt.mycol(1,:);

ax = gca;
% ax.XLim = XLim;  
ax.YLim = [-.01 .01]; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% ax.XTickLabelRotation = -35;
box off

% xlabel('Animal');
ylabel('Random intercept (rank units)');


[animalVar,residVar,v]  = covarianceParameters(out.lme_obs);
animalVar = animalVar{1};
% v = dataset2table(v{2});
% animalVar   = v{1, 'Estimate'};   
ICC = animalVar / (animalVar + residVar);
fprintf('Intraclass correlation (animal-level) = %.2f\n', ICC);


%%
if ismac
    print(gcf, '-dpdf', '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/StateDiff'); 
end
if ispc
    print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\StateDiff'); 
end
