
clear; close;

infile=['E:\Lowerlakes\fishHSI\MER_Coorong_eWater_2020_v1\mat\'];
load([infile,'\','monthlyarea_nonorth.mat']);

outdir=['E:\Lowerlakes\fishHSI\MER_Coorong_eWater_2020_v1\plots\'];

scenario = {...
    'Base',...
    'Scen1',...
    'Scen2',...
    };

fishnames = {...
    'mullowayHSI',...
    'breamHSI',...
    'gobyHSI',...
    'flounderHSI',...
    'mulletHSI',...
    'congolliHSI',...
    'hardyheadHSI',...
};

datearray=datenum(2017,7:42,1);

for n = 1:length(scenario)
    fileID = fopen([outdir,(scenario{n}),'_HSI_area_nonorth.csv'],'w'); %w is to make a new workbook, 'a' is to append
    fprintf(fileID,'%s\n','Month,mullowayHSI,breamHSI,gobyHSI,flounderHSI,mulletHSI,congolliHSI,hardyheadHSI'); %s-character vector, n- start a new line
    
    for i=1:length(datearray)
        fprintf(fileID,'%s',datestr(datearray(i),'dd/mm/yyyy'));
        
        for j=1:length(fishnames)
            fprintf(fileID,',%6.2f',montharea.(scenario{n}).(fishnames{j})(i)); %6.2f: 6 digits,2 decimal points, floating data type, other types include interger, double
        end
        fprintf(fileID,'%s\n','');
    end
    
    
    fclose(fileID);
end



