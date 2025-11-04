
sz = get(0,'screensize');
ftz1 = 20;
ftz2 = 20;
fac2 = 1e9;
svpath = '';
lwt1 = 2;

%% Pooling variables

Maxge = zeros(length(mouse),8);
Maxgi = zeros(length(mouse),8);
Onge = zeros(length(mouse),8);
Ongi = zeros(length(mouse),8);
Tauge = zeros(length(mouse),8);
Taugi = zeros(length(mouse),8);
Rat = zeros(length(mouse),8,5000);
Bal = zeros(length(mouse),2);
Max5ge = zeros(length(mouse),10);
Max5gi = zeros(length(mouse),10);
Max20ge = zeros(length(mouse),40);
Max20gi = zeros(length(mouse),40);
Maxnorm5ge = zeros(length(mouse),10);
Maxnorm5gi = zeros(length(mouse),10);
Maxnorm20ge = zeros(length(mouse),40);
Maxnorm20gi = zeros(length(mouse),40);

%% 
j = 1;
l = 1;
k = 1;
for i = 1 : length(files)
%%
    load([pathname files{i}])
    stimpt = find(diff(stim)*3e-5-0.1>0);
    
    if prot == 1
        Maxge(j,9-length(maxge(:,3)):end) = maxge(:,3);
        Maxgi(j,9-length(maxgi(:,3)):end) = maxgi(:,3);
        Onge(j,9-length(onge(:,3)):end) = onge(:,3);
        Ongi(j,9-length(ongi(:,3)):end) = ongi(:,3);
        Tauge(j,9-length(tauge):end) = tauge;
        Taugi(j,9-length(taugi):end) = taugi;
        [~,~,~,~,~,~,~,~,~,a] = inexmeasure(ge,gi,stim,time,lout,2,str2double(files{i}(5:6)));
        Rat(j,9-length(a(:,1)):end,:) = a;
%         Maxrat = max(maxgi(:,2))/max(maxge(:,2));
        % Calculate the condctance of balanced ratio and the ratio of
        % maximal conductance
        rat = (maxgi(maxge(:,2)~=0,2)*fac2)./(maxge(maxge(:,2)~=0,2)*fac2);
        rat = rat(rat>0);
        s = find(rat<1);
        Bal(j,2) = rat(end-1);
        if ~isempty(s)          
            s = s(end);
            x = maxge(maxge(1:end,2)~=0,2)*fac2;
            x = x(s:end-1);
            y = maxgi(maxge(1:end,2)~=0,2)*fac2;
            y = y(s:end-1);
            xi = min(x):.001:max(x);
            yi = interp1(x,y,xi,'pchip');
            Bal(j,1) = xi(abs(xi-yi)==min(abs(xi-yi)))/fac2;
%             figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);
%             plot(x,y,'o',xi,yi,'k','LineWidth',lwt1)
%             grid on
%             hold on
%             plot(xi,abs(xi-yi))
%             scatter(xi(bal),yi(bal))
        end


        j = j+1;
    end 
    
    if prot == 2
        if min(maxge(:,2))>0
            Max5ge(l,:) = maxge(:,2);
            Maxnorm5ge(l,:) = maxge(:,2)/max(maxge(:,2));
        else
            Max5ge(l,:) = maxge(:,2)-min(maxge(:,2));
            Maxnorm5ge(l,:) = (maxge(:,2)-min(maxge(:,2)))/(max(maxge(:,2)-min(maxge(:,2))));
        end
        if min(maxgi(:,2))>0
            Max5gi(l,:) = maxgi(:,2);
            Maxnorm5gi(l,:) = maxgi(:,2)/max(maxgi(:,2));
        else
            Max5gi(l,:) = maxgi(:,2)-min(maxgi(:,2));
            Maxnorm5gi(l,:) = (maxgi(:,2)-min(maxgi(:,2)))/(max(maxgi(:,2)-min(maxgi(:,2))));
        end
        
        l = l+1;
    end 
    
    if prot == 3
        if min(maxge(:,2))>0
            Max20ge(k,1:length(maxge(:,2))) = maxge(:,2);
            Maxnorm20ge(k,1:length(maxge(:,2))) = maxge(:,2)/max(maxge(:,2));
        else
            Max20ge(k,1:length(maxge(:,2))) = maxge(:,2)-min(maxge(:,2));
            Maxnorm20ge(k,1:length(maxge(:,2))) = (maxge(:,2)-min(maxge(:,2)))/(max(maxge(:,2)-min(maxge(:,2))));
        end
        if min(maxgi(:,2))>0
            Max20gi(k,1:length(maxge(:,2))) = maxgi(:,2);
            Maxnorm20gi(k,1:length(maxge(:,2))) = maxgi(:,2)/max(maxgi(:,2));
        else
            Max20gi(k,1:length(maxge(:,2))) = maxgi(:,2)-min(maxgi(:,2));
            Maxnorm20gi(k,1:length(maxge(:,2))) = (maxgi(:,2)-min(maxgi(:,2)))/(max(maxgi(:,2)-min(maxgi(:,2))));
        end
        
        k = k+1;
    end 
    
    
end

%% Readout and average of delay times for onset max and tau

A = zeros(6,8); % Delay times
B = zeros(6,8); % Standard error of delay times
C = zeros(3,8); % Ttest results for EPSP 

for i = 1:8
    A(1,i) = mean(Maxge(Maxge(:,i)~=0,i));
    A(2,i) = mean(Maxgi(Maxgi(:,i)~=0,i));
    A(3,i) = mean(Onge(Onge(:,i)~=0,i));
    A(4,i) = mean(Ongi(Ongi(:,i)~=0,i));
    A(5,i) = mean(Tauge(Tauge(:,i)~=0,i));
    A(6,i) = mean(Taugi(Taugi(:,i)~=0,i));
    B(1,i) = std(Maxge(Maxge(:,i)~=0,i))/sqrt(length(Maxge(Maxge(:,i)~=0,i)));
    B(2,i) = std(Maxgi(Maxgi(:,i)~=0,i))/sqrt(length(Maxgi(Maxgi(:,i)~=0,i)));
    B(3,i) = std(Onge(Onge(:,i)~=0,i))/sqrt(length(Onge(Onge(:,i)~=0,i)));
    B(4,i) = std(Ongi(Ongi(:,i)~=0,i))/sqrt(length(Ongi(Ongi(:,i)~=0,i)));
    B(5,i) = std(Tauge(Tauge(:,i)~=0,i))/sqrt(length(Tauge(Tauge(:,i)~=0,i)));
    B(6,i) = std(Taugi(Taugi(:,i)~=0,i))/sqrt(length(Taugi(Taugi(:,i)~=0,i)));
    C(1,i) = ttest(Maxge(Maxge(:,i)~=0,i),Maxgi(Maxgi(:,i)~=0,i));
    C(2,i) = ttest(Onge(Onge(:,i)~=0,i),Ongi(Ongi(:,i)~=0,i));
    C(3,i) = ttest(Tauge(Taugi(:,i)~=0,i),Taugi(Taugi(:,i)~=0,i));
end

%% Bar graphs for time values

for i = 7
    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.8*sz(4)]);
    a = [A(3,i),A(4,i)
        A(1,i),A(2,i)
        A(5,i),A(6,i)];
    b = [B(3,i),B(4,i)
        B(1,i),B(2,i)
        B(5,i),B(6,i)];
    barweb(a, b,.9,[],[],[],[],[0 1 1 ; 0 0 0 ; 0 0 0], [],[],[],[]);
    set(gca,'fontsize',ftz1)
    ylabel('time/ms','fontsize',ftz1)
    newname = inputdlg('Figure name:','Name',1,{'pooled1'});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
end

%% Time series of ratio

for i = 7
    a = zeros(length(mouse),5000);
    a(:,:) = Rat(:,i,:);
    figi = figure('position',[.25*sz(3) 0.05*sz(4) .55*sz(3) 0.65*sz(4)]);
    plot(a','color',[.5 .5 .5],'LineWidth',lwt1)
    hold on
    plot(mean(a(a(:,1)~=0,:),1),'g','LineWidth',lwt1)
    plot([0 2000],[0 0],'k--','LineWidth',lwt1)
    hold off
    
%     set(gca,'ylim',[0 100])
    set(gca,'xlim',[0 2000])
    axis off
    
    newname = inputdlg('Figure name:','Name',1,{'pool-ratio'});
    if ~isempty(newname)
        exportfig([svpath newname{1}])
    else
        delete(figi)
    end
end

%% Ratio average

Bal(end+1,1) = mean(Bal(Bal(:,1)~=0,1));
Bal(end,2) = mean(Bal(Bal(:,2)~=0,2));
Bal(end+1,1) = std(Bal(Bal(:,1)~=0,1));
Bal(end,2) = std(Bal(Bal(:,2)~=0,2));

%% 20 Hz adaption plot

plge = mean(Maxnorm20ge(:,:),1);
plgi = mean(Maxnorm20gi(:,:),1);

errge = std(Maxnorm20ge(Maxnorm20ge(:,1)~=0,:))/sqrt(length(Maxnorm20ge(Maxnorm20ge(:,1)~=0,:)));
errgi = std(Maxnorm20gi(Maxnorm20gi(:,1)~=0,:))/sqrt(length(Maxnorm20gi(Maxnorm20gi(:,1)~=0,:)));

figi = figure('position',[.25*sz(3) 0.05*sz(4) .55*sz(3) 0.65*sz(4)]);
errorbar(plge*100,errge*100,'c','LineWidth',lwt1,'Marker','o','MarkerSize',10)
hold on
errorbar(plgi*100,errgi*100,'k','LineWidth',lwt1,'Marker','o','MarkerSize',10)
hold off
grid on
xlabel('# Pulse','fontsize',ftz2)
ylabel('Conductance  %','fontsize',ftz2)
set(gca,'fontsize',ftz1)
set(gca,'ylim',[0 100])
set(gca,'xlim',[1 20])

newname = inputdlg('Figure name:','Name',1,{'pooled20Hz'});
if ~isempty(newname)
    exportfig([svpath newname{1}])
else
    delete(figi)
end

%% 20 Hz ratio plot

plge = mean(Max20ge(:,:),1);
plgi = mean(Max20gi(:,:),1);
plrat = plgi./plge;
errge = std(Max20ge(Max20ge(:,1)~=0,:))/sqrt(length(Max20ge(Max20ge(:,1)~=0,:)));
errgi = std(Max20gi(Max20gi(:,1)~=0,:))/sqrt(length(Max20gi(Max20gi(:,1)~=0,:)));
errat = plrat .* sqrt((errge./plge).^2+(errgi./plgi).^2);

figi = figure('position',[.25*sz(3) 0.05*sz(4) .55*sz(3) 0.65*sz(4)]);
errorbar(plrat,errat,'k','LineWidth',lwt1,'Marker','o','MarkerSize',10)
hold on
plot([1 20],[1 1],'k--','LineWidth',lwt1)
hold off
% set(gca,'ylim',[.8 1.5])
set(gca,'xlim',[1 20])
grid on
xlabel('# Pulse','fontsize',ftz2)
ylabel('G_i/G_e','fontsize',ftz2)
set(gca,'fontsize',ftz1)
set(gca,'xlim',[1 20])

newname = inputdlg('Figure name:','Name',1,{'pooled20Hzratio'});
if ~isempty(newname)
    exportfig([svpath newname{1}])
else
    delete(figi)
end

% figure
% plot(Max20ge')
% figure
% plot(Max20gi')

%% 5 Hz adaption plot
plge = mean(Maxnorm5ge(:,:),1);
plgi = mean(Maxnorm5gi(:,:),1);

errge = std(Maxnorm5ge(Maxnorm5ge(:,1)~=0,:))/sqrt(length(Maxnorm5ge(Maxnorm5ge(:,1)~=0,:)));
errgi = std(Maxnorm5gi(Maxnorm5gi(:,1)~=0,:))/sqrt(length(Maxnorm5gi(Maxnorm5gi(:,1)~=0,:)));

figi = figure('position',[.25*sz(3) 0.05*sz(4) .55*sz(3) 0.65*sz(4)]);
errorbar(plge*100,errge*100,'c','LineWidth',lwt1,'Marker','o','MarkerSize',10)
hold on
errorbar(plgi*100,errgi*100,'k','LineWidth',lwt1,'Marker','o','MarkerSize',10)
hold off
grid on
xlabel('# Pulse','fontsize',ftz2)
ylabel('Conductance  %','fontsize',ftz2)
set(gca,'fontsize',ftz1)
set(gca,'ylim',[0 100])
set(gca,'xlim',[1 10])

newname = inputdlg('Figure name:','Name',1,{'pooled5hz'});
if ~isempty(newname)
    exportfig([svpath newname{1}])
else
    delete(figi)
end

%% 5 Hz ratio plot

plge = mean(Max5ge(:,:),1);
plgi = mean(Max5gi(:,:),1);
plrat = plgi./plge;
errge = std(Max5ge(Max5ge(:,1)~=0,:))/sqrt(length(Max5ge(Max5ge(:,1)~=0,:)));
errgi = std(Max5gi(Max5gi(:,1)~=0,:))/sqrt(length(Max5gi(Max5gi(:,1)~=0,:)));
errat = sqrt(plrat) .* sqrt((errge./plge).^2+(errgi./plgi).^2);


figi = figure('position',[.25*sz(3) 0.05*sz(4) .55*sz(3) 0.65*sz(4)]);
errorbar(plrat,errat,'k','LineWidth',lwt1,'Marker','o','MarkerSize',10)
hold on
plot([1 10],[1 1],'k--','LineWidth',lwt1)
hold off
% set(gca,'ylim',[.8 1.5])
% set(gca,'xlim',[1 10])
grid on
xlabel('# Pulse','fontsize',ftz2)
ylabel('G_i/G_e','fontsize',ftz2)
set(gca,'fontsize',ftz1)
set(gca,'xlim',[1 10])

newname = inputdlg('Figure name:','Name',1,{'pooled5hzratio'});
if ~isempty(newname)
    exportfig([svpath newname{1}])
else
    delete(figi)
end

% figure
% plot(Max5ge')
% set(gca,'ylim',[0 1])
% figure
% plot(Max5gi')
% set(gca,'ylim',[0 1])



