clear all; close all;

addpath(genpath('tuflowfv'));

% scenarios = {...
%     '010_Ruppia_2015_2016_1',...
%     '010_Ruppia_2015_2016_2_B0',...
%     '010_Ruppia_2015_2016_3_BTau',...
%     '010_Ruppia_2015_2016_4_BGoo',...
%     '010_Ruppia_2015_2016_5_BL_SC100',...
%     '010_Ruppia_2015_2016_11_lgt',...
%     '010_Ruppia_2015_2016_6_SC0',...
%     '010_Ruppia_2015_2016_7_SC40',...
%     '010_Ruppia_2015_2016_8_SC100',...
%     '010_Ruppia_2015_2016_9_SC40_2Nut',...
%     '010_Ruppia_2015_2016_10_SC40_0_5Nut',...
%     };

group(1).scenarios = {...
    'ORH_Base_20140101_20170101_80',...
    'ORH_Base_20140101_20170101_100',...
    'ORH_Base_20140101_20170101_120',...
    'ORH_Base_20140101_20170101_140',...
    'ORH_Base_20140101_20170101_160',...
    };

group(1).leg = {...
    'ORH 80',...
    'ORH 100',...
    'ORH 120',...
    'ORH 140',...
    'ORH 160',...
    };

% group(2).scenarios = {...
%     '011_Ruppia_2015_2016_1',...
%     '010_Ruppia_2015_2016_6_SC0',...
%     '010_Ruppia_2015_2016_7_SC40',...
%     '010_Ruppia_2015_2016_8_SC100',...
%     '010_Ruppia_2015_2016_5_BL_SC100',...
%     };
%
% group(3).scenarios = {...
%     '011_Ruppia_2015_2016_1',...
%     '010_Ruppia_2015_2016_9_SC40_2Nut',...
%     '010_Ruppia_2015_2016_7_SC40',...
%     '010_Ruppia_2015_2016_10_SC40_0_5Nut',...
%     '010_Ruppia_2015_2016_11_lgt',...
%     };



load('F:\Cloudstor\Data_Lowerlakes\Illustrator Processing\Ruppia 2017\Area_Information.mat');


col = {'b','r','k','g','m'};

savenames = {'Group1';'Group2';'Group3'};

years = [2014 2015];


figure;
for kk = 1:length(years)
    for bb = 1:length(group)
        
        for i = 1:length(group(bb).scenarios)
            
            if exist(['R:\Coorong_Area\',group(bb).scenarios{i},'\Sheets\',num2str(years(kk)),'\HSI_sexual.mat'],'file');
                
                load(['R:\Coorong_Area\',group(bb).scenarios{i},'\Sheets\',num2str(years(kk)),'\HSI_sexual.mat']);
                
                for j = 1:length(Area)
                    
                    poly_hsi = min_cdata(Area(j).cell_ID);
                    poly_area = Area(j).cell_A;
                    
                    ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area;
                    xdata(j,1) = Area(j).Distance;
                    
                end
                
                [xdata,ind] = sort(xdata);
                ydata = ydata(ind);
                if i == 1
                    plot(xdata,ydata,'color',[0.7 0.7 0.7],'displayname',regexprep(group(bb).leg{i},'_',' '),'linewidth',2);hold on
                    
                    fillX = [min(xdata) sort(xdata)' max(xdata)];
                    fillY =[0;ydata;0];
                    
                    hh = fill(fillX,fillY,[0.7 0.7 0.7]);
                    
                    set(get(get(hh,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
                else
                    plot(xdata,ydata,col{i},'displayname',regexprep(group(bb).leg{i},'_',' '),'linewidth',0.5);hold on
                end
                
                clear xdata ydata;
                
                ylim([0 1]);
                xlim([-5 110]);
            end
            
            
        end
        leg = legend('location','northeast');
        set(leg,'fontsize',8);
        xlabel('Distance from Mouth (km)');
        ylabel('$\overline{HSI}$ (0-1)', 'Interpreter', 'latex');
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 14;
        ySize = 8;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])
        
        
        if ~exist(['Y:\Coorong Report\Transect\',num2str(years(kk)),'\',savenames{bb},'\'],'dir')
            mkdir(['Y:\Coorong Report\Transect\',num2str(years(kk)),'\',savenames{bb},'\']);
        end
        
        final_name  = ['Y:\Coorong Report\Transect\',num2str(years(kk)),'\',savenames{bb},'\Group',num2str(bb),'.png'];
        
        saveas(gcf,final_name);
        
        close
        
    end
end