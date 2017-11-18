function [V_m] = identify_md2(dataFile, pars, plot_validation_toggle)
%% IDENTIFY INTAKE MANIFOLD VOLUME [2]S
% -------------------------------------------------------------------------
% Identify intake manifold volume V_m by using the reduced model
% id_manifol 2.
% -------------------------------------------------------------------------

%% Load Data
    data = load(dataFile);
    meas = data.meas;
    model_file = 'id_manifold_2.slx';
    
%% Define function handle
    efun_fminsearch = @(V_m) model_error_intakemfd2(V_m, meas, pars, model_file, plot_validation_toggle);
    
%% Minimization
    V_m = fminsearch(efun_fminsearch, pars.init.V_m, pars.fmin_opt);

end

function [error] = model_error_intakemfd2(V_m, meas, pars, model_file, plot_validation_toggle)
%% COMPUTE RMS ERROR BETWEEN MODEL AND MEASUREMENTS
    pars.id.V_m = V_m;
    [~, ~, p_m_model] = sim(model_file,... 
                            [meas.time(1) meas.time(end)],...
                            pars.sim_opt); %% add other inputs
    error = sum((meas.p_m.signals.values./(10^5) - p_m_model./(10^5)).^2);

    if plot_validation_toggle
        get(0,'CurrentFigure'); % use current figure - do not set it on top in each update process
        plot(meas.time, meas.p_m.signals.values, 'b'); hold on;grid on;
        plot(meas.time,p_m_model','-r'); hold off; % "hold off" is important here, otherwise you always see the results of all past simulations.
        xlabel('Time [s]');
        ylabel('Intake Manifold Pressure [Pa]');
        legend('Measurements','Simulation','Location','SE');
        % p_m = meas.p_m.signals.values

        set(gca,'XLim',[meas.time(1) meas.time(end)]);
        set(gca,'YLim',[min(meas.p_m.signals.values)-1/10*mean(meas.p_m.signals.values) max(meas.p_m.signals.values)+1/10*mean(meas.p_m.signals.values)]);

        drawnow
    end 
end
