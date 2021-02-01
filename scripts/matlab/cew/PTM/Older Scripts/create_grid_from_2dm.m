function [xStart,yStart,xLength,yLength,xNum,yNum] = create_swan_bathy_from_2dm(filename,cell_size)

if ~exist('Bathymetry/','dir')
    mkdir('Bathymetry/');
end

%[XX,YY,ZZ,nodeID,faces,X,Y,ID] = tfv_get_node_from_2dm(filename);
[XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT] = tfv_get_node_from_2dm(filename);


max_depth = max(ZZ);
min_depth = min(ZZ);

%cell_size = 200;

cell_clip_distance = cell_size;

ZZ = ZZ - max_depth;

%initial_depth = 1022 - max_depth;

xarray = [(min(XX)-1000):cell_size:max(XX)+1000];
yarray = [(min(YY)-1000):cell_size:max(YY)+1000];
[xx,yy] = meshgrid(xarray',yarray');

Fx = scatteredInterpolant(X,Y,MAT','nearest','nearest');

zz = Fx(xx,yy);


%_ Clip the exterior

pnt(:,1) = xx(:);
pnt(:,2) = yy(:);

for i = 1:length(xx)
    inp = 0;
    for j = 1:length(X)
        inpol = inpolygon(pnt(i,1),pnt(i,2),XX(faces(:,j)),YY(faces(:,j)));
        if inpol
            inp = 1;
        end
    end
    if inp == 0
        zz(i) = NaN;
    end
end


% 
% 
% dtri = DelaunayTri(XX,YY);
% 
% pt_id = nearestNeighbor(dtri,pnt);
% 
% for i = 1:length(pt_id)
%     
%     dist = sqrt((XX(pt_id(i))-pnt(i,1)) .^2 + (YY(pt_id(i)) - pnt(i,2)).^2);
%     
%     %dist = sqrt((XX(i)-X(pt_id(i))) .^2 + (YY(i) - Y(pt_id(i))).^2);
%     
%     if abs(dist) > cell_clip_distance
%         zz(i) = NaN;
%     end
% end







xxx = flipud(xx);
yyy = flipud(yy);
zzz = flipud(zz);

pcolor(xxx,yyy,zzz);shading flat;axis xy;hold on
colorbar
scatter(xxx(1,1),yyy(1,1),'*k');

axis equal

%saveas(gcf,'Bathymetry/Bathymetry.png')

zzz(isnan(zzz)) = 999;


save grid.mat xxx yyy zzz -mat;