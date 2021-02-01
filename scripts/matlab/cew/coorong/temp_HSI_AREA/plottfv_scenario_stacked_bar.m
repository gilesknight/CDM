clear all; close all;

% This script requires run_scenario_plot and merge_area_data_into_regions
% to be run bfore hand to create the mat file

mfile = {...
    'High_Salinity_IC.mat',...
    'SC55_Comparison.mat',...
    'Salt_Creek_Flows.mat',...
    'Sill_Comparison.mat',...
    'Timing_Comparison.mat',...
    'All.mat',...
    };

dirname = {...
    'Parnka_Salinity',...
    'Weir_Position',...
    'NoWeir_Parnka',...
    'Weir_Option_1',...
    'Weir_Option_2',...
    'All_Models',...
    };

for bdb = 1:length(mfile)

load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',mfile{bdb}]);

outdir = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\',dirname{bdb},'\Bar\'];

if ~exist(outdir,'dir')
    mkdir(outdir);
end

scenarios = fieldnames(data);
years = fieldnames(data.(scenarios{1}));
regions = fieldnames(data.(scenarios{1}).(years{1}).Sexual);

%_________________________________________________________________________
%for y = 1:length(years)
    
    for i = 1:length(regions)
        figure('position',[1000.3 451 1302.6 886.6]);
        axes('position',[0.1 0.55 0.8 0.4]);
        inc = 1;
        for j = 1:length(scenarios)
            
                        x = (j * 5) - 0.5;

            xl(inc) = x(1);
            
            bardata(inc,1) = data.(scenarios{j}).(years{1}).Sexual.(regions{i})/ 1e7;
            bardata(inc,2) = data.(scenarios{j}).(years{1}).Asexual.(regions{i})/ 1e7;
            
            
            inc = inc + 1;
            
            x = (j * 5) + 0.5;
            if isfield(data.(scenarios{j}),years{2})
                bardata(inc,1) = data.(scenarios{j}).(years{2}).Sexual.(regions{i})/ 1e7;
                bardata(inc,2) = data.(scenarios{j}).(years{2}).Asexual.(regions{i})/ 1e7;
            else
                bardata(inc,1) = NaN;
                bardata(inc,2) = NaN;
            end
            xl(inc) = x(1);
            
            inc = inc + 1;
            
          labels{j} = data.(scenarios{j}).leg;
        end
        b =  bar(bardata,1,'stacked'); hold on
        set(b,'XData',xl);
        %labels = regexprep(scenarios,'_',' ');

        set(gca,'xtick',[5:5:length(scenarios) * 5],'xticklabel',labels,'fontsize',6);
        
        switch regions{i}
            case 'Total'
                ylim([0 10]);
                
            case 'North_Coorong'
                ylim([0 5]);
 
            case 'Parnka_to_Salt'
                ylim([0 5]); 
            case 'Needles_to_Parnka'
                ylim([0 5]);
                
            otherwise
                ylim([0 2]); 
        end
        
%         yy = get(gca,'ylim');
%         xx = get(gca,'xtick');
%         for ii = 1:length(labels)
%             text(xx(ii),(max(yy) * 0.95),labels{ii},'horizontalalignment','center');
%         end
        b(1).FaceColor = [0.5 0.5 0.5];
        b(2).FaceColor = [0.1 0.1 0.1]
        xlim([0 (length(scenarios)*5)+5]);
        % legend({'Sexual';'Asexual'},'location','northwest','fontsize',6);
         
         outdata.Sexual = bardata;
        clear bardata labels;
        %_________________________________________
        axes('position',[0.1 0.05 0.8 0.4],'XAxisLocation','top');
        inc = 1;
        for j = 1:length(scenarios)
            
                        x = (j * 5) - 0.5;

            xl(inc) = x(1);
            
            bardata(inc,1) = data.(scenarios{j}).(years{1}).Seed.(regions{i})/ 1e7;
                bardata(inc,2) = data.(scenarios{j}).(years{1}).Flower.(regions{i})/ 1e7;
                bardata(inc,3) = data.(scenarios{j}).(years{1}).Adult.(regions{i})/ 1e7;
            
            
            inc = inc + 1;
            
            x = (j * 5) + 0.5;
            if isfield(data.(scenarios{j}),years{2})
                bardata(inc,1) = data.(scenarios{j}).(years{2}).Seed.(regions{i})/ 1e7;
                bardata(inc,2) = data.(scenarios{j}).(years{2}).Flower.(regions{i})/ 1e7;
                bardata(inc,3) = data.(scenarios{j}).(years{2}).Adult.(regions{i})/ 1e7;

            else
                bardata(inc,1) = NaN;
                bardata(inc,2) = NaN;
                bardata(inc,3) = NaN;

            end
            xl(inc) = x(1);
            
            inc = inc + 1;
            
        end
        b =  bar(bardata,1,'stacked'); hold on
        set(b,'XData',xl);
        
        set(gca,'xtick',[5:5:length(scenarios) * 5],'xticklabel',[],'fontsize',6);
        
        labels = regexprep(scenarios,'_',' ');
        
%         yy = get(gca,'ylim');
%         xx = get(gca,'xtick');
%         for ii = 1:length(labels)
%             text(xx(ii),(max(yy) * 0.95),labels{ii},'horizontalalignment','center');
%         end
%         
        xlim([0 (length(scenarios)*5)+5]);
        
        switch regions{i}
            case 'Total'
                ylim([0 50]);
                
            case 'North_Coorong'
                ylim([0 20]);
 
            case 'Parnka_to_Salt'
                ylim([0 20]); 
                
             case 'Needles_to_Parnka'
                ylim([0 15]);                
            otherwise
        end
        
        
        set(gca, 'ydir', 'reverse'); 
        
        %legend({'Seed';'Flower';'Adult'},'location','southwest','fontsize',6);
        outdata.Adult = bardata;
        
        clear bardata labels;
        export_regional_bar_data([outdir,regions{i},'.csv'],outdata,scenarios);
                
        savename = [outdir,regions{i},'.png'];
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 12;
        ySize = 7;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])
        saveas(gcf,savename);
                        print(gcf,regexprep(savename,'.png','.eps'),'-depsc2');


        close
    end
end

