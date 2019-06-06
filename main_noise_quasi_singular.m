close all;
clc;
clear;

addpath others;
addpath epnp;
addpath lhm;
addpath RPnP;
addpath SRPnP;
addpath OPnP;

% experimental parameters
nl= 2;
npts= 4:1:20;
num= 500;

% compared methods
A= zeros(size(npts));
B= zeros(num,1);

name= {'LHM', 'EPnP+GN', 'RPnP', 'DLS', 'OPnP','SRPnP'};
f= {@LHM, @EPnP_GN, @RPnP, @dls_pnp_all,@OPnP,@SRPnP};
marker= {'+', 'o', 'd', '^', 's', '*',};
color= {'m','g','b','c','k',[1,0.502,0]};
markerfacecolor=  {'m','n','n','n','n',[1,0.502,0]};
linestyle= {'-','-','-','-','-','-'};

method_list= struct('name', name, 'f', f, 'mean_r', A, 'mean_t', A,...
    'med_r', A, 'med_t', A, 'std_r', A, 'std_t', A, 'r', B, 't', B,...
    'marker', marker, 'color', color, 'markerfacecolor', markerfacecolor, 'linestyle', linestyle);

% experiments
for i= 1:length(npts)
    
    npt= npts(i);
    fprintf('npt = %d: ',npt);
    
    for k= 1:length(method_list)
        method_list(k).r = zeros(1,num);
        method_list(k).t = zeros(1,num);
    end
    
    index_fail = [];
    
    for j= 1:num
        
        % camera's parameters
        width= 640;
        height= 480;
        f= 800;
        
        % generate 3d coordinates in camera space
        Xc= [xrand(1,npt,[1 2]); xrand(1,npt,[1 2]); xrand(1,npt,[4 8])];
        t= mean(Xc,2);
        R= rodrigues(randn(3,1));
        XXw= inv(R)*(Xc-repmat(t,1,npt));
        
        % projection
        xx= [Xc(1,:)./Xc(3,:); Xc(2,:)./Xc(3,:)]*f;
        xxn= xx+randn(2,npt)*nl;

         % pose estimation
         for k= 1:length(method_list)
                try
                    [R1,t1]= method_list(k).f(XXw,xxn/f);
                catch
                    fprintf(['    The solver - ',method_list(k).name,' - encounters internal errors! \n']);
                    index_fail = [index_fail, j];
                    break;
                end
     
            
            %no solution
            if size(t1,2) < 1
                fprintf(['    The solver - ',method_list(k).name,' - returns no solution! \n']);
                index_fail = [index_fail, j];
                break;
            end
            %choose the solution with smallest error 
            error = inf;
            for jjj = 1:size(R1,3)
                tempy = cal_pose_err([R1(:,:,jjj) t1(:,jjj)],[R t]);
                if sum(tempy) < error
                    y = tempy;
                    error = sum(tempy);
                end
            end
            
            if strcmp(method_list(k).name,'OPnP') && error > 30
                txt = 1;
            end
            
            method_list(k).r(j)= y(1);
            method_list(k).t(j)= y(2);
        end

        showpercent(j,num);
    end
    fprintf('\n');
    
    % save result
    for k= 1:length(method_list)
        method_list(k).r(index_fail) = [];
        method_list(k).t(index_fail) = [];
        
        method_list(k).mean_r(i)= mean(method_list(k).r);
        method_list(k).mean_t(i)= mean(method_list(k).t);
        method_list(k).med_r(i)= median(method_list(k).r);
        method_list(k).med_t(i)= median(method_list(k).t);
        method_list(k).std_r(i)= std(method_list(k).r);
        method_list(k).std_t(i)= std(method_list(k).t);
    end
end


yrange= [0 3];

i= 0; w= 400; h= 300;

figure('color','w','position',[w*i,100,w,h]);i=i+1;
xdrawgraph(npts,yrange,method_list,'mean_r','Mean Rotation Error',...
    'Number of Points','Rotation Error (degrees)');

figure('color','w','position',[w*i,100,w,h]);i=i+1;
xdrawgraph(npts,yrange,method_list,'med_r','Median Rotation Error',...
    'Number of Points','Rotation Error (degrees)');

figure('color','w','position',[w*i,100,w,h]);i=i+1;
xdrawgraph(npts,yrange,method_list,'mean_t','Mean Translation Error',...
    'Number of Points','Translation Error (%)');

figure('color','w','position',[w*i,100,w,h]);i=i+1;
xdrawgraph(npts,yrange,method_list,'med_t','Median Translation Error',...
    'Number of Points','Translation Error (%)');

