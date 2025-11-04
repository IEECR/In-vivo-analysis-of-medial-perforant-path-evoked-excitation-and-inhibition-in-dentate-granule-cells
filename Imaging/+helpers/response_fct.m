function resp_out = response_fct(resp,resp_win,bs_win)
    %% z-score values
    baseline = nanmean(resp,1);
    resp_mean = nanmean(baseline(bs_win));
    resp_std = nanstd(baseline(bs_win));
    
    resp_out = sum(resp(:,resp_win),2);
    
    % resp_out = mean(resp(:,resp_win),2);

    % resp_out = mean(resp(:,resp_win)-resp_mean,2);

    % resp_out = mean(resp(:,resp_win),2)/(resp_std);

    % resp_out = mean(resp(:,resp_win)-resp_mean,2)/resp_std;
   
    % resp_out = mean(resp(:,resp_win)-mean(resp(:,bs_win),2),2)./(1+std(resp(:,bs_win),[],2));

    % resp_out = mean(resp(:,resp_win)-mean(resp(:,bs_win),2),2)/(resp_std);
    

    % resp_norm = resp(:,resp_win)-mean(resp(:,bs_win),2);
    % [~,ind] = max(abs(resp_norm),[],2);
    % resp_out = zeros(length(ind),1);
    % for i = 1:length(ind)
    %     resp_out(i) = resp_norm(i,ind(i));
    % end
    % resp_out = resp_out/(resp_std);
    
    % is_singular = sum(resp(:,resp_win)>0,2)==1 & mean(resp(:,bs_win),2)==0;
    % resp_out(is_singular) = [];% mean(resp(is_singular,resp_win),2)*resp_mean/resp_std;

    % resp_out(resp_out==0) = [];

    % resp_out(isnan(resp_out)) = [];
end


% %%

% figure; plot(mean(resp-resp_mean,1)/resp_std)
% hold on
% scatter(ones(length(resp_out))*35,resp_out)
% scatter(33,mean(resp_out))


% %%