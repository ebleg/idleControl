%% TUNING PARAMETERS INTIALIZATION

pars.des.K_l = 3000; % higher is slower?? not sure

r1 = 40000000; % less is faster
r2 = 4; % less is faster 
pars.des.R_ctrl = [r1 0; 0 r2];
clear r1 r2

pars.des.q = 0.002; 