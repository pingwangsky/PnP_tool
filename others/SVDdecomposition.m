% Copyright (C) 2016, Ping Wang, Nanjing University of Aeronautics and Astronautics 
%This program is free software and you can redistribute or modify it.
% Email: randolphingwp@163.com

function [R,T]=SVDdecomposition(Xc,X)
% This routine solves the exterior orientation problem for a point cloud
%  given in both camera and world coordinates. It is described in:
%Umeyama S. Least-Squares Estimation of Transformation Parameters Between 2 Point Patterns[J]. 
%IEEE Transactions on Pattern Analysis & Machine Intelligence, 1991, 13(4):376-380.

%% using SVD's method;
n=size(Xc,2);
% derive the centroid of the two point-clouds
p1=zeros(3,1);
p2=zeros(3,1);
for i=1:n
    p1=p1+Xc(:,i);
    p2=p2+X(:,i);
end
p1=p1/n;
p2=p2/n;
%compute the matrix H = sum(F'*G^{T})
H=zeros(3,3);
for i=1:n
    H=H+(Xc(:,i)-p1)*(X(:,i)-p2)';
end
%decompose this matrix (SVD) to obtain rotation
[U,S,V]=svd(H);
%calculate R and T;
R=U*V';  %or R=(V*U')';
if det(R)<0
    V_prime(:,1)=V(:,1);
    V_prime(:,2)=V(:,2);
    V_prime(:,3)=-V(:,3);
    R=U*V_prime';
end
T=p1-R*p2;
end



