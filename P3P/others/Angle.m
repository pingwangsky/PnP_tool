% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/  

function Angles = Angle( rotation )
% Angles(1,1)=atan(rotation(1,2)/rotation(1,1))/pi*180; %yaw;
% Angles(2,1)=-asin(rotation(1,3))/pi*180; %pitch;
% Angles(3,1)=atan(rotation(2,3)/rotation(3,3))/pi*180; %roll;

Angles(1,1)=atan(rotation(1,2)/rotation(1,1)); %yaw;
Angles(2,1)=-asin(rotation(1,3)); %pitch;
Angles(3,1)=atan(rotation(2,3)/rotation(3,3)); %roll;
end

