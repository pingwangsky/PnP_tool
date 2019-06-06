% Copyright (C) 2016, Ping Wang, Nanjing University of Aeronautics and Astronautics 
% Email: randolphingwp@163.com

function [XXw,xn,R,t]=genPnPdata(d,noise,N)

npt=N;
% camera's parameters
width= 640;
height= 480;
f=200;
nl=noise;
% generate 3d coordinates in camera space
Xc= [xrand(1,npt,[-4 4]); xrand(1,npt,[-4 4]); xrand(1,npt,[d d+4])];
t= mean(Xc,2);
R= rodrigues(randn(3,1));
XXw= inv(R)*(Xc-repmat(t,1,npt));
xx= [Xc(1,:)./Xc(3,:); Xc(2,:)./Xc(3,:)]*f;
xxn= xx+randn(2,npt)*nl;
%normalized focal;
xn=xxn./f;
end
