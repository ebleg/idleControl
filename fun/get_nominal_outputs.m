function [p_m_nom, T_e_nom, w_e_nom, delay1, delay2] = get_nominal_outputs(pars)
%% RUN STEADY STATE SIMULATION TO GET NORMALIZED REFERENCES
    % Load parameters from pars struct
    u_alpha_input = pars.nom.u_alpha;
    du_ign_input = pars.nom.du_ign;

    % Model name
    model_name = 'full_model_steady_state.slx';
    
    % Generate step inputs
    time = 0:0.1:10;
    step_u_alpha = u_alpha_input*double(time>=1)';
    step_du_ign = du_ign_input*double(time>=1)';
    
    % generate step signal
    [~, x, w_e] = sim(model_name, ...
                      [time(1) time(end)], ...
                      pars.sim_opt, ...
                      [time', ...
                      step_u_alpha, ...
                      step_du_ign]);
    
    w_e_nom = mean(w_e((end-100):end));
    T_e_nom = mean(x((end-100):end),1);
    p_m_nom = mean(x((end-100):end),2);
    
    delay1 = mean(delay1.Data((end-100):end));
    delay2 = mean(delay2.Data((end-100):end));

end

