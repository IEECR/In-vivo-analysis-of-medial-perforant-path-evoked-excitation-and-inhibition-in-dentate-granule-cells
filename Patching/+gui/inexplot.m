function inh = inexplot(inex)

ge = inex.ge;
gi = inex.gi;
gemin = inex.gemin;
vi = inex.vi;
ve = inex.ve;
time = inex.time;


sz = get(0,'screensize');
inh = figure('Name','Excitation Inhibition Iteration','NumberTitle','off','toolbar','figure','position',[1 0.14*sz(4) sz(3) 0.7*sz(4)],'doublebuffer','on');
    
for i = 1:length(ge(:,1))
    subplot(2,4,i+1)
    plot(time,ge(i,:),'color','cyan')
    hold on
    plot(time,gi(i,:),'color','blue')
    grid on
end

subplot(2,4,1)
plot(vi,gemin/max(abs(gemin)))
hold on
plot(vi(1:end-2),diff(gemin,2)/max(abs(diff(gemin,2))),'r')
grid on


end