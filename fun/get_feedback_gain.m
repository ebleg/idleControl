function [K] = get_feedback_gain.m(sys, Q, R_ctrl)
%% COMPUTES FEEDBACK GAIN FOR LQR CONTROLLER
    Q = sys.C'*sys.C;
    K = lqr(sys.A, sys.B, Q, R_ctrl);

