% Cross correlation panels
numshuf = 1000;
[traces,ALLCELLS,OTHERCELLS,SHUFFLE] = helpers.noiseCorrPool(CAIM,Df_f,0,numshuf);
%%
figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 30 5],...
    'PaperUnits','centimeters',...
    'PaperSize',[30 5],...
    'visible','on')

XLim = [-1 1];
lagnoise = traces.lagnoise;
x = traces.x;
dtt = traces.dtt;

plotp = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

set(plotp,'Position',[1 2 2 2]);
for i = 1:length(plotp)
    temppos = get(plotp(i),"Position");
    temppos(1) = temppos(1)+(i-1)*3.5;
    set(plotp(i),"Position",temppos);
end

%%%
axes(plotp(1))
hold on

% z-score values
y = nanmean(traces.mean_epochGC,1);
win = 1:15;
Zmean = mean(y(win)); 
y = y - Zmean;
Zstd = std(y(win));
y = y/Zstd;
yerr = nanstd((traces.mean_epochGC-Zmean)/Zstd,1)/sqrt(size(traces.mean_epochGC,1));

plot(x,y,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd);
fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],my_plt.mycol(2,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)


y = nanmean(traces.mean_otherGC,1);
Zmean = mean(y(win)); 
y = y - Zmean;
Zstd = std(y(win));
y = y/Zstd;
% y = zscore(y);
yerr = nanstd((traces.mean_otherGC-Zmean)/Zstd,1)/sqrt(size(traces.mean_otherGC,1));
plot(x,y,'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd);
fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],my_plt.mycol(1,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)


y = mean(traces.mean_MPP,1);
Zmean = mean(y(win)); 
y = y - Zmean;
Zstd = std(y(win));
y = y/Zstd;
yerr = nanstd((traces.mean_MPP-Zmean)/Zstd,1)/sqrt(size(traces.mean_MPP,1));
plot(x,y,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd);
fill([x,fliplr(x)],[y-yerr,fliplr(y+yerr)],my_plt.mycol(5,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)

% legend({'responding GCs','','other GCs','','MPP'},'Location','northwest')
% legend('boxoff')


title('Mean responses after AP')
xlabel('time(s)')
xlim(XLim)
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off

%%%
axes(plotp(2))
hold on

y = nanmean(ALLCELLS.Signal_corr,1);
yerr = nanstd(ALLCELLS.Signal_corr,1)/sqrt(size(ALLCELLS.Signal_corr,1));
plot(lagnoise*dtt,y,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd)
fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],my_plt.mycol(1,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)

y = nanmean(OTHERCELLS.Signal_corr,1);
yerr = nanstd(OTHERCELLS.Signal_corr,1)/sqrt(size(OTHERCELLS.Signal_corr,1));
plot(lagnoise*dtt,y,'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],my_plt.mycol(1,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)


% legend({'responding GCs','','other GCs'},'Location','northwest')
% legend('boxoff')

title('Signal correlation')
xlabel('Lag (s)')
xlim(XLim)
ax = gca;
ax.XTick = -1:.5:1;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off

%%%
axes(plotp(3))
delete(plotp(3).Children)
hold on

mpp_in = (mean(traces.mean_MPP,1));
gc_nresp = (nanmean(traces.mean_otherGC,1));
gc_resp = (nanmean(traces.mean_epochGC,1));

% y = xcorr(mpp_in',gc_resp','coeff');
y = mean(ALLCELLS.ALLCELLS_Mean_corr);
yerr = nanstd(ALLCELLS.ALLCELLS_Mean_corr,1)/sqrt(size(ALLCELLS.ALLCELLS_Mean_corr,1));
plot(lagnoise*dtt,y,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd)
fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],my_plt.mycol(1,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)


% y = xcorr(mpp_in',gc_nresp','coeff');
y = nanmean(OTHERCELLS.ALLCELLS_Mean_corr);
yerr = nanstd(OTHERCELLS.ALLCELLS_Mean_corr,1)/sqrt(size(OTHERCELLS.ALLCELLS_Mean_corr,1));
plot(lagnoise*dtt,y,'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
fill([lagnoise*dtt,fliplr(lagnoise*dtt)],[y-yerr,fliplr(y+yerr)],my_plt.mycol(1,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)

title('Ensemble Correlation')
xlabel('Lag (s)')
xlim(XLim)
ax = gca;
ax.XTick = -1:.5:1;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
box off
%%%
axes(plotp(4))
% set(gca,'Position',[11 2 2 2]);

g = cell(length(ALLCELLS.corr_val),1);
g(:) = {'responder'};
g(end+1:end+length(OTHERCELLS.corr_val)) = {'non-responder'};
g(end+1:end+length(SHUFFLE.corr_val(:))) = {'shuffle'} ;
cg = cell(length(ALLCELLS.corr_val),1);
cg(:) = {my_plt.mycol(2,:)};
cg(end+1:end+length(OTHERCELLS.corr_val)) = {my_plt.mycol(1,:)};
cg(end+1:end+length(SHUFFLE.corr_val)) = {[.5 .5 .5]} ;


boxplot([ALLCELLS.corr_val;OTHERCELLS.corr_val;SHUFFLE.corr_val(:)],g)
% boxchart(categorical(g),[ALLCELLS.corr_val;OTHERCELLS.corr_val;SHUFFLE.corr_val],'GroupByColor',cg)
h = findobj(gca);
% h1 = findobj(gca,'Tag','Box');
% h2 = findobj(gca,'Tag','Median');
% h3 = findobj(gca,'Tag','Upper Whisker');
BoxColors = [[.5 .5 .5];my_plt.mycol(1,:);my_plt.mycol(2,:)];
h(3).MarkerEdgeColor = [.7 .7 .7];
h(4).MarkerEdgeColor = [.7 .7 .7];
h(5).MarkerEdgeColor = [.7 .7 .7];
for j=6:3:length(h)-2
    h(j).Color = BoxColors(1,:);
    h(j+1).Color = BoxColors(2,:);
    h(j+2).Color = BoxColors(3,:);
%     patch(get(h(j),'XData'),get(h(j),'YData'),BoxColors(j,:),'FaceAlpha',.5);
end
title('Individiual correlations')
ylabel('r-values')
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;  
box off
% set(gca,'Position',[11 2 2 2]);

%%%%
axes(plotp(5))

g = cell(length(ALLCELLS.Noise_corr_val),1);
g(:) = {'responder'};
g(end+1:end+length(OTHERCELLS.Noise_corr_val)) = {'non-responder'};
g(end+1:end+length(SHUFFLE.Noise_corr_val(:))) = {'shuffle'} ;

boxplot([ALLCELLS.Noise_corr_val;OTHERCELLS.Noise_corr_val;SHUFFLE.Noise_corr_val(:)],g)
% boxchart(categorical(g),[ALLCELLS.corr_val;OTHERCELLS.corr_val;SHUFFLE.corr_val],'GroupByColor',cg)
h = findobj(gca);
% h1 = findobj(gca,'Tag','Box');
% h2 = findobj(gca,'Tag','Median');
% h3 = findobj(gca,'Tag','Upper Whisker');
BoxColors = [[.5 .5 .5];my_plt.mycol(1,:);my_plt.mycol(2,:)];
h(3).MarkerEdgeColor = [.7 .7 .7];
h(4).MarkerEdgeColor = [.7 .7 .7];
h(5).MarkerEdgeColor = [.7 .7 .7];
for j=6:3:length(h)-2
    h(j).Color = BoxColors(1,:);
    h(j+1).Color = BoxColors(2,:);
    h(j+2).Color = BoxColors(3,:);
%     patch(get(h(j),'XData'),get(h(j),'YData'),BoxColors(j,:),'FaceAlpha',.5);
end
title('Individiual nosie correlations')
ylabel('r-values')
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;  
box off
% set(gca,'Position',[15 2 2 2]);


%%%%
axes(plotp(6))

g = cell(length(ALLCELLS.corr_val),1);
g(:) = {'responder'};
g(end+1:end+length(OTHERCELLS.corr_val)) = {'non-responder'};
swarmchart(categorical(g,["responder","non-responder"]),...
    [ALLCELLS.corr_val;OTHERCELLS.corr_val],...
    1,my_plt.mycol(2,:),'filled')
hold on
y = nanmean(ALLCELLS.corr_val);
plot([.7 1.3],[y y],'color',[0 0 0])
y = nanmean(OTHERCELLS.corr_val);
plot([1.7 2.3],[y y],'color',[0 0 0])
ylabel('r-values')
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;  
box off
stats = [mean(ALLCELLS.corr_val),std(ALLCELLS.corr_val),std(ALLCELLS.corr_val)/sqrt(length(ALLCELLS.corr_val));
    mean(OTHERCELLS.corr_val),std(OTHERCELLS.corr_val),std(OTHERCELLS.corr_val)/sqrt(length(OTHERCELLS.corr_val))];
disp(stats)

%%%%
axes(plotp(7))

g = cell(length(ALLCELLS.Noise_corr_val),1);
g(:) = {'responder'};
g(end+1:end+length(OTHERCELLS.Noise_corr_val)) = {'non-responder'};
swarmchart(categorical(g,["responder","non-responder"]),...
    [ALLCELLS.Noise_corr_val;OTHERCELLS.Noise_corr_val],...
    1,my_plt.mycol(1,:),'filled')

ylabel('r-values')
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;  
box off
stats = [mean(ALLCELLS.Noise_corr_val),std(ALLCELLS.Noise_corr_val),std(ALLCELLS.Noise_corr_val)/sqrt(length(ALLCELLS.Noise_corr_val));
    mean(OTHERCELLS.Noise_corr_val),std(OTHERCELLS.Noise_corr_val),std(OTHERCELLS.Noise_corr_val)/sqrt(length(OTHERCELLS.Noise_corr_val))];
disp(stats)
hold on
y = nanmean(ALLCELLS.Noise_corr_val);
plot([.7 1.3],[y y],'color',[0 0 0])
y = nanmean(OTHERCELLS.Noise_corr_val);
plot([1.7 2.3],[y y],'color',[0 0 0])
%%%%
axes(plotp(8))

g = cell(length(ALLCELLS.Noise_corr_val),1);
g(:) = {'responder'};
g(end+1:end+length(OTHERCELLS.Noise_corr_val)) = {'non-responder'};
scatter(ALLCELLS.corr_val,ALLCELLS.Noise_corr_val,...
    5,my_plt.mycol(1,:),'filled')

ylabel('r-values')
ax = gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;  
box off
%%

% print(gcf, '-dpdf', '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/NoiseCorr.pdf'); 

print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\NoiseCorr.pdf'); 
%% stats
g = cell(length(ALLCELLS.corr_val),1);
g(:) = {'responder'};
g(end+1:end+length(OTHERCELLS.corr_val)) = {'non-responder'};
[p,tblCorr,stats] = kruskalwallis([ALLCELLS.corr_val;OTHERCELLS.corr_val],g);

g = cell(length(ALLCELLS.Noise_corr_val),1);
g(:) = {'responder'};
g(end+1:end+length(OTHERCELLS.Noise_corr_val)) = {'non-responder'};
[p,tblCorr,stats] = kruskalwallis([ALLCELLS.Noise_corr_val;OTHERCELLS.Noise_corr_val],g);

% filename = '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/fig2 - stats.xlsx';
% writecell(tblCorr,filename,'Sheet',1,'Range','a26:f29')

%% subsampling
% correaltion values
smallGroup = ALLCELLS.corr_val;
largeGroup = OTHERCELLS.corr_val;     

nIterations = 1000;
pVals = zeros(nIterations,1);

nSmall = length(smallGroup);

rng(42);  % for reproducibility

for i = 1:nIterations
    % Subsample from large group
    idx = randperm(length(largeGroup), nSmall);
    subsample = largeGroup(idx);
    
    % Mann-Whitney U test (non-parametric)
    p = ranksum(smallGroup, subsample);
    
    pVals(i) = p;
end

% Report summary
fprintf('Median p-value: %.4f\n', median(pVals));
fprintf('Proportion of p < 0.05: %.2f%%\n', mean(pVals < 0.05) * 100);

% Plot histogram of p-values
figure;
histogram(pVals, 'BinWidth', 0.05);
xlabel('p-value');
ylabel('Frequency');
title('Distribution of p-values from subsampling');
grid on;

