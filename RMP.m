function xt = RMP(A, y, k, options)
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
        tol = 1e-8;
end


xt = zeros(size(A, 2), 1); 

index = []; %  indexes of components of s
r     = y;  % first residual
At    =[];  % Matrix of the columns used to represent y 
e0    = sqrt( sum( r.^2 ) ); % norm of the original signal

AA = pinv(A); %¸Ä¶¯
for iter = 1 : k;
    [i,j]     = max(abs(AA * r));
    index     = [index j];
%     At        = [At A(:,j)];
    At        = A(:,index);
%     xtt       = At\y;
	xtt       = pinv(At)*y;
    r         = y - At * xtt;
    xt(index) = xtt;    

%     % compute error
%     e = sqrt( sum( r.^2 ) );
%     if e/e0 < tol  || (e <tol)
%        break;
%     end
    
end
