function [V_m] = identify_intakemanifold(dataFile, pars, plot_validation_toggle)
%IDENTIFY volume of the INTAKE MANIFOLD

%% load data
data = load(dataFile);
meas = data.meas;

%% set fminserach options 
efun_fminsearch = @(V_m) model_error(V_m, meas);
setopt = optimset(   'Algorithm','sqp','display','iter','Maxit',30);

%% call fminsearch
V_m = fminsearch(efun_fminsearch, V_mini, setopt);

%% validate
if plot_validation_toggle
    % plot stuff
end
     
end

function [error] = model_error(V_m , meas)
%% error function for V_m


end

