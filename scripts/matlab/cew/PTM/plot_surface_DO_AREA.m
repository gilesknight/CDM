clear all; close all;

addpath(genpath('tuflowfv'));

main_dir = 'D:\Simulations\Fishballs\Carp_v3_RM\Carp\Murray\Archive\';

dirlist = dir(main_dir);

inc = 1;

%bound = shaperead('GIS/LL_Boundary.shp');


for i = 3:length(dirlist)
    
    str = strsplit(dirlist(i).name,'_');
    
    if strcmpi(str{1},'Output') == 1
        flow_fac(inc) = str2num(str{2});
        aed_fac(inc) = str2num(str{3});
        
        load([main_dir,dirlist(i).name,'/proc.mat']);
        
            
        tot_area = 0;
        
        for k = 1:size(area,1)
            if sum(area2(k,:)) > 0
                tot_area = tot_area + data.cell_A(k);
            end
        end
        total_area(inc) = (tot_area / sum(data.cell_A)) * 100;
        inc = inc + 1;
        
        
    end
end
        

[xx,yy] = meshgrid([min(aed_fac):0.01:max(aed_fac)],[min(flow_fac):0.01:max(flow_fac)]);

f = scatteredInterpolant(aed_fac',flow_fac',total_area','linear');

zz = f(xx,yy);

surf(xx,yy,zz,'edgecolor','none')

xlabel('AED Factor');
ylabel('Flow Factor');
zlabel('Area % < 2mg/L');


