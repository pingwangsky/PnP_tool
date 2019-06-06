% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/    

function y= xrand(m,n,r)
%function description:
%产生范围在r(1)到r(2)之间的m行，n列的随机数;
y= r(1)+rand(m,n)*(r(2)-r(1));

return