clear all; close all;

addpath(genpath('tuflowfv'));

%__________________________________________________________________________


%__________________________________________________________________________

main(1).filename = 'V:\Busch\Studysites\Lowerlakes\CEWH_2017\CEW_2015_2017_Obs_v04_Met_WeirTS\Output\lower_lakes_FLUX.csv';

main(1).fileout = 'V:\Busch\Studysites\Lowerlakes\CEWH_2017\CEW_2015_2017_Obs_v04_Met_WeirTS\Output\Flux_File.csv';

main(1).matout = 'V:\Busch\Studysites\Lowerlakes\CEWH_2017\CEW_2015_2017_Obs_v04_Met_WeirTS\Output\Flux.mat';

%__________________________________________________________________________
% main(2).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\noCEW_Barrage_T2\Output\lower_lakes_FLUX.csv';
% 
% main(2).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\noCEW_Barrage_T2\Output\Flux_File.csv';
% 
% main(2).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\noCEW_Barrage_T2\Output\Flux.mat';
% % 
% % % %__________________________________________________________________________
% % 
% main(3).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\noCEW_Barrage_T3\Output\lower_lakes_FLUX.csv';
% 
% main(3).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\noCEW_Barrage_T3\Output\Flux_File.csv';
% 
% main(3).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\noCEW_Barrage_T3\Output\Flux.mat';

% %__________________________________________________________________________

%__________________________________________________________________________

%__________________________________________________________________________


wqfile = 'Flux Order WQ 1_tfv.xlsx';

nodefile = 'Flux_Nodestrings_1.xlsx';

%__________________________________________________________________________

disp('Running processing in Parrallel: Dont cancel...');

for i = 1:length(main)
    
    
    %tfv_preprocess_fluxfile(main(i).filename,main(i).fileout);
    
    tfv_process_fluxfile(main(i).filename,main(i).matout,wqfile,nodefile);
end