% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/  

%This programe use SVD's(3D alignment) method to calculate R and T;
%reference:
%Umeyama S. Least-Squares Estimation of Transformation Parameters Between 2 Point Patterns[J]. 
%IEEE Transactions on Pattern Analysis & Machine Intelligence, 1991, 13(4):376-380.

function [R,T]=SVDdecomposition(res,X)
%using SVD's method to calculate R and T;
Xc1=res.Xc(:,1);
Xc2=res.Xc(:,2);
Xc3=res.Xc(:,3);

P1=X(:,1);
P2=X(:,2);
P3=X(:,3);
% derive the centroid of the two point-clouds
p1=(Xc1+Xc2+Xc3)/3;
p2=(P1+P2+P3)/3;
%compute the matrix H = sum(F'*G^{T})
H=zeros(3,3);
for i=1:3
    H=H+(res.Xc(:,i)-p1)*(X(:,i)-p2)';
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



