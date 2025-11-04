 %% Inhibition/Excitation posthoc data load protocoll
% choose your mouse/cel/run

% mouse = [15 16 19 23 24 27 29 34 41 42 43 46 49 50 56 58 59 60]; %all
% responding
% mouse = [15 16 19 24 29 34 43 49 58 59 60]; %all postitiv mice interesting
mouse = [19 24 43 49 59]; % Granular cells for sure
% mouse = [15 34]; % Interneurons
% mouse = [16 29]; % Slow Granular cells
% mouse = [16 19 24 29 43 49 59]; % Granular 


% mouse = [29];
cel = [1:60];



%% read out xls file with cell details
% 
% column 1: mouse number
% column 2: cell number
% column 3: run
% column 4: deepnes in �m
% column 5: capacity
% column 6: Stimulation (1: single stim, 2: 5 Hz stim, 3: 20 Hz stim)
% column 7: Average (1: single file, 2: 4 files)
% column 8: reversal potential of excitation in V
% column 9: reversal potential of inhibition in V
% column 10: resting potential in the beginning in V
% column 11: ljp in V
% column 12-15: Current steps in nA 
% column 16-20: Measured fiber output in mW
% column 21: Acces resistance
% column 22: Pipette resistance

% deta = xlsread('\\beck-wiki\tausch\Martin\cells.xlsx');

% find abf files
currdir = pwd;
pathname = '';
% pathname = uigetdir;
cd(pathname)
files1 = dir('*.mat');
cd(currdir)

files = cell(length(files1),1);
for i = 1:length(files)
    files{i} = files1(i).name;
end

%% sort out names and details 

files1 = cell(1,1);

for i = 1: length(files)
    dots = cell2mat(strfind(files(i),'.'));
    
    for j = 1:length(mouse)
        if str2double(files{i}(5:dots(1)-1)) == mouse(j) && ~isempty(find(cel == str2double(files{i}(dots(2)+1:dots(3)-1)),1))

            files1(end+1,1) = files(i);
                       
        end
    end

end

files = files1(2:end);                        
clear files1 deta1
%% pooled data analysis of chosen mice

helpers.inexpool


%% Posthoc calculations and corrections

% files = files(1);
% for i = 1 : length(files)
% 
%     load([pathname files{i}])
%     stimpt = find(diff(stim)*3e-5-0.1>0);
%     if length(stimpt) < 10
%         prot = 1;
%     elseif length(stimpt) > 10
%         prot = 3;
%     else
%         prot = 2;
%     end
% 
%     if prot == 1
% 
% %         [bsln,sat,gl,C,onst,offst] = pasprop(vm,Ra,time,stim,iin);
% %         [vm,rec,ge,gi,gestd,gistd] = inexfit(vm,vi,ve,iin,onst,offst,C,gl,bsln);
% %         [maxge,maxgi,onge,ongi,~,tauge,taugi,~,~,~] = inexmeasure(ge,gi,stim,time,lout,prot,str2double(files{i}(5:6)));
% %         inexposthoc       
% %         inexsave
% 
%     end
% 
% end


