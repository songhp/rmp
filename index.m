%%
function index

% options: 'gm'=1 'gk'=2 'bm'=3 'bk'=4
% g: gaussian 
% b: binary 
% m: fixed measurements 
% k: fixed sparsity level
clear all
k = 20;
m = 128;
n = 256;
ensemble = 'USE';
opts.sigma = 0;
opts.gauss = 1;

% [x, y, A] = gen_signal(k, m, n, ensemble, opts);
[x, y, A] = gen_signal(k, m, n, ensemble, opts);

%  ’¡≤ŒÛ≤Ó
tol = 1e-6;

% tic
% xt  = OPP(A, y, k);
% toc
% SupportDetection(x, xt)
% 
tic
xt  = RMP(A, y, k);
toc
SupportDetection(x, xt)
% 
% tic
% xt  = OMP(A, y, k);
% toc
% SupportDetection(x, xt)
% 
% tic
% xt  = RMPk(A, y, k);
% toc
% SupportDetection(x, xt)
% 
% tic
% xt  = OMPk(A, y, k);
% toc
% SupportDetection(x, xt)
% 
% tic
% xt  = RMPbeta(A, y, 0.8);
% toc
% SupportDetection(x, xt)
% 
% tic
% xt  = OMPbeta(A, y, 0.8);
% toc
% SupportDetection(x, xt)
% 
% 




