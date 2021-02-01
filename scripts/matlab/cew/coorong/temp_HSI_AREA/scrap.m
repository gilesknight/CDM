addpath(genpath('tuflowfv'));

filename = 'E:/lower_lakes.nc';

data = ncread(filename,'WQ_OXY_OXY');%(filename,'names',{'WQ_OXY_OXY'});


