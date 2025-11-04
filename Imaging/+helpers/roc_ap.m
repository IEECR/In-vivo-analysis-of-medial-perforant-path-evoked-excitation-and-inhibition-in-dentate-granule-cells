% ROC analysis for Air Puff response
function [roc_auc,roc_auc_shuffle,roc_resp] = roc_ap(resp_temp,num_steps,numit,do_plot,title_in)
%%
numstim = size(resp_temp,1);

if isempty(num_steps)
    thresh = -1:max(resp_temp(:));
else
    step = abs(min(resp_temp(:)) - max(resp_temp(:)))/num_steps;
    thresh = min(resp_temp(:))-step : step: max(resp_temp(:));
    % thresh = -.01 : step: .01;%max(resp_temp(:))-step;
end

false_pos = zeros(length(thresh),1);
true_pos = zeros(length(thresh),1);
for k = 1:length(thresh)
    false_pos(k) = sum(resp_temp(:,1)>thresh(k))/numstim;
    true_pos(k) = sum(resp_temp(:,2)>thresh(k))/numstim;
end
roc_auc = 1+trapz(true_pos,false_pos);
roc_auc_shuffle = zeros(1,numit);

% Shuffle
parfor k = 1:numit
    resp_shuffle = zeros(size(resp_temp));
    for ii = 1:size(resp_temp,1)
        resp_shuffle(ii,:) = resp_temp(ii,randperm(2));
    end
    false_pos = zeros(length(thresh),1);
    true_pos = zeros(length(thresh),1);
    for ii = 1:length(thresh)
        false_pos(ii) = sum(resp_shuffle(:,1)>thresh(ii))/numstim;
        true_pos(ii) = sum(resp_shuffle(:,2)>thresh(ii))/numstim;
    end
    roc_auc_shuffle(k) = 1+trapz(true_pos,false_pos);
end

roc_resp = [true_pos,false_pos];

if do_plot == 1
    %%
    figure
    plot(false_pos,true_pos)
    hold on
    plot([0 1],[0 1],'--')
    title([title_in ', AUC: ' num2str(round(roc_auc,2)) ', 95th: ' num2str(round(prctile(roc_auc_shuffle,95),2))])
end 