function [] = observer_val_plot(system,pars,dataFile)
%% plot validation plot with nonlin and lin model comparison

%% Load data
data = load(dataFile);
meas = data.meas;
u1 = meas.u_alpha.signals.values;
u2 = meas.du_ign.signals.values;
%% simulate linear model
[ t , x , y] = sim('Observer_check.slx',...
    [meas.time(1) meas.time(end)],...
    pars.sim_opt,...
    [ meas.time, u1, u2 ]); %% add other inputs

figure
get(0,'CurrentFigure'); % use current figure - do not set it on top in each update process
% plot(meas.time, meas.omega_e.signals.values./pars.nom.w_e, 'b');
hold on;grid on;
plot(t,y(:,1),'g');
plot(t,y(:,2),'r');
plot(t,y(:,3),'b');
ylabel('Engine Speed [rad/s]');
% set(gca,'YLim',[min(meas.omega_e.signals.values./pars.nom.w_e) - ...
%     1/10*mean(meas.omega_e.signals.values./pars.nom.w_e) ...
%     max(meas.omega_e.signals.values./pars.nom.w_e) + ...
%     1/10*mean(meas.omega_e.signals.values./pars.nom.w_e)]);

xlabel('Time [s]');
%legend('Measurements','Simulation Lin','Simulation Nonlin','Location','SE');
set(gca,'XLim',[meas.time(1) meas.time(end)]);


drawnow
end
