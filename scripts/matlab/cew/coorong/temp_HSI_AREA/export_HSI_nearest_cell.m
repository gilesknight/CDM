clear all; close all;

addpath(genpath('tuflowfv'));

data = tfv_readnetcdf('I:\Lowerlakes\Coorong Weir Simulations\012_ORH_2014_2016_1\Output\coorong.nc','timestep',1);


Cell_X = data.cell_X;
Cell_Y = data.cell_Y;

vert(:,1) = data.node_X;
vert(:,2) = data.node_Y;

faces = data.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

% Will be changed once the updated files have been processed.
scenarios = {...
    '012_ORH_2014_2016_1',...
    %'009_Ruppia_2016_2017_Matt',...
    };

[snum,sstr] = xlsread('D:\Cloud\Dropbox\Data_Lowerlakes\Ruppia 2016 data.xlsx','summary 12-15 Dec','A2:G25');

lat = snum(:,1);
lon = snum(:,2);
site = sstr(:,1);
field = sstr(:,end);

hfig = figure('visible','on','position',[304         166        1271         812]);




for i = 1:length(scenarios)
    
    
    outfile = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\',scenarios{i},'_Field_Model.csv'];
    
    fid = fopen(outfile,'wt');
    
    fprintf(fid,'Site Name,Ruppia from Field,2016 Sexual,2015 Flower,2016 Seed,2016 Adult\n');
    
    
    if exist(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\2016\HSI_sexual.mat'],'file')
        
        load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\2016\HSI_sexual.mat']);
        
        Sexual = min_cdata; clear min_cdata;
        
        load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\2015\2_flower_new\HSI_flower.mat']);
        
        Flower = min_cdata; clear min_cdata;
        
        load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\2016\3_seed_new\HSI_seed.mat']);
        
        Seed = min_cdata; clear min_cdata;
        
        load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\2016\1_adult_new\HSI_adult.mat']);
        
        Adult = min_cdata; clear min_cdata;
        
    else
        stop;
    end
    
    patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',Adult);shading flat
    set(gca,'box','on');
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    hold on
    
    
    
    for j = 1:length(lat)
        [X(j),Y(j)] = ll2utm(lon(j,1),lat(j));
        
        pnt(:,1) = X(j);
        pnt(:,2) = Y(j);
        
        geo_x = double(Cell_X);
        geo_y = double(Cell_Y);
        dtri = DelaunayTri(geo_x,geo_y);
        
        pt_id = nearestNeighbor(dtri,pnt);
        
        HSI = Sexual(pt_id);
        F = Flower(pt_id);
        S = Seed(pt_id);
        A = Adult(pt_id);
        
        fprintf(fid,'%s,%s,%3.3f,%3.3f,%3.3f,%3.3f\n',site{j},field{j},HSI,F,S,A);
        
        scatter(X(j),Y(j),'*r');hold on
        scatter(Cell_X(pt_id),Cell_Y(pt_id),'ok');
        
        if strcmpi(field{j},'Y') == 1
            
            text(X(j),Y(j),site{j},'color','r');
        else
            text(X(j),Y(j),site{j},'color','k');
        end
        
    end
end

fclose(fid);















