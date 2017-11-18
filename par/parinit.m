%% INTIIAL VALUES
% Intake Manifold
data = load('dynamic_0028_extracted.mat');
meas = data.meas;
p_m = meas.p_m.signals.values;
theta_m = meas.T_m.signals.values;
pars.init.p_m = mean(p_m(1:100)); % [Pa]
pars.init.theta_m = mean(theta_m(1:100)); % [K]
clear data meas p_m theta_m;

% Engine Torque Generation
pars.init.eta_0 = 0.3; % [-]
pars.init.eta_1 = -3*10^-4; % [s/rad]
pars.init.beta_0 = 7; % [Nm]
pars.init.delay_w_e = 190; % [s]
pars.init.delay_du_ign = 0; % [-]
pars.init.delay_m_dot_beta = 0.003; % [kg/s]

% Engine Inertia
pars.init.w_e = 190; % [rad/s]
pars.init.THETA_e = 0.2; % [kg*m^2 ??]

% Throttle Air Mass Flow
pars.init.V_m = 0.007; % [m^3]
