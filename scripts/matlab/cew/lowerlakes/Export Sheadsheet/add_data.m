clear all; close all;

load ts_data.mat;
load flux_data.mat;


sites = fieldnames(ts_data.ON);


scenarios = {'Obs';'noCEW';'noAll'};

for i = 1:length(sites)
    
    for j = 1:length(scenarios)
        
        % TKN...
        
        ts_data.TKN.(sites{i}).(scenarios{j}) = ts_data.ON.(sites{i}).(scenarios{j}) - ts_data.WQ_NIT_AMM.(sites{i}).(scenarios{j});
        
        ts_data.TKN.(sites{i}).mdate = ts_data.ON.(sites{i}).mdate;
        
    end
    
end
        
save ts_data.mat ts_data -mat;

sites = fieldnames(flux_data.ON);

for i = 1:length(sites)
    
    for j = 1:length(scenarios)
        
        % TKN...
        
        flux_data.TKN.(sites{i}).(scenarios{j}) = flux_data.ON.(sites{i}).(scenarios{j}) - flux_data.NIT_amm.(sites{i}).(scenarios{j});
        
        flux_data.TKN.(sites{i}).mdate = flux_data.ON.(sites{i}).mdate;
        
    end
    
end

save flux_data.mat flux_data -mat;