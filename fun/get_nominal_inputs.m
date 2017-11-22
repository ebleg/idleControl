function [u_alpha_nomin, du_ign_nomin] = get_nominal_inputs(dataFile)
%% DETERMINE INPUTS FOR STEADY STATE RUN
    % Load data
    data = load(dataFile); 
    meas = data.meas;
    % Get data
    u_alpha = meas.u_alpha.signals.values;
    du_ign = meas.du_ign.signals.values;
    % Compute mean and store
    u_alpha_nomin = mean(u_alpha); 
    du_ign_nomin = mean(du_ign);
    end

