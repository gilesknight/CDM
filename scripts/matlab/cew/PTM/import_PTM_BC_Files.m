function ptm = import_PTM_BC_Files(folder)

% clear all; close all;
% folder = 'Z:\Busch\Studysites\Lowerlakes\2019_Modelling\Lowerlakes_PTM_Test_v4\Input\PTM\1\PTM\';

dirlist = dir([folder,'*.csv']);



data = tfv_readBCfile([folder,dirlist(1).name]);

ptm.Date(1:length(dirlist),1:length(data.Date)) = NaN;
ptm.Balls(1:length(dirlist),1:length(data.Date)) = NaN;


for i = 1:length(dirlist)
    
    temp = regexprep(dirlist(i).name,'.csv','');
    temp = regexprep(temp,'f','');
    
    ptm.filename(i) = str2num(temp);
    
    disp(dirlist(i).name);
    
    data = tfv_readBCfile([folder,dirlist(i).name]);
    
    ptm.Date(i,:) = data.Date;
    ptm.Balls(i,:) = data.fb;
    
    clear data;
    
      
end

save ptm.mat ptm -mat