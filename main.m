%% IDLE SPEED CONTROL EXERCISE
% -------------------------------------------------------------------------
% Michael Chadwick, Twan van der Sijs & Emiel Legrand
% ETH Zurich - Institute for Dynamics and Systems Control
% Engine Systems (November 2017)
% -------------------------------------------------------------------------
% Master file
% -------------------------------------------------------------------------

%% PREPARE WORKSPACE
clear;
clc;
close all;

addpath(genpath('.'));
% -------------------------------------------------------------------------
disp('main ...');

%% TOGGLE OPTIONS
% Global toggles
identify_params = 0; % general switch
linearize_model = 1;
controller_design = 1;

% Specific toggles
identify_throttle_toggle = 1;
identify_engine_toggle = 1;
identify_manifold_toggle = 1;
identify_manifold2_toggle = 0;
identify_inertia_toggle = 0;
extend_system = 1;

% Additional toggles
plot_validation_toggle = 1;
convert_data_toggle = 0;

validation_toggle = 0;
% -------------------------------------------------------------------------

%% LOAD PARAMETERS
fprintf('$ Loading static parameters ...');
run params;

% Create filename variables
dataFile_id_q = 'quasistatic_0007_extracted.mat';
dataFile_id_dyn = 'dynamic_0028_extracted.mat';
dataFile_val = 'dynamic_0005_extracted.mat';

fprintf(' Done\n');
% -------------------------------------------------------------------------

%% DATA CONVERSION
if convert_data_toggle
    fprintf('$ Converting data ...');
    convert_data('dynamic_0006_extracted.mat');
    fprintf(' Done\n');
end
% -------------------------------------------------------------------------

%% PARAMETER IDENTIFICATION
if identify_params
    % Identify throttle parameters alpha_0, alpha_1
    if identify_throttle_toggle
        fprintf('\n$ Identify throttle parameters ...');
        pars = parinit(dataFile_id_q, pars);
        [pars.id.alpha_0, pars.id.alpha_1] = ...
            identify_throttle(dataFile_id_q, ...
            pars, ...
            plot_validation_toggle);
        fprintf(' Done\n');
    end
    
    % Identify engine parameters gamma_0, gamma_1
    if identify_engine_toggle
        fprintf('$ Identify engine parameters ...');
        pars = parinit(dataFile_id_q, pars);
        [pars.id.gamma_0, pars.id.gamma_1] = ...
            identify_engine(dataFile_id_q, ...
            pars, ...
            plot_validation_toggle);
        fprintf(' Done\n');
    end
    
    % Identify intake manifold volume V_m (second method)
    if identify_manifold2_toggle
        fprintf('$ Identify intake manifold volume (model 2) ...\n');
        [pars.id.V_m] = ...
            identify_md2(dataFile_id_dyn, ...
            pars, ...
            plot_validation_toggle);
    end
    
    % Identify intake manifold volume V_m (first method)
    if identify_manifold_toggle
        fprintf('$ Identify intake manifold volume (model 1) ...\n');
        pars = parinit(dataFile_id_dyn, pars);
        [pars.id.V_m] = ...
            identify_intakemfd(dataFile_id_dyn, ...
            pars, ...
            plot_validation_toggle);
        fprintf('... Done\n');
    end
    
    if identify_inertia_toggle
        fprintf('$ Identify torque and inertia ...');
        pars = parinit(dataFile_id_dyn, pars);
        [pars.id.eta_0, ...
            pars.id.eta_1, ...
            pars.id.beta_0, ...
            pars.id.THETA_e] = ...
            identify_ti(dataFile_id_dyn, ...
            pars, ...
            plot_validation_toggle);
        fprintf(' Done\n');
    end
else
    % Load parameters that are identified before
    fprintf('$ Loading previously identified parameters ...');
    load('pars.mat');
    fprintf('Done\n');
end
% -------------------------------------------------------------------------

%% VALIDATE MODEL
% Validate identified parameters with engine speed plot
if validation_toggle
    fprintf('$ Validating model ... ');
    pars = parinit(dataFile_val, pars);
    validation(dataFile_val, pars)
    fprintf('Done\n');
end
% -------------------------------------------------------------------------

%% NORMALIZE AND LINEARIZE THE MODEL
if linearize_model
    % Compute the nominal input values for the steady-state model run
    fprintf('$ Computing nominal inputs ... ');
    [pars.nom.u_alpha, pars.nom.du_ign] = get_nominal_inputs('dynamic_0005_extracted.mat');
    fprintf('Done\n'); 
    
    % Run the steady state model and extracting delays and engine speed
    fprintf('$ Computing nominal outputs and delays ... ');
    [pars.nom.p_m, pars.nom.w_e, pars.nom.delay1, pars.nom.delay2, pars.nom.m_dot_beta_omega] = get_nominal_outputs(pars);
    fprintf('Done\n');
    
    % Linearize normalized model
    fprintf('$ Computing linearization ... ');
    [system] = linearize_fn(pars);
    % debug_fn(dataFile_id_q, pars, system);
    fprintf('Done\n');
    
    if plot_validation_toggle
        linearization_val_plot(system,pars,dataFile_id_dyn);
    end
            
else % in case the model is already linearized
    load('system.mat');
end

% Just making notation a bit less complicated...
system.lin = system.ss.lin_minreal;
% -------------------------------------------------------------------------

%% CONTROLLER SYNTHESIS
run des_params

if controller_design
    % System extension with integrator
    if extend_system
        fprintf('$ Extending system ... ');
        system.ext = get_extended_system(system.lin, pars);
        fprintf('Done\n');
    end
    
    % Determine feedback gain 
    fprintf('$ Computing feedback gain ... ');
    pars.des.K = get_feedback_gain(system.ext, pars);
    fprintf('Done\n');

    % Create observer system
    fprintf('$ Creating observer system ... ');
    [pars.des.L, system.obs] = create_observer(system, pars);
    fprintf('Done\n');
    
    % check observer with simulink simulation
    observer_val_plot(system,pars,dataFile_id_dyn)
end

    %pars = control_fn(system, pars);
    
%else
%   load('controller.mat')
%end

disp('End of main reached');
