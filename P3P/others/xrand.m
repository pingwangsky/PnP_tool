% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/    

function y= xrand(m,n,r)
%function description:
%������Χ��r(1)��r(2)֮���m�У�n�е������;
y= r(1)+rand(m,n)*(r(2)-r(1));

return