function [K] = get_feedback_gain(sys, pars)
%% COMPUTES FEEDBACK GAIN FOR LQR CONTROLLER
Q = sys.C'*sys.C;
K = lqr(sys.A, sys.B, Q, pars.des.R_ctrl);

end

