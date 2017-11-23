function [system] = linearize_fn(pars)
%% LINEARIZE the full system

%% Linearize without delays
[system.ss.nodelay.A, ...
    system.ss.nodelay.B, ...
    system.ss.nodelay.C, ...
    system.ss.nodelay.D] = ...
    linmod('model_norm_nodelay', [1,1], [1,1,1,1]);

system.tf.lin_nodelay = tf(ss(system.ss.nodelay.A, ...
    system.ss.nodelay.B, ...
    system.ss.nodelay.C, ...
    system.ss.nodelay.D));

%% define the delays seperately
[num1 , den1]  = pade(pars.nom.delay1, 4);
[num2 , den2]  = pade(pars.nom.delay2, 4);

system.tf.delay1 = tf(num1 , den1);
system.tf.delay2 = tf(num2 , den2);

%% use iconnect functionality to connect the systems
% create ic instance
u1 = icsignal(1); u2 = icsignal(1); u3 = icsignal(1); u4 = icsignal(1);
y1 = icsignal(1); y2 = icsignal(1); y3 = icsignal(1);

Q = iconnect;
Q.input = [u1 ; u2];
Q.output = [y1];

% add cocnstraint equations for P2 & P3
Q.Equation{1} = equate(u3 , system.tf.delay1 * y2);
Q.Equation{2} = equate(u4 , system.tf.delay2 * y3);

% add constraints from the linearized system without delays
Q.Equation{3} = equate(y1 , system.tf.lin_nodelay(1,1) * u1 + ...
    system.tf.lin_nodelay(1,2) * u2 + ...
    system.tf.lin_nodelay(1,3) * u3 + ...
    system.tf.lin_nodelay(1,4) * u4);
Q.Equation{4} = equate(y2 , system.tf.lin_nodelay(2,1) * u1 + ...
    system.tf.lin_nodelay(2,2) * u2 + ...
    system.tf.lin_nodelay(2,3) * u3 + ...
    system.tf.lin_nodelay(2,4) * u4);
Q.Equation{5} = equate(y3 , system.tf.lin_nodelay(3,1) * u1 + ...
    system.tf.lin_nodelay(3,2) * u2 + ...
    system.tf.lin_nodelay(3,3) * u3 + ...
    system.tf.lin_nodelay(3,4) * u4);

% Get resulting system from iconnect
system.tf.lin = tf(Q.System);
[system.ss.lin.A , system.ss.lin.B , system.ss.lin.C , system.ss.lin.D ] =...
    ssdata(minreal(system.tf.lin));

% check if size is correct
disp('If this outputs 10x10, a miracle occured:')
disp(size(system.ss.lin.A));

end

