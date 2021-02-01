clear all; close all;

addpath(genpath('functions'));

sites = {'Lowerlakes';'Murray';'Chowilla';'Moonie'};

outdir = 'Maps/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

for i = 1:length(sites)
    
    %base = load(['I:\GCLOUD\PTM_Results\',sites{i},'\Output_1_0\proc.mat']);
    sim =  load(['I:\GCLOUD\PTM_Results_v3\',sites{i},'\Output_1_1\proc_multi.mat']);    
    
    %delDO_A = base.data.OXY_BOT - sim.data.OXY_BOT;
    %delDO = mean(delDO_A,2);
    
    sss = find(sim.data.tdate >= (min(floor(sim.data.tdate))+20) & sim.data.tdate < (min(floor(sim.data.tdate))+27));
    
    udates = unique(floor(sim.data.tdate(sss)));
    
    for j = 1:length(udates)
        [~,ind] = min(abs(sim.data.tdate - (udates(j)+0.5)));
        delDO_A(:,j) = sim.data.OXY_BOT(:,ind);
        
    end
    
    delDO_A(delDO_A > 0) = 0;
    
    delDO = mean(delDO_A,2);    
    
    
    
    
      
    clear sim delDO_A;

    %base = load(['I:\GCLOUD\PTM_Results\',sites{i},'\Output_1_0\proc.mat']);
    sim =  load(['I:\GCLOUD\PTM_Results_v3\',sites{i},'\Output_1_1\proc_cyano_V.mat']);    
    
    sss = find(sim.data.tdate >= (min(floor(sim.data.tdate))+10) & sim.data.tdate <= (min(floor(sim.data.tdate))+17));
    
    udates = unique(floor(sim.data.tdate(sss)));
    
    for j = 1:length(udates)
        [~,ind] = min(abs(sim.data.tdate - (udates(j)+0.5)));
        delDO_B(:,j) = sim.data.CYANO_data(:,ind);
    end
    
    %delDO_A(delDO_A > 0) = 0;
    
    HSI_V = mean(delDO_B,2);  
    
    sim =  load(['I:\GCLOUD\PTM_Results_v3\',sites{i},'\Output_1_1\proc_cyano.mat']);    
    
    sss = find(sim.data.tdate >= (min(floor(sim.data.tdate))+10) & sim.data.tdate <= (min(floor(sim.data.tdate))+17));
    
    udates = unique(floor(sim.data.tdate(sss)));
    
    for j = 1:length(udates)
        [~,ind] = min(abs(sim.data.tdate - (udates(j)+0.5)));
        delDO_B(:,j) = sim.data.CYANO_data(:,ind);
    end
    
    %delDO_A(delDO_A > 0) = 0;
    
    HSI = mean(delDO_B,2);  
    
    
    
    
    
    
    convert_2dm_to_shp(['Grids/',sites{i},'.2dm'],'DO',double(delDO),'HSI_V',double(HSI_V),'HSI',double(HSI));
    
    
    clear delDO_B HSI delDO HSI_V;
    
    
    
end