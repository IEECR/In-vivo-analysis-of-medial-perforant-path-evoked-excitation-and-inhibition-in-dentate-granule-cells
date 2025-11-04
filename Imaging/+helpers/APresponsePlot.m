function APresponsePlot(stim,all,resp,nresp,speed,pupil,bulk,plt_ax,my_plt,Shuf,dyn_fit)

x = stim.times(1,:)/1000;

%% responder

delete(plt_ax(1).Children)
axes(plt_ax(1));

if ~isempty(Shuf)
    % z-score values
    % y = nanmean(resp,1);
    y = (nanmean(Shuf.Resp,1));
    win = 1:15;
    Zmean = mean(y(:)); 
    y = y - Zmean;
    Zstd = std(y(:));
    
    y = nanmean(nanmean(Shuf.Resp,1),3);
    y = (y - Zmean)/Zstd;
    b = 2*nanstd(nanmean((Shuf.Resp - Zmean)/Zstd,1),[],3);
    
    fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(6,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    hold on
    plot(x,y,'color',my_plt.mycol(6,:),'linewidth',my_plt.lnwd)
end

% z-score values
y = nanmean(resp,1);
win = 1:15;
Zmean = mean(y(win)); 
y = y - Zmean;
Zstd = std(y(win));

y = nanmean(resp,1);
y = (y - Zmean)/Zstd;
b = nanstd((resp - Zmean)/Zstd)/sqrt(size(resp,1));

fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(2,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on

% plot fit 
if ~isempty(dyn_fit)
    t = x(find(x==0)+1:end)-x(find(x==0)+1);
    tt = t(1):.01:t(end);
    yy = dyn_fit.model_resp(dyn_fit.fit_responders, tt);
    % z-score
    yy = (yy - Zmean)/Zstd;
    plot(tt+x(find(x==0)+1), yy, '-','color',[0 0 0], 'linewidth',my_plt.lnwd/2);
end

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

%% non-responder

delete(plt_ax(2).Children)
axes(plt_ax(2));

win = 1:15;
if ~isempty(Shuf)
    % z-score values
    % y = nanmean(nresp,1);  
    y = (nanmean(Shuf.NResp,1));
    Zmean = nanmean(y(:)); 
    y = y - Zmean;
    Zstd = nanstd(y(:));
    % y = y/Zstd;

    y = nanmean(nanmean(Shuf.NResp,1),3);
    Zmean = mean(y(win)); 
    y = (y - Zmean)/Zstd;
    b = 2*nanstd(nanmean((Shuf.NResp-Zmean)/Zstd,1),[],3);
    % b = 2*nanstd(nanmean((Shuf.NResp-Zmean),1),[],3);
    
    fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(6,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    hold on
    plot(x,y,'color',my_plt.mycol(6,:),'linewidth',my_plt.lnwd)
end

% z-score values
y = nanmean(nresp,1);
Zmean = mean(y(win)); 
y = y - Zmean;
Zstd = std(y(win));

y = nanmean(nresp,1);
y = (y - Zmean)/Zstd;
b = nanstd((nresp - Zmean)/Zstd)/sqrt(size(nresp,1));

fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(1,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on

% plot fit
if ~isempty(dyn_fit)
    yy = dyn_fit.model_nonresp(dyn_fit.fit_non_responders, tt);
    yy = (yy - Zmean)/Zstd;
    plot(tt+x(find(x==0)+1), yy,'-','color',[0 0 0], 'linewidth',my_plt.lnwd/2);
end
  

plot(x,y,'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
hold on
axis tight
ax = gca;
ax.XLim = my_plt.XLim;
ax.XAxis.Visible = 'off';   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
% YLimIn = [.6 1.8]*10^-3;%ax.YLim;
plot([0 0],my_plt.YLimIn,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimIn;
box off

%% Speed plot
delete(plt_ax(3).Children)
axes(plt_ax(3));

if ~isempty(Shuf)
    y = nanmean(nanmean(Shuf.Speed,1),3);
    b = 2*nanstd(nanmean(Shuf.Speed,1),[],3);%/sqrt(size(Shuf.Speed,1));
    fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(6,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    hold on
    plot(x,y,'color',my_plt.mycol(6,:),'linewidth',my_plt.lnwd)
end
y = nanmean(speed,1);
b = nanstd(speed)/sqrt(size(speed,1));
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
% YLimSp = [0 .13];
plot([0 0],my_plt.YLimSp,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimSp;
box off

%% Pupil
delete(plt_ax(4).Children)
axes(plt_ax(4));

win = 1:15;

if ~isempty(Shuf)
    y = nanmean(nanmean(Shuf.Pupil,1),3);
    Zmean = mean(y(win)); 
    y = y - Zmean;
    b = 2*nanstd(nanmean(Shuf.Pupil,1),[],3);%/sqrt(size(Shuf.Pupil,1));
    fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(6,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    hold on
    plot(x,y,'color',my_plt.mycol(6,:),'linewidth',my_plt.lnwd)
end

y = nanmean(pupil,1);
Zmean = mean(y(win)); 
y = y - Zmean;
b = nanstd(pupil)/sqrt(size(pupil,1));
fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(4,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on
plot(x,y,'color',my_plt.mycol(4,:),'linewidth',my_plt.lnwd)
ax = gca;
ax.XLim = my_plt.XLim;
ax.XAxis.Visible = 'off';   
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
ax.YLim = my_plt.YLimPup;
YLim = ax.YLim;
plot([0 0],YLim,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)

box off

%% MPP bulk 

delete(plt_ax(5).Children)
axes(plt_ax(5));

if ~isempty(Shuf)
    y = nanmean(nanmean(Shuf.Bulk,1),3);
    Zmean = mean(y(win)); 
    y = y - Zmean +1;
    b = 2*nanstd(nanmean(Shuf.Bulk,1),[],3);%/sqrt(sum(~isnan(Shuf.Bulk(:,1,1))));
    fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(6,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    hold on
    plot(x,y,'color',my_plt.mycol(6,:),'linewidth',my_plt.lnwd)
end

y = nanmean(bulk,1);
Zmean = mean(y(win)); 
    y = y - Zmean + 1;
b = nanstd(bulk)/sqrt(size(bulk,1));
fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(5,:),...
    'EdgeColor',[1 1 1],...
    'EdgeAlpha',0,...
    'FaceAlpha',.3)
hold on
plot(x,y,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
hold on
ax = gca;
ax.XLim = my_plt.XLim;
ax.XAxis.Visible = 'off'; 
ax.LineWidth = my_plt.lnwd;
ax.FontSize = my_plt.ftsz-3;   
% YLimMPP = [.8 1.3];%ax.YLim;
plot([0 0],my_plt.YLimMPP,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimMPP;
box off

%% all cells

delete(plt_ax(6).Children)
axes(plt_ax(6));

if ~isempty(Shuf)
    % z-score values
    % y = nanmean(resp,1);
    y = (nanmean(Shuf.All,1));
    win = 1:15;
    Zmean = mean(y(:)); 
    y = y - Zmean;
    Zstd = std(y(:));
    
    y = nanmean(nanmean(Shuf.All,1),3);
    y = (y - Zmean)/Zstd;
    b = 2*nanstd(nanmean((Shuf.All - Zmean)/Zstd,1),[],3);
    
    fill([x,fliplr(x)],[y-b,fliplr(y+b)],my_plt.mycol(6,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    hold on
    plot(x,y,'color',my_plt.mycol(6,:),'linewidth',my_plt.lnwd)
end

% z-score values
y = nanmean(all,1);
win = 1:15;
Zmean = mean(y(win)); 
y = y - Zmean;
Zstd = std(y(win));

y = nanmean(all,1);
y = (y - Zmean)/Zstd;
b = nanstd((all - Zmean)/Zstd)/sqrt(size(all,1));

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
plot([0 0],my_plt.YLimIn,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
ax.YLim = my_plt.YLimIn;
box off

%% fitted Dynamics
if ~isempty(dyn_fit) && length(plt_ax) > 6
    % Fitted dynamics
    delete(plt_ax(7).Children)
    axes(plt_ax(7));

    tt = t(1):.01:t(end);
    fit1 = dyn_fit.model_resp([0 dyn_fit.fit_responders([2 3 4])],tt);
    fit1_low = dyn_fit.model_resp([0 dyn_fit.cf_resp(1,[2 3 4])],tt);
    fit1_high = dyn_fit.model_resp([0 dyn_fit.cf_resp(2,[2 3 4])],tt);
    fit1_low = fit1_low/max(fit1);
    fit1_high = fit1_high/max(fit1);
    fit1 = fit1/max(fit1);
    
    % fit2 = -model_nonresp([0 fit_non_responders([2 3 4])],t);
    fit2 = dyn_fit.model_resp([0 dyn_fit.fit_non_responders([2 3 4])],tt);
    fit2_low = dyn_fit.model_resp([0 dyn_fit.cf_non_resp(1,[2 3 4])],tt);
    fit2_high = dyn_fit.model_resp([0 dyn_fit.cf_non_resp(2,[2 3 4])],tt);
    fit2_low = fit2_low/max(fit2);
    fit2_high = fit2_high/max(fit2);
    fit2 = fit2/max(fit2);
    
    plot(tt+x(find(x==0)+1),fit1,'color',my_plt.mycol(2,:),'linewidth',my_plt.lnwd)
    hold on
    fill([tt+x(find(x==0)+1),fliplr(tt+x(find(x==0)+1))],[fit1_low,fliplr(fit1_high)],my_plt.mycol(2,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    plot(tt+x(find(x==0)+1),fit2,'color',my_plt.mycol(1,:),'linewidth',my_plt.lnwd)
    fill([tt+x(find(x==0)+1),fliplr(tt+x(find(x==0)+1))],[fit2_low,fliplr(fit2_high)],my_plt.mycol(1,:),...
        'EdgeColor',[1 1 1],...
        'EdgeAlpha',0,...
        'FaceAlpha',.3)
    
    ax = gca;
    ax.XLim = my_plt.XLim;
    ax.XAxis.Visible = 'off';   
    ax.LineWidth = my_plt.lnwd;
    ax.FontSize = my_plt.ftsz-3;   
    YLimFit = [0 1.2];%ax.YLim;
    plot([0 0],YLimFit,'color',my_plt.mycol(5,:),'linewidth',my_plt.lnwd)
    ax.YLim = YLimFit;
    title(['Ex: ' num2str(round(dyn_fit.fwhm_exc(1))) ', Inh: ' num2str(round(dyn_fit.fwhm_inh(1)))])
    box off
end

axes(plt_ax(end));
ax = gca;
ax.XAxis.Visible = 'on';   
xlabel('time (s)')
end