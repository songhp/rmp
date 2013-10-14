function  SupportDetection(x, xbar)
% Thesholding-based iterative support detection (ISD) for 1D signals


%%%%%%%%%% Input %%%%%%%%%%%%%%%%%%%

% x:      true signal
% xbar:   recovered signal
%

%
%%%%%%%%%% Output %%%%%%%%%%%%%%%%
%
% SNR:          Signal-to-Noise Ratio
% err_inf:	absolute error in inf-norm. 
% relerr2: 	relative error in l2 norm. 
% relerr1:	relative error in l1 norm. 


if length(x)~= length(xbar)
    error('Input parameter x, xbar must be the same length!');
end
n = length(x);

SNR = 10*log10(norm(x)/norm(x-xbar));
err_inf = norm(x-xbar,'inf');
relerr2 = norm(x-xbar)/norm(x);
relerr1 = norm(x-xbar,1)/norm(x,1);

fprintf('SNR=%4.2f, err_inf=%4.2e, relerr2=%4.2e, relerr1=%4.2e ', SNR, err_inf, relerr2, relerr1 );
fprintf('\n');  

nozero_criteria = 1e-6;
true_nzs = (abs(x)>nozero_criteria);
nzs = (abs(xbar)>nozero_criteria); % jumps is logical
good_nzs = nzs & true_nzs;
bad_nzs = nzs & (~true_nzs);
miss_nzs = true_nzs & ~nzs;

fprintf('\n');  
fprintf('Sparsity=%2d, detected(total=%2d, good=%2d, bad=%2d, miss=%2d), RelErr=%4.2e',...
nnz(true_nzs), nnz(nzs), nnz(good_nzs), nnz(bad_nzs), nnz(miss_nzs), relerr2);
fprintf('\n');
       

figure;
% box on
h = stem(1:n,x,'ko','MarkerSize',10);
set(h, 'LineWidth', 2);
set(gca, 'FontSize', 14);
hold on;
h = stem(find(good_nzs),xbar(good_nzs),'rs','MarkerSize',5);
set(h, 'LineWidth', 2);
set(gca, 'FontSize', 14);
if any(bad_nzs)
	h = stem(find(bad_nzs), xbar(bad_nzs),'bd','MarkerSize',5);
	legend('true signal','true nonzero','false nonzero');
    set(h, 'LineWidth', 2);
    set(gca, 'FontSize', 14);   
else
	legend('true signal','true nonzero');
end
axis([1 n min(x)-0.5 max(x)+0.5]);
hold off
title(sprintf('Sparsity=%2d, detected(total=%2d, good=%2d, bad=%2d, miss=%2d), RelErr=%4.2e',...
nnz(true_nzs), nnz(nzs), nnz(good_nzs), nnz(bad_nzs), nnz(miss_nzs), relerr2),...
'fontsize',14);             

tt = datevec(now);
str = num2str(tt(6));
fn = strcat('Fig_supp_det_', str, '.fig'); 
% fn = strcat('Fig_supp_det_', num2str(sigma), '.fig'); 
set(gcf,'color','none');
set(gca,'color','none');
set(gcf,'InvertHardCopy','off');
saveas(gcf, fn)

% fn = strcat('Fig_supp_det_', str, '.eps'); 
% % fn = strcat('Fig_supp_det_', num2str(sigma), '.fig'); 
% print(gcf, '-depsc2', fn)
    
     
