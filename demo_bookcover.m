%addpath 
addpath data
addpath OPnP
addpath SRPnP;

%load data 
load model_bookcover

%inliers-3D points
U = model_bookcover.fpoint(1:3,(model_bookcover.mask>0));

%inliers-2D points
u = model_bookcover.fpoint(6:7,(model_bookcover.mask>0));

%normalize 2D points
uu = model_bookcover.K\[u;ones(1,size(u,2))];
uu = uu(1:2,:);

%estimate camera pose using SRPnP
% [R t] = OPnP(U,uu);
[R t] = SRPnP1(U,uu);

for i = 1:size(t,2)
%calculate the projection of vertices
v2d_i = model_bookcover.K*(R(:,:,i)*model_bookcover.templateV3D+t(:,i)*ones(1,4));
v2d_i = v2d_i./repmat(v2d_i(end,:),3,1);
v2d_i = v2d_i(1:2,:);

%calculatae the projection of all inliers
p2d_i = model_bookcover.K*(R(:,:,i)*U+t(:,i)*ones(1,size(U,2)));
p2d_i = p2d_i./repmat(p2d_i(end,:),3,1);
p2d_i = p2d_i(1:2,:);

%draw image
ShowReferenceImage(model_bookcover.templateimage,model_bookcover.templateV2D);
ShowInputImage(model_bookcover.inputimage,v2d_i,model_bookcover.fpoint(6:7,:),model_bookcover.mask,p2d_i);

end
rmpath data;
rmpath OPnP;
