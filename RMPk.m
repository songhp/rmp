function [xt Out] = RMPk(A, y, k, options)
% max { ( pinv(A) * residual }
% Residual Minimization Pursuit
%----- Input
% A: measurement matrix
% y: measurements
% k: sparsity level
% options.tol: convergence tolerance
%----- Output
% xt: the recovery signal
%
% Written by Heping Song

if nargin == 3
    options = [];
end

if isfield(options, 'tol')
        tol = options.tol;
    else
        tol = 1e-6;
end
maxit = 100; 
n = size(A,2); % signal length

% initialization
t = 1; % iteration number
xt = zeros(n,1);  % initial x
% xt = pinv(A)*y; % initial x
r = y;  % initial residue
support_size = k;  % initial sparsity level
support = [];
stop = 0; % not convergent
AA = pinv(A);

while ~stop

    % support detection
    [v, idx] = sort(abs( AA *r), 'descend');
	activeset = sort(idx(1:support_size));
    support =sort(union(activeset, support));
    
    % signal estimation    
	At = A(:, support);
    z = abs(pinv(At) * y);
    [v, idx] = sort(z,'descend');
    support = support(idx(1:support_size));
    
    At = A(:, support);
    xt = zeros(n,1);
    xt(support) = pinv(At) * y;
    r = y - A*xt;
    
	if  norm(r)/norm(y) < tol  || t > maxit
        stop = 1; % convergent
	else
        t = t+1;
    end
end
Out.iter = t;

