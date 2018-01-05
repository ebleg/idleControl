%% TUNING PARAMETERS INTIALIZATION

pars.des.K_l = 400; % higher is slower?? not sure

r1 = 1500; % less is faster
r2 = 0.05; % less is faster 
pars.des.R_ctrl = [r1 0; 0 r2];
clear r1 r2

pars.des.q = 0.01; 