clc
clear all

% shp_file = 'C:\Data\Matlab_Work\Development_GF\Shapefiles\pv_subset.shp';
% out_file = 'C:\Data\Matlab_Work\Development_GF\Shapefiles\pv_subset_merged.shp';

shp_file = 'C:\Data\Temp\Chile\Chile_shapefile_shp\bio_regions.shp';
out_file = 'C:\Data\Temp\Chile\diss\chile_bioregions_merged.shp';




si = shapeinfo(shp_file);
shapefile_attribs = {si.Attributes(:).Name};
disp(shapefile_attribs);

% merge_field = 'AREA_TYPE';
merge_field = 'NOM_REG';  % test for Chile data


s = shaperead(shp_file);

all_field_vals = {s(:).(merge_field)};
unique_field_vals = unique(all_field_vals);

w = waitbar(0,'Processing');
c=1;
for k=1:numel(unique_field_vals)
   idx = find(ismember(all_field_vals, unique_field_vals{k}));
   x = s(idx(1)).X;
   y = s(idx(1)).Y;
   for i=2:numel(idx)
       [x,y] = polybool('union',x,y,s(idx(i)).X,s(idx(i)).Y);
   end
   
   s2(c).X = x;
   s2(c).Y = y;
   s2(c).Geometry = s(idx(1)).Geometry;
   s2(c).(merge_field) = s(idx(1)).(merge_field);
   c=c+1;
   waitbar(k/numel(unique_field_vals),w);
   drawnow
end

% Create output Shapefile
shapewrite(s2,out_file);

% copy across projection file
[p,f,e] = fileparts(shp_file);
prj_in = fullfile(p,[f '.prj']);

[p,f,e] = fileparts(out_file);
prj_out = fullfile(p,[f '.prj']);
if exist(prj_in,'file')
    copyfile(prj_in,prj_out);
end

delete(w);
drawnow