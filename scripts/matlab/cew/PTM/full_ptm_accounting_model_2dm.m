clear all; close all;

addpath(genpath('functions'));

outdir = 'PTM Accounting/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

  ptm = import_PTM_BC_Files('E:\Github 2018\Carp_PTM\Chowilla\Input\PTM\1\PTM\');
  save([outdir,'Chowilla.mat'],'ptm','-mat');
% load([outdir,'Moonie.mat']);

shp = shaperead('E:\Github 2018\Carp_PTM\Chowilla\Input\PTM\1\points.shp');

[XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT] = tfv_get_node_from_2dm('E:\Github 2018\Carp_PTM\Chowilla\Geo\Chowilla_v1_Hi_Res_MZ_Biomass.2dm');

mod_ncfile = 'I:\GCLOUD\PTM_Results_v3\Chowilla\Output_1_1\run.nc';

data = tfv_readnetcdf(mod_ncfile,'names',{'D';'WQ_DIAG_PTM_TOTAL_MASS';'WQ_DIAG_PTM_TOTAL_COUNT';'V_x';'V_y';'cell_A';'cell_X';'cell_Y'});
dat = tfv_readnetcdf(mod_ncfile,'time',1);
time = dat.Time;

geo_x = double(X);
geo_y = double(Y);
dtri = DelaunayTri(geo_x,geo_y);

[~,ind] = min(abs(time - datenum(2016,04,07)));


depth = find(data.D(:,ind) > 0.1);

for i = 1:size(ptm.Balls,1)
    
    tt = find(ptm.filename == i);
    
    cell.BM(i) = sum(ptm.Balls(tt,:));
    
    pnt(1,1) = shp(i).X;
    pnt(1,2) = shp(i).Y;
    
    

    
    
    
    pt_id = nearestNeighbor(dtri,pnt);
    
    cell.Mat(i) = MAT(pt_id);
    
    ff = find(depth == pt_id);
    
    if ~isempty(ff)
        cell.BM_Wet(i) = cell.BM(i);
    else
        cell.BM_Wet(i) = 0;
    end
    
    
end
  

u_zones = unique(cell.Mat);





for i = 1:length(u_zones)
    
    
    
    sss = find(cell.Mat == u_zones(i));
    
    ttt = find(MAT == u_zones(i));
    
    tvt = find(MAT(depth) == u_zones(i));
    
    zone.BM(i) = sum(cell.BM(sss));
    zone.BM_Wet(i) = sum(cell.BM_Wet(sss));
    
    zone.Area(i) = sum(data.cell_A(ttt))/ 10000;
    zone.Wet_Area(i) = sum(data.cell_A(depth(tvt)))/ 10000;
    
end

zone.kg = zone.BM ./ zone.Area;

zone.kgwet_A = zone.BM ./ zone.Wet_Area;

zone.kgwet = zone.BM_Wet ./ zone.Wet_Area;


save([outdir,'Chowilla_Zone.mat'],'zone','-mat');
    
    
    




