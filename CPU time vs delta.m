%%%%%% test instnaces
m  = 5000 ;
n = 1000 ;
%%%%%% highly correlated
 A = 0.9 + (1-0.9).*rand(m,n);

%%%%%% libsvm data
%A = xlsread('a9a.xlsx');

%%%%%% matrix market data
%A = xlsread('nos4.xlsx');

%%%%%% gaussian random
%  A = normrnd(0,1,[m,n]);

%%%%%%  Netlib data
% load('lp_recipe.mat');
% A = full(Problem.A);
% b = Problem.b;
% fun = @(x) (Problem.aux.c)'*x;
% m = size(C,1);
% n = size(C,2);
% d(~isfinite(d)) = 10^50;
% norm_rowsA=sqrt(sum((C).^2,2));
% d(1:m) = d (1:m)./norm_rowsA;
% C(1:m,:) = C (1:m,:)./repmat(norm_rowsA,1,n); 
% C = full(C);
% C(isnan(C))=0;
% d(isnan(d))=0;
% res_int = max(C*1000*ones(n,1)-d);
% A = C;
% b = d;
% [m, n] = size(A);
% x_init = 1000*ones(n,1);
% err = 10^(-7);
%%%%%%

%% CPU time vs sample size
er = 10^(-15);
IT = 10000000;
UT = 15;

k = 10;
delta = 0.8;

[m, n] = size(A);
x = normrnd(0,1,[n,1]);
s = normrnd(0,1,[m,1]);
b = (A*x)+s;
x_int = 1000*ones(n,1);

delta_list  = 0.95:0.05:1.5;
%delta_m = 0.95;
[f, p] = size(delta_list);

t_alg = zeros(p, 6);

for j = 1:p    
    delta = delta_list(1,j);
    t_int = zeros(k, 6);
  
    for i = 1:k
        gam = [0,0.1,0.2,0.3,0.4,0.5];
        for l = 1:6
            tic;
            sol_MSKM(l) = MSKM(A,b,x_int,er,IT,beta,delta,gam(l),UT);
            t_int(i,l) = toc;
        end
    end
    t_alg = mean(t_int);
    
end
data = [t_alg(1), t_alg(2), t_alg(3), t_alg(4), t_alg(5), t_alg(6), delta_list'];
xlswrite(['gaussian_',sprintf('%d',beta),'.xlsx'],data,'Time vs delta');

