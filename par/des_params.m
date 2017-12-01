%% TUNING PARAMETERS INTIALIZATION

pars.des.K_l = 15; % higher is slower?? not sure

r1 = 20; % less is faster
r2 = 0.2; % less is faster 
pars.des.R_ctrl = [r1 0; 0 r2];
clear r1 r2

pars.des.q = 0.1; % less is faster (observer, should be as slow as possible)
