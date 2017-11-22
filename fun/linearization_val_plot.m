function [] = linearization_val_plot(system,pars,dataFile)
%% plot validation plot with nonlin and lin model comparison

%% Load data
data = load(dataFile);
meas = data.meas;
u1 = meas.u_alpha.signals.values./pars.nom.u_alpha;
u2 = meas.du_ign.signals.values./pars.nom.du_ign;

%% simulate linear model
[ ~ , x_lin , y_lin] = sim('linear_validation.slx',...
    [data.time(1) data.time(end)],...
    pars.sim_opt,...
    [ data.time, u1, u2 ]); %% add other inputs

%% simulate nonlinear model
[ ~ , x_nl , y_nl] = sim('linear_validation.slx',...
    [data.time(1) data.time(end)],...
    pars.sim_opt,...
    [ data.time, u1, u2 ]); %% add other inputs

get(0,'CurrentFigure'); % use current figure - do not set it on top in each update process
plot(data.time, data.omega_e.signals.values, 'b');hold on;grid on;
plot(data.time,w_e_model,'-r');
ylabel('Engine Speed [rad/s]');
set(gca,'YLim',[min(meas.omega_e.signals.values) - ...
    1/10*mean(meas.omega_e.signals.values) ...
    max(meas.omega_e.signals.values) + ...
    1/10*mean(meas.omega_e.signals.values)]);

plot(meas.time(meas.u_l.signals.values>0), 40+10.*meas.u_l.signals.values(meas.u_l.signals.values>0),...
    'g','Linewidth',3);hold off; % "holf off" is important here, otherwise you always see the results of all past simulations.

xlabel('Time [s]');
legend('Measurements','Simulation','Load state','Location','SE');
set(gca,'XLim',[meas.time(1) meas.time(end)]);


drawnow
end