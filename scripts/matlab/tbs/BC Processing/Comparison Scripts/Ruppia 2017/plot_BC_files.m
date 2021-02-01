clear all; close all;

addpath(genpath('tuflowfv'))
%%
dirlist = dir(['Tide/','*.csv']);

for i = 1:length(dirlist)
    
    dd = strsplit(dirlist(i).name,'.');
    
    sitename = dd{1};
    
    disp(sitename);
    
     temp = tfv_readBCfile(['Tide/',dirlist(i).name]);
    
    vars = fieldnames(temp);
    for j = 1:length(vars)
        data.(sitename).(upper(vars{j})) = temp.(vars{j});
    end
    
    
end

save BC_files_tide.mat data -mat;
%%
load BC_files_tide.mat;

sites = fieldnames(data);

vars = fieldnames(data.(sites{1}));

for i = 1:length(vars)
    if strcmpi(vars{i},'DATE') == 0
        figure
    
        for j = 1:length(sites)
            if isfield(data.(sites{j}),vars{i})
                plot(data.(sites{j}).DATE,data.(sites{j}).(vars{i}),'displayname',regexprep(sites{j},'_',' '));hold on
            end
            
        end
        
        legend(gca,'location','northeast');
        
        title(regexprep(vars{i},'_',' '));
        
        xlim([datenum(2014,01,01) datenum(2017,01,01)]);
        
        datearray = datenum(2015,01:03:13,01);
        
        set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'mm-yy'));
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 16;
        ySize = 12;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])
        
        saveas(gcf,[vars{i},'_tide.png']);
        
        close all;
        
    end
end