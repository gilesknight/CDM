clear all; close all;

addpath(genpath('functions'));

mod_ncfile = 'I:\GCLOUD\Testsv2\Chowilla\Output\run.nc';

data = tfv_readnetcdf(mod_ncfile,'names',{'D';'WQ_DIAG_PTM_TOTAL_MASS';'WQ_DIAG_PTM_TOTAL_COUNT';'V_x';'V_y';'cell_A'});


dat = tfv_readnetcdf(mod_ncfile,'time',1);
time = dat.Time;

mod_ncfile = 'I:\GCLOUD\Testsv2\Chowilla_HD\Output\run.nc';

data2 = tfv_readnetcdf(mod_ncfile,'names',{'D';'WQ_DIAG_PTM_TOTAL_MASS';'WQ_DIAG_PTM_TOTAL_COUNT';'V_x';'V_y';'cell_A'});

dat = tfv_readnetcdf(mod_ncfile,'time',1);
time2 = dat.Time;

mod_ncfile = 'I:\GCLOUD\PTM_Results_v2\Chowilla\Output_1_1\run.nc';

data3 = tfv_readnetcdf(mod_ncfile,'names',{'D';'WQ_DIAG_PTM_TOTAL_MASS';'WQ_DIAG_PTM_TOTAL_COUNT';'V_x';'V_y';'cell_A'});

dat = tfv_readnetcdf(mod_ncfile,'time',1);
time3 = dat.Time;


V = sqrt(power(data.V_x,2) + power(data.V_y,2));
V2 = sqrt(power(data2.V_x,2) + power(data2.V_y,2));
V3 = sqrt(power(data3.V_x,2) + power(data3.V_y,2));

for i = 1:length(time)
    
    total_ball(i) = sum(data.WQ_DIAG_PTM_TOTAL_MASS(:,i));
    
    ttt = find(data.D(:,i) >= 0.005);
    
    area = sum(data.cell_A(ttt));
    total_ball(i) = total_ball(i) /(area / 10000)/1000;
    
    sss = find(data.D(ttt,i) <= 0.05);
    total_dry(i) = sum(data.WQ_DIAG_PTM_TOTAL_MASS(ttt(sss),i));
    total_dry(i) = total_dry(i) /(sum(data.cell_A(ttt(sss))) / 10000)/1000;
    
   % stat(i) = length(find(data.stat(:,i) > -1));
    
end
    





for i = 1:length(time2)
    
    total_ball2(i) = sum(data2.WQ_DIAG_PTM_TOTAL_MASS(:,i));
    
    
    ttt = find(data2.D(:,i) >= 0.005);
    
    area2 = sum(data2.cell_A(ttt));
    total_ball2(i) = total_ball2(i) /( area2 / 10000)/1000;
    
    sss = find(data2.D(ttt,i) <= 0.05);
    total_dry2(i) = sum(data2.WQ_DIAG_PTM_TOTAL_MASS(ttt(sss),i));
    total_dry2(i) = total_dry2(i) /( sum(data2.cell_A(ttt(sss))) / 10000)/1000;
    %stat2(i) = length(find(data2.stat(:,i) > -1));
end

for i = 1:length(time3)
    
    total_ball3(i) = sum(data3.WQ_DIAG_PTM_TOTAL_MASS(:,i));
    
        ttt = find(data3.D(:,i) >= 0.005);
    
    area3 = sum(data3.cell_A(ttt));
    total_ball3(i) = total_ball3(i) /( area3 / 10000)/1000;
    
    
    sss = find(data3.D(ttt,i) <= 0.05);
    total_dry3(i) = sum(data3.WQ_DIAG_PTM_TOTAL_MASS(ttt(sss),i));
    total_dry3(i) = total_dry3(i) / (sum(data3.cell_A(ttt(sss))) / 10000)/1000;
    %stat3(i) = length(find(data3.stat(:,i) > -1));
end


plot(time,total_ball,'r');
hold on
plot(time,total_dry,'--r');
plot(time2,total_ball2,'g');
hold on
plot(time2,total_dry2,'--g');

plot(time3,total_ball3,'b');

plot(time3,total_dry3,'--b');

legend({'AED Depth All Ball Count';'AED Depth Dry Ball Count';'No H.D. All Ball Count';'No H.D. Dry Ball Count';'Original Depth All Ball Count';'Original Depth Dry Ball Count'})
%legend({'AED Depth All Ball';'AED Depth Dry Balls';'Original Depth All Balls';'Original Depth Dry Balls'})

% figure;
% 
% plot(time,stat,'r');
% hold on
% plot(time2,stat2,'g');


