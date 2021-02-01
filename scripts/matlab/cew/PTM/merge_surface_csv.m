clear all; close all;


sitelist = dir('I:\GCLOUD\PTM_Results_v3\');

filenames = {...
    'AMM_RISK.csv',...
    'DN.csv',...
    'DO.csv',...
    'DO_Risk.csv',...
    'DP.csv',...
    'HSI_V',...
    };

for i = 1:length(filenames)
    fid(i).ID = fopen(['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\FINALREPORT\2.Surfaces\',filenames{i}],'wt');
end


for kk = 3:length(sitelist)
    
    
    base_dir = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\FINALREPORT\2.Surfaces\',...
        sitelist(kk).name,'\Surface_PTM_Polygons_v3\'];
    
    
    newfile = dir([base_dir,'*.csv']);
    
    for i = 1:length(newfile)
        fd = fopen([base_dir,newfile(i).name],'rt');
        
        while ~feof(fd)
            fl = fgetl(fd);
            fprintf(fid(i).ID,'%s\n',fl);
        end
        fclose(fd);
    end
    
    
end
for i = 1:length(filenames)
    fclose(fid(i).ID);
end
