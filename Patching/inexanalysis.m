%% Inhibition/Excitation analysis protocoll
% choose your mouse/cel/run

mouse = [19 23 24 27 29 34 41 42 43 46 49 50 56 58 59 60];
mouse = [16];
cel = [1:30];
run = [2:4];


%% read out xls file with cell details
% 
% column 1: mouse number
% column 2: cell number
% column 3: run
% column 4: deepnes in um
% column 5: capacity
% column 6: Stimulation (1: single stim, 2: 5 Hz stim, 3: 20 Hz stim)
% column 7: Average (1: single file, 2: 4 files)
% column 8: reversal potential of excitation in V
% column 9: reversal potential of inhibition in V
% column 10: resting potential in the beginning in V
% column 11: ljp in V
% column 12-15: Current steps in nA 
% column 16-20: Measured fiber output in mW
% column 21: Access resistance
% column 22: Pipette resistance

deta = xlsread('cells.xlsx');

% find abf files
currdir = pwd;
% set data path here
pathname = '';
% pathname = uigetdir;
cd(pathname)
files1 = dir('*.abf');
cd(currdir)

files = cell(length(files1),1);
for i = 1:length(files)
    files{i} = files1(i).name;
end


%% sort out names and details 

files1 = cell(1,1);
deta1 = zeros(1,length(deta(1,:)));

for i = 1: length(files)
    dots = cell2mat(strfind(files(i),'.'));
    
    for j = 1:length(mouse)
        if str2double(files{i}(5:dots(1)-1)) == mouse(j)
            for k = 1:length(cel)
                if str2double(files{i}(dots(2)+1:dots(3)-1)) == cel(k)
                    if length(dots) > 3
                        for kk = 1:length(run)
                            if str2double(files{i}(dots(3)+1:dots(4)-1)) == run(kk)
                                files1(end+1,1) = files(i);
                            end
                        end
                    else
                        files1(end+1) = files(i);
                    end
                end
            end
        end
    end

end

for i = 1:length(deta(:,1))
    for j = 1:length(mouse)
        if deta(i,1) == mouse(j)
            for k = 1:length(cel)
                if deta(i,2) == cel(k)
                    for ii = 1:length(run)
                        if deta(i,3) == run(ii)
                            deta1(end+1,:) = deta(i,:);
                        end
                    end
                end
            end
        end
    end
end

files = files1(2:end);                        
deta = deta1(2:end,:);
clear files1 deta1

%% Load data

i = 1;
while i <= length(files)

    [time, ~, ~, ~, ~] = helpers.loadVclampAbf([pathname files{i}]);
    int = 1 : length(time);
    
    if deta(i,7) == 0
        i = i +1;     
%     elseif deta(i,7) == 2
%         vm = zeros(length(int),4,1);
%         ve = deta(i,8);
%         vi = deta(i,9);
%         vr = deta(i,10);
%         ljp = deta(i,11);
%         iin = zeros(1,4);
%         lout = deta(i,16:20); % laser output
%         
%         for j = 0:3
%             [time, dt, ~, data_v, cell_name] = loadVclampAbf([pathname files{i+j}]);
%             iin(j+1) = deta(i+j,12)*1e-12;
%             vm1 = zeros(length(int),length(data_v(1,1,:)));
%             vm1(:,:) = data_v(int,1,:)*1e-3;
%             vm(:,j+1,1) = mean(vm1,2);             
%         end
%         
%         stim = data_v(int,3,1); % stimulation pulses
%         time = time(int); % shortens time intervall
% 
%         [vm,rec,bsln,gl,ge,gi,gestd,gistd,C,sat] = inexfit(vm,vi,ve,vr,ljp,iin,time);
%         [maxge,maxgi,delge,delgi,lout] = inexmeasure(ge,gi,stim,time,lout,deta(i,6),str2double(files{i}(5:6)));        
%         
%         save([pathname files{i}(1:end-3) 'av.mat'],...
%             'time','stim','vm','rec','bsln','gl','ge','gi','gestd','gistd','vm','vi','ve','C','iin','ljp','sat','maxge','maxgi','delge','delgi','lout')
%         i = i+4;
    else
        
        Cpip = deta(i,5)*1e-12; % cell capacitance in F
        prot = deta(i,6);
        num = deta(i,7); % number of files to average
        ve = deta(i,8);
        vi = deta(i,9);
        vr = deta(i,10);
        ljp = deta(i,11);
        iin = deta(i,12:15)*1e-12;
        lout = deta(i,16:20); % laser output
        Ra = deta(i,21)*1e6; % Access resistance of the patch
        expr = struct; 
        inex = struct;
            
        if exist([pathname files{i}(1:end-3) 'av.mat'],'file')
            A = load([pathname files{i}(1:end-3) 'av.mat']);
            if isfield(A,'expr')
               expr = A.expr;
            end
            if isfield(A,'inex')
               inex = A.inex;
            end
            time = A.time;
            stim = A.stim;
%             dt = A.dt;
            vm = A.vm;
            clear A
        else
            [time, stim, ~, vm] = helpers.inexread(pathname, files(i:i+num-1,:),num,int,ljp);
        end
        
        
        [bsln,sat,gl,C,onst,offst] = helpers.pasprop(vm,Ra,time,stim,iin);
        [vm,rec,ge,gi,gestd,gistd] = helpers.inexfit(vm,vi,ve,iin,onst,offst,C,gl,bsln);
        [maxge,maxgi,onge,ongi,lout,tauge,taugi,~,~,~] = helpers.inexmeasure(ge,gi,stim,time,lout,prot,str2double(files{i}(5:6)));
        files{i} = [files{i}(1:end-3)  'av.mat'];
        helpers.inexsave
        
        clear time stim vm rec bsln gl ge gi gestd gistd vm vi ve C iin ljp sat maxge maxgi delge delgi lout expr inex
        
        i = i+deta(i,7);
    end

end

showdata
