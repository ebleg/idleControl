function [system] = linearize(pars)
%LINEARIZE Summary of this function goes here

% linearize without delays
    [system.ss.nodelay.A,system.ss.nodelay.B,...
        system.ss.nodelay.C,system.ss.nodelay.D] = ...
        linmod(model_norm_nodelay, [1,1], [1,1,1,1]);

    system.tf.lin_nodelay = tf(ss([system.ss.nodelay.A, ...
        system.ss.nodelay.B, ...
        system.ss.nodelay.C, ...
        system.ss.nodelay.D]));

    system.tf.delay1 = pade(pars.nom.delay1,4);
    system.tf.delay2 = pade(pars.nom.delay2,4);



    %% use iconnect functionality
    % create ic
    u1 = icsignal(1); u2 = icsignal(1); u3 = icsignal(1); u4 = icsignal(1);
    y1 = icsignal(1); y2 = icsignal(1); y3 = icsignal(1);

    Q = iconnect;
    Q.input = [u1 ; u2 ; u3 ; u4];
    Q.output = [y1 ; y2 ; y3];

    Q.Equation{1} = equate(u3 , system.tf.delay1 * y2);
    Q.Equation{2} = equate(u4 , system.tf.delay2 * y3);
    Q.Equation{3} = equate(y1 , system.tf.lin_nodelay(1,1) * u1 + ...
        system.tf.lin_nodelay(1,2) * u2 + ...
        system.tf.lin_nodelay(1,3) * u3 + ...
        system.tf.lin_nodelay(1,4) * u4);

    system.tf.lin = tf(Q.System);
    [system.ss.lin.A , system.ss.lin.B , system.ss.lin.C , system.ss.lin.D ] =...
        minreal(ssdata(system.tf.lin));


    disp('If this outputs 10x10, a miracle occured: \n')
    disp(size(system.ss.lin.A));

end

