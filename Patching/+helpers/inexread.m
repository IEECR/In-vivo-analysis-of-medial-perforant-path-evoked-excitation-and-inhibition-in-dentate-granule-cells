function [time,stim, dt, vm] = inexread(path,files,num,int,ljp)
    
    vm = zeros(length(int),4,num);
    for j = 1:num
        [time, dt, ~, data_v, ~] = helpers.loadVclampAbf([path files{j}]);
        vm(:,:,j) = data_v(int,1,:)*1e-3;
    end
    
    time = time(int); % shortens time intervall
    stim = data_v(int,3,1); % stimulation pulses
    vm1 = zeros(size(vm(:,:,1)));

    % smoothing traces, offset & liquid junction potential correction, 

    for i = 1 : length(vm(1,1,:))
        for j = 1 : length(vm(1,:,1))
            vm(:,j,i) = smooth(vm(:,j,i),100);         
        end
        ofst = 0;%vr - bsln(iin==0);
        vm(:,:,i) = vm(:,:,i) + ofst + ljp;   
    end

    % vr = vr + ljp;

    for i = 1 : length(vm(1,:,1))
        vm1(:,i) = mean(vm(:,i,:),3);
    end
    vm = vm1;
    
end

