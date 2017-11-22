function [w_e_nom, delay1, delay2] = get_normalized_outputs(pars)
%% RUN STEADY STATE SIMULATION TO GET NORMALIZED REFERENCES
    u_alpha_input = pars.nom.u_alpha;
    du_ign_input = pars.nom.du_ign;
    model_name = 'full_model_steady_state.slx';
    
    time = 0:0.1:10;
    step_u_alpha = u_alpha_input*double(time>=1)';
    step_du_ign = du_ign_input*double(time>=1)';
    
    disp('Begin sim!');
    % generate step signal
    [~, ~, w_e] = sim(model_name, ...
                      [time(1) time(end)], ...
                      pars.sim_opt, ...
                      [time', ...
                      step_u_alpha, ...
                      step_du_ign]);
                      
    disp('Sim done!');
    
    w_e_nom = mean(w_e((end-100):end));
    
    delay1 = mean(delay1.Data((end-100):end));
    delay2 = mean(delay2.Data((end-100):end));

end

