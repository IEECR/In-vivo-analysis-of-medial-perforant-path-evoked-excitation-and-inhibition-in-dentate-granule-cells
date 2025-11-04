
%% number of responded stimuli in responders
numexp = 1;
numice = [1:8 10];
% numice = [1 2 3 5 7 8 10];

win = 32:45;
Nstim = nan(length(numice),1);
Int_ap_int = [];
Int_run_int = [];
APrespN = [];
APrespF = [];
APallN = [];
APallF = [];
APf = [];
AP_N_cell = [];
AP_f_cell = [];
group = [];
respN = [];
Delay = [];
DelaySes = nan(length(numice),3);
DelayGroup = [];
RespMap = [];
Party = cell(length(numice),1);

k = 1;
i = 1;
for j = 1:length(numice)
    % i =1;j=1;
    stim = CAIM(numexp(i),numice(j)).airpuff;
    % stim = CAIM(numexp(i),numice(j)).runonset;
    running = CAIM(numexp(i),numice(j)).behave.running;
    n = size(CAIM(numexp(i),numice(j)).S,1);
    if ~isempty(stim)
        % Number of stimuli & inter ap intervall
        Nstim(j) = size(stim.times,1);
        stim_idx = diff(stim.stimon)==1;
        stim_idx(1) = 1;
        stim_idx = find(stim_idx);
        trig_pos = diff(running)==-1;
        trig_pos(1) = 1;
        trig_pos = find(trig_pos);
        int_run_int = zeros(1,length(stim_idx));
        int_ap_int = zeros(1,length(stim_idx));
        for jj = 1:length(stim_idx)-1
            idx_ap_for = find(stim_idx<stim_idx(jj+1),1,'last');
            int_ap_int(jj) = stim_idx(jj+1) - stim_idx(idx_ap_for);
            idx_run_for = find(trig_pos<stim_idx(jj+1),1,'last');
            int_run_int(jj) = stim_idx(jj+1) - trig_pos(idx_run_for);
            if int_ap_int(jj) > int_run_int(jj)
                int_ap_int(jj) = nan;
            else
                int_run_int(jj) = nan;
            end
        end
        int_ap_int(isnan(int_ap_int)) = [];
        int_run_int(isnan(int_run_int)) = [];
        int_ap_int(int_ap_int == 0) = [];
        int_run_int(int_run_int == 0) = [];
        int_ap_int = int_ap_int / 15;
        int_run_int = int_run_int / 15;
        Int_ap_int = [Int_ap_int int_ap_int];
        Int_run_int = [Int_run_int int_run_int];
        % include only AP that did trigger pupil constriction
        pupiltemp = stim.pupil;
        a = nanmean(pupiltemp(:,1:15),2);
        b = nanmean(pupiltemp(:,31:46),2);
        c = nanstd(nanmean(pupiltemp(:,1:15),1),[],2);
        % c = nanstd(pupiltemp(:,1:15),[],2); 
        pupiltemp = (b-a)./c;
        include = abs(pupiltemp)>stdsig;%

        % number of responses per cell
        respN = [respN; size(stim.cellID(:,1),1) size(stim.nr.cellID(:,1),1) size(stim.cellID(:,1),1)/size(stim.nr.cellID(:,1),1)];
        APf = [APf; CAIM(numexp(i),numice(j)).fireprop.fire(stim.cellID(:,1))];
        APrespN = [APrespN; stim.cellID(:,3)];
        APrespF = [APrespF; stim.cellID(:,3)./size(stim.times,1)];
        APallN = [APallN; stim.cellID(:,3); stim.nr.cellID(:,3)];
        APallF = [APallF; [stim.cellID(:,3); stim.nr.cellID(:,3)]./size(stim.times,1)];
        group(end+1:end+length(stim.cellID(:,3)),1) = CAIM(numexp(i),numice(j)).cclust(1);
        
        % number of cells following each AP
        N_cell = (sum(sum(stim.nr.resp(:,include,win),3)>0,1)+sum(sum(stim.resp(:,include,win),3)>0,1))';
        f_cell = N_cell/n;
        AP_N_cell = [AP_N_cell;N_cell];
        AP_f_cell = [AP_f_cell;f_cell];


        a = stim.resp(:,:,:); 
        tempDelay = [];
        Thist = [];
        part = [];
        for ii = 1:size(a,1)
            thist = [];
            tonset = [];
            x = stim.times(1,:)/1000;

            for jj = 1:size(a,2)
                temp = permute(a(ii,jj,win),[3 2 1]);
                thist = [thist; x(win(1)+find(temp)-1)'];
                part(ii,jj) = ~isempty(find(temp,1));
            end

            Thist = [Thist; thist];
            onset = round(min(thist)*15);
            
            
            if ~ isempty(onset)
                y = permute(mean(a(ii,:,:),2),[1 3 2]);
                y_err = permute(nanstd(a(ii,:,:),[],2)/sqrt(size(a,2)),[1 3 2]);
                % model function
                model_resp = @(params, t) params(1) + params(2) * (1-exp(-t / params(3))) .* exp(-t / params(4));
                % give some initial params
                initial_params = [median(y), max(y), 1, 1];
                % fit function to data
                [fit_Ses,~,fwhm_cell] = helpers.trajectory_fit(x,y,y_err,model_resp,initial_params,onset);
                % plot fit
                t = x(find(x==0)+onset:end)-x(find(x==0)+onset);
                tt = t(1):.01:t(end);
                yy = model_resp(fit_Ses, tt);
                tempDelay = [tempDelay; min(thist) fwhm_cell(1) length(thist)];
            else 
                tempDelay = [tempDelay; nan(1,3)];
            end
            % figure
            % hold on
            % plot(tt+x(find(x==0)+onset), yy, '-','color',[0 0 0], 'linewidth',my_plt.lnwd/2);
            % % plot data
            % plot(x,y,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd) 
            % scatter(min(thist),0)
            % xlim([-1 4])
            % 
            % k = k+1;
            % title(fwhm_cell)
        end
        Party{j} = part;
        DelayGroup(end+1:end+size(tempDelay,1)) = CAIM(numexp(i),numice(j)).cclust(1);
        Delay = [Delay; tempDelay];
        a = mean(stim.resp(:,:,:),2);
        a = permute(a,[1 3 2]);
        
        RespMap = [RespMap;a];
        
        if respN(j,1) > 2
            x = stim.times(1,:)/1000;
            y = mean(a,1);
            onset = find(y(win),1);
            y_err = nanstd(a)/sqrt(size(a,1));
            % model function
            model_resp = @(params, t) params(1) + params(2) * (1-exp(-t / params(3))) .* exp(-t / params(4));
            % give some initial params
            initial_params = [median(y), max(y), 1, 1];
            % fit function to data
            [fit_Ses,cf_resp,fwhm_ses] = helpers.trajectory_fit(x,y,y_err,model_resp,initial_params,1);
            % plot fit
            t = x(find(x==0)+onset:end)-x(find(x==0)+onset);
            tt = t(1):.01:t(end);
            yy = model_resp(fit_Ses, tt);

            % figure
            % hold on
            % plot(tt+x(find(x==0)+onset), yy, '-','color',[0 0 0], 'linewidth',my_plt.lnwd/2);
            % % plot data
            % plot(x,y,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd) 
            DelaySes(j,:) = [ x(find(x==0)+onset) fwhm_ses(1) length(Thist)];
        end


%         [~,h] = sort(tempDelay(:,1),'descend');
%         a = a(h,:);
%         
%         figure
%         h = imagesc(stim.times(j,:)/1000,1:size(a,1),a,Clim);
%         set(h, 'AlphaData', ~isnan(a))
%         hold on 
%         plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
% 
%         hold off
%         box off
% 
%         ax = gca;
%         ax.XLim = [-1 3];
%         ax.XAxis.Visible = 'off'; 
%         % ax.YLim = YLim/5;
%         ax.YColor = [0 0 0];
%         ax.XColor = [0 0 0];
%         ax.Color = [1 1 1];     
%         ax.LineWidth = my_plt.lnwd;
%         ax.LineWidth = my_plt.lnwd;
%         ax.FontSize = my_plt.ftsz-3;
%         % colormap(h5,jet);
%         ylabel('cell ID')
    end
end

[APrespN_hist_x,APrespN_hist_y] = histcounts(APrespN,0:1:60,'normalization','probability');
[APrespF_hist_x,APrespF_hist_y] = histcounts(APrespF,0:.05:1,'normalization','probability');

[APallN_hist_x,APallN_hist_y] = histcounts(APallN(APallN>0),0:1:60,'normalization','probability');
[APallF_hist_x,APallF_hist_y] = histcounts(APallF(APallN>0),0:.01:1,'normalization','probability');

[AP_N_cell_hist_x,AP_N_cell_hist_y]= histcounts(AP_N_cell,0:1:60,'normalization','probability');
[AP_F_cell_hist_x,AP_F_cell_hist_y]= histcounts(AP_f_cell,0:.005:1,'normalization','probability');

resp_stats = [mean(APrespF) median(APrespF) std(APrespF) std(APrespF)/sqrt(length(APrespF)) APrespF_hist_y(max(APrespF_hist_x)==APrespF_hist_x)];
[BF, BC] = helpers.bimodalitycoeff(APrespF_hist_x);
all_stats = [mean(APallF) median(APallF) std(APallF) std(APallF)/sqrt(length(APallF)) APallF_hist_y(max(APallF_hist_x)==APallF_hist_x) sum(APallF==0)/length(APallF)];

%%
figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 15 12],...
    'PaperUnits','centimeters',...
    'PaperSize',[15 12],...
    'visible','on')

ploto = [ axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter'); 
        axes('Units','centimeter');
        axes('Units','centimeter')
        ];


% Mouse wise reponded APs per cell
axes(ploto(1))
set(gca,'Position',[1 9 5 2]);
boxplot(APrespN,group)
ylim([0 60])
ax = gca;
ax.XLabel.String = 'mouse ID';
ax.YLabel.String = 'respondet AP per cell';
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off

% Pool all mice
axes(ploto(2))
set(gca,'Position',[7 9 1.5 2]);
boxplot(APrespN)
hold on
barh(APrespN_hist_y(1:end-1),APrespN_hist_x*2)
xlim([0 1.2])
ylim([0 60])
ax = gca;
ax.XTickLabel = ' ';
ax.XLabel.String = 'all';
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off

% Mouse wise responded fraction
axes(ploto(3))
set(gca,'Position',[1 5 5 2]);
boxplot(APrespF,group)
ylim([0 1])
ax = gca;
ax.XLabel.String = 'mouse ID';
ax.YLabel.String = 'respondet AP fraction';
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off

% Pool all mice
axes(ploto(4))
set(gca,'Position',[7 5 1.5 2]);
boxplot(APrespF)
hold on
barh(APrespF_hist_y(1:end-1),APrespF_hist_x*2)
xlim([0 1.2])
ylim([0 1])
ax = gca;
% ax.XTickLabel = 'all';
ax.XTickLabel = ' ';
ax.XLabel.String = 'all';
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off

% Pool with normal histogram
axes(ploto(5))
set(gca,'Position',[1 1 2 2]);
bar(APrespF_hist_y(1:end-1),APrespF_hist_x,1,'facecolor',[.5 .5 .5],'LineStyle','none')
hold on
plot(APrespF_hist_y(1:end-1),cumsum(APrespF_hist_x)/sum(APrespF_hist_x),'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd)
ax = gca;
ax.XLabel.String = 'respondet AP fraction';
ax.YLabel.String = 'fraction of responding GCs';
ax.XTick = [0:.25:1];
ax.YLim = [0 1];
ax.XLim = [0 .7];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off
hold off

% Cumulative fraction of GCS
delete(ploto(6).Children)
axes(ploto(6))
set(gca,'Position',[5 1 2 2]);

bar(APallF_hist_y(1:end-1),APallF_hist_x,1,'facecolor',[.5 .5 .5],'LineStyle','none')
hold on
plot(APallF_hist_y(1:end-1),cumsum(APallF_hist_x)/sum(APallF_hist_x),'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
% bar(APallN_hist_y(1:end-1),APallN_hist_x,1,'facecolor',[.5 .5 .5],'LineStyle','none')
% hold on
% plot(APallN_hist_y(1:end-1),cumsum(APallN_hist_x)/sum(APallN_hist_x),'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd)
ax = gca;
ax.XLabel.String = 'respondet AP fraction';
ax.YLabel.String = 'cumulative fraction of all GCs';
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
ax.YLim = [0 1];
ax.XLim = [0 .7];
box off
hold off

% Pie chart for responder percentage
delete(ploto(7).Children)
axes(ploto(7))
set(gca,'Position',[7.5 1 2 2]);

pie_data = [length(APrespF)/length(APallF) (sum(APallN>0)-length(APrespF))/length(APallF) sum(APallN==0)/length(APallN)];

my_pie = piechart(pie_data);
my_pie.ColorOrder(1,:) = my_plt.mycol(2,:);
my_pie.ColorOrder(2,:) = my_plt.mycol(1,:);
my_pie.ColorOrder(3,:) = my_plt.mycol(6,:);
my_pie.FaceAlpha = 1;
my_pie.Labels = [];


 
delete(ploto(8).Children)
axes(ploto(8))
set(gca,'Position',[10.5 1 2 2]);

AP_F_shuf_cs = zeros(1000);
AP_F_med = zeros(1,1000);
for i = 1:1000
    [AP_F_cell_shuf_hist_x,AP_F_cell_shuf_hist_y]= histcounts(Shuf.Fresp(:,i),0:.001:1,'normalization','probability');
    AP_F_med(i) = mean(Shuf.Fresp(:,i));
    AP_F_shuf_cs(i,:) = cumsum(AP_F_cell_shuf_hist_x)/sum(AP_F_cell_shuf_hist_x);
end
% p value of permutation test
p_AP_F = sum(abs(mean(AP_f_cell))>abs(AP_F_med))/1000;

hold on
x = AP_F_cell_shuf_hist_y(1:end-1);
y = mean(AP_F_shuf_cs);
b = std(AP_F_shuf_cs)*2;
fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(6,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)

plot(x,y,'color',my_plt.mycol(6,:),'linewidth',my_plt.lnwd)

% bar(AP_N_cell_hist_y(1:end-1),AP_N_cell_hist_x,1,'facecolor',[.5 .5 .5],'LineStyle','none')
% hold on
% plot(AP_N_cell_hist_y(1:end-1),cumsum(AP_N_cell_hist_x)/sum(AP_N_cell_hist_x),'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
bar(AP_F_cell_hist_y(1:end-1),AP_F_cell_hist_x,1,'facecolor',[.5 .5 .5],'LineStyle','none')

plot(AP_F_cell_hist_y(1:end-1),cumsum(AP_F_cell_hist_x)/sum(AP_F_cell_hist_x),'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
ax = gca;
ax.XLabel.String = 'fraction of GCs';
ax.YLabel.String = 'fraction of APs'; 
% ax.XTick = [0:.25:1];
% ax.YLim = [0 .1];
ax.XLim = [0 .1];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off
hold off


% print(gcf, '-dpdf', '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/APresponseN'); 

print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\APresponseN'); 
%% plot number of cells & reponders per mouse

figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 26 20],...
    'PaperUnits','centimeters',...
    'PaperSize',[26 20],...
    'visible','on')

plota = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotb = [axes('Units','centimeter')
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

plotd = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

set(plota,'Position',[1 1 2.5 2]);
for i = 1:length(plota)
    temppos = get(plota(i),"Position");
    temppos(2) = temppos(2)+(i-1)*3.5;
    set(plota(i),"Position",temppos);
end

set(plotb,'Position',[5 1 2 2]);
for i = 1:length(plotb)
    temppos = get(plotb(i),"Position");
    temppos(2) = temppos(2)+(i-1)*3;
    set(plotb(i),"Position",temppos);
end

set(plotc(1),'Position',[8 1 2.5 2]);
set(plotc(2),'Position',[8 4 2 2]);
set(plotc(3),'Position',[8 7 2 2]);
set(plotc(4),'Position',[8 10 2 2]);
set(plotc(5),'Position',[8 13 2 2]);

set(plotd,'Position',[11 1 2.5 2]);
for i = 1:length(plotd)
    temppos = get(plotd(i),"Position");
    temppos(2) = temppos(2)+(i-1)*3;
    set(plotd(i),"Position",temppos);
end

n_cells = zeros(1,length(numice));
n_resp = zeros(1,length(numice));
for j = 1:length(numice)
    i = 1;
    stim = CAIM(numexp(i),numice(j)).airpuff;
    if ~isempty(stim)
        n_cells(j) = size(CAIM(numexp(i),numice(j)).S,1);
        n_resp(j) = size(stim.cellID,1);
    end      
end
perc_resp = 100 * n_resp./n_cells;

delete(plota(1).Children)
axes(plota(1))

b = bar(n_cells);
b.BarWidth = 0.7;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData = my_plt.mycol(6,:);

n_mean = round([mean(n_cells), std(n_cells), std(n_cells)/sqrt(length(n_cells)), sum(n_cells)]);
title(['n = ' num2str(n_mean(4)) ', mean = ' num2str(n_mean(1)) ' \pm ' num2str(n_mean(3))])
ax = gca;
% ax.XLim = [-1 3];
% ax.YLim = [1 3];
% YLim = ax.YLim;
% ax.YLim = [1 YLim(2)];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabel = mouse_id(numice);
box('off')

delete(plota(2).Children)
axes(plota(2))

b = bar(n_resp);
b.BarWidth = 0.7;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData = my_plt.mycol(2,:);
n_resp_mean = round([mean(n_resp), std(n_resp), std(n_resp)/sqrt(length(n_resp)), sum(n_resp)],2);
title(['n = ' num2str(n_resp_mean(4)) ', mean = ' num2str(n_resp_mean(1)) ' \pm ' num2str(n_resp_mean(3))])
ax = gca;
% ax.XLim = [-1 3];
% ax.YLim = [1 3];
% YLim = ax.YLim;
% ax.YLim = [1 YLim(2)];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabel = mouse_id(numice);
box('off')

delete(plota(3).Children)
axes(plota(3))

b = bar(perc_resp);
b.BarWidth = 0.7;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData = my_plt.mycol(2,:);
perc_resp_mean = round([mean(perc_resp), std(perc_resp), std(perc_resp)/sqrt(length(perc_resp)), 100*n_resp_mean(4)/n_mean(4)],2);
title(['total = ' num2str(perc_resp_mean(4)) '%, mean = ' num2str(perc_resp_mean(1)) ' \pm ' num2str(perc_resp_mean(3))])
ax = gca;
% ax.XLim = [-1 3];
% ax.YLim = [1 3];
% YLim = ax.YLim;
% ax.YLim = [1 YLim(2)];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabel = mouse_id(numice);
box('off')


[resp,values,RecValues] = helpers.qtf_response(CAIM,numexp,numice,stdsig,mouse_id,'airpuff');
title_in = '';
do_plot = 0;

delete(plotb(1).Children)
axes(plotb(1))

hold on
plot([0 1],[0 1],'--','color',[0 0 0])
numsteps    = 50;
numit       = 1000;
for j = 1:size(RecValues,2)
    numstim = size(RecValues(j).pupil,1);
    if ~isempty(RecValues(j).bulk_pre)
        
        Resp_bulk      = zeros(numstim,2);
        Resp_bulk(:,1) = [RecValues(j).bulk_pre]';
        Resp_bulk(:,2) = [RecValues(j).bulk_post]';
        [auc,~,roc_resp] = helpers.roc_ap(Resp_bulk,numsteps,numit,do_plot,title_in); 
        % disp(auc)
        plot(roc_resp(:,2),roc_resp(:,1),'color',[.5 .5 .5],LineWidth=my_plt.lnwd/2)
    end 
end
Resp_bulk      = zeros(size(values.bulk_pre,1),2);
Resp_bulk(:,1) = [values.bulk_pre]';
Resp_bulk(:,2) = [values.bulk_post]';
[~,~,roc_resp] = helpers.roc_ap(Resp_bulk,numsteps,numit,do_plot,title_in); 
plot(roc_resp(:,2),roc_resp(:,1),'color',my_plt.mycol(5,:),LineWidth=my_plt.lnwd)

delete(plotb(2).Children)
axes(plotb(2))

hold on
plot([0 1],[0 1],'--','color',[0 0 0])
for j = 1:size(RecValues,2)
    numstim = size(RecValues(j).pupil,1);
    Resp_pupil      = zeros(numstim,2);
    Resp_pupil(:,2) = [RecValues(j).pupil_pre_pre]'-[RecValues(j).pupil_pre]';
    Resp_pupil(:,1) = [RecValues(j).pupil_post]'-[RecValues(j).pupil_pre]';
    Resp_pupil(isnan(Resp_pupil(:,1)),:)= [];
    Resp_pupil(isnan(Resp_pupil(:,2)),:)= [];
    [auc,~,roc_resp] = helpers.roc_ap(Resp_pupil,numsteps,numit,do_plot,title_in); 
    % disp(auc)
    plot(roc_resp(:,2),roc_resp(:,1),'color',[.5 .5 .5],LineWidth=my_plt.lnwd/2)
end
Resp_pupil      = zeros(size(values.pupil,1),2);
Resp_pupil(:,2) = [values.pupil_pre_pre]'-[values.pupil_pre]';
Resp_pupil(:,1) = [values.pupil_post]'-[values.pupil_pre]';
Resp_pupil(isnan(Resp_pupil(:,1)),:)= [];
Resp_pupil(isnan(Resp_pupil(:,2)),:)= [];
[~,~,roc_resp] = helpers.roc_ap(Resp_pupil,numsteps,numit,do_plot,title_in); 
plot(roc_resp(:,2),roc_resp(:,1),'color',my_plt.mycol(3,:),LineWidth=my_plt.lnwd)

delete(plotb(3).Children)
axes(plotb(3))
hold on
roc_auc = zeros(size(RecValues,2),3);
plot([0 1],[0 1],'--','color',[0 0 0])
for j = 1:size(RecValues,2)
    numstim = size(RecValues(j).pupil,1);
    NonResp_Ca      = zeros(numstim,2);
    NonResp_Ca(:,1) = [RecValues(j).CaNonResp_pre]';
    NonResp_Ca(:,2) = [RecValues(j).CaNonResp_post]';
    [roc_auc(j,3),~,roc_resp] = helpers.roc_ap(NonResp_Ca,numsteps,numit,do_plot,title_in); 
    plot(roc_resp(:,2),roc_resp(:,1),'color',[.5 .5 .5],LineWidth=my_plt.lnwd/2)
end

NonResp_Ca      = zeros(size(values.CaResp,1),2);
NonResp_Ca(:,1) = [values.CaNonResp_pre]';
NonResp_Ca(:,2) = [values.CaNonResp_post]';
[~,~,roc_resp] = helpers.roc_ap(NonResp_Ca,numsteps,numit,do_plot,title_in);
plot(roc_resp(:,2),roc_resp(:,1),'color',my_plt.mycol(1,:),LineWidth=my_plt.lnwd)

delete(plotb(4).Children)
axes(plotb(4))
hold on
plot([0 1],[0 1],'--','color',[0 0 0])
for j = 1:size(RecValues,2)
    numstim = size(RecValues(j).pupil,1);
    Resp_Ca      = zeros(numstim,2);
    Resp_Ca(:,1) = [RecValues(j).CaResp_pre]';
    Resp_Ca(:,2) = [RecValues(j).CaResp_post]';
    [roc_auc(j,2),~,roc_resp] = helpers.roc_ap(Resp_Ca,numsteps,numit,do_plot,title_in); 
    plot(roc_resp(:,2),roc_resp(:,1),'color',[.5 .5 .5],LineWidth=my_plt.lnwd/2)
end

Resp_Ca      = zeros(size(values.CaResp,1),2);
Resp_Ca(:,1) = [values.CaResp_pre]';
Resp_Ca(:,2) = [values.CaResp_post]';
[~,~,roc_resp] = helpers.roc_ap(Resp_Ca,numsteps,numit,do_plot,title_in); 
plot(roc_resp(:,2),roc_resp(:,1),'color',my_plt.mycol(2,:),LineWidth=my_plt.lnwd)

delete(plotb(5).Children)
axes(plotb(5))
hold on
plot([0 1],[0 1],'--','color',[0 0 0])
for j = 1:size(RecValues,2)
    numstim = size(RecValues(j).pupil,1);
    Ca      = zeros(numstim,2);
    Ca(:,1) = [RecValues(j).Ca_pre]';
    Ca(:,2) = [RecValues(j).Ca_post]';
    [roc_auc(j,1),~,roc_resp] = helpers.roc_ap(Ca,numsteps,numit,do_plot,title_in); 
    plot(roc_resp(:,2),roc_resp(:,1),'color',[.5 .5 .5],LineWidth=my_plt.lnwd/2)
end

Ca      = zeros(size(values.CaResp,1),2);
Ca(:,1) = [values.Ca_pre]';
Ca(:,2) = [values.Ca_post]';
[~,~,roc_resp] = helpers.roc_ap(Ca,numsteps,numit,do_plot,title_in); 
plot(roc_resp(:,2),roc_resp(:,1),'color',[0 0 0],LineWidth=my_plt.lnwd)

delete(plotb(6).Children)
axes(plotb(6))
hold on
plot([0 1],[0 1],'--','color',[0 0 0])


Ca      = zeros(size(values.CaResp,1),2);
Ca(:,1) = [values.Ca_pre]';
Ca(:,2) = [values.Ca_post]';
[~,~,roc_resp] = helpers.roc_ap(Ca,numsteps,numit,do_plot,title_in); 
plot(roc_resp(:,2),roc_resp(:,1),'color',[0 0 0 ],LineWidth=my_plt.lnwd)

Resp_Ca      = zeros(size(values.CaResp,1),2);
Resp_Ca(:,1) = [values.CaResp_pre]';
Resp_Ca(:,2) = [values.CaResp_post]';
[~,~,roc_resp] = helpers.roc_ap(Resp_Ca,numsteps,numit,do_plot,title_in); 
plot(roc_resp(:,2),roc_resp(:,1),'color',my_plt.mycol(2,:),LineWidth=my_plt.lnwd)

NonResp_Ca      = zeros(size(values.CaResp,1),2);
NonResp_Ca(:,1) = [values.CaNonResp_pre]';
NonResp_Ca(:,2) = [values.CaNonResp_post]';
[~,~,roc_resp] = helpers.roc_ap(NonResp_Ca,numsteps,numit,do_plot,title_in);
plot(roc_resp(:,2),roc_resp(:,1),'color',my_plt.mycol(1,:),LineWidth=my_plt.lnwd) 

for i = 1:length(plotb)
    set(plotb(i),"LineWidth",my_plt.lnwd);
    set(plotb(i),"FontSize",my_plt.ftsz-3);
    plotb(i).XLabel.String =['false positives'];
    plotb(i).YLabel.String =['true positives'];
end


delete(plotc(1).Children)
axes(plotc(1))

hold on
boxplot(roc_auc)

h = findobj(gca);
% h1 = findobj(gca,'Tag','Box');
% h2 = findobj(gca,'Tag','Median');
% h3 = findobj(gca,'Tag','Upper Whisker');
BoxColors = [[0 0 0 ];my_plt.mycol(1,:);my_plt.mycol(2,:)];
% h(3).MarkerEdgeColor = [.7 .7 .7];
% h(4).MarkerEdgeColor = [.7 .7 .7];
h(3).MarkerEdgeColor = [.7 .7 .7];
for j=5:3:length(h)-2
    h(j).Color = BoxColors(1,:);
    h(j+1).Color = BoxColors(2,:);
    h(j+2).Color = BoxColors(3,:);
%     patch(get(h(j),'XData'),get(h(j),'YData'),BoxColors(j,:),'FaceAlpha',.5);
end
plot(roc_auc','Color',[.5 .5 .5])
box off

ylabel('AUC')

% repeated measures for the AUC
T = array2table(roc_auc, 'VariableNames', {'All', 'Resps', 'NonResps'});
rm = fitrm(T, 'All-NonResps ~ 1', 'WithinDesign', table([1 2 3]','VariableNames',{'AUC'}));
% ranova_result = ranova(rm)
results = multcompare(rm, 'AUC', 'ComparisonType', 'bonferroni');

%

delete(plotc(2).Children)
axes(plotc(2))

plot([0 1],[0 1],'--','color',[0 0 0])
hold on
ind_auc = [];
for i =1:length(ROC)
    rocs = ROC(i).ROC_resp;
    ind_auc = [ind_auc; ROC(i).auc];
    for j = 1:length(rocs)
        roc_resp = rocs{j};
        plot(roc_resp(:,2),roc_resp(:,1),'color',my_plt.mycol(2,:),LineWidth=my_plt.lnwd/4) 
    end
end

box off
plotc(2).XLabel.String =['false positives'];
plotc(2).YLabel.String =['true positives'];

delete(plotc(3).Children)
axes(plotc(3))

hold on
auc_group = cell(length(ind_auc),1);
auc_group(:) = {'cells'};
auc_group(end+1:end+size(roc_auc,1)) = {'ensemble'};
boxplot([ind_auc;roc_auc(:,2)],auc_group)


% h = findobj(gca);
% % h1 = findobj(gca,'Tag','Box');
% % h2 = findobj(gca,'Tag','Median');
% % h3 = findobj(gca,'Tag','Upper Whisker');
% BoxColors = [[0 0 0 ];my_plt.mycol(1,:);my_plt.mycol(2,:)];
% % h(3).MarkerEdgeColor = [.7 .7 .7];
% % h(4).MarkerEdgeColor = [.7 .7 .7];
% h(3).MarkerEdgeColor = [.7 .7 .7];
% for j=5:3:length(h)-2
%     h(j).Color = BoxColors(1,:);
%     h(j+1).Color = BoxColors(2,:);
%     h(j+2).Color = BoxColors(3,:);
% %     patch(get(h(j),'XData'),get(h(j),'YData'),BoxColors(j,:),'FaceAlpha',.5);
% end

box off
ylabel('AUC')



delete(plotc(4).Children)
axes(plotc(4))

[r,p] = corr(perc_resp',roc_auc(:,2));
scatter(perc_resp,roc_auc(:,2),6,my_plt.mycol(2,:),"filled")

ax = gca;
ax.YLim = [.5 1];
ax.XTick = 1:5;
ylabel('AUC')
xlabel('responders (%)')


delete(plotc(5).Children)
axes(plotc(5))

[r,p] = corr(n_resp',roc_auc(:,2));
scatter(n_resp,roc_auc(:,2),6,my_plt.mycol(2,:),"filled")

ax = gca;
ax.YLim = [.5 1];
ylabel('AUC')
xlabel('responders (n)')
for i = 1:length(plotc)
    set(plotc(i),"LineWidth",my_plt.lnwd);
    set(plotc(i),"FontSize",my_plt.ftsz-3);
end

delete(plotd(1).Children)
axes(plotd(1))

b = bar(Nstim);
b.BarWidth = 0.7;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData = my_plt.mycol(5,:);

n_mean = round([mean(Nstim), std(Nstim), std(Nstim)/sqrt(length(Nstim)), sum(Nstim)]);
title(['n = ' num2str(n_mean(4)) ', mean = ' num2str(n_mean(1)) ' \pm ' num2str(n_mean(3))])
ax = gca;
% ax.XLim = [-1 3];
% ax.YLim = [1 3];
% YLim = ax.YLim;
% ax.YLim = [1 YLim(2)];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTickLabel = mouse_id(numice);
box('off')

delete(plotd(2).Children)
axes(plotd(2))

bin_int = 3;
bins = 0:bin_int:60;
x = bins(2:end)-bin_int/2;
Int_run_hist = histcounts(Int_run_int,bins);
b = bar(x,Int_run_hist);
b.BarWidth = 0.7;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData = my_plt.mycol(5,:);

xlabel('stop to AP time (s)')
ylabel('counts')
ax = gca;
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
box('off')

delete(plotd(3).Children)
axes(plotd(3))

Int_ap_hist = histcounts(Int_ap_int,bins);
b = bar(x,Int_ap_hist);
b.BarWidth = 0.7;
b.FaceColor = 'flat';
b.LineStyle = 'none';
% b.LineWidth = my_plt.lnwd ;
b.CData = my_plt.mycol(5,:);

xlabel('inter AP time (s)')
ylabel('counts')
ax = gca;
% ax.XLim = [-1 3];
% ax.YLim = [1 3];
% YLim = ax.YLim;
% ax.YLim = [1 YLim(2)];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
box('off')

% print(gcf, '-dpdf', '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/Time'); 

print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\ROC');
%%
figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 26 10],...
    'PaperUnits','centimeters',...
    'PaperSize',[26 10],...
    'visible','on')

plotp1 = axes('Units','centimeter');
plotp2 = axes('Units','centimeter');
plotp3 = axes('Units','centimeter');
plotp4 = axes('Units','centimeter');
plotp5 = axes('Units','centimeter');
plotp6 = axes('Units','centimeter');
plotp7 = axes('Units','centimeter');
plotp8 = axes('Units','centimeter');
plotp9 = axes('Units','centimeter');
plotp10 = axes('Units','centimeter');
plotp11 = axes('Units','centimeter');

axes(plotp1)
set(gca,'Position',[2 6 2 2]);
scatter(APf,APrespF,'.','MarkerEdgeColor',my_plt.mycol(2,:))
[r,p] = corr(APf,APrespF);
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTick = 0:3:50;
ax.XLim = [0 10];
ylabel('frac of responed APs')
xlabel('events/min')
title(["responded APs vs cell activity",['r = ' num2str(round(r,2)) ', p = ' num2str(round(p,3))]])

% filename = '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/fig1 - stats.xlsx';
% writematrix(APf',filename,'Sheet',1,'Range','b3:ba3')
% writematrix(APrespF',filename,'Sheet',1,'Range','b4:ba4')
% writematrix(r,filename,'Sheet',1,'Range','b5')
% writematrix(p,filename,'Sheet',1,'Range','b6')

axes(plotp2)
set(gca,'Position',[6 6 2 2]);
bins = 0:min(Delay(:,1)):1;
y = histcounts(Delay(:,1),bins,'normalization','probability');
bar(bins(1:end-1),y,1,'facecolor',[.5 .5 .5],'LineStyle','none')
hold on
y = cumsum(y);
plot(bins(2:end),y,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd)
ax = gca;
ax.XLim = [0 1];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ylabel('probability')
xlabel('Onset Delay after AP (s)')
title('Response Onset delay per cell')
box off

axes(plotp3)
set(gca,'Position',[6 2 2 2]);
bins = 0:min(Delay(:,2)/1000)*2:4;
y = histcounts(Delay(:,2)/1000,bins,'normalization','probability');
bar(bins(1:end-1),y,1,'facecolor',[.5 .5 .5],'LineStyle','none')
hold on
y = cumsum(y);
plot(bins(2:end),y)
ax = gca;
ax.XLim = [0 4];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ylabel('probability')
xlabel('FWHM of fitted response (s)')
title('Reponse FWHM per cell')
box off

axes(plotp4)
set(gca,'Position',[10 6 2.5 3]);

[~,h] = sort(Delay(:,1),'descend');
APrespN_hist_x = RespMap(h,:);

YLim = [0 size(APrespN_hist_x,1)];
% scatter(sort(Delay(:,1)),1:size(Delay,1))
[x,h] = sort(Delay(:,1),'descend');
y = 1:size(Delay,1);
xneg = [];
xpos = Delay(h,2)/1000;
errorbar(x,y,[],[],xneg,xpos,'.','Color',my_plt.mycol(2,:))
hold on
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
% xlim([1 15])
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XLim = [-1 3];
ax.XAxis.Visible = 'off'; 
% % ax.YLim = YLim/5;
% ax.YColor = [0 0 0];
% ax.XColor = [0 0 0];
% ax.Color = [1 1 1];     
% ax.LineWidth = my_plt.lnwd;
% ax.FontSize = my_plt.ftsz-3;
ax.YLim = YLim;
% colormap(h5,jet);
ylabel('cell ID')
xlabel('time(s)')
box off
title('Reponse onset with delay')



axes(plotp5)
delete(plotp5.Children)

set(gca,'Position',[10 1 2.5 3]);

for i = 1:size(APrespN_hist_x,1)
    APrespN_hist_x(i,:) = zscore(APrespN_hist_x(i,:));
    % a(i,:) = (a(i,:)-min(a(i,:)))/max((a(i,:)-min(a(i,:))));
    % a(i,:) = a(i,:)/max(a(i,:));
    % a(i,:) = a(i,:)*100;   
    % a(i,:) = a(i,:)-min(a(i,:));
end

Clim = [-.5 8];
h = imagesc(stim.times(j,:)/1000,size(APrespN_hist_x,1):-1:1,APrespN_hist_x,Clim);
set(h, 'AlphaData', ~isnan(APrespN_hist_x))
hold on 
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)

% colorbar 
hold off
box off

ax = gca;
ax.XLim = [-1 3];
ax.XAxis.Visible = 'off'; 
% ax.YLim = YLim;
% ax.YColor = [0 0 0];
% ax.XColor = [0 0 0];
% ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% colormap(h5,jet);
ylabel('cell ID')
xlabel('time(s)')
title('Sorted response maps')

axes(plotp6)
set(gca,'Position',[14 6 2 2]);


scatter(Delay(:,1),Delay(:,2)/1000,'.','MarkerEdgeColor',my_plt.mycol(2,:))
[r,p] = corr(Delay(:,1),Delay(:,2)/1000);
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
xlabel('delay of response(s)')
ylabel('resp FWHM (s)')
title(['FWHM against Delay'], ['r = ' num2str(round(r,2)) ', p = ' num2str(round(p,3))])

axes(plotp7)
set(gca,'Position',[14 2 1.5 2]);

x = [DelaySes(:,2); Delay(:,2)]/1000;
g = {};
g(1:size(DelaySes,1)) = {'Session'};
g(end+1:end+size(Delay,1)) = {'Cell'};
boxplot(x,g)
ylabel('response FWHM (s)')
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.YLim = [0 4];
title(['FWHM session vs. cell'])

axes(plotp8)
set(gca,'Position',[17 2 3.5 2]);

boxplot(Delay(:,2)/1000,DelayGroup)
hold on
scatter(1:9,DelaySes(:,2)/1000,'*')
hold off
ylabel('response FWHM (s)')
ax = gca;
ax.YLim = [0 4];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
title(['session wise FWHM'])

axes(plotp9)
set(gca,'Position',[18 6 2 2]);

scatter(Delay(:,1),APrespF,'.','MarkerEdgeColor',my_plt.mycol(2,:))
[r,p] = corr(Delay(:,1),APrespF);
ax = gca;
ax.YLim = [0 4];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3; 
xlabel('delay of response(s)')
ylabel('frac of responed APs')
title(['response frac vs. delay'],['r = ' num2str(round(r,2)) ', p = ' num2str(round(p,3))])

axes(plotp10)
set(gca,'Position',[22 6 2 2]);
scatter(Delay(:,1),APf,'.','MarkerEdgeColor',my_plt.mycol(2,:))
[r,p] = corr(Delay(:,1),APf);
ax = gca;
ax.YLim = [0 4];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3; 
xlabel('delay of response (s)')
ylabel('events/min')
title(['activity vs. delay'],[ 'r = ' num2str(round(r,2)) ', p = ' num2str(round(p,3))])

Run_frac = [];
for j = 1:size(RecValues,2)
    run_frac = RecValues(j).run_frac;    
    Run_frac = [Run_frac; run_frac];
end

axes(plotp11)
set(gca,'Position',[22 2 2 2]);
scatter(Run_frac,Delay(:,1),'.','MarkerEdgeColor',my_plt.mycol(2,:))
ax = gca;
% ax.YLim = [0 4];
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3; 
xlabel('fraction of run-init')
ylabel('delay of response (s)')
% title(['activity vs. delay'],[ 'r = ' num2str(round(r,2)) ', p = ' num2str(round(p,3))])


% print(gcf, '-dpdf', '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/ReponderProperties'); 

print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\ReponderProperties'); 
