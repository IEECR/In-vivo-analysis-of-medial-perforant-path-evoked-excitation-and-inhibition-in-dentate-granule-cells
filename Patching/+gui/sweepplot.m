% function sweepplot

fac1 = 1000;
fac2 = 1e9;

subplot(trax)
stimpt = find(diff(stim)*3e-5-0.1>0); % find stimulation points
xll=get(gca,'xlim');
yll=get(gca,'ylim');


if get(bsvm,'value') == 1
    plot(time,vm.*fac1,'k')
    hold on
end
if get(bsrec,'value') == 1
    plot(time,rec.*fac1,'color',[.5 .5 .5])
    hold on
end
if get(bsbsln,'value') == 1
    plot(time,bsln.*fac1,'color','green')
    hold on
end
if get(bsstim,'value') == 1
    plot(time,stim*4e-2-150,'r')
    hold on
end
if get(bsge,'value') == 1
    plot(time,ge*fac2,'c')
    hold on
    scatter(maxge(:,1),fac2*maxge(:,2))
    scatter(onge(:,1),fac2*onge(:,2)) 
end
if get(bsgi,'value') == 1
    plot(time,gi*fac2,'k')
    hold on
    scatter(maxgi(:,1),fac2*maxgi(:,2))
    scatter(ongi(:,1),fac2*ongi(:,2))   
end

if get(bssat,'value') == 1 && exist('sat','var')
    plot(sat(:,1),sat(:,2)*1000,'r',sat(:,1),sat(:,3)*1000,'r')    
    hold on
end

% if time(length(vm(:,1))) < xll(2)
%     xll(2) = time(length(vm(:,1)));
% end

grid on
set(gca,'xlim',xll)
set(gca,'ylim',yll)
ylabel('Membrane Voltage/mV (Conductance/nS)')
xlabel('Time/ms')
% axis tight

hold off

subplot(cond)
p = polyfit(mean(bsln,1)*1000,iin*1e12,1);
x = -100:1:20;
scatter(mean(bsln,1)*1000,iin*1e12)
hold on
plot(x,p(2)+p(1)*x)
% plot(x,p(3)+p(2)*x+p(1).*x.^2)
set(gca,'xlim',[-100 -20])
set(gca,'ylim',[-60 100])
xlabel('Membrane Voltage/mV')
ylabel('Membrane Current/nA')
% axis tight
grid on
hold off

%% Values

uicontrol('Style','text','Units','normalized',...
    'String',['Cell Resistance: ' num2str(round(1/gl(iin==0)*1e-6)) ' MOhm'],...
    'HorizontalAlignment','left',...
    'Position',[.85 .635 .2 .03],'FontSize',9,...
    'BackgroundColor',[.8 .8 .8]);

uicontrol('Style','text','Units','normalized',...
    'String',['Resting Potential: ' num2str(round(bsln(1,iin==0)*1000)) ' mV'],...
    'HorizontalAlignment','left',...
    'Position',[.85 .605 .2 .03],'FontSize',9,...
    'BackgroundColor',[.8 .8 .8]);

uicontrol('Style','text','Units','normalized',...
    'String',['Capacitance: ' num2str(round(C*1e12)) ' pF'],...
    'HorizontalAlignment','left',...
    'Position',[.85 .575 .2 .03],'FontSize',9,...
    'BackgroundColor',[.8 .8 .8]);

uicontrol('Style','text','Units','normalized',...
    'String',['Ex. Rev. Potential: ' num2str(ve*1000) ' mV'],...
    'HorizontalAlignment','left',...
    'Position',[.85 .545 .2 .03],'FontSize',9,...
    'BackgroundColor',[.8 .8 .8]);

uicontrol('Style','text','Units','normalized',...
    'String',['Inh. Rev. Potential: ' num2str(vi*1000) ' mV'],...
    'HorizontalAlignment','left',...
    'Position',[.85 .515 .2 .03],'FontSize',9,...
    'BackgroundColor',[.8 .8 .8]);
