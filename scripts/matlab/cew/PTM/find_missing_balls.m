clear all; close all;

addpath(genpath('functions'));

mod_ncfile = 'I:\GCLOUD\Testsv2\Chowilla\Output\run_PTM.nc';

[data,x,y,z] = tfv_readPTM(mod_ncfile);

mod_ncfile = 'I:\GCLOUD\Testsv2\Chowilla_HD\Output\run_PTM.nc';

[data2,x2,y2,z2] = tfv_readPTM(mod_ncfile);


for i = 1:228
    st1(i) = length(find(data.stat(:,i) > 0));
    st2(i) = length(find(data2.stat(:,i) > 0));
end

plot(st1,'r');hold on
plot(st2,'g')