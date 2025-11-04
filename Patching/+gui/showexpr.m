
if exist('expr','var') && isfield(expr,'a')
    exh = gui.exprplot(expr);
else
    pathname1 = 'C:\Users\Martin\Documents\Daten\Patch Daten\Reconstructions\';
    [filename1, pathname1] = uigetfile('*.tif', 'Choose image to open', pathname1);

    if ~ischar(filename1)
        return
    end

    [exh,expr] = gui.expression(pathname1,filename1);
    sv = questdlg('Save data?','Save','Yes','No','Yes');
    if strcmp(sv,'Yes')
        save([pathname, files{st1}],...
                'time','stim','vm','rec','bsln','gl','ge','gi','gestd','gistd','vm','vi','ve','C','iin','ljp','sat','maxge','maxgi','delge','delgi','lout','inex','expr','Ra')
    end
end

uicontrol('style','pushbutton','String','Recalculate','Units','normalized',...
    'Position',[.1 .01 .1 .03],'BackgroundColor',[.8 .8 .8],...
    'callback','delete(exh);clear(''expr'',''exh'');gui.showexpr;');

uicontrol('style','pushbutton','String','figit','Units','normalized',...
    'Position',[.2 .01 .1 .03],'BackgroundColor',[.8 .8 .8],...
    'callback','gui.figit');