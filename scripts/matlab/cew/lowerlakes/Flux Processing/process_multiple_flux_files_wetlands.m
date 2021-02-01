clear all; close all;

addpath(genpath('tuflowfv'));

%__________________________________________________________________________

%__________________________________________________________________________

main(1).filename = 'I:\Lowerlakes\CEW_2015_2016_Obs_v12_IC_AED_Barrage06_Grid\Output\lower_lakes_FLUX.csv';

main(1).fileout = 'I:\Lowerlakes\CEW_2015_2016_Obs_v12_IC_AED_Barrage06_Grid\Output\Flux_File.csv';

main(1).matout = 'I:\Lowerlakes\CEW_2015_2016_Obs_v12_IC_AED_Barrage06_Grid\Output\Flux.mat';

% %__________________________________________________________________________
% main(2).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\v10_Simulations\CEW_2015_2016_noCEW_v10_IC_AED_Barrage06\Output\lower_lakes_FLUX.csv';
% 
% main(2).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\v10_Simulations\CEW_2015_2016_noCEW_v10_IC_AED_Barrage06\Output\Flux_File.csv';
% 
% main(2).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\v10_Simulations\CEW_2015_2016_noCEW_v10_IC_AED_Barrage06\Output\Flux.mat';
% 
% % %__________________________________________________________________________
% 
% main(3).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\v10_Simulations\CEW_2015_2016_noALL_v10_IC_AED_Barrage06\Output\lower_lakes_FLUX.csv';
% 
% main(3).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\v10_Simulations\CEW_2015_2016_noALL_v10_IC_AED_Barrage06\Output\Flux_File.csv';
% 
% main(3).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\v10_Simulations\CEW_2015_2016_noALL_v10_IC_AED_Barrage06\Output\Flux.mat';
% 
% %__________________________________________________________________________
% main(4).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_no_Offtake_v6_Met_v2\Output\lower_lakes_FLUX.csv';
% 
% main(4).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_no_Offtake_v6_Met_v2\Output\Flux_File.csv';
% 
% main(4).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_no_Offtake_v6_Met_v2\Output\Flux.mat';
% 
% % %__________________________________________________________________________
% 
% main(5).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_FRP_SEDFLUX_v6_Met_v2\Output\lower_lakes_FLUX.csv';
% 
% main(5).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_FRP_SEDFLUX_v6_Met_v2\Output\Flux_File.csv';
% 
% main(5).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_FRP_SEDFLUX_v6_Met_v2\Output\Flux.mat';

% %__________________________________________________________________________


%__________________________________________________________________________

%__________________________________________________________________________


wqfile = 'Flux Order WQ 1.xlsx';

nodefile = 'Flux_Nodestrings_Wetlands.xlsx';

%__________________________________________________________________________

disp('Running processing in Parrallel: Dont cancel...');

for i = 1:length(main)
    
    
    %tfv_preprocess_fluxfile(main(i).filename,main(i).fileout);
    
    tfv_process_fluxfile(main(i).filename,main(i).matout,wqfile,nodefile);
end