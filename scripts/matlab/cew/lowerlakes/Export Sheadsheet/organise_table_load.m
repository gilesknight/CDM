clear all; close all;

base_dir = 'H:\Lowerlakes-CEW-Results\Cumulative Totals/';

vars = {'Salt';'NIT_amm';'PHS_frp';'SIL_rsi';'ON';'OP';'PHY_grn'};


fid = fopen('tables_load.csv','wt');

%%

fprintf(fid,'Mean\n');
fprintf(fid,'Site,Scenario,Salinity (PSU),Ammonium (mg/L),Phosphate (mg/L),Silica (mg/L),Particulate organic nitrogen (mg/L),Particulate organic phosphorus (mg/L),Chlorophyll a (mg/L)\n');


%____________

filename = 'Wellington.csv';

fprintf(fid,'Wellington,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C14:C14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D14:D14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'E14:E14');
    
    fprintf(fid,'%10.4f,',snum);
    
end
fprintf(fid,'\n');

%____________

filename = 'Barrage.csv';

fprintf(fid,'Lake Alexandrina Middle,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C14:C14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D14:D14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'E14:E14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

%____________
fprintf(fid,'\n');

filename = 'Murray.csv';

fprintf(fid,'Murray Mouth,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C14:C14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D14:D14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'E14:E14');
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'\n');




