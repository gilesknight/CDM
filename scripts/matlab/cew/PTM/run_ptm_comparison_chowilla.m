clear all; close all;

addpath(genpath('functions'));




[nDep_nEro.ptm_data,nDep_nEro.x,nDep_nEro.y,nDep_nEro.z] = tfv_readPTM('I:\GCLOUD\Chowilla Tests\Chow_nDep_00_nEro_nAED\Output\run_ptm.nc');

[yDep05_nEro.ptm_data,yDep05_nEro.x,yDep05_nEro.y,yDep05_nEro.z] = tfv_readPTM('I:\GCLOUD\Chowilla Tests\Chow_yDep_05_nEro_nAED\Output\run_ptm.nc');

[yDep02_yEro.ptm_data,yDep02_yEro.x,yDep02_yEro.y,yDep02_yEro.z] = tfv_readPTM('I:\GCLOUD\Chowilla Tests\Chow_yDep_02_Ero_nAED\Output\run_ptm_bak.nc');

[yDep05_yEro.ptm_data,yDep05_yEro.x,yDep05_yEro.y,yDep05_yEro.z] = tfv_readPTM('I:\GCLOUD\Chowilla Tests\Chow_yDep_02_Ero_nAED\Output\run_ptm.nc');


[yDep02_1kg_yEro.ptm_data,yDep02_1kg_yEro.x,yDep02_1kg_yEro.y,yDep02_1kg_yEro.z] = tfv_readPTM('I:\GCLOUD\Chowilla Tests\Chow_yDep_02_Ero_nAED_1kg\Output\run_ptm.nc');


figure('position',[151          243.666666666667          2218.66666666667          1074.66666666667]);


subplot(2,2,1)

scatter(nDep_nEro.ptm_data.x_raw(:),nDep_nEro.ptm_data.y_raw(:),'.r');hold on

xlim([479123.989218329           480336.92722372]);
ylim([6220250          6222613.63636364]);

title('no Dep, no Ero');

subplot(2,2,2)

scatter(yDep05_nEro.ptm_data.x_raw(:),yDep05_nEro.ptm_data.y_raw(:),'.r');hold on
xlim([479123.989218329           480336.92722372]);
ylim([6220250          6222613.63636364]);
title('Dep 0.5, no Ero');
subplot(2,2,3)

scatter(yDep05_yEro.ptm_data.x_raw(:),yDep05_yEro.ptm_data.y_raw(:),'.r');hold on
xlim([479123.989218329           480336.92722372]);
ylim([6220250          6222613.63636364]);
title('Dep 0.5, yes Ero');
subplot(2,2,4)

scatter(yDep02_yEro.ptm_data.x_raw(:),yDep02_yEro.ptm_data.y_raw(:),'.r');hold on
xlim([479123.989218329           480336.92722372]);
ylim([6220250          6222613.63636364]);
title('Dep 0.2, yes Ero');

