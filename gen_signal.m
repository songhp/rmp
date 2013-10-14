function [x, y, A] = gen_signal(k, m, n, ensemble, opts)
% generate the signal
%----- Input
% k: the sparsity level
% m: the number of measurements
% n: the dimension of signal
% ensemble: matrix ensemble
% opts: 
% opts.gauss: 1-generate gaussian signal(default), 0-bernoulli signal
% opts.sigma: additive noise variance
%----- Output
% x: the generated signal
% y: the measurements
% A: the measurement matrix

if nargin == 3
    ensemble = 'USE';
    gauss = 1;
    sigma = 0;
end

if isfield(opts,'sigma');
    sigma = opts.sigma;
else
    sigma = 0;
end

if isfield(opts,'gauss');
    gauss = opts.gauss;
else
    gauss = 1;
end
    

%% ”–‘Î…˘
% % rand signal
% % location of the diracs
% sel = randperm(n); sel = sel(1:k);
% x = zeros(n,1); x(sel)=1;
% 
% 
% if options
% % % randomization of the signs and values
% x = x.*sign(randn(n,1)).*(1-.5*rand(n,1));
% end
% 
% 
% % Gaussian matrix
% A = randn(m,n);
% % normalization
% A = A ./ repmat( sqrt(sum(A.^2)), [m 1] );
% 
% 
% % perform random measurements without noise.
% y = A*x;
% %º”‘Î…˘
% sigma = 0.001;
% y = imnoise(y,'gaussian',0,sigma);


%% Œﬁ‘Î…˘
% % creating a measurement matrix
% AA = orth(randn(n));
% A = AA(1:m,:);
% % normalization
% A = A ./ repmat( sqrt(sum(A.^2)), [m 1] );

A = MatrixEnsemble(m, n,ensemble);
% ensemble:
% 'USE' - Uniform spherical ensemble
% 'RSE' - Random signs ensemble
% 'RST' - Partial RST (Real Fourier) ensemble
% 'Hadamard' - Partial Hadamard ensemble


% generating a signal sparse in the time domain
if gauss
    x = [randn(k,1); zeros(n-k,1)]; %gaussian vector
else
    x = [sign(rand([k 1]) - 0.5); zeros(n-k,1)]; %bernoulli vector
end
p = randperm(n);
x = x(p);



% observation
y = A*x + sigma*randn(m,1);

