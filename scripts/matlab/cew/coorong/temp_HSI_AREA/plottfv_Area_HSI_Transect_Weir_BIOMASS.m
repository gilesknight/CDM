clear all; close all;

addpath(genpath('tuflowfv'));


group(1).scenarios = {...
    '012_ORH_2014_2016_1',...
    '012_Weir_3_SC40_noWeir',...
    '012_Weir_6_SC70_noWeir',...
    '013_Weir_9_SC55_noWeir',...
    '013_Weir_2_SC40_Parnka_Fixed_TS',...
    '013_Weir_5_SC70_Parnka',...
    '013_Weir_8_SC55_Parnka',...
    };

group(1).leg = {...
    'ORH',...
    'No Weir SC40',...
    'No Weir SC70',...
    'No Weir SC55',...
    'Parnka SC40',...
    'Parnka SC70',...
    'Parnka SC55',...
    };


group(2).scenarios = {...
    '012_ORH_2014_2016_1',...
    '013_Weir_10_SC70_Needles_Sill04',...
    '013_Weir_4_SC70_Needles',...
    '012_Weir_6_SC70_noWeir',...
    };

group(2).leg = {...
    'ORH',...
    'Needles Sill 0.4m SC70',...
    'Needles Sill 0.6m SC70',...
    'No Weir SC70',...
    };


group(3).scenarios = {...
    '012_ORH_2014_2016_1',...
    '013_Weir_2_SC40_Parnka_Fixed_TS',...
    '013_Weir_2_SC40_Parnka',...
    '012_Weir_3_SC40_noWeir',...
    };
group(3).leg = {...
    'ORH',...
    'Parnka Sept. SC40',...
    'Parnka Aug. SC40',...
    'No Weir SC40',...
    };


group(4).scenarios = {...
    '012_ORH_2014_2016_1',...
    '013_Weir_7_SC55_Needles',...
    '013_Weir_8_SC55_Parnka',...
    '013_Weir_9_SC55_noWeir',...
    };

group(4).leg = {...
    'ORH',...
    'Needles SC55',...
    'Parnka SC55',...
    'No Weir SC55',...
    };

group(5).scenarios = {...
    '012_ORH_2014_2016_1',...
    '013_Weir_2_SC40_Parnka_Fixed_TS',...
    '013_Weir_11_Parnka_SC40_SAL',...
    '013_Weir_12_noWeir_SC40_SAL_PGrid',...
    };
group(5).leg = {...
    'ORH',...
    'Parnka SC40',...
    'Parnka SC40 High Salinity',...
    'No Weir SC40 High Salinity',...
    };

load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\Area_Information_Weir.mat');


col = {'b','r','k','g','m','y','c'};

savenames = {'NoWeir_Parnka';'Weir_Option_1';'Weir_Option_2';'Weir_Position';'High_Salinity'};

years = [2014 2015];


figure;
for kk = 1:length(years)

    for bb = 1:length(group)

        for i = 1:length(group(bb).scenarios)

            if exist(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',group(bb).scenarios{i},'\Sheets\',num2str(years(kk)),'\malg\ULVA_BIOMASS.mat'],'file');

                load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',group(bb).scenarios{i},'\Sheets\',num2str(years(kk)),'\malg\ULVA_BIOMASS.mat']);

                min_cdata = ave_data;

                for j = 1:length(Area)

                    if bb == 1
                        if i < 5
                            poly_hsi = min_cdata(Area(j).cell_ID1);
                            poly_area = Area(j).cell_A1;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area1;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        else
                            poly_hsi = min_cdata(Area(j).cell_ID2);
                            poly_area = Area(j).cell_A2;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area2;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        end

                    end
                    if bb == 2 | bb == 3
                        if i == 4 | i == 1
                            poly_hsi = min_cdata(Area(j).cell_ID1);
                            poly_area = Area(j).cell_A1;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area1;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        else
                            poly_hsi = min_cdata(Area(j).cell_ID2);
                            poly_area = Area(j).cell_A2;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area2;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        end
                    end

                    if bb == 4
                        if i == 1 | i == 4
                            poly_hsi = min_cdata(Area(j).cell_ID1);
                            poly_area = Area(j).cell_A1;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area1;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        else
                            poly_hsi = min_cdata(Area(j).cell_ID2);
                            poly_area = Area(j).cell_A2;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area2;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        end
                    end

                    if bb == 5
                        if i == 1
                            poly_hsi = min_cdata(Area(j).cell_ID1);

                            poly_area = Area(j).cell_A1;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area1;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        else
                            poly_hsi = min_cdata(Area(j).cell_ID2);
                            poly_area = Area(j).cell_A2;

                            ydata(j,1) = sum(poly_hsi .* poly_area) / Area(j).Total_Area2;
                            xdata(j,1) = Area(j).Distance;
                            clear ploy_hsi ploy_area;
                        end
                    end


                end

                [xdata,ind] = sort(xdata);
                ydata = ydata(ind);
                if i == 1
                    plot(xdata,ydata,'color',[0.7 0.7 0.7],'displayname',regexprep(group(bb).leg{i},'_',' '),'linewidth',2);hold on

                    fillX = [min(xdata) sort(xdata)' max(xdata)];
                    fillY =[0;ydata;0];

                    hh = fill(fillX,fillY,[0.7 0.7 0.7],'edgecolor','none');

                    set(get(get(hh,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');


                    np = plot([Area(i).N/1000 Area(i).N/1000],[0 200],'--k','linewidth',0.5);
                    set(get(get(np,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
                    pp = plot([Area(i).P/1000 Area(i).P/1000],[0 200],'--k','linewidth',0.5);
                    set(get(get(pp,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
                    sp = plot([Area(i).S/1000 Area(i).S/1000],[0 200],'--k','linewidth',0.5);
                    set(get(get(sp,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
                    uistack(np,'bottom');
                    uistack(pp,'bottom');
                    uistack(sp,'bottom');

                else

                    plot(xdata,ydata,col{i},'displayname',regexprep(group(bb).leg{i},'_',' '),'linewidth',0.5);hold on
                end

                clear xdata ydata;


                %ylim([0 0.8]);
                xlim([-5 110]);
            end


        end
        leg = legend('location','northwest');
        set(leg,'fontsize',6);
        ylabel('Ulva ($g DW m^{-2}$)', 'Interpreter', 'latex','fontsize',6);

        xl = get(gca,'xtick');

        if bb == 6
            set(gca,'xtick',xl,'fontsize',6);
            xlabel('Distance from Mouth (km)','fontsize',6);

        else
            set(gca,'xtick',xl,'xticklabel',[],'fontsize',6);
        end
        set(gca,'xtick',[0:20:100],'xticklabel',[],'fontsize',6);


        yl = get(gca,'ytick');
        %set(gca,'ytick',[0.2:0.2:0.8],'fontsize',6);


        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 8;
        ySize = 4;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])

        if ~exist(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\Transect_BISOMASS\',num2str(years(kk)),'\',savenames{bb},'\'],'dir')
            mkdir(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\Transect_BISOMASS\',num2str(years(kk)),'\',savenames{bb},'\']);
        end

        final_name  = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\Transect\',num2str(years(kk)),'\',savenames{bb},'\Group',num2str(bb),'.png'];

        saveas(gcf,final_name);
        print(gcf,regexprep(final_name,'.png','.eps'),'-depsc2');

        close

    end
end
