clear all; close all; fclose all;

dirlist = dir(['Output/Murray_100/PTM/','*.csv']);

num_balls = 0;
num_mass = 0;
for i = 1:length(dirlist)
    data = tfv_readBCfile(['Output/Murray_100/PTM/',dirlist(i).name]);
    
    sss = find(data.fb > 0);
    num_balls = num_balls + length(sss);
    num_mass = num_mass + sum(data.fb);
    
    
    
end