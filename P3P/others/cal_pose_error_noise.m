% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/  

function [res_out,position_error,rotation_error]=cal_pose_error(res,R,t)
%找误差最小的值作为最终的结果并且输入
min_error=inf;
for i=1:length(res)
    temp=norm(res{i}.R-R,2);
    if temp<min_error
        min_error=temp;
        res_out.R=res{i}.R;
        res_out.t=res{i}.T;
    end
end 
rotation_error=norm(res_out.R-R,2);
position_error=norm(res_out.t-t,2);

end