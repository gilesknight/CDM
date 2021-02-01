clear all; close all;


addpath(genpath('tuflowfv'));

d2016 = tfv_readBCfile('2016/BK_2017.csv');
d2017 = tfv_readBCfile('2017/BK_2017.csv');


dVec = datevec(d2016.Date);

dVec(:,1) = dVec(:,1) + 1;


vars = {...
    'DOC',...
    'DON',...
    'DOP',...
    'FRP',...
    'FRP_ADS',...
    'GRN',...
    'OXY',...
    'POC',...
    'PON',...
    'RSI',...
    'SS1',...
    };

for i = 1:length(vars)
    
    pdata = [d2016.(vars{i});d2016.(vars{i})];
    pdate = [d2016.Date;datenum(dVec)];
    
    [pdate_1,ind]  = unique(pdate);
    pdata_1 = pdata(ind);
    
    d2017.(vars{i}) = [];
    d2017.(vars{i}) = interp1(pdate_1,pdata_1,d2017.Date);
end



vars = fieldnames(d2016);

xarray = datenum(2015,06:06:30,01);

outdir = 'Images/';

if ~exist(outdir,'dir');
    mkdir(outdir);
end


for j = 1:length(vars)
    if strcmpi(vars{j},'Date') == 0
        
        figure
        
        plot(d2016.Date,d2016.(vars{j}));hold on
        plot(d2017.Date,d2017.(vars{j}));hold on
        
        xlim([xarray(1) xarray(end)]);
        
        set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'mm-yyyy'));
        
        title(vars{j});
        
        filename = [outdir,'BK_2017_',vars{j},'.png'];
        
        saveas(gcf,filename);
        close
        
    end
end

fid = fopen('BK_2017.csv','wt');
for i = 1:length(vars)
    if i ==1 
        fprintf(fid,'ISOTime,');
    else
        if i == length(vars)
            fprintf(fid,'%s\n',vars{i});
        else
            fprintf(fid,'%s,',vars{i});
        end
    end
end

for j = 1:length(d2017.Date)
    for i = 1:length(vars)
        if i ==1 
        fprintf(fid,'%s,',datestr(d2017.Date(j),'dd/mm/yyyy HH:MM:SS'));
        else
            if i == length(vars)
                fprintf(fid,'%6.6f\n',d2017.(vars{i})(j));
            else
                fprintf(fid,'%6.6f,',d2017.(vars{i})(j));
            end
        end
    end
end
fclose(fid);

d2017 = tfv_readBCfile('2017/BK_2017.csv');

        