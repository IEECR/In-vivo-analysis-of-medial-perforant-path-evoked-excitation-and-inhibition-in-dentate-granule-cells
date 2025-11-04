

function [delays, mutual_infos] = calculate_mutual_information_with_delay(S, stim, max_delay,bins,downsample)
    % Calculate the mutual information between the neuron's activity (S) and the stimulus (stim)
    % with a range of delays.
    %
    % Parameters:
    % - S: Binary activity trace of the neuron (1D array).
    % - stim: Binary stimulus trace (1D array, same length as S).
    % - max_delay: Maximum delay (in frames) to consider.
    %
    % Returns:
    % - delays: Array of delays considered.
    % - mutual_infos: Array of mutual information values for each delay.
    
    if nargin>4 & ~isempty(downsample)
        S = downsample_binary_vector(S, downsample);
        stim = downsample_binary_vector(stim,downsample);
    end

    S = double(S(:)); % Ensure column vector
    stim = double(stim(:)); % Ensure column vector
    mutual_infos = [];
    delays = 0:max_delay;

    for delay = delays        
        shifted_stim = stim(1:end-delay);
        truncated_S = S(delay+1:end);
        % Calculate mutual information
        mutual_info = helpers.mutualinfo(truncated_S, shifted_stim,bins);
        % mutual_info = mi_discrete_cont(truncated_S, shifted_stim,bins);
        mutual_infos = [mutual_infos; mutual_info];
    end
end

function downsampled_S = downsample_binary_vector(S, binsize)
    % Ensure S is a column vector
    S = S(:);
    
    % Calculate the number of bins
    num_bins = floor(length(S) / binsize);
    
    % Reshape and sum values in each bin
    downsampled_S = sum(reshape(S(1:num_bins * binsize), binsize, num_bins), 1);

    % % Reshape and max value in each bin
    % downsampled_S = max(reshape(S(1:num_bins * binsize), binsize, num_bins),[], 1);
end

