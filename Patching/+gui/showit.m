if exist('inex','var') && isfield(inex,'ge')
    inh = inexplot(inex);
else
    inex = gui.revit(time,stim,vm,bsln,iin,C);
    inh = hui.inexplot(inex);
    sv = questdlg('Save data?','Save','Yes','No','Yes');
    if strcmp(sv,'Yes')
        i = st1;   
        helpers.inexsave
    end
end

uicontrol('style','pushbutton','String','Recalculate','Units','normalized',...
    'Position',[.1 .05 .1 .03],'BackgroundColor',[.8 .8 .8],...
    'callback','delete(inh);clear(''inex'');showit;');