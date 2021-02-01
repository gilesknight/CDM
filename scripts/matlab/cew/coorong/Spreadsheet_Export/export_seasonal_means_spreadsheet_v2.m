clear all; close all;


%filename = 'Seasonal Means.csv';

base_dir = 'Y:\Coorong Report\Process_Final\';

sims = {...
    'ORH_Base_20140101_20170101',...
    'ORH_Base_3D_20140101_20170101',...
    'ORH_Base_FSED0_20140101_20170101',...
    'ORH_Base_FSED2_20140101_20170101',...
    'ORH_SLR_02_20140101_20170101',...
    'SC40_Base_20140101_20170101',...
    'SC40_NUT_1_5_20140101_20170101',...
    'SC40_NUT_2_0_20140101_20170101',...
    };

names = {...
    'ORH',...
    'MPB 2000',...
    'FSED 0',...
    'FSED 2',...
    'SLR 0.2m',...
    'SC40',...
    'SC40 NUT 1.5',...
    'SC40 NUT 2.0',...
    };


zones = {...
    'Mouth',...
    'Upper',...
    'Mid',...
    'Upper_Salt',...
    'Lower_Salt',...
    };

vars = {...
    'SAL',...
    'WQ_NIT_NIT',...
    'WQ_PHS_FRP',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_OXY_OXY',...
    'WQ_DIAG_HAB_RUPPIA_HSI',...
    'WQ_DIAG_MAG_HSI',...
    };

range(1).val = [datenum(2014,01,01) datenum(2014,04,01)];
range(2).val = [datenum(2014,04,01) datenum(2014,07,01)];
range(3).val = [datenum(2014,07,01) datenum(2014,10,01)];
range(4).val = [datenum(2014,10,01) datenum(2015,01,01)];
range(5).val = [datenum(2015,01,01) datenum(2015,04,01)];



conv = [1 14/1000 31/1000 14/1000 31/1000 32/1000 1 1];


shp = shaperead('Y:\Coorong Report\Coorong_Regions.shp');

%_______________________________________________________________

outdata = [];

for i = 1:length(sims)
    for j = 1:length(vars)
        load([base_dir,sims{i},'/',vars{j},'.mat']);
        for k = 1:length(zones)
            for bb = 1:length(shp)
                if strcmpi(shp(bb).Name,zones{k}) == 1
                    the_zone = bb;
                end
            end
            for l = 1:length(range)
                disp([sims{i},'<<<',vars{j},'<<<',datestr(range(l).val(1),'dd-mm-yyyy'),'<<<',zones{k}]);
                the_time = find(savedata.Time >= range(l).val(1) & ...
                    savedata.Time < range(l).val(2));
                
                the_cells = find(inpolygon(savedata.X,savedata.Y,shp(the_zone).X,shp(the_zone).Y) == 1);
                
                if j < 7
%                     
                    the_mean = mean(mean(savedata.(vars{j}).Bot(the_cells,the_time))) * conv(j);
                    
                else
                    the_data = savedata.(vars{j}).Bot(the_cells,the_time);
                    the_area = savedata.Area(the_cells);
                    for m = 1:length(the_time)
                        sss = find(the_data(:,m) > 0.3);
                        the_perc(m) = (sum(the_area(sss)) / sum(the_area))* 100;
                        
                    end
                    the_mean = mean(the_perc);
                    clear the_perc;
                end
                
                outdata.(sims{i}).(vars{j}).(zones{k})(l) = the_mean;
            end
        end
        
        clear savedata; 
                        
    end
end

save outdata.mat outdata -mat -v7.3;








% fid = fopen(filename,'wt');
% 
% 
% fprintf(fid,'Start Date,End Date,Zone,Simulation,');
% for i = 1:length(vars)
%     fprintf(fid,'%s,',vars{i});
% end
% fprintf(fid,'\n');

% for i = 1:length(range)
%     
%     
%     for j = 1:length(zones)
%         
%         
%         for bb = 1:length(shp)
%             if strcmpi(shp(bb).Name,zones{j}) == 1
%                 the_zone = bb;
%             end
%         end
%         
%         
%         
%         for k = 1:length(sims)
%             fprintf(fid,'%s,%s,',datestr(range(i).val(1),'dd/mm/yyyy'),datestr(range(i).val(2)-1,'dd/mm/yyyy'));
%             fprintf(fid,'%s,',zones{j});
%             
%             fprintf(fid,'%s,',sims{k});
%             
%             for l = 1:length(vars)
%                 
%                 disp([sims{k},'<<<',vars{l},'<<<',datestr(range(i).val(1),'dd-mm-yyyy')]);
%                 
%                 load([base_dir,sims{k},'/',vars{l},'.mat']);
%                 
%                 the_time = find(savedata.Time >= range(i).val(1) & ...
%                     savedata.Time < range(i).val(2));
%                 
%                 the_cells = find(inpolygon(savedata.X,savedata.Y,shp(the_zone).X,shp(the_zone).Y) == 1);
%                 
%                 
%                 if l < 7
%                     
%                     the_mean = mean(mean(savedata.(vars{l}).Bot(the_cells,the_time))) * conv(l);
%                     
%                 else
%                     the_data = savedata.(vars{l}).Bot(the_cells,the_time);
%                     the_area = savedata.Area(the_cells);
%                     for m = 1:length(the_time)
%                         sss = find(the_data(:,m) > 0.3);
%                         the_perc(m) = (sum(the_area(sss)) / sum(the_area))* 100;
%                         
%                     end
%                     the_mean = mean(the_perc);
%                 end
%                 
%                 fprintf(fid,'%4.4f,',the_mean);
%                 
%                 clear savedata the_perc;
%                 
%                 
%             end
%             fprintf(fid,'\n');
%         end
%     end
% end
% 
% fclose(fid);


























