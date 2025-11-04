%% open figure
figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 25 20],...
    'PaperUnits','centimeters',...
    'PaperSize',[25 20],...
    'visible','on')

plota1 = axes('Units','centimeter');
plota2 = axes('Units','centimeter');
plota3 = axes('Units','centimeter');
plota4 = axes('Units','centimeter');

plotb1 = axes('Units','centimeter');
plotb2 = axes('Units','centimeter');
plotb3 = axes('Units','centimeter');
plotb4 = axes('Units','centimeter');

plotc1 = axes('Units','centimeter');

plotd1 = axes('Units','centimeter');

plote1 = axes('Units','centimeter');

plotf1 = axes('Units','centimeter');

plotg1 = axes('Units','centimeter');

ploth1 = axes('Units','centimeter');

% ploti1 = axes('Units','centimeter');
ploti2 = axes('Units','centimeter');
ploti3 = axes('Units','centimeter');
ploti4 = axes('Units','centimeter');

plotj1 = axes('Units','centimeter');

plotk1 = axes('Units','centimeter');


%%
% GC Ca traces
set(plota1,'Position',[ 1 5 2.5 1.2]);
set(plota2,'Position',[ 5 5 2.5 1.2]);
set(plota3,'Position',[ 9 5 2.5 1.2]);
set(plota4,'Position',[ 13 5 2.5 1.2]);

% GC responder raster plots
set(plotb1,'Position',[1 1  2.5 2]);
set(plotb2,'Position',[5 1  2.5 2]);
set(plotb3,'Position',[9 1 2.5 2]);
set(plotb4,'Position',[13 1 2.5 2]);

% GC non-responder Ca traces
set(plotc1,'Position',[17 5 2.5 1.2]);

% GC non-reponder raster plonder
set(plotd1,'Position',[17 1 2.5 2]);

% non responder mean-plot
set(plote1,'Position',[17 9 2.5 3]);

% responder mean-plot
set(plotf1,'Position',[17 12.5 2.5 2]);

% MPP Ca bulk mean
set(plotg1,'Position',[13 14 2.5 2]);

% FOV
set(ploth1,'Position',[1 10 5 5]);

% data
% set(ploti1,'Position',[7 14.5   5    .8]);
set(ploti2,'Position',[7 10.8  5   3.6]);
set(ploti3,'Position',[7 9.9  5    .8]);
set(ploti4,'Position',[7 9  5    .8]);

% mean speed
set(plotj1,'Position',[13 11 2.5 2]);

% mean pupil
set(plotk1,'Position',[13 8 2.5 2]);

%% Example resposnsive cell M234.1 cell 2 M234.2 cell 8 

% stim = scn.airpuff;
% i = 2;j = 10;
ses = 1;mouse = 1;
stim = CAIM(ses,mouse).airpuff;
Df = CAIM(ses,mouse).Df;
Clim = [0 .15];
% include all APs
include = 1:35;%60 %size(stim.resp,2);
% include only AP that did not trigger running
% include = find(sum(stim.speed(:,31:60),2) <= 0);
% include = find(sum(stim.speed(:,31:60),2) > 0);

% CellID
maxcell = size(stim.resp,1);
if maxcell >4; maxcell = 4;end
cellId = [2 4 12 11]; %  2 4 8 12
for i = 1:maxcell
    if i == 1
        delete(plota1.Children)
        axes(plota1);
    elseif i == 2
        delete(plota2.Children)
        axes(plota2);
    elseif i == 3
        delete(plota3.Children)
        axes(plota3);
    else
        delete(plota4.Children)
        axes(plota4);
    end

    yy = [];
    for j = 1:length(include)
        y = permute(stim.respCa(cellId(i),include(j),:),[1 3 2]);
        y = y/Df(stim.cellID(cellId(i)));
        y = 1+y-min(y);
        yy = [yy; y];
        plot(stim.times(include(j),:)/1000,y,'color',[.5 .5 .5],"LineWidth",my_plt.lnwd*0.25) 
        hold on
        % ylim([0 8])
    end
%     plot(stim.times(include(j),:)/1000,mean(yy,1),'color',[0 0 0],'linewidth',my_plt.lnwd+1)

    ax = gca;
    ax.XLim = [-1 3];
    % ax.YLim = [0 8];
    YLim = ax.YLim;
    ax.YLim = [1 YLim(2)];
    ax.YColor = [0 0 0];
    ax.XColor = [0 0 0];
    ax.Color = [1 1 1];     
    ax.LineWidth = my_plt.lnwd;
    ax.FontSize = my_plt.ftsz-3;
    YLim = ax.YLim;
    box('off')
    % plot([0 0],[0 size(stim.respCa,2)],'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)    
    ylabel('\Delta F / F','FontSize',my_plt.ftsz-2)
    
    plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
    hold off
%     title('A','Units','centimeter','position',[-1.3 5.5],'FontSize',my_plt.ftsz)
    axis off

    if i == 1
        delete(plotb1.Children)
        axes(plotb1);
    elseif i == 2
        delete(plotb2.Children)
        axes(plotb2);
    elseif i == 3
        delete(plotb3.Children)
        axes(plotb3);
    else
        delete(plotb4.Children)
        axes(plotb4);
    end
    
    for j = 1:length(include)
        scatter(stim.times(include(j),stim.resp(cellId(i),include(j),:)==1)/1000,permute(stim.resp(cellId(i),include(j),stim.resp(cellId(i),include(j),:)==1)+j-1,[1 3 2]),4,'filled','markerfacecolor',[0 0 0]) 
        hold on
    end

    imagesc(stim.times(j,:)/1000,j+5:j+9,permute(mean(stim.resp(cellId(i),include,:),2),[1 3 2]),Clim);
    % colormap(h1,jet);

    ax = gca;
    ax.XLim = [-1 3];
    ax.YLim = [0 length(include)+10];
    ax.YTick = [0:10: length(include)+10];
    ax.YColor = [0 0 0];
    ax.XColor = [0 0 0];
    ax.Color = [1 1 1];     
    ax.LineWidth = my_plt.lnwd;
    ax.FontSize = my_plt.ftsz-3;
    box('off')
    plot([0 0],[0 length(include)],'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
    hold off
    ylabel('Airpuff #','FontSize',my_plt.ftsz-2)

%     title('B','Units','centimeter','position',[-1.3 5.5],'FontSize',my_plt.ftsz)

end


%% Example NON-resposnsive cell M234.1 cell 2 M234.2 cell 8 

i = 49;% CellID

delete(plotc1.Children)
axes(plotc1);
        
yy = [];
for j = 1:length(include)
    y = permute(stim.nr.respCa(i,include(j),:),[1 3 2]);
    y = y/Df(stim.nr.cellID(i));
    y = 1+y-min(y);
    yy = [yy; y];
    plot(stim.times(include(j),:)/1000,y,'color',[.5 .5 .5],"LineWidth",my_plt.lnwd*0.25) 
    hold on
    % axis off
end
% plot(stim.times(include(j),:)/1000,mean(yy,1),'color'v,[0 0 0],'linewidth',my_plt.lnwd+1)

ax = gca;
ax.XLim = [-1 3];
ax.YLim = [1 3];
YLim = ax.YLim;
ax.YLim = [1 YLim(2)];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
box('off')
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ylabel('\Delta F / F','FontSize',my_plt.ftsz-2)
hold off

% title('C','Units','centimeter','position',[-1.3 5.5],'FontSize',my_plt.ftsz)

% NON - responder scatter
delete(plotd1.Children)
axes(plotd1);

for j = 1:length(include)
    scatter(stim.times(include(j),stim.nr.resp(i,include(j),:)==1)/1000,permute(stim.nr.resp(i,include(j),stim.nr.resp(i,include(j),:)==1)+j-1,[1 3 2]),4,'filled','markerfacecolor',[0 0 0]) 
    hold on
end

imagesc(stim.times(j,:)/1000,j+5:j+9,permute(mean(stim.nr.resp(i,include,:),2),[1 3 2]));
% colormap(h1,jet);

ax = gca;
ax.XLim = [-1 3];
ax.YLim = [0 length(include)+10];
ax.YTick = [0:10: length(include)+10];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
box('off')
plot([0 0],[0 length(include)],'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
hold off
ylabel('Airpuff #','FontSize',my_plt.ftsz-2)

% title('D','Units','centimeter','position',[-1.3 5.5],'FontSize',my_plt.ftsz)

%% Summary NON-reponder
delete(plote1.Children)
axes(plote1);

b = mean(stim.nr.resp(:,include,:),2);
b = permute(b,[1 3 2]);
[~,h] = sort(sum(b,2),'descend');
b = b(h,:);
for i = 1:size(b,1)
    b(i,:) = zscore(b(i,:));
    % b(i,:) = (b(i,:)-min(b(i,:)))/max((b(i,:)-min(b(i,:))));
end
% b(b==0) = nan;
Clim = [-.5 8];
h = imagesc(stim.times(j,:)/1000,1:size(b,1),b,Clim);
set(h, 'AlphaData', ~isnan(b))
hold on
ax = gca;
ax.XLim = [-1 3];
ax.XAxis.Visible = 'off';
% ax.YLim = YLim;
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
ax.YLim = [1 150];
YLim = ax.YLim;
ylabel('cell ID')
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
box off
hold off
temp = ax.Position;
colorbar
ax.Position = temp;
% colormap(h6,jet);
 
%% Summary responder
delete(plotf1.Children)
axes(plotf1);
 
a = mean(stim.resp(:,include,:),2);
a = permute(a,[1 3 2]);
% a(a==0) = nan;
% [~,h] = sort(sum(a,2),'descend');
% a = a(h,:);
for i = 1:size(a,1)
    a(i,:) = zscore(a(i,:));
    % a(i,:) = (a(i,:)-min(a(i,:)))/max((a(i,:)-min(a(i,:))));
    % a(i,:) = a(i,:)/max(a(i,:));
    % a(i,:) = a(i,:)*100;   
    % a(i,:) = a(i,:)-min(a(i,:));
end
h = imagesc(stim.times(j,:)/1000,1:size(a,1),a);%,Clim);
set(h, 'AlphaData', ~isnan(a))
hold on 
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)

hold off
box off

ax = gca;
ax.XLim = [-1 3];
ax.XAxis.Visible = 'off'; 
% ax.YLim = YLim/5;
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
% colormap(h5,jet);
ylabel('cell ID')
% temp = ax.Position;
% colorbar
% ax.Position = temp;

% delete(plotg1.Children)
% axes(plotg1);

% yy = [];
% for j = 1:length(include)
%     y = stim.bulkresp(include(j),:);
% %     y = y-min(y);
%     yy = [yy; y];
% %     plot(stim.bulktime(include(j),:)/1000,y,'color',[.5 .5 .5]) 
% %     hold on
% end
% 
% x = stim.bulktime(1,:)/1000;
% y = mean(yy);
% b = std(yy)/sqrt(length(include));
% 
% fill([x,fliplr(x)],[y-b,fliplr(y+b)],[.7 0 0],...
%     'EdgeColor',[1 1 1],...
%     'EdgeAlpha',0,...
%     'FaceAlpha',.3)
% hold on
% 
% plot(x,y,'color',[.8 0 0],'linewidth',my_plt.lnwd)
% 
% box('off')
% % plot([0 0],[0 size(stim.respCa,2)],'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
% 
% ylabel('\Delta F / F','FontSize',my_plt.ftsz-2)
% % title('G','Units','centimeter','position',[-1.3 5.5],'FontSize',my_plt.ftsz)
% 
% ax = gca;
% ax.XLim = [-1 3];
% ax.YColor = [0 0 0];
% ax.XColor = [0 0 0];
% ax.Color = [1 1 1];     
% ax.LineWidth = my_plt.lnwd;
% ax.LineWidth = my_plt.lnwd;
% ax.FontSize = my_plt.ftsz-3;
% YLim = ax.YLim;
% plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
% hold off
% ax.YLim = YLim;

%% FOV
delete(ploth1.Children)
axes(ploth1);

FOV = CAIM(ses,mouse).FOV(:,:,1)*my_plt.mycol(2,1);
FOV(:,:,2) = CAIM(ses,mouse).FOV(:,:,1)*my_plt.mycol(2,2);
FOV(:,:,3) = CAIM(ses,mouse).FOV(:,:,1)*my_plt.mycol(2,3);
FOV = mat2gray(FOV);
FOV = FOV * 2.8;

% scale bar
pxsc = 1.12; %micrometer per pixel
lgsc = 100; %length of scalebar in micrometer
lgsc = round(lgsc/pxsc);
FOV(end-round((20:30)/pxsc),end-(lgsc+20)+(1:lgsc),:) =1;

image(FOV)
axis off

%% mean speed
delete(plotj1.Children)
axes(plotj1);

yy = [];
for j = 1:length(include)
    y = stim.speed(include(j),:);
    y(y<0) = 0;
%     y = y-min(y);
    yy = [yy; y];
%     plot(stim.bulktime(include(j),:)/1000,y,'color',[.5 .5 .5]) 
%     hold on
end

x = stim.times(1,:)/1000;
y = mean(yy);
b = std(yy)/sqrt(length(include));

fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(3,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on

plot(x,y,'color',my_plt.mycol(3,:),'linewidth',my_plt.lnwd)

box('off')
% plot([0 0],[0 size(stim.respCa,2)],'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)

ylabel('\Delta F / F','FontSize',my_plt.ftsz-2)
% title('G','Units','centimeter','position',[-1.3 5.5],'FontSize',my_plt.ftsz)

ax = gca;
ax.XLim = [-1 3];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
YLim = ax.YLim;
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
hold off
ax.YLim = YLim;

% mean pupil
delete(plotk1.Children)
axes(plotk1);

yy = [];
for j = 1:length(include)
    y = stim.pupilLP(include(j),:);
%     y = y-min(y);
    yy = [yy; y];
%     plot(stim.bulktime(include(j),:)/1000,y,'color',[.5 .5 .5]) 
%     hold on
end

x = stim.times(1,:)/1000;
y = nanmean(yy);
b = nanstd(yy)/sqrt(length(include));

fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(4,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on

plot(x,y,'color',my_plt.mycol(4,:),'linewidth',my_plt.lnwd)

box('off')
% plot([0 0],[0 size(stim.respCa,2)],'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)

ylabel('pupil size (/max)','FontSize',my_plt.ftsz-2)
% title('G','Units','centimeter','position',[-1.3 5.5],'FontSize',my_plt.ftsz)

ax = gca;
ax.XLim = [-1 3];
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.Color = [1 1 1];     
ax.LineWidth = my_plt.lnwd;
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;
YLim = ax.YLim;
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
hold off
ax.YLim = YLim;
%%
load('C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\Data\Example Mouse\M103.071216.1325pro.mat')
% load('/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/Data/Example Mouse/M103.071216.1325pro.mat')
%% Data
timeint = [8 16]; %[5 15] for M227 %[5 15] for M234
timeint = timeint*60*1000;


% MPP bulk data

% delete(ploti1.Children)
% axes(ploti1);
% a = smooth(caim.bulk.traceMEC(1,:),10);
% a = caim.bulk.trace(:,1);
% a = caim.bulk.decon.Y;
% ScaleBulk = max(a-min(a));
% a = smooth(a,10);
% a = (a-min(a))/max(a-min(a));
% plot(scn.tsscn(1:end),a,...
%         'color',[1 0 0],...
%         'linewidth',my_plt.lnwd-.5);
% axis off
% ax = gca;
% ax.YLim = [0 1];
% ax.XLim = timeint;
% 
%     fig_pos=get(gca,'position');
%         scbr(1) = fig_pos(1)+.45;
%         scbr(2) = fig_pos(2)+.25;
%         scbr(3) = 0;
%         scbr(4) = 0;
% 
%     if exist('h1','var') && isvalid(h1);delete(h1);end
%     h1 = annotation('textarrow',[0,0],[0,0],...
%            'Units','centimeter',... 
%            'position',scbr,...
%            'color',[0 0 0],...
%            'HeadStyle','none',...
%            'string','100 % \DeltaF/F',...
%            'fontsize',my_plt.ftsz-2,...
%            'VerticalAlignment','bottom',...  
%            'TextRotation',90,...
%            'HorizontalAlignment','center');
% 
%     a = ylim; a = a(2)-a(1);
%     scbr(1) = fig_pos(1)-.15;
%     scbr(2) = fig_pos(2);
%     scbr(4) = fig_pos(4)/a/ScaleBulk;
% 
%     if exist('h2','var') && isvalid(h2);delete(h2);end
%     h2 = annotation('textarrow',[0,0],[0,0],... 
%            'units','centimeter',... 
%            'position',scbr,...
%            'color',[0 0 0],...
%            'HeadStyle','none',...
%            'linewidth',my_plt.lnwd); 


delete(ploti2.Children)
axes(ploti2);
nums = 1:15;
for i = 1:length(nums)
    aa = CAIM(ses,mouse).Y(nums(i),:)/CAIM(ses,mouse).Df(nums(i));
    aa = aa-min(aa);
    % aa = Df_f{1}(nums(i),:);
    % aa = aa(1:end-1);
    % aa = aa/3;
    plot(CAIM(ses,mouse).behave.tsscn(1:end),aa(1:end)+((i-1)),...
        'color',[.5 .5 .5],...
        'linewidth',my_plt.lnwd-.5);
    hold on
end

axis tight
axis off
ax = gca;
ax.XLim = timeint;

    fig_pos=get(gca,'position');
        scbr(1) = fig_pos(1)+.45;
        scbr(2) = fig_pos(2)+.5;
        scbr(3) = 0;
        scbr(4) = 0;

    if exist('h3','var') && isvalid(h3);delete(h3);end
    h3 = annotation('textarrow',[0,0],[0,0],...
           'Units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'string','100 % \DeltaF/F',...
           'fontsize',my_plt.ftsz-2,...
           'VerticalAlignment','bottom',...  
           'TextRotation',90,...
           'HorizontalAlignment','center');

    scbr(1) = fig_pos(1)-.15;
    scbr(2) = fig_pos(2);
    scbr(4) = fig_pos(4)/length(nums);
    
    if exist('h4','var') && isvalid(h4);delete(h4);end
    h4 = annotation('textarrow',[0,0],[0,0],... 
           'units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'linewidth',my_plt.lnwd);       


delete(ploti3.Children)
axes(ploti3);
plot(CAIM(ses,mouse).behave.tsscn,scn.distance/max(scn.distance),...
        'color',my_plt.mycol(3,:),...
        'linewidth',my_plt.lnwd-.5);
    
AP = CAIM(ses,mouse).airpuff.stimon==1;
hold on
scatter(CAIM(ses,mouse).behave.tsscn(AP),ones(1,sum(AP)),3,'*','LineWidth',.2,'MarkerEdgeColor',my_plt.mycol(5,:));
hold off

    fig_pos=get(gca,'position');
        scbr(1) = fig_pos(1)+.05;
        scbr(2) = fig_pos(2)+.2;
        scbr(3) = 0;
        scbr(4) = 0;

    if exist('h5','var') && isvalid(h5);delete(h5);end
    h5 = annotation('textarrow',[0,0],[0,0],...
           'Units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'string','1 m',...
           'fontsize',my_plt.ftsz-2,...
           'VerticalAlignment','bottom',...  
           'TextRotation',90,...
           'HorizontalAlignment','center');

    scbr(1) = fig_pos(1)-.15;
    scbr(2) = fig_pos(2);
    scbr(4) = fig_pos(4)*2/3;
    
    if exist('h6','var') && isvalid(h6);delete(h6);end
    h6 = annotation('textarrow',[0,0],[0,0],... 
           'units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'linewidth',my_plt.lnwd);   

       
ax = gca;
ax.XLim = timeint;
ax.YLim = [0 1];

axis off



delete(ploti4.Children)
axes(ploti4);
% pupil = scn.pupil;
pupil = CAIM(ses,mouse).behave.pupil(:,1);
pupil(scn.blink) = nan;
pupil = smoothdata(pupil,'movmean',30);%,'includenan');
% pupil = (pupil-min(pupil))/max(pupil-min(pupil));
plot(scn.tsscn,pupil,...
        'color',my_plt.mycol(4,:),...
        'linewidth',my_plt.lnwd-.5);
ax = gca;
ax.XLim = timeint;
ax.YLim = [.95 1.05];
axis off

    fig_pos=get(gca,'position');
        scbr(1) = fig_pos(1)+.15;
        scbr(2) = fig_pos(2)+.25;
        scbr(3) = 0;
        scbr(4) = 0;

    if exist('h7','var') && isvalid(h7);delete(h7);end
    h7 = annotation('textarrow',[0,0],[0,0],...
           'Units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'string','20 %',...
           'fontsize',my_plt.ftsz-2,...
           'VerticalAlignment','bottom',...  
           'TextRotation',90,...
           'HorizontalAlignment','center');

    scbr(1) = fig_pos(1)-.15;
    scbr(2) = fig_pos(2);
    scbr(4) = fig_pos(4)*2/3;

    if exist('h8','var') && isvalid(h8);delete(h8);end
    h8 = annotation('textarrow',[0,0],[0,0],... 
           'units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'linewidth',my_plt.lnwd);  

    % time scale bar
    lbar = 60; %length of scalebar in seconds    
    tmscl = lbar*1000*(fig_pos(3)/(timeint(2)-timeint(1)));
    scbr(1) = fig_pos(1)+fig_pos(3); 
    scbr(2) = fig_pos(2)-.1;
    scbr(3) = 0;%fig_pos(1)+fig_pos(3);
    scbr(4) = 0;

    if exist('h8a','var') && isvalid(h8a);delete(h8a);end
    h8a= annotation('textarrow',[0,0],[0,0],...
           'Units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'string','1 min',...        
           'fontsize',my_plt.ftsz-2,...
           'VerticalAlignment','top',...
           'TextRotation',0,...
           'HorizontalAlignment','right');

    scbr(1) = fig_pos(1)+fig_pos(3)-tmscl; 
    scbr(2) = fig_pos(2)-.1;
    scbr(3) = tmscl;%fig_pos(1)+fig_pos(3);
    scbr(4) = 0;

    if exist('h8b','var') && isvalid(h8b);delete(h8b);end
    h8b = annotation('textarrow',[0,0],[0,0],... 
           'units','centimeter',... 
           'position',scbr,...
           'color',[0 0 0],...
           'HeadStyle','none',...
           'linewidth',my_plt.lnwd); 
    

%%
% print(gcf, '-dpdf', '/Users/martinpofahl/Dropbox (IEECR)/MPP - DG project/figures/figure1b'); 

% print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\figures\figure1b'); 