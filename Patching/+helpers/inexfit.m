function [vm,rec,ge,gi,gestd,gistd] = inexfit(vm,vi,ve,iin,onst,offst,C,gl,bsln)

% calculating derivatives of measured voltages
dvm = zeros(size(vm));

for i = 1 : length(vm(1,:,1))
    dvm(1:end-1,i) = diff(vm(:,i));
end



%% Conductance model analysis

ge = zeros(1,length(vm(:,1)));
gi = zeros(1,length(vm(:,1)));
gestd = zeros(1,length(vm(:,1)));
gistd = zeros(1,length(vm(:,1)));


a = zeros(1,4);
b = zeros(1,4);
s = zeros(2,6);

for j = onst+1000 : offst-50
    for i = 1 : length(vm(1,:))
        a(i) = -(vm(j,i)-ve)/(vm(j,i)-vi);
        b(i) = (iin(i) - C*dvm(j,i) - gl(j,i)*(vm(j,i)-bsln(j,iin==0)))/(vm(j,i)-vi);   
    end
    
    k = 1;
    kk = 1;
    for i = 1: 0.5*length(vm(1,:))*(length(vm(1,:))-1)
        
        s(1,i) = (b(k+kk)-b(k))/(a(k)-a(k+kk));
        s(2,i) = a(k)*s(1,i)+b(k);
        
        k = k + 1;
        if k+kk-1 == length(vm(1,:))
            k = 1;
            kk = kk + 1;
        end
    end
    
    ge(j) = mean(s(1,:),2); 
    gi(j) = mean(s(2,:),2);
    
    gestd(j) = std(s(1,:),1,2);
    gistd(j) = std(s(2,:),1,2);
end

%% reconstruction of traces

rec = zeros(size(vm));

for j = 1 : length(vm(:,1))
    for i = 1 : length(vm(1,:))
         rec(j,i) = (iin(i) - C*dvm(j,i) + ge(j)*ve + gi(j)*vi  +  gl(j,i)*bsln(j,iin==0))/(ge(j) + gi(j) + gl(j,i));
    end
end

% mean sqared error
% mse = mean((vm - rec).^2);
% rmse = sqrt(mse);

% R^^2 score
% SS_res = sum((vm - rec).^2);
% SS_tot = sum((vm - mean(rec)).^2);
% R2 = 1 - SS_res / SS_tot;
end