% List of good simulations...

%_________________________________________________


% 010_Ruppia_2015_2016_10_SC40_0_5Nut
% 010_Ruppia_2015_2016_11_lgt
% 010_Ruppia_2015_2016_3_BTau
% 010_Ruppia_2015_2016_4_BGoo
% 010_Ruppia_2015_2016_5_BL_SC100
% 010_Ruppia_2015_2016_6_SC0
% 010_Ruppia_2015_2016_7_SC40
% 010_Ruppia_2015_2016_8_SC100
% 010_Ruppia_2015_2016_9_SC40_2Nut
% 010_Ruppia_2016_2017_1
% 011_Ruppia_2014_2015_1
% 011_Ruppia_2015_2016_1
% 011_Ruppia_2015_2016_2_B0fin

%_________________________________________________


% pre_process_area_plot;
% clear all; close all;
%
% plottfv_Area_HSI_Transect;
% clear all; close all;
%
% run_3year_plots;
%
% plottfv_prof 2014VH;
% plottfv_prof 2015VH;
% plottfv_prof 2016BK;
% plottfv_prof 2014VH_Sal;
% plottfv_prof 2015VH_Sal;
% plottfv_prof 2016BK_Sal;


% plottfv_prof GP1;
% plottfv_prof GP1_Sal;
% 
% plottfv_prof GP2;
% plottfv_prof GP2_Sal;
% 
% plottfv_prof GP3;
% plottfv_prof GP3_Sal;




%plottfv_prof 2014VH_Sal;


run_scenario_plots;


pre_process_area_plot;

plottfv_Area_HSI_Transect;


run_3year_plots % Do GIS plot once run....

plottfv_polygon 3yr;
plottfv_polygon 3yr_Sal;


% plottfv_prof 2015VH_Sal;
% plottfv_prof 2016BK_Sal;