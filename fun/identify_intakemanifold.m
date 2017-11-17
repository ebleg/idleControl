function [V_m] = identify_intakemanifold(dataFile, pars, plot_validation_toggle)
%IDENTIFY volume of the INTAKE MANIFOLD

%% load data
data = load(dataFile);
meas = data.meas;

%% set fminserach options 
efun_fminsearch = @(V_m) model_error(V_m, meas, pars);


%% call fminsearch
V_m = fminsearch(efun_fminsearch, pars.init.V_m, pars.fmin_opt);

%% validate
if plot_validation_toggle
    % plot stuff
end
     
end

function [error] = model_error(V_m , meas, pars)
%% error function for V_m

[~, ~, p_m_model] = sim('some name',... %% ###insert model name here###
    [meas.time(1) meas.time(end)],...
    pars.sim_opt,...
    [meas.time meas.mdotin]); %% add other inputs

error = sum((meas.p_m.signals.values - p_m_model).^2);
end

