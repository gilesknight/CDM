clear all; close all;

addpath(genpath('functions'));

mod_ncfile = 'I:\GCLOUD\Testsv2\Chowilla\Output\run.nc';

data = tfv_readnetcdf(mod_ncfile);


dat = tfv_readnetcdf(mod_ncfile,'time',1);
time = dat.Time;


V = sqrt(power(data.V_x,2) + power(data.V_y,2));

cell_id = 30561;


subplot(2,3,1)

plot(time,data.D(cell_id,:));
datetick('x','dd');

title('Depth');

subplot(2,3,2)

plot(time,V(cell_id,:));
datetick('x','dd');

title('V');


subplot(2,3,3)

plot(time,data.WQ_OXY_OXY(cell_id,:));
datetick('x','dd');

title('Oxy');


subplot(2,3,4)

plot(time,data.WQ_DIAG_PTM_OXY_FLUX(cell_id,:));
datetick('x','dd');

title('Oxy PTM Flux');

subplot(2,3,5)

plot(time,data.WQ_DIAG_PTM_TOTAL_MASS(cell_id,:));
datetick('x','dd');

title('PTM Mass');

subplot(2,3,6)

plot(time,data.WQ_DIAG_PTM_TOTAL_COUNT(cell_id,:));
datetick('x','dd');

title('PTM Count');





