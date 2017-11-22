function [] = linearization_val_plot(system,pars,dataFile)
%% plot validation plot with nonlin and lin model comparison

%% Load data
data = load(dataFile);
meas = data.meas;
u1 = meas.u_alpha.signals.values./pars.nom.u_alpha;
u2 = meas.du_ign.signals.values./pars.nom.du_ign;
u = [u1 , u2];
%% simulate linear model
[ ~ , x_lin , y_lin] = sim('linear_validation.slx',...
    [meas.time(1) meas.time(end)],...
    pars.sim_opt,...
    [ meas.time, u1, u2 ]); %% add other inputs

%% simulate nonlinear model
[ ~ , x_nl , y_nl] = sim('full_model_split.slx',...
    [meas.time(1) meas.time(end)],...
    pars.sim_opt,...
    [ meas.time, u1, u2 ]); %% add other inputs

get(0,'CurrentFigure'); % use current figure - do not set it on top in each update process
plot(meas.time, meas.omega_e.signals.values./pars.nom.w_e, 'b');hold on;grid on;
plot(meas.time,y_lin,'k-',meas.time,y_nl,'-r');
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