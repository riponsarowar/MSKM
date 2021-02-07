function [l,a] = greedy(A,b,x,delta) 

m = size(A,1);
perm=randsample(m,delta);
[l,ind]=max(A(perm(1:size(perm,1)),:)*x-b(perm(1:size(perm,1))));
a=A(perm(ind),:);
l = max(l,0);

end
