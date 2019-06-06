% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/   

%This programe to solve the P3P problem as described in: 
%Reference:
%S. Li and C. Xu. A stable direct solution of perspective-point-problem. 
%International Journal of Pattern Recognition and Artificial Intelligence,
%25(5):627-642, 2011

function res=P3P_Li(Xw,xn)
n=size(xn,2);
xxv=[xn;ones(1,n)];
X=Xw;
x=xxv;
%求距离;
D1=norm(X(:,1)-X(:,2));
D2=norm(X(:,1)-X(:,3));
D3=norm(X(:,2)-X(:,3));
%求单位向量;
v1=x(:,1)/norm(x(:,1));
v2=x(:,2)/norm(x(:,2));
v3=x(:,3)/norm(x(:,3));

cg1=v1.'*v2;
sg1=sqrt(1-cg1^2);
cg2=v1.'*v3;
sg2=sqrt(1-cg2^2);
cg3=v2.'*v3;
sg3=sqrt(1-cg3^2);

s0=1;
s1=s0*cg1;
s2=s0*cg2;

C1=s0*sg1;
C2=s0*sg2;

A1=(D2/D1)^2;
A2=A1*C1^2-C2^2;
A3=s2*cg3-s1;
A4=s1*cg3-s2;
A5=cg3;
A6=(D3^2-D1^2-D2^2)/(2*D1^2);
A7=s0^2-s1^2-s2^2+s1*s2*cg3+A6*C1^2;

B0=A7^2-A2*A4^2;
B1=2*(A3*A7-A2*A4*A5);
B2=A3^2+2*A6*A7-A1*A4^2-A2*A5^2;
B3=2*(A3*A6-A1*A4*A5);
B4=A6^2-A1*A5^2;
B=[B4,B3,B2,B1,B0];
t11=roots(B);
t11=real(t11);
%求得roots，然后依据求得跟计算其他参数;
n1=length(t11);
for i=1:n1
    t1=t11(i);
    c=A4+A5*t1;
    if c~=0
        t2=-(A3*t1+A6*t1^2+A7)/(A4+A5*t1);
        lam=D1/sqrt(t1^2+C1^2);
        d0=lam*s0;
        d1=lam*(s1+t1);
        d2=lam*(s2+t2);
        res{i}.d0=d0;
        res{i}.d1=d1;
        res{i}.d2=d2;
    elseif c==0
        t2=sqrt(A1*t1^2+A2);
        lam=D1/sqrt(t1^2+C1^2);
        d0=lam*s0;
        d1=lam*(s1+t1);
        d2=lam*(s2+t2);
        d22=lam*(s2-t2);
        res{1,i}.d0=d0;
        res{1,i}.d1=d1;
        res{1,i}.d2=d2;
        res{1,i+n1}.d0=d0;
        res{1,i+n1}.d1=d1;
        res{1,i+n1}.d2=d22; 
    end   
end

%从图像坐标恢复相机坐标下坐标值;
for i=1:n1
    res{i}.Xc(:,1)=res{i}.d0*v1;
    res{i}.Xc(:,2)=res{i}.d1*v2;
    res{i}.Xc(:,3)=res{i}.d2*v3;
end

for i=1:n1
    %using SVD's method to calculate R and T;
    [R,T]=SVDdecomposition(res{i},X);
    res{i}.R=R;
    res{i}.T=T;
end

end