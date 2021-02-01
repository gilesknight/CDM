clear all; close all;

addpath(genpath('tuflowfv'));

%__________________________________________________________________________

%__________________________________________________________________________

main(1).filename = 'H:\Lowerlakes-CEW-Results\2019\Obs\lower_lakes_FLUX.csv';

main(1).fileout = 'H:\Lowerlakes-CEW-Results\2019\Obs\Flux_File.csv';

main(1).matout = 'H:\Lowerlakes-CEW-Results\2019\Obs\Flux.mat';

% %__________________________________________________________________________
main(2).filename = 'H:\Lowerlakes-CEW-Results\2019\NoCEW\lower_lakes_noCEW_FLUX.csv';

main(2).fileout = 'H:\Lowerlakes-CEW-Results\2019\NoCEW\Flux_File.csv';

main(2).matout = 'H:\Lowerlakes-CEW-Results\2019\NoCEW\Flux.mat';
% 
% %__________________________________________________________________________
% 
main(3).filename = 'H:\Lowerlakes-CEW-Results\2019\NoEWater\lower_lakes_noEWater_FLUX.csv';

main(3).fileout = 'H:\Lowerlakes-CEW-Results\2019\NoEWater\Flux_File.csv';

main(3).matout = 'H:\Lowerlakes-CEW-Results\2019\NoEWater\Flux.mat';

%__________________________________________________________________________
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

nodefile = 'Flux_Nodestrings.xlsx';

%__________________________________________________________________________

disp('Running processing in Parrallel: Dont cancel...');

for i = 1:length(main)
    
    
    %tfv_preprocess_fluxfile(main(i).filename,main(i).fileout);
    
    tfv_process_fluxfile(main(i).filename,main(i).matout,wqfile,nodefile);
    
    
    
    
    
    
    
    
    
end