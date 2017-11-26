function [sys] = get_extended_system(old_ss, pars)
%% EXTENDS OLD LINEAR SS SYTEM WITH AN INTEGRATOR PART TO INSURE 0 SS ERROR 

A_e = 0;
B_e = [1 0]; 
C_e = [pars.des.K_l; 0];
D_e = eye(2);

ext = ss(A_e, B_e, C_e, D_e);

sys = series(ext, old_ss);

end

