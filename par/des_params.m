%% TUNING PARAMETERS INTIALIZATION

pars.des.K_l = 45; % higher is slower?? not sure

r1 = 0.2; % less is faster
r2 = 0.001; % less is faster 
pars.des.R_ctrl = [r1 0; 0 r2];
clear r1 r2

pars.des.q = 10; 