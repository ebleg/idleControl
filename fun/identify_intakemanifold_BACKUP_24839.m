function [V_m] = identify_intakemanifold(dataFile, pars, plot_validation_toggle)
    %IDENTIFY volume of the INTAKE MANIFOLD

    %% load data
    data = load(dataFile);
    meas = data.meas;
    model = 'id_manifold_model.slx';

<<<<<<< HEAD
    %% set fminserach options 
    mod = @(V_m) model_error(model, V_m, meas);
    setopt = optimset('Algorithm','sqp','display','iter','Maxit',30);

    %% call fminsearch
    V_m = fminsearch(efun_fminsearch, V_mini, setopt);
=======

%% set fminsearch function
efun_fminsearch = @(V_m) model_error(V_m, meas, pars, plot_validation_toggle);


%% call fminsearch
V_m = fminsearch(efun_fminsearch, pars.init.V_m, pars.fmin_opt);
>>>>>>> 2d3ebed0560c92a9496a3aa7fd6268075ed0fec8

    %% validate
    if plot_validation_toggle
        % plot stuff
    end
     
end
<<<<<<< HEAD
=======

function [error] = model_error(V_m , meas, pars, plot_validation_toggle)
%% error function for V_m
pars.id.V_m = V_m;
[~, ~, p_m_model] = sim('id_manifold_model.slx',... %% ###insert model name here###
    [meas.time(1) meas.time(end)],...
    pars.sim_opt,...
    [meas.time, meas.u_alpha.signals.values, meas.omega_e.signals.values]); %% add other inputs

error = sum((meas.p_m.signals.values./10^5 - p_m_model./10^5).^2);

if plot_validation_toggle
    get(0,'CurrentFigure'); % use current figure - do not set it on top in each update process
    plot(meas.time, meas.p_m.signals.values, 'b');hold on;grid on;
    plot(meas.time,p_m_model','-r');hold off; % "holf off" is important here, otherwise you always see the results of all past simulations.
    xlabel('Time [s]');
    ylabel('Intake Manifold Pressure [Pa]');
    legend('Measurements','Simulation','Location','SE');
    
    set(gca,'XLim',[meas.time(1) meas.time(end)]);
    set(gca,'YLim',[min(meas.p_m.signals.values)-1/10*mean(meas.p_m.signals.values) max(meas.p_m.signals.values)+1/10*mean(meas.p_m.signals.values)]);
    
    drawnow
end 
end

>>>>>>> 2d3ebed0560c92a9496a3aa7fd6268075ed0fec8
