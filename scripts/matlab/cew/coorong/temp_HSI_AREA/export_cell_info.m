clear all; close all;
addpath(genpath('tuflowfv'));

geofile = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_1_SC40_Needles\Input\log\coorong_geo.nc';


data = tfv_readnetcdf(geofile);

fid = fopen('D:\Cloud\Dropbox\Data_Lowerlakes\Grid Processing\012_Coorong_Salt_Crk_Mouth_Channel_MZ3_Culverts_IDS.csv','wt');

fprintf(fid,'x,y,id,z\n');

for i = 1:length(data.cell_Zb)
    fprintf(fid,'%8.4f,%8.4f,%d,%4.4f\n',...
        data.cell_ctrd(1,i),data.cell_ctrd(2,i),i,data.cell_Zb(i));
end

fclose(fid);
