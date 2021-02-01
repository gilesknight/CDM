clear all; close all;

main_dir = 'H:\Lowerlakes-CEW-Results\Flux Dailys Totals\';

dirlist = dir(main_dir);

flux_data = [];

mdate = [];

for i = 3:length(dirlist)
    
    filelist = dir([main_dir,dirlist(i).name,'/*.csv']);
    
    varname = dirlist(i).name;
    
    for j = 1:length(filelist)
        
        sitename = regexprep(filelist(j).name,'.csv','');
        
        disp([varname,': ',sitename]);
        
        if isempty(mdate)
            [snum,sstr] = xlsread([main_dir,dirlist(i).name,'/',filelist(j).name],'A2:D100000');
            for kkk = 1:length(sstr(:,1));
             mdate(kkk,1) = datenum(sstr{kkk,1},'dd/mm/yyyy');
            end
            
        else
            [snum,~] = xlsread([main_dir,dirlist(i).name,'/',filelist(j).name],'A2:D100000');
        end
        
        flux_data.(varname).(sitename).Obs = snum(:,1);
        flux_data.(varname).(sitename).noCEW = snum(:,2);
        flux_data.(varname).(sitename).noAll = snum(:,3);
        flux_data.(varname).(sitename).mdate = mdate;
        
    end
            
end

save flux_data.mat flux_data -mat -v7.3;
    
    