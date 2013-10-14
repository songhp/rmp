function x = OPP(A, y, k)
% Othogonal Pruning Pursuit
%----- Input
% A: measurement matrix
% y: measurements
% k: sparsity level
% options.tol: convergence tolerance
%----- Output
% x: the recovery signal
%
% Written by Heping Song


[m ,n] = size(A);

I     = 1:n; %  indexes of components of s
r     = y;  % first residual
Ai    = A;  % Matrix of the columns used to represent y 
e0    = norm(r); % norm of the original signal

for t = 1 : (n-k);
    xt = pinv(Ai)*y;
    a= (xt.*xt)'./sum(Ai.*Ai);
%     a= (xt.*xt)';
    [val, idx] = min(a);
    Ai(:,idx) = [];
    I(idx) = []; 
% 	xtt = Ai \ y;
	xtt = pinv(Ai) * y;
    r = y - Ai * xtt;
    x = zeros(n, 1); 
    x(I) = xtt;
    
%     % compute error
%     e = norm(r);
%     if e/e0 < tol  || (e <tol)
%        break;
%     end
    
end


