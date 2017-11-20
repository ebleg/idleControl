%% MAIN PARAMETER FILE
% -------------------------------------------------------------------------
% This file contains all static parameters (that is, parameters that will
% not be changed throughout the entire program, and configurations structs.
% All parameters in this file are stored in pars.static.
% -------------------------------------------------------------------------

%% Simulation options
    pars.fmin_opt = optimset('TolX', 10^-8, ... % configuration for fminsearch
                             'TolFun',10^-8, ...
                             'display','iter', ...
                             'Maxit',1000,'Algorithm', 'sqp');
    pars.sim_opt = simset('SrcWorkspace','current', ... % configuration for sim
                          'FixedStep', 1e-3, ...
                          'Solver','ode1');

%% Control inputs
    pars.static.u_alpha = 20; % control input in range [0,...,100]
    pars.static.du_ign = 0; % control input in CA, delaying CA should be negative

%% Disturbance inputs
    pars.static.U_bat = 0; % Voltage Battery [V]
    pars.static.I_gen = 0; % Current of the Generator [A]
    pars.static.u_l = 0; % control input [-]

%% Constants
    % Throttle Area Mass Flow
    pars.static.R = 287; %J/kgK
    pars.static.p_a = 101325; % upstream air pressure; assumed normal pressure [Pa]
    pars.static.theta_a = 293.15; % upstream air temperature; assumed normal temperature [K]

    % Engine Torque Generation
    pars.static.V_d = 2.48*10^-3; % Displacement volume [m^3]
    pars.static.H_l = 42.5*10^6; % Lower heating value [J/kg]
    pars.static.k_zeta = 2.3345*10^-4; % [1/degCA^2]
    pars.static.sigma_0 = 14.7; % [-] stochiometric air constant [-]

    % Engine Airmass Flow
    pars.static.V_c =  2.48*10^-4; % Compression volume [m^3]
    pars.static.kappa = 1.35; % [-]
    pars.static.p_e = 100000; %[Pa] most random guess 

    % Load Torque
    pars.static.eta_gen = 0.7; % efficiency generator [-]

%% END