function data = tfv_find_polygon_IDS(shpfile,ncfile)

raw = tfv_readnetcdf(ncfile,'timestep',1);
clear functions

shp = shaperead(shpfile);



for i = 1:length(shp)
    inpol = inpolygon(raw.cell_X,raw.cell_Y,shp(i).X,shp(i).Y);
    
    sss = find(inpol == 1);
    
    data(i).Cell_3D_IDs = sss;
end