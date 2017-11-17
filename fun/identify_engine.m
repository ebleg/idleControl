function [gamma_0, gamma_1] = identify_engine(dataFile, pars, plot_validation_toggle)
%% IDENTIFY ENGINE PARAMETERS
    data = load(dataFile);
    meas = data.meas;
    
    T_m = meas.T_m.signals.values;
    p_m = meas.p_m.signals.values;
    m_dot_alpha = meas.m_dot_alpha.signals.values;
    w_e = meas.omega_e.signals.values;
    lambda = meas.lambda.signals.values;
    p_e = meas.p_e.signals.values;
    t = meas.time;
    
    R = pars.static.R;
    V_d = pars.static.V_d;
    sigma_0 = pars.static.sigma_0;
    V_c = pars.static.V_c;
    kappa = pars.static.kappa;
    
    lambda_lp = (V_c + V_d)/V_d - (V_c/V_d)*(p_e./p_m).^(1/kappa);
    lambda_lw = (4*pi*R/V_d)*((T_m.*m_dot_alpha)./(p_m.*w_e.*lambda_lp)).*(1 + 1./(lambda*sigma_0));
    M_w_e = [ones(size(w_e, 1), 1) w_e];
    
    gamma = (M_w_e'*M_w_e)\M_w_e'*lambda_lw;
    
    gamma_0 = gamma(1);
    gamma_1 = gamma(2);
    
    
    
end

