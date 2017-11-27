function [] = debug_fn(dataFile, pars, system)

data = load(dataFile);
meas = data.meas;

du_ign = meas.du_ign.signals.values./pars.nom.du_ign;
u_alpha = meas.u_alpha.signals.values./pars.nom.u_alpha;
w_e_meas = meas.omega_e.signals.values./pars.nom.w_e;

data = load(dataFile);
meas = data.meas;

[time, ~, w_e_model] = sim('full_model_split.slx',...
    [meas.time(1) meas.time(end)],...
    pars.sim_opt,...
    [meas.time, u_alpha, du_ign...
    ]); %% add other inputs

get(0,'CurrentFigure'); % use current figure - do not set it on top in each update process
plot(meas.time, w_e_meas, 'b');hold on;grid on;
plot(time,w_e_model,'-r');
ylabel('Engine Speed [rad/s]');
set(gca,'YLim',[min(meas.omega_e.signals.values./pars.nom.w_e) - ...
    1/10*mean(meas.omega_e.signals.values./pars.nom.w_e) ...
    max(meas.omega_e.signals.values./pars.nom.w_e) + ...
    1/10*mean(meas.omega_e.signals.values./pars.nom.w_e)]);

xlabel('Time [s]');
legend('Measurements','Simulation','Load state','Location','SE');
set(gca,'XLim',[meas.time(1) meas.time(end)]);


drawnow

end


