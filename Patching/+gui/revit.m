function inex = revit(time,stim,vm,bsln,iin,C)


stimpt = find(diff(stim)*3e-5-0.1>0);
int = stimpt(end-1):stimpt(end-1)+20000;
% int = stimpt(end):stimpt(end)+20000;
vi = -.1:0.001:-.04;
ve = 0;%-0.01:0.001:0.05;
ofst = 0;
vm1 = vm(int,:);
bsln1 = bsln(int,:);
gemin = zeros(1,length(ve));
gemax = zeros(1,length(ve));
gimin = zeros(1,length(ve));
gimax = zeros(1,length(ve));
ge = zeros(round(length(ve)/10)+1,length(int));
gi = zeros(round(length(ve)/10)+1,length(int));
jj  = 1;

for i = 1:length(ve)
    for j = 1:length(vi)
%         ve = vi(j)+.06;
        for k = 1:length(ofst)
            
            [~,~,~,~,ge1,gi1,~,~] = helpers.inexit(vm1,bsln1,vi(j),ve(i),ofst(k),iin,C);
            
            gemin(j)=min(ge1);
            gemax(j)=max(ge1);
            gimin(j)=min(gi1);
            gimax(j)=max(gi1);
            
            if mod(jj+9,10) == 0
                ge((jj+9)/10,:) = ge1;
                gi((jj+9)/10,:) = gi1;
            end
            jj = jj+1;
        end
    end
end

inex = struct('ge',ge,'gi',gi,'gemin',gemin,'gemax',gemax,'gimin',gimin,'gimax',gimax,'vi',vi,'ve',ve,'time',time(int));

end


