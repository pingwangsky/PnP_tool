% Copyright (C) 2016, Ping Wang, Nanjing University of Aeronautics and Astronautics 
% Email: randolphingwp@163.com

function Angles = Angle( rotation )
%calculation the  three components of the rotation;
Angles(1,1)=atan(rotation(1,2)/rotation(1,1)); %yaw;
Angles(2,1)=-asin(rotation(1,3)); %pitch;
Angles(3,1)=atan(rotation(2,3)/rotation(3,3)); %roll;
end

