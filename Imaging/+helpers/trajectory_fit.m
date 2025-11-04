function [fit_resp,cf_resp,fwhm] = trajectory_fit(x,y,y_err,model,initial_params,offset)


    t = x(find(x==0)+offset:end)-x(find(x==0)+offset);
    data = (y(find(x==0)+offset:end));
    data_error = (y_err(find(x==0)+offset:end));
    
    % Fit data
    options = optimset('MaxFunEvals',20000,'MaxIter',20000);
    % error function
    error_function = @(params) sum((data - model(params, t)).^2);
    % fit function to data
    fit_resp = fminsearch(error_function, initial_params,options);
    
    % figure 
    % plot(t,data)
    % hold on
    % plot(t,model(fit_resp,t))
    %% Bootstrapping 
    num_samples = 10; % Anzahl der Bootstrapping-Wiederholungen
    bootstrap_values = zeros(num_samples, 4);
    
    tt = t(1):.001:t(end);
    t50_values = zeros(num_samples, 1);
    
    % figure
    % hold on
    
    % Bootstrapping
    for i = 1:num_samples
        % Erzeuge leicht verrauschte Daten für Bootstrapping
        data_bootstrap = data + data_error .* (randn(size(data))*.2);
    
        % Fehlerfunktion für Bootstrap-Daten
        error_function_bootstrap = @(params) sum((data_bootstrap - model(params, t)).^2);
        
        % Fitting mit den Bootstrap-Daten
        bootstrap_values(i,:) = fminsearch(error_function_bootstrap, initial_params,options);
        
        % calculate FWHM
        model_function = @(tt) abs(model([0 bootstrap_values(i,2:4)], tt))/ max(abs(model([0 bootstrap_values(i,2:4)], tt)));   
        fitted = model_function(tt);
        t50_values(i) = (tt(find(fitted>=.5,1,'last')) - tt(find(fitted>=.5,1)))*1000; 
        
        % plot(tt,fitted)
    end
    
    % Berechnen des 95%-Konfidenzintervalls
    cf_resp = prctile(bootstrap_values, 2.5);
    cf_resp(2,:) = prctile(bootstrap_values, 97.5);
    cf_resp(3,:) = cf_resp(2,:)-fit_resp;
    
    
    fwhm = [mean(t50_values) prctile(t50_values, 2.5) prctile(t50_values, 97.5)];
    
    
    %% Monte-Carlo-Simulation
    
    % tt = t(1):.001:t(end);
    % 
    % % Anzahl der Monte-Carlo-Simulationen
    % num_simulations = 1000;
    % 
    % % Speicher für die t50-Werte
    % t50_values = zeros(num_simulations, 1);
    % 
    % % Ziel-Amplitude für 50 % des Maximums
    % target_amplitude = fit_responders(1) + 0.5 * fit_responders(2);
    % 
    % i = 1;
    % figure
    % hold on
    % while i < num_simulations
    %     % Zufällige Variationen der Parameter basierend auf den Unsicherheiten
    %     perturbed_params = fit_responders + cf_resp(3,:) .* randn(size(fit_responders));
    % 
    % %     target_amplitude = perturbed_params(1) + 0.5 * perturbed_params(2);
    %     % Funktion, um den Zeitpunkt zu finden, an dem die Amplitude 50% erreicht
    %     model_function = @(tt) model([0 perturbed_params(2:4)], tt) / max(model([0 perturbed_params(2:4)], tt));
    % 
    %     fitted = model_function(tt);
    %     if max(abs(fitted)) < 1000 && ~isempty(find(fitted>=0.5,1))
    %         % Numerische Suche nach t50 mit fzero
    %         t50_values(i) = (tt(find(fitted>=.5,1,'last')) - tt(find(fitted>=.5,1)))*1000; 
    %         i = i+1;
    %         plot(tt,fitted)
    %     end
    % 
    % end
    % 
    % % 95%-Konfidenzintervall berechnen
    % ci_lower = prctile(t50_values, 2.5);
    % ci_upper = prctile(t50_values, 97.5);
    %_t50 = mean(t50_values);

end



