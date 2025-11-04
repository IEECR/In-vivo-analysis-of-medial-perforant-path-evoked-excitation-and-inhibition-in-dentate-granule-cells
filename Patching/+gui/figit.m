% figurize it

if exist('exh','var') && gcf == exh
    figi = exprplot(expr);
else
    
    subplot(trax)

    fac1 = 1000;
    fac2 = 1e9;
    ftz1 = 20;
    ftz2 = 20;
    lwt1 = 2;
    nS = 0;
    mW = 0;
    scbr = 1; %choose wether axis or scalebars should be plotted
    xll=get(gca,'xlim');
    yll=get(gca,'ylim');
    xli = 200;
    


    figi = figure('position',[1 0.14*sz(4) .7*sz(3) 0.7*sz(4)]);
    
    if get(bsrec,'value') == 1
        plot(time,rec.*fac1,'color',[.5 .5 .5],'LineWidth',lwt1)
        mW = 1;
        hold on
    end
    
    if get(bsvm,'value') == 1
        plot(time,vm.*fac1,'k','LineWidth',lwt1)
        mW = 1;
        hold on
    end
    
    if get(bsbsln,'value') == 1
        plot(time,ones(length(vm(:,1)),1)*bsln.*fac1,'g','LineWidth',lwt1)
        mW = 1;
        hold on
    end
    if get(bsstim,'value') == 1
        plot(time,stim*4e-2-150,'r','LineWidth',lwt1)
        hold on
    end
    if get(bsge,'value') == 1
        plot(time,ge*fac2,'c','LineWidth',lwt1)
        nS = 1;
        hold on
    end
    if get(bsgi,'value') == 1
        plot(time,gi*fac2,'k','LineWidth',lwt1)
        nS = 1;
        hold on
    end
    % if get(bsge,'value') == 1
    %     plot(time,ge/maxge(6,2),'color','cyan','LineWidth',lwt1)
    %     nS = 1;
    %     hold on
    % end
    % if get(bsgi,'value') == 1
    %     plot(time,gi/maxgi(6,2),'color','blue','LineWidth',lwt1)
    %     nS = 1;
    %     hold on
    % end

    if get(bssat,'value') == 1 && exist('sat','var')
        plot(sat(:,1),sat(:,2)*1000,'r',sat(:,1),sat(:,3)*1000,'r','LineWidth',lwt1)
        mV = 1;
        hold on
    end

    grid on
    set(gca,'xlim',xll)
    set(gca,'ylim',yll)
    set(gca,'fontsize',ftz1)
    
    if scbr == 1
        axis off
        plot([xll(1) xll(1)],[yll(1) yll(1)+2],'k','LineWidth',lwt1+1)
        plot([xll(1) xll(1)+200],[yll(1) yll(1)],'k','LineWidth',lwt1)
    else
        if mW == 1 && nS == 1
            ylabel('Membrane Voltage/mV  Conductance/nS','fontsize',ftz2)
        elseif nS == 1
            ylabel('Conductance/nS','fontsize',ftz2)
        else
            ylabel('Membrane Voltage/mV','fontsize',ftz2)
        end
        xlabel('Time/ms','fontsize',ftz2)

        set(gca,'XTick',round(xll(1))+xli:xli:round(xll(2)));
        set(gca,'XTickLabel',xli:100:round(xll(2))-round(xll(1)));
    end
    
    
    
    
end


