function [xt Out] = RMPbeta(A, y, beta, options)
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
support = [];
stop = 0; % not convergent
AA = pinv(A);

while ~stop

    % support detection
    g = abs( AA *r);
    [activeset, gvale] = find(g > max(g)* beta);
    support =sort(union(activeset, support));
    
    % signal estimation
    xt = zeros(n,1);
    xt(support) = pinv(A(:, support)) * y;
    r = y - A*xt;    

	if  ( norm(r)/norm(y) < tol  || t > maxit)
        stop = 1; % convergent
    else
        t = t+1;
    end


end
Out.iter = t;

