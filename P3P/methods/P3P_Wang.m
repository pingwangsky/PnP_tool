% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/   

%Using my efficient method to solve P3P problem
function res=P3P_Wang(P,xn)

x=[xn;ones(1,3)];
f1=x(:,1)/norm(x(:,1));
f2=x(:,2)/norm(x(:,2));
f3=x(:,3)/norm(x(:,3));
P1=P(:,1);
P2=P(:,2);
P3=P(:,3);
uz=(P2-P1)/norm(P2-P1);
uy=cross(uz,P3-P1)/norm(cross(uz,P3-P1));
ux=cross(uy,uz);
R_temp=[ux,uy,uz]';
P_u1=[0;0;0];
P_u2=R_temp*(P2-P1);
P_u3=R_temp*(P3-P1);
z_2=P_u2(3);
x_3=P_u3(1);
z_3=P_u3(3);
%----------------------
A1=f1(1)/f1(3);
A2=f1(2)/f1(3);
B1=f2(1)/f2(3);
B2=f2(2)/f2(3);
C1=f3(1)/f3(3);
C2=f3(2)/f3(3);
%----------------------
T1=(B1-A1)/z_2;
T2=(B2-A2)/z_2;
%----------------------
D1=(C1*z_3-B1*z_3)/x_3;
D2=(C1-A1-z_3*T1)/x_3;
D3=(C2*z_3-B2*z_3)/x_3;
D4=(C2-A2-z_3*T2)/x_3;
%----------------------
G1=D1*B1+D3*B2;
G2=C1*B1+C2*B2+1;
G3=B1*D2+D1*T1+D3*T2+B2*D4;
G4=C1*T1+C2*T2;
G5=D2*T1+D4*T2;
%----------------------
H1=(C1^2+C2^2+1);
H2=(D1^2+D3^2-B1^2-B2^2-1);
H3=2*C1*D1+2*C2*D3;
H4=2*C1*D2+2*C2*D4;
H5=2*D1*D2+2*D3*D4-2*B1*T1-2*B2*T2;
H6=D2^2+D4^2-T1^2-T2^2;
%-----------------------
U4=H1*G1^2+H2*G2^2-H3*G1*G2;
U3=2*H1*G1*G3+2*H2*G2*G4-H3*(G1*G4+G2*G3)-H4*G1*G2+H5*G2^2;
U2=H1*G3^2+2*H1*G1*G5+H2*G4^2-H3*(G3*G4+G2*G5)-H4*(G1*G4+G2*G3)+2*H5*G2*G4+H6*G2^2;
U1=2*H1*G3*G5-H3*G4*G5-H4*(G3*G4+G2*G5)+H5*G4^2+2*H6*G2*G4;
U0=H1*G5^2-H4*G4*G5+H6*G4^2;
%-----------------------
U=[U4,U3,U2,U1,U0];
S4_roots=roots(U);
S4_roots=real(S4_roots);
n1=length(S4_roots);
for i=1:n1
    S4=S4_roots(i);
    S7=-(G1*S4^2+G3*S4+G5)/(G2*S4+G4);
    S1=A1;
    S2=A2;
    S3=B1*S4+T1;
    S5=B2*S4+T2;
    S6=C1*S7+D1*S4+D2;
    S8=C2*S7+D3*S4+D4;
    tz=1/sqrt(S3^2+S4^2+S5^2);
    tx=S1*tz;
    ty=S2*tz;
    r1=S6*tz;
    r3=S3*tz;
    r4=S8*tz;
    r6=S5*tz;
    r7=S7*tz;
    r9=S4*tz;
    T_F=[tx;ty;tz];
    r2=r6*r7-r4*r9;
    r5=r1*r9-r3*r7;
    r8=r3*r4-r1*r6;
    R_F=[r1,r2,r3;r4,r5,r6;r7,r8,r9];
    res{i}.R=R_F*R_temp;
    res{i}.T=T_F-R_F*R_temp*P1;
end

end