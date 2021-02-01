clear all; close all;

addpath(genpath('Functions'));

oldfile = {'Tauwitchere_v3.csv';'Ewe_v3.csv';'Boundary_v3.csv';'Mundoo_v3.csv';'Goolwa_v3.csv';};

load barrages_daily.mat;



for i = 1:length(oldfile)
    
    data = tfv_readBCfile(oldfile{i});
    
    
    site_name = regexprep(oldfile{i},'_v3.csv','');
    
    sss = find(barrages_daily.(site_name).Date >= datenum(2016,01,01) &  barrages_daily.(site_name).Date < datenum(2017,01,01)); 
    
    bDate(:,1) = barrages_daily.(site_name).Date(sss);
    bFlow = barrages_daily.(site_name).Flow(sss);
    
    
    vars = fieldnames(data);
    
    
    sss = find(data.Date < datenum(2016,01,01));
    
    ttt = find(data.Date >= datenum(2015,01,01) & data.Date < datenum(2016,01,01));
    
    cDate = data.Date(ttt);
    
    vDate = datevec(cDate);
    vDate(:,1) = 2016;
    
    mDate = datenum(vDate);
    
    iFlow = interp1(bDate,bFlow,mDate);
    
    for j = 1:length(vars)
        clipped.(vars{j}) = data.(vars{j})(sss);
        
        switch vars{j}
            case 'Date'
                clipped.Date = [clipped.Date;mDate];
            case 'Flow'
                clipped.Flow = [clipped.Flow;iFlow];
            otherwise
                clipped.(vars{j}) = [clipped.(vars{j});data.(vars{j})(ttt)];
        end

    end
    
    
    fid = fopen([site_name,'_2017.csv'],'wt');
    
    fprintf(fid,'ISOTime,');
    
    
    for ii = 2:length(vars)
            if ii == length(vars)
                fprintf(fid,'%s\n',vars{ii});
            else
                fprintf(fid,'%s,',vars{ii});
            end
    end
    
    for j = 1:length(clipped.Date)
        fprintf(fid,'%s,',datestr(clipped.Date(j),'dd/mm/yyyy HH:MM:SS'));
        for ii = 2:length(vars)
                if ii == length(vars)
                    fprintf(fid,'%6.6f\n',clipped.(vars{ii})(j));
                else
                    fprintf(fid,'%6.6f,',clipped.(vars{ii})(j));
                end
        end
    end
    fclose(fid);
    
end
    
    
    
    
    
    
    
    
    
    
    
    