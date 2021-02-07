function [solution, Time, REN, VC, REl] = MSKM_DC(A,b,x_int,er,IT,beta,delta,gamma, UT, Time, VC, REN, REl) 
tic;

IRTE=1;
[m,n] = size(A);
norm_rowsA=sqrt(sum((A).^2,2));
b = b(1:m)./norm_rowsA;
A(1:m,:) = A(1:m,:)./repmat(norm_rowsA,1,n);
res_int = A*x_int - b;
x = x_int;
z= x_int;
res_int = res_int(res_int > 0);
count=1;
time = 0;

while (toc < UT) && (count <= IT)
      tic
      
    [l,c] = greedy(A,b,z,beta);
    z_prime = (z - ((delta * l/(c*c')) * c')) + gamma*(z-x);
    x = z;
    z = z_prime;
    res = A*z-b;
    VC (count, 1) = sum(res > 0);
    REl(count, 1) = norm(z)/norm(x_int);
    res = res(res > 0); 
    s_res = sort(res, 'descend');
    p_res = s_res(1:VC(count, 1));
    REN (count,1) = sqrt(sum(p_res.^2)); 

    if norm(res,2)/norm(res_int,2) < er 
        count=IT; 	         
        solution=z;
	    IRTE=0; 		    
    end
    t = toc;
    time = time + t;
    Time (count, 1) = time;    
    count=count+1;   
end

if(IRTE)
solution=z;

end
Time = Time (1:(count-1), 1);
VC = VC (1:(count-1), 1);
REN = REN (1:(count-1),1);
RE = RE(1:(count-1),1);
end
