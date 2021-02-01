clear all; close all;

addpath(genpath('tuflowfv'));

line = load('GIS/Area.xy');
X = line(:,2);
Y = line(:,3);

% Our 0 point
Mouth(1,1) = 308068.927;
Mouth(1,2) = 6063353.143;

Needles(1,1) = 351138.0;
Needles(1,2) = 6031744.0;

Parnka(1,1) = 355191.0;
Parnka(1,2) = 6025804.0;

Salt(1,1) = 377637.0;
Salt(1,2) = 6000507.0;

shp = shaperead('GIS/Area_Poly.shp');

data = tfv_readnetcdf('I:\Lowerlakes\Coorong Weir Simulations\012_ORH_2014_2016_1\Output\coorong.nc','timestep',1);
data2 = tfv_readnetcdf('I:\Lowerlakes\Coorong Weir Simulations\013_Weir_1_SC40_Needles\Output\coorong.nc','timestep',1);


% Calculate the distances along the line
curt.dist(1:length(X)) = 0;
for ii = 1:length(X)-1
    temp_d = sqrt((X(ii+1)-X(ii)) .^2 + (Y(ii+1) - Y(ii)).^2);
    dist(ii+1,1) = dist(ii,1) + temp_d;
end

% Find the nearest point to our 0 point

geo_x = double(X);
geo_y = double(Y);
dtri = DelaunayTri(geo_x,geo_y);

pt_id = nearestNeighbor(dtri,Mouth);
pt_ID_N = nearestNeighbor(dtri,Needles);
pt_ID_P = nearestNeighbor(dtri,Parnka);
pt_ID_S = nearestNeighbor(dtri,Salt);

Zero_dist = dist(pt_id);
N_dist = dist(pt_ID_N);
P_dist = dist(pt_ID_P);
S_dist = dist(pt_ID_S);

final_dist = dist - Zero_dist;


for i = 1:length(shp)
    % Distance of centroid
    cent(1,1) = shp(i).Centx;
    cent(1,2) = shp(i).Centy;
    pt_id = nearestNeighbor(dtri,cent);
    
    Area(i).Distance = final_dist(pt_id) / 1000;
    
    inpol = inpolygon(data.cell_X,data.cell_Y,shp(i).X,shp(i).Y);
    inpol2 = inpolygon(data2.cell_X,data2.cell_Y,shp(i).X,shp(i).Y);
  
    Area(i).cell_ID1 = inpol; %logical array of 1 & 0;
    Area(i).cell_ID2 = inpol2; %logical array of 1 & 0;

    Area(i).Total_Area1 = sum(data.cell_A(inpol));
    Area(i).Total_Area2 = sum(data2.cell_A(inpol2));

    Area(i).cell_A1 = data.cell_A(inpol);
    Area(i).cell_A2 = data2.cell_A(inpol2);

    Area(i).N = N_dist;
    Area(i).P = P_dist;
    Area(i).S = S_dist;
end

save('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\Area_Information_Weir.mat','Area','-mat');

% scenarios = {...
%     '011_Ruppia_2015_2016_1',...
%     '011_Ruppia_2015_2016_2_B0fin',...
%     '010_Ruppia_2015_2016_3_BTau',...
%     '010_Ruppia_2015_2016_4_BGoo',...
%     '010_Ruppia_2015_2016_5_BL_SC100',...
%     '010_Ruppia_2015_2016_11_lgt',...
%     '010_Ruppia_2015_2016_6_SC0',...
%     '010_Ruppia_2015_2016_7_SC40',...
%     '010_Ruppia_2015_2016_8_SC100',...
%     '010_Ruppia_2015_2016_9_SC40_2Nut',...
%     '010_Ruppia_2015_2016_10_SC40_0_5Nut',...
%     };
% 
% % Create the shapefiles
% 
% vert(:,1) = data.node_X;
% vert(:,2) = data.node_Y;
% 
% faces = data.cell_node';
% 
% %--% Fix the triangles
% faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);
% 
% if ~exist('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\GIS\','dir')
%     mkdir('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\GIS\');
% end
% 
% for i = 1:length(scenarios)
%     
%     if exist(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\HSI_sexual.mat'],'file');
%         
%         load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\HSI_sexual.mat']);
%         
%         filename = regexprep(scenarios{i},'010_Ruppia_2015_2016_','sim_');
%         
%         for j = 1:length(faces)
%             S(j).X = double(vert(faces(j,:),1));
%             S(j).Y = double(vert(faces(j,:),2));
%             S(j).Geometry = 'Polygon';
%             S(j).Z = min_cdata(j);
%         end
%         
%         
%         
%         shapewrite(S,['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\GIS\',filename,'.shp']);
%     end
% end
% 
% load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\3_year_HSI.mat');
% 
% 
% for j = 1:length(faces)
%     S(j).X = double(vert(faces(j,:),1));
%     S(j).Y = double(vert(faces(j,:),2));
%     S(j).Geometry = 'Polygon';
%     S(j).s2014 = hsi.year2014.min_cdata(j);
%     S(j).s2015 = hsi.year2015.min_cdata(j);
%     S(j).s2016 = hsi.year2016.min_cdata(j);
%     
% end
% shapewrite(S,['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\GIS\3_Year.shp']);
