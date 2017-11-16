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

identify_throttle = 1;
identify_engine = 1;
identify_manifold = 1;
identify_generator = 1;

plot_data = 1;
convert_data = 0;

%% CODE
% Data conversion
if convert_data
  convertData();
  disp('Data converted')
end

% Parameter identification



