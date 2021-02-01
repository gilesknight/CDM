clear all; close all;

base_dir = 'R:\Coorong-Local\Flux_Out\';

% load([base_dir,'flux_all.mat']);
% 
% flux.run_scenario_0a = flux_all;

filelist = dir([base_dir,'*.mat']);

for i = 1:length(filelist)
    
    simname = regexprep(filelist(i).name,'_FLUX.mat','');
    simname = regexprep(simname,'\.','_');
    
    data = load([base_dir,filelist(i).name]);
    
    flux.(simname) = data.flux;
    
end

save('Y:\Coorong Report\Budget_Final\flux.mat','flux','-mat','-v7.3');