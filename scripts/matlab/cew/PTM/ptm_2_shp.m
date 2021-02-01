clear all; close all;

addpath(genpath('functions'));

ptmfile = 'I:\DRR_TUFLOW_v5\Output_PTM\drr_swan2_ptm.nc';

%stat = ncread(ptmfile,'stat');

[data,x,y,z] = tfv_readPTM(ptmfile);

shp = shaperead('Maps/DRR_Basin.shp');
inc = 1;
do_inpol = 1;
for i = 1323:1:2000%:length(data.mdate)

    [sx,sy,sz,stat] = get_ball_TS(ptmfile,i,data,x,y,z);
    if do_inpol
        inpol = inpolygon(sx,sy,shp.X,shp.Y);
        do_inpol = 0;
    end
    for j = 1:length(inpol)
        if inpol(j) == 1
            S(inc).ID = j;
            S(inc).X = sx(j);
            S(inc).Y = sy(j);
            S(inc).Z = sz(j);
            S(inc).Geometry = 'Point';
            S(inc).time = [datestr(data.mdate(i),'yyyy/mm/dd HH:MM'),':00'];
            inc = inc + 1;
        end
    end
    
end

shapewrite(S,'Maps/scatter_1h.shp')
