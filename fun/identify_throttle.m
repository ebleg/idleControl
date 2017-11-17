function [alpha_0, alpha_1] = identify_throttle(dataFile, pars, plot_validation_toggle)
%% IDENTIFY THROTTLE PARAMETERS (alpha0, alpha1)
    % Import data from quasistatic data
    data = load(dataFile);
    meas = data.meas;
    
    t = meas.time;
    p_a = meas.p_a.signals.values;
    theta_a = meas.T_a.signals.values;
    m_dot_alpha = meas.m_dot_alpha.signals.values;
    u_alpha = meas.u_alpha.signals.values;
    
    % Import necessary parameters
    R = pars.static.R;
    
    % Establish matrices
    A_alpha = m_dot_alpha.*sqrt(2.*R.*theta_a)./p_a;
    M_u_alpha = [ones(size(u_alpha, 1), 1) u_alpha];
    
    % Perform linear least-squares
    alpha = (M_u_alpha'*M_u_alpha)\M_u_alpha'*A_alpha; 
    
    % Get desired parameters
    alpha_0 = alpha(1);
    alpha_1 = alpha(2);
    
    % Validation plot
    if plot_validation_toggle
        plot(t, A_alpha);
        hold on;
        plot(t, alpha_0 + alpha_1*u_alpha);
        hold off;
    end
   

end

