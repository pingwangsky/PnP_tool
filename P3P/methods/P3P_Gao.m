% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/    

%This programe to solve the P3P problem as described in: 
%X. Gao, X. Hou, J. Tang, H. Cheng. Complete solution classification for 
%the perspective-three-point problem. IEEE Transactions 
%on Pattern Analysis and Machine In-telligence, 25(8):930-943, 2003.

function res = P3P_Gao( Xw,xn )
k=size(xn,2);
xxv=[xn;ones(1,k)];

A=Xw(:,1);
B=Xw(:,2);
C=Xw(:,3);
AB=norm(A-B);
BC=norm(B-C);
AC=norm(A-C);

f1=xxv(:,1)/norm(xxv(:,1));
f2=xxv(:,2)/norm(xxv(:,2));
f3=xxv(:,3)/norm(xxv(:,3));

cos_alpha=f2.'*f3;
cos_beta=f1.'*f3;
cos_gamma=f1.'*f2;

a=(BC/AB)^2;
b=(AC/AB)^2;
p=2*cos_alpha;
q=2*cos_beta;
r=2*cos_gamma;

aSq=a*a;
bSq=b*b;
pSq=p*p;
qSq=q*q;
rSq=r*r;

factors5 = -2*b + bSq + aSq + 1 - b*rSq*a + 2*b*a - 2*a;
factors4 = -2*b*q*a - 2*aSq*q + b*rSq*q*a - 2*q + 2*b*q + ...
             4*a*q + p*b*r + b*r*p*a - bSq*r*p;
factors3 =  qSq + bSq*rSq - b*pSq - q*p*b*r + bSq*pSq - b*rSq*a + ...
            2 - 2*bSq - a*b*r*p*q + 2*aSq - 4*a - 2*qSq*a + qSq*aSq;
factors2 = -bSq*r*p + b*r*p*a - 2*aSq*q + q*pSq*b + ...
            2*b*q*a + 4*a*q + p*b*r - 2*b*q - 2*q;    
factors1 =  1 - 2*a + 2*b + bSq - b*pSq + aSq - 2*b*a;

factors=[factors5,factors4,factors3,factors2,factors1];
x=roots(factors);
x=real(x);

temp = (pSq*(a-1+b) + p*q*r - q*a*r*p + (a-1-b)*rSq);
b0 = b * temp * temp;
rCb = rSq*r;

tempXP2(1)=x(1)*x(1);
tempXP2(2)=x(2)*x(2);
tempXP2(3)=x(3)*x(3);
tempXP2(4)=x(4)*x(4);
tempXP2=tempXP2';

tempXP3(1) = tempXP2(1)*x(1);
tempXP3(2) = tempXP2(2)*x(2);
tempXP3(3) = tempXP2(3)*x(3);
tempXP3(4) = tempXP2(4)*x(4);
tempXP3=tempXP3';

b1_part1 = (1-a-b)*tempXP2 + (q*a-q)*x + (1 - a + b)*ones(4,1);
b1_part2 = (aSq*rCb + 2*b*rCb*a - b*rSq*rCb*a - 2*a*rCb + rCb + bSq*rCb - 2*rCb*b)*tempXP3...
          +(p*rSq + p*aSq*rSq - 2*b*rCb*q*a + 2*rCb*b*q - 2*rCb*q - 2*p*(a+b)*rSq...
          + rSq*rSq*p*b + 4*a*rCb*q + b*q*a*rCb*rSq - 2*rCb*aSq*q +2*rSq*p*b*a...
          + bSq*rSq*p - rSq*rSq*p*bSq)*tempXP2...
          +(rCb*qSq + rSq*rCb*bSq + r*pSq*bSq - 4*a*rCb - 2*a*rCb*qSq + rCb*qSq*aSq...
          + 2*aSq*rCb - 2*bSq*rCb - 2*pSq*b*r + 4*p*a*rSq*q + 2*a*pSq*r*b...
          - 2*a*rSq*q*b*p - 2*pSq*a*r + r*pSq - b*rSq*rCb*a + 2*p*rSq*b*q...
          + r*pSq*aSq -2*p*q*rSq + 2*rCb - 2*rSq*p*aSq*q - rSq*rSq*q*b*p)*x...
          +(4*a*rCb*q + p*rSq*qSq + 2*pSq*p*b*a - 4*p*a*rSq - 2*rCb*b*q - 2*pSq*q*r...
          - 2*bSq*rSq*p + rSq*rSq*p*b + 2*p*aSq*rSq - 2*rCb*aSq*q - 2*pSq*p*a...
          + pSq*p*aSq + 2*p*rSq + pSq*p + 2*b*rCb*q*a + 2*q*pSq*b*r + 4*q*a*r*pSq...
          - 2*p*a*rSq*qSq - 2*pSq*aSq*r*q + p*aSq*rSq*qSq - 2*rCb*q - 2*pSq*p*b...
          + pSq*p*bSq - 2*pSq*b*r*q*a)*ones(4,1);
      
b1(1) = b1_part1(1)*b1_part2(1);
b1(2) = b1_part1(2)*b1_part2(2);      
b1(3) = b1_part1(3)*b1_part2(3);  
b1(4) = b1_part1(4)*b1_part2(4);
b1=b1';

y=b1/b0;
tempYP2(1) = y(1)^2;
tempYP2(2) = y(2)^2;
tempYP2(3) = y(3)^2;
tempYP2(4) = y(4)^2;
tempYP2=tempYP2';

tempXY(1) = x(1)*y(1);
tempXY(2) = x(2)*y(2);
tempXY(3) = x(3)*y(3);
tempXY(4) = x(4)*y(4);
tempXY=tempXY';

v= tempXP2 + tempYP2 - r*tempXY;

Z(1) = AB/sqrt(v(1));
Z(2) = AB/sqrt(v(2));
Z(3) = AB/sqrt(v(3));
Z(4) = AB/sqrt(v(4));
  
X(1) = x(1)*Z(1);
X(2) = x(2)*Z(2);
X(3) = x(3)*Z(3);
X(4) = x(4)*Z(4);
   
Y(1) = y(1)*Z(1);
Y(2) = y(2)*Z(2);
Y(3) = y(3)*Z(3);
Y(4) = y(4)*Z(4);

for i=1:4
    res{i}.Xc(:,1)=X(i)*f1;
    res{i}.Xc(:,2)=Y(i)*f2;
    res{i}.Xc(:,3)=Z(i)*f3;
end

for i=1:4
    %using SVD's(3D alignment) method to calculate R and T;
    %reference:
    %Umeyama S. Least-Squares Estimation of Transformation Parameters Between 2 Point Patterns[J]. 
    %IEEE Transactions on Pattern Analysis & Machine Intelligence, 1991, 13(4):376-380.
    [R,T]=SVDdecomposition(res{i},Xw);
    res{i}.R=R;
    res{i}.T=T;
end

end



















