clear all; close all;

addpath(genpath('tuflowfv'));

if ~exist('E:\Dropbox\AED_Swan2\Matlab\Plotting\Images\007_UpperSwan_2008_2011_oxy_grid_AED2_Turb_IC/BCs/','dir')
    mkdir('E:\Dropbox\AED_Swan2\Matlab\Plotting\Images\007_UpperSwan_2008_2011_oxy_grid_AED2_Turb_IC/BCs/');
end


dirlist = dir('BCs/Flow/');

for i = 3:length(dirlist)
    name = regexprep(dirlist(i).name,'_Inflow.csv','');
    
    disp(['Importing ',dirlist(i).name]);
    
    data.(name) = tfv_readBCfile(['BCs/Flow/',dirlist(i).name]);
    
end

col(1) = 'r';
col(2) = 'b';
col(3) = 'g';
col(4) = 'y';
col(5) = 'm';
col(6) = 'c';
col(7) = 'k';
col(8) = 'c';

sites = fieldnames(data);

vars = fieldnames(data.Bennet);
vars(end+1) = {'wl'};

%datearray = datenum(2007,01:6:85,01);
datearray = datenum(2008,01:06:36,01);

for i = 1:length(vars)
    figure
    if strcmpi(vars{i},'ISOTIME') == 0
        
        for j = 1:length(sites)
            name = regexprep(dirlist(j+2).name,'_Inflow.csv','');
            
            if isfield(data.(sites{j}),vars{i})
                
                xdata = data.(sites{j}).ISOTIME;
                ydata = data.(sites{j}).(vars{i});
                
                plot(xdata,ydata,col(j),'displayname',regexprep(name,'_',' '));hold on
                
                
            end
        end
        
        xlim([datearray(1) datearray(end)]);
        
        set(gca,'XTick',datearray,'XTickLabel',datestr(datearray,'dd-mm'),'fontsize',6);
        
        ylabel(upper(regexprep(vars{i},'_',' ')),'fontsize',8);
        
        legend('location','NW');
        
        %--% Paper Size
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 21;
        ySize = 8;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])
        
        print(gcf,['E:\Dropbox\AED_Swan2\Matlab\Plotting\Images\007_UpperSwan_2008_2011_oxy_grid_AED2_Turb_IC/BCs/',vars{i},'.eps'],'-depsc2','-painters');
        print(gcf,['E:\Dropbox\AED_Swan2\Matlab\Plotting\Images\007_UpperSwan_2008_2011_oxy_grid_AED2_Turb_IC/BCs/',vars{i},'.png'],'-dpng','-zbuffer');
        
        close all;
        
    end
end










