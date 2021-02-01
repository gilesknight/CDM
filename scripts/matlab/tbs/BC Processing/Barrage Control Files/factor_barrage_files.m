clear all; close all;

dirlist = dir(['Old/','*.csv']);

factors = [2:1:10];

for bb = 1:length(factors)
    
    
    
    newdir = ['Factor_x',num2str(factors(bb)),'/'];
    
    if ~exist(newdir,'dir')
        mkdir(newdir);
    end
    
    for i = 1:length(dirlist)
        
        fid = fopen(['Old/',dirlist(i).name],'rt');
        
        fid1 = fopen([newdir,regexprep(dirlist(i).name,'.csv','_v2.csv')],'wt');
        fline = fgetl(fid);
        fprintf(fid1,'%s\n',fline);
        fline = fgetl(fid);
        fprintf(fid1,'%s\n',fline);
        
        fline = fgetl(fid);
        fprintf(fid1,'%s\n',fline);
        
        while ~feof(fid)
            fline = fgetl(fid);
            spt = strsplit(fline,',');
            for j = 1:length(spt)
                num = str2num(spt{j});
                    num = num * factors(bb);
                
                fprintf(fid1,'%4.4f,',num);
            end
            fprintf(fid1,'\n');
        end
        fclose(fid);
        fclose(fid1);
        
        
    end
    
end