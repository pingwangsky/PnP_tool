% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/  

%This programe generates experiment data;

function [XXw,xn,R,t]=genP3Pdata(noise)

npt=3;
% camera's parameters
width= 640;
height= 480;
f=200;
nl=noise;
% generate 3d coordinates in camera space
Xc= [xrand(1,npt,[-4 4]); xrand(1,npt,[-4 4]); xrand(1,npt,[8 16])];
t= mean(Xc,2);
R= rodrigues(randn(3,1));
XXw= inv(R)*(Xc-repmat(t,1,npt));
xx= [Xc(1,:)./Xc(3,:); Xc(2,:)./Xc(3,:)]*f;
xxn= xx+randn(2,npt)*nl;
%normalized focal;
xn=xxn./f;
end
