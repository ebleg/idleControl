function [V_m] = identify_intakemanifold(dataFile, pars, plot_validation_toggle)
    %IDENTIFY volume of the INTAKE MANIFOLD

    %% load data
    data = load(dataFile);
    meas = data.meas;
    model = 'id_manifold_model.slx';

    %% set fminserach options 
    mod = @(V_m) model_error(model, V_m, meas);
    setopt = optimset('Algorithm','sqp','display','iter','Maxit',30);

    %% call fminsearch
    V_m = fminsearch(efun_fminsearch, V_mini, setopt);

    %% validate
    if plot_validation_toggle
        % plot stuff
    end
     
end
