ftz1 = 20;
ftz2 = 20;
fac2 = 1e9;
lwt1 = 2;
svpath = '';
%% balance

if length(stimpt) < 10
    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);
    scatter(maxge(:,2)*fac2,maxgi(:,2)*fac2)
    plot([0 max(maxge(:,2)*fac2)], [0 max(maxge(:,2)*fac2)],'--','Color',[.4 .4 .4],'LineWidth',lwt1)
    hold on
    plot(maxge(:,2)*fac2,maxgi(:,2)*fac2,'Marker','o','MarkerSize',10,'Color','k','LineWidth',lwt1)
    grid on
    xlabel('G_e / nS','fontsize',ftz2)
    ylabel('G_i / nS','fontsize',ftz2)
    set(gca,'xlim',[0 max(maxge(:,2)*fac2)])
    set(gca,'fontsize',ftz1)
    newname = inputdlg('Figure name:','Name',1,{[files{st1}(1:6) '.gegi']});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
end

%% ratio

if length(stimpt) < 10
    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);
    rat = maxgi(maxge(:,2)~=0,2)./maxge(maxge(:,2)~=0,2);
    rat = rat(rat>0);
    x = 1:length(rat);
    xi = 1:.01:length(x);
    yi = interp1(x,rat,xi,'pchip');
    plot(x,rat,'o',xi,yi,'k','LineWidth',lwt1)
%     plot(maxgi(:,2)./maxge(:,2),'k','LineWidth',lwt1)
    grid on
    xlabel('# Pulse','fontsize',ftz2)
    ylabel('G_i / G_e','fontsize',ftz2)
%     set(gca,'xlim',[0 max(maxge(:,2)*fac2)])
    set(gca,'fontsize',ftz1)
    newname = inputdlg('Figure name:','Name',1,{[files{st1}(1:6) '.rat']});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
end


%%
figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);
rat = maxgi(maxge(:,2)~=0,2)./maxge(maxge(:,2)~=0,2);
rat = rat(rat>0);
s = find(rat<1);
s = s(end);
x = maxge(maxge(1:end,2)~=0,2)*fac2;
x = x(s:end-1);
y = maxgi(maxge(1:end,2)~=0,2)*fac2;
y = y(s:end-1);
xi = min(x):.001:max(x);
yi = interp1(x,y,xi,'pchip');
plot(x,y,'o',xi,yi,'k','LineWidth',lwt1)
grid on
hold on
plot(xi,abs(xi-yi))
bal = find(abs(xi-yi)==min(abs(xi-yi)));
scatter(xi(bal),yi(bal))
%% power linear
if length(stimpt) < 10
    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);

    plot(lout,maxge(:,2)*fac2,'c','LineWidth',lwt1)
    hold on
    plot(lout,maxgi(:,2)*fac2,'k','LineWidth',lwt1)
    hold off
    grid on
    xlabel('Laser-fiber output / mW','fontsize',ftz2,'Marker','o','MarkerSize',10)
    ylabel('Conductance / nS','fontsize',ftz2,'Marker','o','MarkerSize',10)
    set(gca,'fontsize',ftz1)
    newname = inputdlg('Figure name:','Name',1,{[files{st1}(1:6) '.max']});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
end

%% power semilog

if length(stimpt) < 10
    
    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);

    semilogx(lout,maxge(:,2)*fac2,'c','LineWidth',lwt1,'Marker','o','MarkerSize',10)
    hold on
    semilogx(lout,maxgi(:,2)*fac2,'k','LineWidth',lwt1,'Marker','o','MarkerSize',10)
    hold off
    grid on
    xlabel('Laser-fiber output / mW','fontsize',ftz2)
    ylabel('Conductance / nS','fontsize',ftz2)
    set(gca,'fontsize',ftz1)


    newname = inputdlg('Figure name:','Name',1,{[files{st1}(1:6) '.maxlog']});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
end
%% Single Pulse Responses plot
if length(stimpt) < 10
    int = 2000;
    y = time(1:int);
    stimpt1 = stimpt;
    stimpt = stimpt(1:end);

    Ge = zeros(length(stimpt),int);
    Gi = zeros(length(stimpt),int);
    Gedv = zeros(length(stimpt),int);
    Gidv = zeros(length(stimpt),int);
    Rat = zeros(length(stimpt),int);
    for i = 1:length(stimpt)
        Ge(i,:) = ge(stimpt(i):stimpt(i)+int-1)+i*2e-9;
        Gi(i,:) = gi(stimpt(i):stimpt(i)+int-1)+i*2e-9;
        Rat(i,:) = (Gi(i,:)+1)./(Ge(i,:)+1);%-i*1e-9;
        Gedv(i,1:end-1) = diff(ge(stimpt(i):stimpt(i)+int-1),1)*100;
        Gidv(i,1:end-2) = smooth(diff(gi(stimpt(i):stimpt(i)+int-1),2),100)*10000;
    end
    
    figi = figure('position',[.25*sz(3) 0.05*sz(4) .45*sz(3) 0.85*sz(4)]);
    plot(y,Ge,'c','LineWidth',lwt1)
    hold on
    plot(y,Gi,'k','LineWidth',lwt1)
    plot([0 0],[0 1e-9],'k','LineWidth',lwt1+1)
    plot([0 10],[0 0],'k','LineWidth',lwt1)
    axis off
    hold off
    
    newname = inputdlg('Figure name:','Name',1,{[files{st1}(1:6) '.resp']});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
    stimpt = stimpt1;
   
end

%% prozentualer verlauf der leitfähigkeiten normiert auf absolutes maximum
if length(stimpt) > 9
    
    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);

    if maxge(:,2) > 0
        mgen = (maxge(:,2))/(max(abs(maxge(:,2))))*100;
    else
        mgen = (maxge(:,2)-min(ge(stimpt(1):stimpt(end))))/(max(abs(maxge(:,2)-min(ge(stimpt(1):stimpt(end))))))*100;
    end

    if maxgi(:,2) > 0
        mgin = (maxgi(:,2))/(max(abs(maxgi(:,2))))*100;
    else
        mgin = (maxgi(:,2)-min(gi(stimpt(1):stimpt(end))))/(max(abs(maxgi(:,2)-min(gi(stimpt(1):stimpt(end))))))*100;
    end


    plot(mgen,'color','cyan','LineWidth',lwt1)
    hold on
    plot(mgin,'color','black','LineWidth',lwt1)

    hold off
    grid on
    xlabel('# Pulse','fontsize',ftz2)
    ylabel('Conductance / %','fontsize',ftz2)
    set(gca,'fontsize',ftz1)

    newname = inputdlg('Figure name:','Name',1,{[files{st1}(1:6) '.ad%']});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
end
%% verlauf der leitfähigkeiten

if length(stimpt) > 9
    
    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);

    plot(maxge(:,2)*fac2,'color','cyan','LineWidth',lwt1)
    hold on
    plot(maxgi(:,2)*fac2,'color','black','LineWidth',lwt1)

    hold off
    grid on
    xlabel('# Pulse','fontsize',ftz2)
    ylabel('Conductance / nS','fontsize',ftz2)
    set(gca,'fontsize',ftz1)

    newname = inputdlg('Figure name:','Name',1,{[files{st1}(1:6) '.ad']});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end

end

