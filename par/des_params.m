%% TUNING PARAMETERS INTIALIZATION

pars.des.K_l = 20; % higher is slower?? not sure

r1 = 0.4; % less is faster
r2 = 0.015; % less is faster 
pars.des.R_ctrl = [r1 0; 0 r2];
clear r1 r2

pars.des.q = 15; % less is faster (observer, should be as slow as possible)
