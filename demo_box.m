addpath data
addpath OPnP
addpath SRPnP;

%load data 
load model_box

%inliers-3D points
U = model_box.fpoint(1:3,(model_box.mask>0));

%inliers-2D points
u = model_box.fpoint(6:7,(model_box.mask>0));

%normalize 2D points
uu = model_box.KK\[u;ones(1,size(u,2))];
uu = uu(1:2,:);

%estimate camera pose using SRPnP
[R t] = SRPnP1(U,uu);

R = R(:,:,1); t = t(:,1);
%calculate the projection of vertices
v2d_i = model_box.KK*(R*model_box.Vertex3D+t*ones(1,8));
v2d_i = v2d_i./repmat(v2d_i(end,:),3,1);
v2d_i = v2d_i(1:2,:);

%calculatae the projection of all inliers
p2d_i = model_box.KK*(R*U+t*ones(1,size(U,2)));
p2d_i = p2d_i./repmat(p2d_i(end,:),3,1);
p2d_i = p2d_i(1:2,:);

%draw image
ShowReferenceImage(model_box.templateimage,model_box.Vertex2D);
ShowInputImage(model_box.inputimage,v2d_i,model_box.fpoint(6:7,:),model_box.mask,p2d_i);

rmpath data;
rmpath OPnP;