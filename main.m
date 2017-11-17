%% IDLE SPEED CONTROL EXERCISE
% Michael Chadwick, Twan van der Sijs & Emiel Legrand
% ETH Zurich (2017) - Engine Systems
% ------------------------------------------------------------------------

clear;
clc;
close all;

addpath(genpath('.'));

%% MAIN TOGGLE OPTIONS
identify_params = 1; % general switch

identify_throttle_toggle = 1;
identify_engine_toggle = 1;
identify_manifold_toggle = 1;
identify_generator_toggle = 1;

plot_validation = 1;
convert_data = 1;

%% LOAD PARAMETERS
fprintf('------ MAIN -------\n \n');
fprintf('$ Loading parameters ...');
run params;
run parinit;
fprintf(' Done\n');

%% CODE
% Data conversion
if convert_data
  fprintf('$ Converting data ...');
  convertData('dynamic_0006_extracted.mat');
  fprintf(' Done\n');
end

% Parameter identification
if identify_params
    if identify_throttle_toggle
        fprintf('\n$ Identify throttle parameters ...'); 
        [alpha0, alpha1] = identify_throttle('quasistatic_0007_extracted.mat', pars, plot_validation);
        pars.id.alpha0 = alpha0;
        pars.id.alpha1 = alpha1;
        fprintf(' Done\n');
    end

end

%% LOAD IDENTIFIED PARAMETERS
%run parid;


fprintf('\n------ END --------\n');


