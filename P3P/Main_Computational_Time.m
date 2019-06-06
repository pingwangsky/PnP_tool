% Author :  Ping Wang                                                        
% Contact:  pingwangsky@gmail.com  or  randolphingwp@163.com 
% This programe is implemented in matlab 2016A
% License:  Copyright (c) 2016 Ping Wang, NUAA, All rights reserved       
% Address:  Nanjing University of Aeronautics and Astronautics              
% My site:  http://pingwang.sxl.cn/  

clear;
clc;
close all;
addpath C++data;

Kneip=load('Kneip.txt');
Gao=load('Gao.txt');
Li=load('Li.txt');
Wang_EP3P =load('Wang_EP3P.txt');

name1={'Gao','Li'};
name2={'Kneip','Wang'};

figure(1);
set(gcf, 'position', [100 200 500 500]);
box on;
[x1,y1]=hist(Gao,17);
[x2,y2]=hist(Li,17);
bar(y1,x1,'r');
hold on;
bar(y2,x2);
colormap([0,0.7,0]);
set(gca,'FontSize',14);
xlabel('Execution Time (s)');
ylabel('Number of Counts');
axis([1.2e-5,1.5e-5,0,1400]);
legend(name1);

figure(2);
set(gcf, 'position', [700 200 500 500]);
box on;
[x3,y3]=hist(Kneip,8);
[x4,y4]=hist(Wang_EP3P,8);
bar(y3,x3,'b');
hold on;
bar(y4,x4);
colormap([1,0.5,0.1]);
set(gca,'FontSize',14);
xlabel('Execution Time (s)');
ylabel('Number of Counts');
axis([2.5e-6,4.4e-6,0,1600]);
legend(name2);
