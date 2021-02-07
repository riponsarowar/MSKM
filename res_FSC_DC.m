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

%%%%%%
[m, n] = size(A);
x = normrnd(0,1,[n,1]);
s = normrnd(0,1,[m,1]);
b = (A*x)+s;
x_int = 1000*ones(n,1);

%% 
er = 10^(-5);
IT = 300000;
UT = 1000;

%%%%%%
k = 5;
beta = 5;
delta = 1;
%%%%%%

V = zeros(IT,1);
RN = zeros(IT,1);
TM = zeros(IT,1);
RE = zeros(IT,1);

VC_SKM = zeros(IT, k);
REN_SKM = zeros(IT, k);
Time_SKM = zeros(IT, k);
REL_SKM = zeros(IT, k);

VC_MSKM_1 = zeros(IT, k);
REN_MSKM_1 = zeros(IT, k);
Time_MSKM_1 = zeros(IT, k);
REL_MSKM_1 = zeros(IT, k);

VC_MSKM_2 = zeros(IT, k);
REN_MSKM_2 = zeros(IT, k);
Time_MSKM_2 = zeros(IT, k);
REL_MSKM_2 = zeros(IT, k);

VC_MSKM_3 = zeros(IT, k);
REN_MSKM_3 = zeros(IT, k);
Time_MSKM_3 = zeros(IT, k);
REL_MSKM_3 = zeros(IT, k);

VC_MSKM_4 = zeros(IT, k);
REN_MSKM_4 = zeros(IT, k);
Time_MSKM_4 = zeros(IT, k);
REL_MSKM_4 = zeros(IT, k);

VC_MSKM_5 = zeros(IT, k);
REN_MSKM_5 = zeros(IT, k);
Time_MSKM_5 = zeros(IT, k);
REL_MSKM_5 = zeros(IT, k);

for i = 1:k

     gamma = 0;
     [sol_SKM, Time, REN, VC, REL] = MSKM_DC(A,b,x_int,er,IT,beta,delta,gamma, UT, TM, V, RN, RE) ;
     VC_SKM(:,i) = VC;
     REN_SKM(:,i) = REN;
     Time_SKM(:,i) = Time; 
     REL_SKM(:,i) = REL; 
     
     gamma = 0.1;
     [sol_MSKM_1, Time, REN, VC, REL] =  MSKM_DC(A,b,x_int,er,IT,beta,delta,gamma, UT, TM, V, RN, RE) ;
     VC_MSKM_1(:,i) = VC;
     REN_MSKM_1(:,i) = REN;
     Time_MSKM_1(:,i) = Time;
     REL_MSKM_1(:,i) = REL; 
     
     gamma = 0.2;
     [sol_MSKM_2, Time, REN, VC, REL] =  MSKM_DC(A,b,x_int,er,IT,beta,delta,gamma, UT, TM, V, RN, RE) ;
     VC_MSKM_2(:,i) = VC;
     REN_MSKM_2(:,i) = REN;
     Time_MSKM_2(:,i) = Time;
     REL_MSKM_2(:,i) = REL;
     
     gamma = 0.3;
     [sol_MSKM_3, Time, REN, VC, REL] =  MSKM_DC(A,b,x_int,er,IT,beta,delta,gamma, UT, TM, V, RN, RE) ;
     VC_MSKM_3(:,i) = VC;
     REN_MSKM_3(:,i) = REN;
     Time_MSKM_3(:,i) = Time;
     REL_MSKM_3(:,i) = REL;
     
     gamma = 0.4;
     [sol_MSKM_4, Time, REN, VC, REL] =  MSKM_DC(A,b,x_int,er,IT,beta,delta,gamma, UT, TM, V, RN, RE) ;
     VC_MSKM_4(:,i) = VC;
     REN_MSKM_4(:,i) = REN;
     Time_MSKM_4(:,i) = Time;
     REL_MSKM_4(:,i) = REL;
     
     gamma = 0.5;
     [sol_MSKM_5, Time, REN, VC, REL] =  MSKM_DC(A,b,x_int,er,IT,beta,delta,gamma, UT, TM, V, RN, RE) ;
     VC_MSKM_5(:,i) = VC;
     REN_MSKM_5(:,i) = REN;
     Time_MSKM_5(:,i) = Time;
     REL_MSKM_5(:,i) = REL;
end

Time_avg_SKM = sum(Time_SKM, 2)./sum(Time_SKM~=0, 2);
Time_avg_SKM(isnan(Time_avg_SKM))=0;
t = Time_avg_SKM;
idx = find(t==0, 1, 'first');
t(idx)= t(idx-1)+0.05;
t(idx+1)= t(idx-1)+0.1;
Time_avg_SKM = t;

VC_avg_SKM = sum(VC_SKM, 2)./sum(VC_SKM~=0, 2);
VC_avg_SKM(isnan(VC_avg_SKM))=0;
REN_avg_SKM = sum(REN_SKM, 2)./sum(REN_SKM~=0, 2);
REN_avg_SKM(isnan(REN_avg_SKM))=0;
REL_avg_SKM = sum(REL_SKM, 2)./sum(REL_SKM~=0, 2);
REL_avg_SKM(isnan(REL_avg_SKM))=0;

Time_avg_MSKM_1 = sum(Time_MSKM_1, 2)./sum(Time_MSKM_1~=0, 2);
Time_avg_MSKM_1(isnan(Time_avg_MSKM_1))=0;
t = Time_avg_MSKM_1;
idx = find(t==0, 1, 'first');
t(idx)= t(idx-1)+0.05;
t(idx+1)= t(idx-1)+0.1;
Time_avg_MSKM_1 = t;

VC_avg_MSKM_1 = sum(VC_MSKM_1, 2)./sum(VC_MSKM_1~=0, 2);
VC_avg_MSKM_1(isnan(VC_avg_MSKM_1))=0;
REN_avg_MSKM_1 = sum(REN_MSKM_1, 2)./sum(REN_MSKM_1~=0, 2);
REN_avg_MSKM_1(isnan(REN_avg_MSKM_1))=0;
REL_avg_MSKM_1 = sum(REL_MSKM_1, 2)./sum(REL_MSKM_1~=0, 2);
REL_avg_MSKM_1(isnan(REL_avg_MSKM_1))=0;

Time_avg_MSKM_2 = sum(Time_MSKM_2, 2)./sum(Time_MSKM_2~=0, 2);
Time_avg_MSKM_2(isnan(Time_avg_MSKM_2))=0;
t = Time_avg_MSKM_2;
idx = find(t==0, 1, 'first');
t(idx)= t(idx-1)+0.05;
t(idx+1)= t(idx-1)+0.1;
Time_avg_MSKM_2 = t;

VC_avg_MSKM_2 = sum(VC_MSKM_2, 2)./sum(VC_MSKM_2~=0, 2);
VC_avg_MSKM_2(isnan(VC_avg_MSKM_2))=0;
REN_avg_MSKM_2 = sum(REN_MSKM_2, 2)./sum(REN_MSKM_2~=0, 2);
REN_avg_MSKM_2(isnan(REN_avg_MSKM_2))=0;
REL_avg_MSKM_2 = sum(REL_MSKM_2, 2)./sum(REL_MSKM_2~=0, 2);
REL_avg_MSKM_2(isnan(REL_avg_MSKM_2))=0;

Time_avg_MSKM_3 = sum(Time_MSKM_3, 2)./sum(Time_MSKM_3~=0, 2);
Time_avg_MSKM_3(isnan(Time_avg_MSKM_3))=0;
t = Time_avg_MSKM_3;
idx = find(t==0, 1, 'first');
t(idx)= t(idx-1)+0.05;
t(idx+1)= t(idx-1)+0.1;
Time_avg_MSKM_3 = t;

VC_avg_MSKM_3 = sum(VC_MSKM_3, 2)./sum(VC_MSKM_3~=0, 2);
VC_avg_MSKM_3(isnan(VC_avg_MSKM_3))=0;
REN_avg_MSKM_3 = sum(REN_MSKM_3, 2)./sum(REN_MSKM_3~=0, 2);
REN_avg_MSKM_3(isnan(REN_avg_MSKM_3))=0;
REL_avg_MSKM_3 = sum(REL_MSKM_3, 2)./sum(REL_MSKM_3~=0, 2);
REL_avg_MSKM_3(isnan(REL_avg_MSKM_3))=0;

Time_avg_MSKM_4 = sum(Time_MSKM_4, 2)./sum(Time_MSKM_4~=0, 2);
Time_avg_MSKM_4(isnan(Time_avg_MSKM_4))=0;
t = Time_avg_MSKM_4;
idx = find(t==0, 1, 'first');
t(idx)= t(idx-1)+0.05;
t(idx+1)= t(idx-1)+0.1;
Time_avg_MSKM_4 = t;

VC_avg_MSKM_4 = sum(VC_MSKM_4, 2)./sum(VC_MSKM_4~=0, 2);
VC_avg_MSKM_4(isnan(VC_avg_MSKM_4))=0;
REN_avg_MSKM_4 = sum(REN_MSKM_4, 2)./sum(REN_MSKM_4~=0, 2);
REN_avg_MSKM_4(isnan(REN_avg_MSKM_4))=0;
REL_avg_MSKM_4 = sum(REL_MSKM_4, 2)./sum(REL_MSKM_4~=0, 2);
REL_avg_MSKM_4(isnan(REL_avg_MSKM_4))=0;

Time_avg_MSKM_5 = sum(Time_MSKM_5, 2)./sum(Time_MSKM_5~=0, 2);
Time_avg_MSKM_5(isnan(Time_avg_MSKM_5))=0;
t = Time_avg_MSKM_5;
idx = find(t==0, 1, 'first');
t(idx)= t(idx-1)+0.05;
t(idx+1)= t(idx-1)+0.1;
Time_avg_MSKM_5 = t;


VC_avg_MSKM_5 = sum(VC_MSKM_5, 2)./sum(VC_MSKM_5~=0, 2);
VC_avg_MSKM_5(isnan(VC_avg_MSKM_5))=0;
REN_avg_MSKM_5 = sum(REN_MSKM_5, 2)./sum(REN_MSKM_5~=0, 2);
REN_avg_MSKM_5(isnan(REN_avg_MSKM_5))=0;
REL_avg_MSKM_5 = sum(REL_MSKM_5, 2)./sum(REL_MSKM_5~=0, 2);
REL_avg_MSKM_5(isnan(REL_avg_MSKM_5))=0;

Time = [Time_avg_SKM,Time_avg_MSKM_1,Time_avg_MSKM_2,Time_avg_MSKM_3,Time_avg_MSKM_4,Time_avg_MSKM_5];
VC = [VC_avg_SKM,VC_avg_MSKM_1,VC_avg_MSKM_2,VC_avg_MSKM_3,VC_avg_MSKM_4,VC_avg_MSKM_5];
REN = [REN_avg_SKM,REN_avg_MSKM_1,REN_avg_MSKM_2,REN_avg_MSKM_3,REN_avg_MSKM_4,REN_avg_MSKM_5];
REL = [REL_avg_SKM,REL_avg_MSKM_1,REL_avg_MSKM_2,REL_avg_MSKM_3,REL_avg_MSKM_4,REL_avg_MSKM_5];


xlswrite(['australian_tau_',sprintf('%d',beta),'.xlsx'],Time,'Time');
xlswrite(['australian_tau_',sprintf('%d',beta),'.xlsx'],VC,'VC');
xlswrite(['australian_tau_',sprintf('%d',beta),'.xlsx'],REN,'Residual');
xlswrite(['australian_tau_',sprintf('%d',beta),'.xlsx'],REL,'Relative error');

