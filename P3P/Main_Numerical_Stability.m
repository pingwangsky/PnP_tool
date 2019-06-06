% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/   

 
%clear all;
close all;
clc;
clear;
addpath methods;
addpath others;

%setting camera paramaters;
noise=0;

%------------------------Algorithms comparison--------------------
%the total iterative numbers of algorithms;
N=100000;
A= zeros(N,1);
name={'Gao','Li','Kneip','Wang'};
f= { @P3P_Gao, @P3P_Li, @P3P_Kneip, @P3P_Wang};
color= {'r',[0,0.7,0],'b',[1,0.5,0.1]};

method_list= struct('name', name, 'f', f, 'r', A, 't', A,...
    'color', color);

counter=0;
for i=1:N
    % generating experiment data;
    [Xw,xn,R,t]=genP3Pdata(noise);
    
    for k=1:length(method_list)
        try
            res= method_list(k).f(Xw,xn);
        catch
            fprintf(['   The solver - ',method_list(k).name,' - encounters internal errors! \n']);
            break;
        end      
        [res_out,position_error,rotation_error]=cal_pose_error_noise(res,R,t);
       method_list(k).r(i)= rotation_error; 
       method_list(k).t(i)= position_error;
    end
    
    counter = counter + 1;
    if counter == 1000
        counter = 0;
        display(['Iteration ' num2str(i) ' of ' num2str(N)]);
    end

end

disp('------------Mean errors------------')
%the mean error of each algorithm;
for k=1:length(method_list)
    disp(method_list(k).name);
    disp('Rotation Error (rad)');
    disp(mean(method_list(k).r));
    disp(' Translation Error (m) ');
    disp(mean(method_list(k).t));
end

for k= 1:length(method_list)
    method_list(k).r(method_list(k).r==0) = [];
    method_list(k).t(method_list(k).t==0) = [];
end

figure(1);
set(gcf, 'position', [100 200 500 500]);
box on;
hold on;
for k=1:length(method_list)
    [h1,b1] = hist(log10(method_list(k).r),20);
    plot(b1,h1,'color',method_list(k).color,'LineWidth',2.5); 
end
set(gca,'FontSize',14);
xlabel('Log_{10} Absolute Rotation Error');
ylabel('Number of Counts');
legend(name);

figure(2);
set(gcf, 'position', [700 200 500 500]);
box on;
hold on;
for k=1:length(method_list)
    [h2,b2] = hist(log10(method_list(k).t),20);
    plot(b2,h2,'color',method_list(k).color,'LineWidth',2.5);    
end
set(gca,'FontSize',14);
xlabel('Log_{10} Absolute Translation Error');
ylabel('Number of Counts');
legend(name);


