function [dsys] = discretize_controller_matrices(system)

%% DISCRETIZES THE CONTROLLER MATRICES
TS = 0.001;
dsys = c2d(system.ss.cont,TS,'tustin');