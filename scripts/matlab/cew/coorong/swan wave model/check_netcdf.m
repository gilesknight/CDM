clear all; close all;

ncfile = 'F:\Coorong SWAN Model v2\out\WAVE.nc';

data = tfv_readnetcdf(ncfile);

mtime = double(datenum(1970,01,01) + (data.time/86400));

shp = shaperead('Files/Bound.shp');

mapshow(shp)

[XX,YY] = meshgrid(data.x,data.y);

pcolor(XX,YY,data.hs(:,:,100)');shading flat;hold on

mapshow(shp,'facecolor','none')

