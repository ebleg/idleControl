function [L] = get_observer_gain(ss, pars)
%% COMPUTES OBSERVER GAIN BASED ON GIVEN q
    B_in = ss.B*ss.B';
    L = lqr(ss.A', ss.C', B_in, q); 
    M = iconnect();

