clear all; close all;

addpath(genpath('tuflowfv'));

main_dir = 'I:\Simulations\Lowerlakes\Carp_PTM\Lowerlakes\Archive\';

dirlist = dir(main_dir);

% bound = shaperead('GIS/LL_Boundary.shp');

for i = 3:length(dirlist)
    
    str = strsplit(dirlist(i).name,'_');
    
    if strcmpi(str{1},'Output') == 1
        if exist([main_dir,dirlist(i).name,'/run.nc'],'file')
            
            data = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D';'WQ_OXY_OXY';'cell_A';'cell_X';'cell_Y'});
            
            dat = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'time',1);
            tdate = dat.Time;
            
            data.WQ_OXY_OXY = data.WQ_OXY_OXY * 32/1000;
            
            area(1:size(data.WQ_OXY_OXY,1),1:length(tdate)) = 0;
            area2(1:size(data.WQ_OXY_OXY,1),1:length(tdate)) = 0;
%             inpol = inpolygon(data.cell_X,data.cell_Y,bound.X,bound.Y);

            for k = 1:length(tdate)
                
                sss = find(data.WQ_OXY_OXY(:,k) < 4 & data.D(:,k) > 0.05);
                
                area(sss,k) = 1;
                ttt = find(data.WQ_OXY_OXY(:,k) < 2 & data.D(:,k) > 0.05);
                
                area2(ttt,k) = 1;   
                
                
                area(:,k) = 0;
                area2(:,k) = 0;
                
            end
            
            
            save([main_dir,dirlist(i).name,'/proc.mat'],'area','area2','data','tdate','-mat');
            
        end
    end
end