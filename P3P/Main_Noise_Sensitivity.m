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
% warning off;

%setting camera paramaters;

%The repetitive numbers to per noise level;
iterations=2000;
%The maximum noise to analyze
max_noise=5;
%The step in between dirrerent noise levels;
noise_step=0.1;
%prepare the overall result arrays
number_noise_levels=max_noise/noise_step + 1;

noise_levels=zeros(1,number_noise_levels);
%------------------------Algorithms comparison--------------------
A= zeros(3,number_noise_levels);
B= zeros(3,iterations);

name= {'Gao','Li','Kneip', 'Wang'};
f= { @P3P_Gao, @P3P_Li, @P3P_Kneip, @P3P_Wang};
color= {'r',[0,0.7,0],'b',[1,0.5,0.1]};

method_list= struct('name', name, 'f', f, 'mean_r', A, 'mean_t', A, 'std_r', A, 'std_t', A,...
                    'r', B, 't', B, 'color', color);

%beging;
for n=1:number_noise_levels
    noise=(n-1)*noise_step;
    noise_levels(n)=noise;
    display(['Analyzing noise level: ',num2str(noise)]);   
    
    for i=1:iterations
        %generating experiment data;
        [Xw,xn,R,t]=genP3Pdata(noise);
        for k=1:length(method_list)
            try
                res= method_list(k).f(Xw,xn);
            catch
                fprintf(['    The solver - ',method_list(k).name,' - encounters internal errors! \n']);
                break;
            end
            %Calculation errors;
            [res_out,position_error,rotation_error]=pose_error(res,R,t);
            method_list(k).r(:,i)= rotation_error; 
            method_list(k).t(:,i)= position_error;
        end               
        showpercent(i,iterations);
    end
    %Now compute the mean and std. value of the error for each algorithm;
    for k=1:length(method_list)
        method_list(k).mean_r(:,n)=mean(method_list(k).r,2);
        method_list(k).mean_t(:,n)=mean(method_list(k).t,2);
        method_list(k).std_r(:,n)= std(method_list(k).r,1,2);
        method_list(k).std_t(:,n)= std(method_list(k).t,1,2);
    end
    fprintf('\n');
end

% %show the results
figure(1);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).mean_r(1,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Yaw Angle Error Mean (Rad)');
legend(name,'Location','NorthWest');

figure(2);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).mean_r(2,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Pitch Angle Error Mean (Rad)');
legend(name,'Location','NorthWest');

figure(3);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).mean_r(3,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Roll Angle Error Mean (Rad)');
legend(name,'Location','NorthWest');

figure(4);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).mean_t(1,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('X Error Mean (m)');
legend(name,'Location','NorthWest');

figure(5);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).mean_t(2,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Y Error Mean (m)');
legend(name,'Location','NorthWest');

figure(6);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).mean_t(3,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Z Error Mean (m)');
legend(name,'Location','NorthWest');

figure(7);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).std_r(1,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Yaw Angle Error Std. Dev. (Rad)');
legend(name,'Location','NorthWest');

figure(8);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).std_r(2,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Pitch Angle Error Std. Dev. (Rad)');
legend(name,'Location','NorthWest');

figure(9);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).std_r(3,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Roll Angle Error Std. Dev. (Rad)');
legend(name,'Location','NorthWest');

figure(10);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).std_t(1,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('X Error Std. Dev. (m)');
legend(name,'Location','NorthWest');

figure(11);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).std_t(2,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Y Error Std. Dev. (m)');
legend(name,'Location','NorthWest');

figure(12);
hold on;box on;
for k=1:length(method_list)
    plot(noise_levels,method_list(k).std_t(3,:),'color',method_list(k).color,'LineWidth',2);    
end
set(gca,'FontSize',12);
xlabel('Noise Level (Pixel)');ylabel('Z Error Std. Dev. (m)');
legend(name,'Location','NorthWest');

