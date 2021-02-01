clear all; close all;

base_dir = 'K:\Lowerlakes-CEW-Results\Yearly Totals v5/';

vars = {'Salt';'NIT_amm';'PHS_frp';'SIL_rsi';'ON';'OP';'PHY_grn'};

years = [2014:01:2019];

the_rows = [2:01:07];

for bb = 1:length(years)

fid = fopen(['tables_load',num2str(years(bb)),'.csv'],'wt');

%%

fprintf(fid,'Mean\n');
fprintf(fid,'Site,Scenario,Salinity (PSU),Ammonium (mg/L),Phosphate (mg/L),Silica (mg/L),Particulate organic nitrogen (mg/L),Particulate organic phosphorus (mg/L),Chlorophyll a (mg/L)\n');

ob = ['C',num2str(the_rows(bb)),':C',num2str(the_rows(bb))];
nc = ['D',num2str(the_rows(bb)),':D',num2str(the_rows(bb))];
ne = ['E',num2str(the_rows(bb)),':E',num2str(the_rows(bb))];

%____________

filename = 'Wellington.csv';

fprintf(fid,'Wellington,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,ob);
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,nc);
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,ne);
    
    fprintf(fid,'%10.4f,',snum);
    
end
fprintf(fid,'\n');

%____________

filename = 'Barrage.csv';

fprintf(fid,'Lake Alexandrina Middle,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,ob);
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,nc);
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,ne);
    
    fprintf(fid,'%10.4f,',snum);
    
end

%____________
fprintf(fid,'\n');

filename = 'Murray.csv';

fprintf(fid,'Murray Mouth,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,ob);
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,nc);
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,ne);
    
    fprintf(fid,'%10.4f,',snum);
    
end

fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'\n');

end


