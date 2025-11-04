
function dyn_fit = resp_fit(x,resp,nresp)

    % x = stim.times(1,:)/1000;
    y = nanmean(resp,1);
    y_err = nanstd(resp)/sqrt(size(resp,1));
    % offset for expected response onset after stim
    offset = 1;
    % model function
    model_resp = @(params, t) params(1) + params(2) * (1-exp(-t / params(3))) .* exp(-t / params(4));
    % give some initial params
    initial_params = [median(y), max(y), 1, 1];
    % fit function to data
    [fit_responders,cf_resp,fwhm_exc] = helpers.trajectory_fit(x,y,y_err,model_resp,initial_params,offset);
    
    % fit a trajectory to the non-responders
    y = nanmean(nresp,1);
    y_err = nanstd(nresp)/sqrt(size(nresp,1));
    % model function
    model_nonresp = @(params, t) params(1) + params(2) * -(1 - exp(-t / params(3))) .* exp(-t / params(4));
    % give some initial params
    initial_params = [median(y), min(y), 1, 1];
    % % fit function to data
    [fit_non_responders,cf_non_resp,fwhm_inh] = helpers.trajectory_fit(x,y,y_err,model_nonresp,initial_params,offset);
    
    dyn_fit.model_resp = model_resp;
    dyn_fit.fit_responders = fit_responders;
    dyn_fit.cf_resp = cf_resp;
    dyn_fit.fwhm_exc = fwhm_exc;
    
    dyn_fit.model_nonresp = model_nonresp;
    dyn_fit.fit_non_responders = fit_non_responders;
    dyn_fit.cf_non_resp = cf_non_resp;
    dyn_fit.fwhm_inh = fwhm_inh;

end

