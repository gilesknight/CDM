clear all; close all;

% a script to compare the 2016 and 2017 CEWH input files

addpath(genpath('tuflowfv'));

dirlist_2016 = dir(['2016/','*.csv']);
dirlist_2017 = dir(['2017/','*.csv']);

xarray = datenum(2015,06:06:30,01);

outdir = 'Images/';

if ~exist(outdir,'dir');
    mkdir(outdir);
end


for i = 1%:length(dirlist_2016)
    d2016 = tfv_readBCfile(['2016/',dirlist_2016(i).name]);
    d2017 = tfv_readBCfile(['2017/',dirlist_2017(i).name]);
    
    vars = fieldnames(d2016);
    
    for j = 1:length(vars)
        if strcmpi(vars{j},'Date') == 0
            
            figure
            
            plot(d2016.Date,d2016.(vars{j}));hold on
            plot(d2017.Date,d2017.(vars{j}));hold on
            
            xlim([xarray(1) xarray(end)]);
            
            set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'mm-yyyy'));
            
            title(vars{j});
            
            filename = [outdir,dirlist_2016(i).name,'_',vars{j},'.png'];
            
            saveas(gcf,filename);
            close
            
        end
    end
end
            
            
            
            
            