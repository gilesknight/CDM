clear all; close all;

[snum,sstr] = xlsread('DailyBarrageFlows_2019.csv','A2:G20000');

bar.Date = datenum(sstr(:,1),'dd/mm/yyyy');
bar.Tauwitchere = snum(:,6) * (1000/86400);
bar.Ewe = snum(:,5) * (1000/86400);
bar.Boundary = snum(:,4) * (1000/86400);
bar.Mundoo = snum(:,3) * (1000/86400);
bar.Goolwa = snum(:,2) * (1000/86400);

dirlist = dir(['BC_Old/','*.csv']);

for i = 1:length(dirlist)
    
    filename = dirlist(i).name;
    newfile = regexprep(filename,'_2017','_v3');
    site = regexprep(filename,'_2017.csv','');
    
    old = tfv_readBCfile(['BC_Old/',filename]);
    new = tfv_readBCfile(['BC_New/',newfile]);
    
    vars = fieldnames(old);
    
    sss = find(new.Date > old.Date(end));
    ttt = find(bar.Date > old.Date(end));
    
    if strcmpi(site,'Salt') == 0 & ...
            strcmpi(site,'BK_Tide') == 0
        theflow = interp1(bar.Date(ttt),bar.(site)(ttt),new.Date(sss));
    end
    
    ext = [];
    for j = 1:length(vars)
        
        switch vars{j}
            case 'Flow'
                if strcmpi(site,'Salt') == 0
                    ext.(vars{j}) = [old.(vars{j});theflow];
                else
                    ext.(vars{j}) = [old.(vars{j});new.(vars{j})(sss)];
                end
            case 'TRACE_2'
                fake(1:length(sss),1) = old.(vars{j})(10);
                ext.(vars{j}) = [old.(vars{j});fake];clear fake;
            case 'RET'
                fake(1:length(ext.Date),1) = 0;
                ext.(vars{j}) = [old.(vars{j});fake];clear fake;
                
            case 'MAG_ulva'
                fake(1:length(sss),1) = old.(vars{j})(10);
                ext.(vars{j}) = [old.(vars{j});fake];clear fake;
                
            case 'MAG_ulva_IN'
                fake(1:length(sss),1) = old.(vars{j})(10);
                ext.(vars{j}) = [old.(vars{j});fake];clear fake;
                
            case 'MAG_ulva_IP'
                fake(1:length(sss),1) = old.(vars{j})(10);
                ext.(vars{j}) = [old.(vars{j});fake];clear fake;
                
                
            otherwise
                ext.(vars{j}) = [old.(vars{j});new.(vars{j})(sss)];
        end
        
    end
    
    
    fid = fopen(['BC_Extended/',site,'_Extended.csv'],'wt');
    
    fprintf(fid,'ISOTime,');
    
    for j = 2:length(vars)
        if j == length(vars)
            fprintf(fid,'%s\n',vars{j});
        else
            fprintf(fid,'%s,',vars{j});
        end
    end
    
    for k = 1:length(ext.Date)
        fprintf(fid,'%s,',datestr(ext.Date(k),'dd/mm/yyyy HH:MM:SS'));
        for j = 2:length(vars)
            if j == length(vars)
                fprintf(fid,'%4.4f\n',ext.(vars{j})(k));
            else
                fprintf(fid,'%4.4f,',ext.(vars{j})(k));
            end
        end
    end
    fclose(fid);
    
    
    
end










