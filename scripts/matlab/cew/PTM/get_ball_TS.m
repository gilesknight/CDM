function [sx,sy,sz,stat] = get_ball_TS(ncfile,timestep,data,x,y,z)



    dat = tfv_readnetcdf(ncfile,'timestep',timestep);
    
    stat = dat.stat;
    
    dat.x = double(dat.x);
    dat.y = double(dat.y);
    dat.z = double(dat.z);
    
    init_x = 368823.0;
    init_y = 6180880.0;
    
    x_offset = x.add_offset;
    y_offset = y.add_offset;
    z_offset = z.add_offset;

    x_fillvalue = x.fill_value;
    y_fillvalue = y.fill_value;
    z_fillvalue = z.fill_value;

    dat.x(dat.x == x_fillvalue) = NaN;
    dat.y(dat.y == y_fillvalue) = NaN;

    x_scalevalue = x.scale_factor;
    y_scalevalue = y.scale_factor;
    z_scalevalue = z.scale_factor;

    xx = (dat.x .*x_scalevalue)+  x_offset;%  ;
    yy = (dat.y .*y_scalevalue) + y_offset;% ;
    zz = (dat.z .*z_scalevalue) + z_offset;%  ;
    
    
    sx_1 = xx(:);
    sy_1 = yy(:);
    sz_1 = zz(:);
    
    %inpol = inpolygon(sx,sy,shp.X,shp.Y);
    
    ss = find(dat.stat > 0);
    
    sx = sx_1(ss);
    sy = sy_1(ss);
    sz = sz_1(ss);