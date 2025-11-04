function [maxge,maxgi,onge,ongi,lout,tauge,taugi,Ge,Gi,Rat] = inexmeasure(ge,gi,stim,time,lout,prot,maus)


%% measure delay and amplitude of response in excitation and inhibition


stimpt = find(diff(stim)*3e-5-0.1>0); % find stimulation points
int = 5000;
y = time(1:int);
% stimpt = stimpt(3:end);


maxge = zeros(length(stimpt),3);
maxgi = zeros(length(stimpt),3);
onge = zeros(length(stimpt),3);
ongi = zeros(length(stimpt),3);
Ge = zeros(length(stimpt),int);
Gi = zeros(length(stimpt),int);
Rat = zeros(length(stimpt),int);
taugi = zeros(length(stimpt),1);
tauge = zeros(length(stimpt),1);

st = 1;
possg = [15 1
        16 1
        19 1
        24 2
        29 4
        34 3
        43 3
        49 2
        58 0
        59 3
        60 0];
    
if length(stimpt) < 10 && ~isempty(find(possg(:,1)==maus,1))
    st = possg(possg==maus,2);
end
%%
%   decay fitoptions
    s = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[    -10,  0,   -1],...
               'Upper',[    +10, 1000,1],...
               'Startpoint',[1, 20,  0]);         
               
    f = fittype('a*(-exp(-((x)./c)))+d','options',s); 

%     EPSP/IPSP fit options
%     s1 = fitoptions('Method','NonlinearLeastSquares',...
%                 'Lower',[    -10,-20,  0,   -1],...
%                'Upper',[    +10,20, 1000,1],...
%                'Startpoint',[1, -4, 20,  0]);                      
%     f1 = fittype('a*(x+b)*(-exp(-((x+b)./c)))+d','options',s1); 
%%

if st ~= 0
    for i = st:length(stimpt)
        maxge(i,2) = max(ge(stimpt(i)+100:stimpt(i)+1000));
        maxgi(i,2) = max(gi(stimpt(i)+200:stimpt(i)+1000));  
        maxge(i,1) = time(stimpt(i)-1+find(ge(stimpt(i):stimpt(i)+1000) == maxge(i,2)));
        maxgi(i,1) = time(stimpt(i)-1+find(gi(stimpt(i):stimpt(i)+1000) == maxgi(i,2)));
        maxge(i,3) = maxge(i,1) - time(stimpt(i));
        maxgi(i,3) = maxgi(i,1) - time(stimpt(i));


        gedv = smooth(diff(ge(stimpt(i):find(time == maxge(i,1))),2),100);
        gidv = smooth(diff(gi(stimpt(i):find(time == maxgi(i,1))),2),100);
        gidv = gidv(20:end-20);
        gedv = gedv(20:end-20);

        onge(i,2) = ge(stimpt(i)+find(gedv == max(gedv)));
        ongi(i,2) = gi(stimpt(i)+find(gidv == max(gidv)));
        onge(i,1) = time(stimpt(i)-1+find(ge(stimpt(i):stimpt(i)+int) == onge(i,2)));
        ongi(i,1) = time(stimpt(i)-1+find(gi(stimpt(i):stimpt(i)+int) == ongi(i,2)));
        onge(i,3) = onge(i,1) - time(stimpt(i));
        ongi(i,3) = ongi(i,1) - time(stimpt(i));

        Ge(i,:) = ge(stimpt(i):stimpt(i)+int-1);%-i*1e-9;
        Gi(i,:) = gi(stimpt(i):stimpt(i)+int-1);%-i*1e-9;
        Rat(i,:) = (Gi(i,:)-Ge(i,:))./max(Gi(i,:));%-i*1e-9;
%         Rat(i,:) = ((Gi(i,:)+1)./(Ge(i,:)+1))-1;%./max(Gi(i,:));%-i*1e-9;

        if prot == 1
            cfun = fit(y(find(Ge(i,:) == maxge(i,2)):end),Ge(i,find(Ge(i,:) == maxge(i,2)):end)'/maxge(i,2),f);
            if cfun.c < 190
                tauge(i) = cfun.c;
            end
            cfun = fit(y(find(Gi(i,:) == maxgi(i,2)):end),Gi(i,find(Gi(i,:) == maxgi(i,2)):end)'/maxgi(i,2),f);
            if cfun.c < 190
                taugi(i) = cfun.c;
            end
            
%             figure
%             plot(y(find(Gi(i,:) == maxgi(i,2)):end),Gi(i,find(Gi(i,:) == maxgi(i,2)):end))
%             hold on
%             plot(y(find(Gi(i,:) == maxgi(i,2)):end),cfun(y(find(Gi(i,:) == maxgi(i,2)):end))*maxgi(i,2),'r')
%             set(gcf,'name',[ 'Maus ' num2str(maus) ' Stim ' num2str(i)])
        end
%         EPSP/IPSP fit options
%         cfun = fit(y(find(Ge == onge(i,2)):end),Ge(i,find(Ge == onge(i,2)):end)'/maxge(i,2),f1);
        
    end
end

if maus == 29 && length(stimpt) < 10
    
    maxge(1:end-1,2) = maxge(2:end,2);
    maxgi(1:end-1,2) = maxgi(2:end,2);  
    maxge(1:end-1,1) = maxge(2:end,1);
    maxgi(1:end-1,1) = maxgi(2:end,1);
    maxge(1:end-1,3) = maxge(2:end,3);
    maxgi(1:end-1,3) = maxgi(2:end,3);
    
    onge(1:end-1,2) = onge(2:end,2);
    ongi(1:end-1,2) = ongi(2:end,2);
    onge(1:end-1,1) = onge(2:end,1);
    ongi(1:end-1,1) = ongi(2:end,1);
    onge(1:end-1,3) = onge(2:end,3);
    ongi(1:end-1,3) = ongi(2:end,3);
    
    tauge(1:end-1) = tauge(2:end);
    taugi(1:end-1) = taugi(2:end);
    
    Ge(1:end-1,:) = Ge(2:end,:);
    Gi(1:end-1,:) = Gi(2:end,:);
    Rat(1:end-1,:) = Rat(2:end,:);
end




%%
% close all

% % close all
% int = (2:length(stimpt));
% figure
% semilogx(lout(int),tauge(int),lout(int),taugi(int))
% figure
% semilogx(lout(int),onge(int,3),lout(int),ongi(int,3))
% figure
% semilogx(lout(int),maxge(int,2)/max(maxge(int,2)),lout(int),maxgi(int,2)/max(maxgi(int,2)))
% figure
% semilogx(lout(int),maxge(int,2),lout(int),maxgi(int,2))
% semilogx(lout(int),maxgi(int,2))
% hold on
% figure
% semilogx(lout(int),maxgi(int,2)./maxge(int,2))
% 
% figure
% plot(y,Ge(7,:)*1e9,y,Gi(7,:)*1e9,y,(Rat(7,:)-1)*1e9)
% figure
% plot(y(find(Ge == maxge(i,2)):end),Ge(find(Ge == maxge(i,2)):end))
% hold on
% plot(y(find(Ge == maxge(i,2)):end),cfun(y(find(Ge == maxge(i,2)):end))*maxge(i,2),'r')
% figure
% plot(y(find(Ge == onge(i,2)):end),Ge(find(Ge == onge(i,2)):end))
% hold on
% plot(y(find(Ge == onge(i,2)):end),cfun(y(find(Ge == onge(i,2)):end))*maxge(i,2),'r')
% figure
% plot(y,Rat)
% figure
% plot(y,Gi)
% hold on 
% scatter(ongi(:,3),ongi(:,2))
% scatter(maxgi(:,3),maxgi(:,2))
% scatter(onge(:,3),onge(:,2))
% scatter(maxge(:,3),maxge(:,2))
% set(gcf,'name',[ 'Maus ' num2str(maus)])

%% adjust laser output

% if prot == 1
%     lin = (20:20:100);
%     p = polyfit(lin,lout,1);
%     p(1);
%     if maus > 23
%         lout = [.1 .2 .3 .5 1 2 3 5] * 100/5 *p(1);
%     else
%         lout = [1 2 3 4 5] * 100/5 * p(1);
%     end
% else
%     lout = max(lout);
% end


end