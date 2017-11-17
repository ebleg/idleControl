%% INTIIAL VALUES
% Intake Manifold
pars.init.p_m = 100000; % [Pa]
pars.init.theta_m = 300; % [K]


% Engine Torque Generation
pars.init.eta_0 = 0.3; % [-]
pars.init.eta_1 = -3*10^-4; % [s/rad]
pars.init.beta_0 = 7; % [Nm]
pars.init.delay_w_e = 1000; % [s]
pars.init.du_ign = 0; % [-]
pars.init.m_dot_beta = 0.7; % [s]

% Engine Inertia
pars.init.w_e = 100; % [rad/s]


% Throttle Air Mass Flow
pars.init.V_m = 0.007; % [m^3]
