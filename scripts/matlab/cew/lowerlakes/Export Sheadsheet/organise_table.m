clear all; close all;

base_dir = 'K:\Lowerlakes-CEW-Results\Regions/';

vars = {'SAL';'WQ_NIT_AMM';'WQ_PHS_FRP';'WQ_SIL_RSI';'ON';'OP';'WQ_DIAG_PHY_TCHLA'};

years = [2014:01:2019];

[~,sstr] = xlsread([base_dir,'H\0001_Wellington.csv'],'A2:A2193');
mDate = datenum(sstr,'dd/mm/yyyy');


for bb = 1:length(years)
    
    the_search = find(mDate >= datenum(years(bb)-1,07,01) & ...
        mDate < datenum(years(bb),07,01));
    
    
    
    fid = fopen(['tables',num2str(years(bb)),'.csv'],'wt');
    
    %%
    
    fprintf(fid,'Mean\n');
    fprintf(fid,'Site,Scenario,Salinity (PSU),Ammonium (mg/L),Phosphate (mg/L),Silica (mg/L),Particulate organic nitrogen (mg/L),Particulate organic phosphorus (mg/L),Chlorophyll a (mg/L)\n');
    
    
    
    
    %____________
    
    filename = '0001_Wellington.csv';
    
    fprintf(fid,'Wellington,With all Water,');
    
    
    
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'B2:B2193');
        
        
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Wellington,No CEW,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'C2:C2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Wellington,No eWater,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'D2:D2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    fprintf(fid,'\n');
    
    %____________
    
    filename = '0005_Lake Alex Mid.csv';
    
    fprintf(fid,'Lake Alexandrina Middle,With all Water,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'B2:B2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Lake Alexandrina Middle,No CEW,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'C2:C2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Lake Alexandrina Middle,No eWater,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'D2:D2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    %____________
    fprintf(fid,'\n');
    
    filename = '0023_Mouth.csv';
    
    fprintf(fid,'Murray Mouth,With all Water,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'B2:B2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Murray Mouth,No CEW,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'C2:C2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Murray Mouth,No eWater,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'D2:D2193');
        
        fprintf(fid,'%4.4f,',mean(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    fprintf(fid,'\n');
    fprintf(fid,'\n');
    
    
    fprintf(fid,'Median\n');
    fprintf(fid,'Site,Scenario,Salinity (PSU),Ammonium (mg/L),Phosphate (mg/L),Silica (mg/L),Particulate organic nitrogen (mg/L),Particulate organic phosphorus (mg/L),Chlorophyll a (mg/L)\n');
    
    
    %____________
    
    filename = '0001_Wellington.csv';
    
    fprintf(fid,'Wellington,With all Water,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'B2:B2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Wellington,No CEW,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'C2:C2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Wellington,No eWater,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'D2:D2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    fprintf(fid,'\n');
    
    %____________
    
    filename = '0005_Lake Alex Mid.csv';
    
    fprintf(fid,'Lake Alexandrina Middle,With all Water,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'B2:B2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Lake Alexandrina Middle,No CEW,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'C2:C2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Lake Alexandrina Middle,No eWater,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'D2:D2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    fprintf(fid,'\n');
    
    %____________
    
    filename = '0023_Mouth.csv';
    
    fprintf(fid,'Murray Mouth,With all Water,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'B2:B2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Murray Mouth,No CEW,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'C2:C2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    
    fprintf(fid,'\n');
    
    fprintf(fid,'Murray Mouth,No eWater,');
    
    for i = 1:length(vars)
        
        csv_file = [base_dir,vars{i},'\',filename];
        
        
        snum = xlsread(csv_file,'D2:D2193');
        
        fprintf(fid,'%4.4f,',median(snum(the_search)));
        
    end
    fprintf(fid,'\n');
    
    fclose(fid);
    
end
