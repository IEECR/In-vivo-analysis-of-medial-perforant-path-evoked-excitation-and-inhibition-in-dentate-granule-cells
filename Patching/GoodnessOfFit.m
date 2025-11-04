% Global axis limits for reponses curves
my_plt.ftsz = 10;
my_plt.lnwd = 1;
% Color set used in the paper
my_plt.mycol = [119,169,180;
    72,136,163;
    237,184,30;
    209,156,44;
    211,47,38;
    175,175,175]./255; 

%%


pathname = 'C:\DATA\Patch Daten\Choice\';
files = dir([pathname '*.mat']);

MSE = zeros(1,length(files));
R2 = zeros(1,length(files));
Corr_r = zeros(1,length(files));
cell_num = zeros(1,length(files));
int_range = [-200 3000];
TIME = zeros(int_range(2)-int_range(1),length(files));
VM = zeros(int_range(2)-int_range(1),4,length(files));
REC = zeros(int_range(2)-int_range(1),4,length(files));
for i = 1:length(files)
    load([pathname files(i).name])    
    [bsln,sat,gl,C,onst,offst] = helpers.pasprop(vm,Ra,time,stim,iin);
    [vm,rec,ge,gi,gestd,gistd,mse,r2,corr_r] = helpers.inexfit(vm,vi,ve,iin,onst,offst,C,gl,bsln,stim);
    MSE(i) = mse;%sqrt(mse);
    R2(i) = r2;
    Corr_r(i) = corr_r;
    dots = strfind(files(i).name,'.');
    cell_num(i) = str2double(files(i).name(dots(2)+1:dots(2)+2));

    stimpt = find(diff(stim)*3e-5-0.1>0); % find stimulation points
    int = stimpt(end)+int_range(1)+1:stimpt(end)+int_range(2);
    TIME(:,i) = time(int) - time(stimpt(end));
    VM(:,:,i) = vm(int,:);
    REC(:,:,i) = rec(int,:);
end       


%%
colors = rand(length(files), 3);
figure
for i = 1 :length(files)
    subplot(1,3,1)
    hold on
    scatter(1,MSE(i),10,colors(i,:),'filled')
    subplot(1,3,2)
    hold on
    scatter(1,R2(i),10,colors(i,:),'filled')
    subplot(1,3,3)
    hold on
    scatter(1,Corr_r(i),10,colors(i,:),'filled', ...
            'DisplayName', sprintf('Cell %d', cell_num(i)))
end
legend show

%%
for i = 1:length(files)  
    figure
    plot(TIME(:,i),REC(:,:,i),'Color',[.5 .5 .5])
    hold on
    plot(TIME(:,i),VM(:,:,i),'Color',[0 0 0])
    title(['Cell ' num2str(cell_num(i)) ', R^2 = ' num2str(R2(i))])
end 



%%
figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 40 29],...
    'PaperUnits','centimeters',...
    'PaperSize',[40 29],...
    'visible','on')

plota = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

plotb = [axes('Units','centimeter')
    axes('Units','centimeter')];

plotc = [axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')
    axes('Units','centimeter')];

%%
% colors = hsv(length(files));%rand(length(files), 3);
color_temp = lines(7);
colors = [my_plt.mycol(1:end-1,:); color_temp([5 4 2 6],:)];
set(plota,'Position',[2 25 1.5 2]);
for i = 1:length(plota)
    temppos = get(plota(i),"Position");
    temppos(1) = temppos(1)+(i-1)*3;
    set(plota(i),"Position",temppos);
end

delete(plota(1).Children)
axes(plota(1));
for i = 1 :length(files)
    hold on
    scatter(1,MSE(i),10,colors(i,:),'filled')
end
ax =gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTick = 1;
ax.XTickLabel = 'MSE';
ax.YLim = [0 1*10^-6];
ax.YLabel.String = ['MSE value'];


delete(plota(2).Children)
axes(plota(2));
for i = 1 :length(files)
    hold on
    scatter(1,R2(i),10,colors(i,:),'filled')
end
ax =gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTick = 1;
ax.XTickLabel = 'R^2';
ax.YLim = [.99 1];
ax.YLabel.String = ['R^2 value'];

delete(plota(3).Children)
axes(plota(3));
for i = 1 :length(files)
    hold on
    scatter(1,Corr_r(i),10,colors(i,:),'filled', ...
            'DisplayName', sprintf('Cell %d', cell_num(i)))
end
ax =gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.XTick = 1;
ax.XTickLabel = 'corr';
ax.YLim = [.995 1];
ax.YLabel.String = ['r'];
legend show
legend('Location','eastoutside')
legend('boxoff')
legend('Location','eastoutside')



set(plotb,'Position',[2 21 2.5 2]);
for i = 1:length(plotb)
    temppos = get(plotb(i),"Position");
    temppos(1) = temppos(1)+(i-1)*4;
    set(plotb(i),"Position",temppos);
end

delete(plotb(1).Children)
axes(plotb(1));

[~,i] = max(R2);
plot(TIME(:,i),1000*REC(:,:,i),'Color',my_plt.mycol(3,:),'linewidth',my_plt.lnwd)
hold on
plot(TIME(:,i),1000*VM(:,:,i),'Color',[.2 .2 .2],'linewidth',my_plt.lnwd/2)
hold off
title(['Smallest error, Cell ' num2str(cell_num(i))])
ax =gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
box off
% ax.XTick = 1;
% ax.XTickLabel = 'corr';
% ax.YLim = [-100 -20];
ax.YLabel.String = 'V (mV)';
ax.XLabel.String = 'time (ms)';

delete(plotb(2).Children)
axes(plotb(2));

[~,i] = min(R2);
plot(TIME(:,i),1000*REC(:,:,i),'Color',my_plt.mycol(3,:),'linewidth',my_plt.lnwd)
hold on
plot(TIME(:,i),1000*VM(:,:,i),'Color',[.2 .2 .2],'linewidth',my_plt.lnwd/2)
title(['Bigest error, Cell ' num2str(cell_num(i))])
ax =gca;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
box off
% ax.XTick = 1;
% ax.XTickLabel = 'corr';
% ax.YLim = [-100 -20];
ax.YLabel.String = 'V (mV)';
ax.XLabel.String = 'time (ms)';


set(plotc,'Position',[2 17 2.5 2]);
for i = 1:length(plotc)
    temppos = get(plotc(i),"Position");
    temppos(1) = temppos(1)+(i-1)*4;
    set(plotc(i),"Position",temppos);
end


for i = 1:length(files)  
    delete(plotc(i).Children)
    axes(plotc(i));  
    plot(TIME(:,i),1000*REC(:,:,i),'Color',my_plt.mycol(3,:),'linewidth',my_plt.lnwd)
    hold on
    plot(TIME(:,i),1000*VM(:,:,i),'Color',[.2 .2 .2],'linewidth',my_plt.lnwd/2)
    title(['Cell ' num2str(cell_num(i)) ', R^2 = ' num2str(R2(i))])
    ax =gca;
    ax.LineWidth = my_plt.lnwd;
    ax.FontSize = my_plt.ftsz-3;
    box off
    % ax.XTick = 1;
    % ax.XTickLabel = 'corr';
    % ax.YLim = [-100 -20];
    ax.YLabel.String = 'V (mV)';
    ax.XLabel.String = 'time (ms)';
end 


print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\eNeuro-rereview\ReReviewFigures\GoodnessOfFit'); 