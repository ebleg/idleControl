function [ pars ] = parinit(dataFile, pars)

%% INTIIAL VALUES
% Intake Manifold
data = load(dataFile);
meas = data.meas;
p_m = meas.p_m.signals.values;
theta_m = meas.T_m.signals.values;
w_e = meas.omega_e.signals.values;
pars.init.p_m = mean(p_m(1:100)); % [Pa]
pars.init.theta_m = mean(theta_m(1:100)); % [K]

% Engine Inertia
pars.init.w_e = mean(w_e(1:100)); % [rad/s]
pars.init.THETA_e = 0.2; % [kg*m^2 ??]

% Engine Torque Generation
pars.init.eta_0 = 0.3; % [-]
pars.init.eta_1 = -3*10^-4; % [s/rad]
pars.init.beta_0 = 7; % [Nm]
pars.init.delay_w_e = pars.init.w_e; % [s]
pars.init.delay_du_ign = 0; % [-]
pars.init.delay_m_dot_beta = 0.003; % [kg/s]



% Throttle Air Mass Flow
pars.init.V_m = 0.007; % [m^3]
