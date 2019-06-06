close all;
clc;
clear;
addpath others;
addpath epnp;
addpath lhm;
addpath RPnP;
addpath SRPnP;
addpath OPnP;
addpath SPnP;
addpath dls_pnp_matlab;

% experimental parameters
ntest= 1000;
nl= 2;
npts= 4:4:104;

name= {'LHM', 'EPnP+GN', 'RPnP', 'DLS', 'OPnP','SRPnP'};
f= {@LHM, @EPnP_GN, @RPnP, @dls_pnp_all,@OPnP,@SRPnP};
marker= {'+', 'o', 'd', '^', 's', '*',};
color= {'m','g','b','c','k',[1,0.502,0]};
markerfacecolor=  {'m','n','n','n','n',[1,0.502,0]};
linestyle= {'-','-','-','-','-','-'};


method_list= struct('name', name, 'f', f, 't', zeros(size(npts)),...
    'marker', marker, 'color', color, 'markerfacecolor', markerfacecolor);


% camera's parameters
width= 640;
height= 480;
f= 800;

for j= 1:length(npts)
    npt= npts(j);
    fprintf('%d points\n',npt);
    
    % generate experimental data
    para= cell(ntest,2);
    for i= 1:ntest
        % generate 3d coordinates in camera space
        Xc= [xrand(1,npt,[-2 2]); xrand(1,npt,[-2 2]); xrand(1,npt,[4 8])];
        t= mean(Xc,2);
        R= rodrigues(randn(3,1));
        XXw= inv(R)*(Xc-repmat(t,1,npt));
        
        % projection
        xx= [Xc(1,:)./Xc(3,:); Xc(2,:)./Xc(3,:)]*f;
        xxn= xx+randn(2,npt)*nl;
		xxn= xxn/f;
        % save
        para{i,1}= XXw;
        para{i,2}= xxn;
    end

    for k= 1:length(method_list)
        tic;
        for i= 1:ntest
            XXw= para{i,1};
            xxn= para{i,2};
            method_list(k).f(XXw,xxn);
        end
        t= toc; method_list(k).t(j)= t/ntest*1000;
        disp([method_list(k).name ' - ' num2str(t) ' s']);
    end


end
close all;

figure('color','w');
hold all;
box on;
p= zeros(size(method_list));
for k= 1:length(method_list)
    p(k)= plot(npts,method_list(k).t,'color',method_list(k).color,...
        'marker',method_list(k).marker,...
        'markerfacecolor',method_list(k).markerfacecolor,...
        'displayname',method_list(k).name,'LineWidth',2);
end
%legend(p,2,'Location','NorthWest');
legend(method_list.name,'Location','NorthWest');
xlim(npts([1,end]));
%axis([4,100,0,20]);

xtick= 4:12:104;
set(gca,'xtick',xtick);

xlabel('点的数目','FontSize',14);
ylabel('运行时间 (ms)','FontSize',14);
% xlabel('Number of Points','FontSize',12);
% ylabel('Computational Time (milliseconds)','FontSize',12);


