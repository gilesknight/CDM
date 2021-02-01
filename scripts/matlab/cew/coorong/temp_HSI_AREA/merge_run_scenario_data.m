function data = merge_run_scenario_data
%clear all; close all;

scenarios = {...
    '013_Weir_1_SC40_Needles',...
'013_Weir_2_SC40_Parnka',...
'013_Weir_2_SC40_Parnka_Fixed_TS',...
'012_Weir_3_SC40_noWeir',...
'013_Weir_4_SC70_Needles',...
'013_Weir_5_SC70_Parnka',...
'013_Weir_9_SC55_noWeir',...
'013_Weir_7_SC55_Needles',...
'013_Weir_8_SC55_Parnka',...
'013_Weir_9_SC55_noWeir',...
'012_ORH_2014_2016_1',...
'013_Weir_10_SC70_Needles_Sill04',...
'013_Weir_11_Parnka_SC40_SAL',...
'013_Weir_12_noWeir_SC40_SAL_PGrid',...
'013_Weir_13_Parnka_SC55_J',...
'013_ORH_2014_2016_Needles_Sill',...
    };

basedir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\';

outfile = 'All_Weir_Scenarios.csv';

years = [2014 2015];


for i = 1:length(years)
    for j = 1:length(scenarios)
        % Check to see if the right files exist for a scenario and year
        
        chx_file = [basedir,scenarios{j},'/Sheets/',num2str(years(i)),'/HSI_asexual.csv'];
        
        if exist(chx_file,'file')
            % We have files :)
            
            main_dir = [basedir,scenarios{j},'/Sheets/',num2str(years(i)),'/'];
            
            data.(['s',scenarios{j}]).(['s',num2str(years(i))]).Asexual ...
                = read_export_file([main_dir,'HSI_asexual.csv']);
            data.(['s',scenarios{j}]).(['s',num2str(years(i))]).Sexual ...
                = read_export_file([main_dir,'HSI_sexual.csv']);
            
            data.(['s',scenarios{j}]).(['s',num2str(years(i))]).Adult ...
                = read_export_file([main_dir,'1_adult_new/HSI_adult.csv']);
            data.(['s',scenarios{j}]).(['s',num2str(years(i))]).Flower ...
                = read_export_file([main_dir,'2_flower_new/HSI_flower.csv']);
            data.(['s',scenarios{j}]).(['s',num2str(years(i))]).Seed ...
                = read_export_file([main_dir,'3_seed_new/HSI_seed.csv']);
            data.(['s',scenarios{j}]).(['s',num2str(years(i))]).Turion ...
                = read_export_file([main_dir,'4_turion_new/HSI_turion.csv']);
            data.(['s',scenarios{j}]).(['s',num2str(years(i))]).Sprout ...
                = read_export_file([main_dir,'5_sprout_new/HSI_sprout.csv']);
            
        end
    end
end

export_data([basedir,outfile],data,years);

savename = regexprep([basedir,outfile],'.csv','.mat');

save(savename,'data','-mat');
end
function area = read_export_file(filename)
fid = fopen(filename,'rt');
fline = fgetl(fid);
tt = strsplit(fline,',');
area = str2num(tt{2});
end

function export_data(filename,data,years)
fid = fopen(filename,'wt');

scen = fieldnames(data);
fprintf(fid,'Analysis Type,');
for i = 1:length(years)
    for j = 1:length(scen)
        name = regexprep(scen{j},'s','');
        
        fprintf(fid,'%s,',[name ' (',num2str(years(i)),')']);
    end
end
fprintf(fid,'\n');

vars = fieldnames(data.(scen{1}).(['s',num2str(years(i))]));
for k = 1:length(vars)
    fprintf(fid,'%s,',vars{k});
    for i = 1:length(years)
        for j = 1:length(scen)
            if isfield(data.(scen{j}),['s',num2str(years(i))])
                fprintf(fid,'%10.10f,',data.(scen{j}).(['s',num2str(years(i))]).(vars{k}));
            else
                fprintf(fid,' ,');
            end
        end
    end
    fprintf(fid,'\n');
end
fclose(fid);
end




