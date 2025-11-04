

j = 3;
i = st1;
lout = deta(j,16:20);
prot = deta(j,6);
[maxge,maxgi,delge,delgi,lout] = helpers.inexmeasure(ge,gi,stim,time,lout,prot,str2double(files{i}(5:6)));
save([pathname files{i}],...
            'time','stim','vm','rec','bsln','gl','ge','gi','gestd','gistd',...
            'vm','vi','ve','C','iin','ljp','sat','maxge','maxgi','delge',...
            'delgi','lout');