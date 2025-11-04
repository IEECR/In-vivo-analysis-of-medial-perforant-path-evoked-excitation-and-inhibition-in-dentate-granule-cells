function [bsln,sat,gl,C,onst,offst] = pasprop(vm,Ra,time,stim,iin)

stimpt = find(diff(stim)*3e-5-0.1>0);


%% find on- and offset

trc = 4;

int = 100:12000;
int2 = 200;
onst = int(1)+find(diff(vm(int,trc),2)==min(diff(vm(int,trc),2)));
onst = onst-int2+find(diff(vm(onst-int2:onst+int2,trc),1)==min(diff(vm(onst-int2:onst+int2,trc),1)));
onst = onst(1);

if stimpt(end)+5000 > length(vm(:,1))-45000
    int = stimpt(end)+5000:length(vm(:,1))-1000;
else
    int = length(vm(:,1))-45000:length(vm(:,1))-1000;
end
    

offst = int(1)+find(diff(vm(int,trc),2)==min(diff(vm(int,trc),2)));
offst = offst-int2+find(diff(vm(offst-int2:offst+int2,trc),1)==min(diff(vm(offst-int2:offst+int2,trc),1)));
offst = offst(1);
%% baseline estimation


bsln = zeros(size(vm));
gl = zeros(size(vm));
k = 0;
for j = 1:length(stimpt)+1
    i = 4;
    if j == 1
        int = onst+1000 : stimpt(1);
        int2 = 1:int(end)+19999;
    elseif j == length(stimpt)+1
        int2 = int(end)+20000:length(bsln(:,i));
    elseif stimpt(j-1) + 20000 < stimpt(j)
        int = stimpt(j-1) + 20000:stimpt(j);  
        if int(end)+19999 < length(bsln(:,i))
            int2 = int(1):int(end)+19999;
        else
            int2 = int(1):length(bsln(:,i));
        end
    else
        k = 1;
    end
    if k~=1
        for i = 1:4
            bsln(int2,i) = bsln(int2,i) + mean(vm(int,i));
        end
        for i = 1:4
            if iin(i)~=0
               gl(int2,i) = iin(i)/(mean(vm(int,i))-bsln(int(1),2));
            else
            p = polyfit(bsln(int(1),:),iin,1);
            gl(int2,iin==0) = p(1);
            end
        end
    end
    k = 0;
end




%% calculating cell capacitance Using charging of cell capacitance

C=0;
int = 100:15000;
int2 = 200;
sat = zeros(10*int2+1,3);

for j = 3:4  
    
    trc = j;
    
    onst = int(1)+find(diff(vm(int,trc),2)==min(diff(vm(int,trc),2)));
    onst = onst-int2+find(diff(vm(onst-int2:onst+int2,trc),1)==min(diff(vm(onst-int2:onst+int2,trc),1)));
    onst = onst(1);

    lo = mean(vm(int(1):onst,trc));
    hi = mean(vm(onst+2*int2:onst+3*int2,trc));
    
    s = fitoptions('Method','NonlinearLeastSquares',...
                   'Lower',[hi-lo-0.01,time(onst)-.01,0,vm(onst,trc)-0.0001],...
                   'Upper',[hi-lo+0.01,time(onst)+.01,1000,vm(onst,trc)+0.0001],...
                   'Startpoint',[hi-lo, time(onst), 20, vm(onst,trc)]);

    f = fittype('a*(1-exp(-((x-b)/c)))+d','options',s);

%   Sigmoid function fitting    
%     s = fitoptions('Method','NonlinearLeastSquares',...
%                    'Lower',[hi-lo-10,time(onst)-.01,0,vm(onst,trc)-1],...
%                    'Upper',[hi-lo+10,time(onst)+.01,1000,vm(onst,trc)+1],...
%                    'Startpoint',[hi-lo, time(onst), 20, vm(onst,trc)]);
%     f = fittype('a./(1+exp(-((x-b)/c)))+d','options',s);
    
    sat(:,1) = time(onst:onst+10*int2);
    cfun = fit(sat(:,1),vm(onst:onst+10*int2,trc),f);
    tau = cfun.c;
%     C = C + tau*(gl(2));
        C = C + tau*(1/Ra+gl(2));
    sat(:,j-1)=cfun(sat(:,1));
    
    
%     figure
%     plot(sat(:,1),cfun(sat(:,1)),'r')
%     hold on
%     scatter(time(onst),lo)
%     scatter(time(onst+100),hi)
%     plot(sat(:,1),vm(onst:onst+10*int2,trc)) 
%     plot(sat(1:end-1,1),diff(vm(onst:onst+10*int2,trc))*10-0.07)
%     plot(sat(1:end-2,1),diff(vm(onst:onst+10*int2,trc),2)*50-0.07)
    grid on
    hold off

end
C = C/2000;

%% calculating cell capacitance Using uncharging of cell capacitance
% 
% C=0;
% 
% if offst+3000 > length(vm(:,1))
%     int = offst-50:length(vm(:,1));
% else
%     int = offst-50:offst+3000;
% end
% sat = zeros(length(int),3);
% sat(:,1) = time(int);
% 
% 
% 
% for j = 3:4
%     
%     trc = j;
% 
%     lo = mean(vm(offst+1000:end,trc));
%     hi = mean(vm(offst-2000:offst-100,trc));
%                
% %     s = fitoptions('Method','NonlinearLeastSquares',...
% %                    'Lower',[hi-lo-1000,0,0,vm(offst,trc)-20],...
% %                    'Upper',[hi-lo+1000,100000,1000,vm(offst,trc)+20],...
% %                    'Startpoint',[hi-lo, time(offst), 20, vm(offst,trc)]);         
% %                
% %     f = fittype('a*(-exp(-((x-b)./c)))+d','options',s);
% %         cfun = fit(time(int),vm(int,trc),f);
% %     tau = cfun.c;
% 
%     s = fitoptions('Method','NonlinearLeastSquares',...
%         'Startpoint',[hi-lo,     time(int(1)), 20,    20,     vm(offst,trc), time(int(1)),hi-lo],...
%         'Lower', [   hi-lo-1000,  0,          0,      0,      vm(offst,trc)-20,   0,       hi-lo-1000],...
%         'Upper', [   hi-lo+1000,  100000,     1000,   1000,   vm(offst,trc)+20,   100000,  hi-lo+1000],...
%         'MaxIter',1000);         
%                
%     f = fittype('a*exp(-((x-b)/c))+g*exp(-((x-f)/d))+e','options',s);
%     cfun = fit(time(int),vm(int,trc),f);
% 
%     if cfun.c > cfun.d
%         tau = cfun.d;
%     else
%         tau = cfun.c;
%     end
%      
% 
%     C = C + tau*(1/Ra+gl(2));
% %     C = C + tau*(gl(2));
%     sat(:,j-1)=cfun(sat(:,1));
%     
% 
% %     figure
% %     plot(sat(:,1),cfun(sat(:,1)),'r')
% %     hold on
% %     scatter(time(offst+200),lo)
% %     scatter(time(offst),hi)
% %     plot(sat(:,1),vm(int,trc))
% %     grid on
% %     hold off
% 
% end
% 
% C = C/2000;

end