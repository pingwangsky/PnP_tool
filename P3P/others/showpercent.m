% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/  

function showpercent(i,n)

global spi;

curi= floor(i/n*100);

if i == 1 | isempty(spi)
    spi= curi;
    fprintf(1,'%2d%%',spi);
    return;
end

if spi < curi
    spi= curi;
    fprintf(1,'\b\b\b%2d%%',spi);
end

return
