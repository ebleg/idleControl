%% IDLE SPEED CONTROL EXERCISE
% -------------------------------------------------------------------------
% Michael Chadwick, Twan van der Sijs & Emiel Legrand
% ETH Zurich - Institute for Dynamics and Systems Constrol
% Engine Systems (November 2017)
% -------------------------------------------------------------------------
% Master file
% -------------------------------------------------------------------------

%% PREPARE WORKSPACE
clear;
clc;
close all;

addpath(genpath('.'));

%% TOGGLE OPTIONS
identify_params = 1; % general switch

identify_throttle_toggle = 1;
identify_engine_toggle = 1;
identify_manifold_toggle = 1;
identify_manifold2_toggle = 0;
identify_inertia_toggle = 0;

plot_validation_toggle = 1;
convert_data_toggle = 0;

validation_toggle = 0;

%% LOAD PARAMETERS
fprintf('------ MAIN -------\n \n');
fprintf('$ Loading static parameters ...');
run params;

%% create filename variables
dataFile_id_q = 'quasistatic_0007_extracted.mat';
dataFile_id_dyn = 'dynamic_0028_extracted.mat';
dataFile_val = 'dynamic_0005_extracted.mat';

fprintf(' Done\n');

%% CODE
%% Data conversion
if convert_data_toggle
    fprintf('$ Converting data ...');
    convert_data('dynamic_0006_extracted.mat');
    fprintf(' Done\n');
end

%% Parameter identification
if identify_params
    
    if identify_throttle_toggle
        fprintf('\n$ Identify throttle parameters ...');
        pars = parinit(dataFile_id_q, pars);
        [pars.id.alpha_0, pars.id.alpha_1] = ...
            identify_throttle(dataFile_id_q, ...
            pars, ...
            plot_validation_toggle);
        fprintf(' Done\n');
    end
    
    if identify_engine_toggle
        fprintf('$ Identify engine parameters ...');
        pars = parinit(dataFile_id_q, pars);
        [pars.id.gamma_0, pars.id.gamma_1] = ...
            identify_engine(dataFile_id_q, ...
            pars, ...
            plot_validation_toggle);
        fprintf(' Done\n');
    end
    
    if identify_manifold2_toggle
        fprintf('$ Identify intake manifold volume (model 2) ...\n');
        [pars.id.V_m] = ...
            identify_md2(dataFile_id_dyn, ...
            pars, ...
            plot_validation_toggle);
    end
    
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
    load('pars.mat');
end

%% LOAD IDENTIFIED PARAMETERS

%% Validate model
if validation_toggle
    fprintf('$ Validating model ... ');
    pars = parinit(dataFile_val, pars);
    validation(dataFile_val, pars)
    fprintf('Done\n');
end


fprintf('\n------ END --------\n');
