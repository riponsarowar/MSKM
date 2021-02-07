function solution=MSKM(A,b,xinit,er,IT,beta,delta,gamma, user_time) 
tic;

ITReached=1;
[m,n] = size(A);
norm_rowsA=sqrt(sum((A).^2,2));
b = b(1:m)./norm_rowsA;
A(1:m,:) = A(1:m,:)./repmat(norm_rowsA,1,n);
res_int = A*xinit - b;
x = xinit;
z= xinit;
res_int = res_int(res_int > 0);
count=1;

while (toc < user_time) && (count <= IT)
    
    [l,c] = greedy(A,b,z,beta);
    
    z_prime = (z - ((delta * l/(c*c')) * c')) + gamma*(z-x);
    x = z;
    z = z_prime;
    res = A*z-b;
    res = res(res > 0);

    if norm(res,2)/norm(res_int,2) < er
        count=IT;
        solution=z;
	    ITReached=0;
    end
    count=count+1;   
end

if(ITReached)
solution=z;

end
end
