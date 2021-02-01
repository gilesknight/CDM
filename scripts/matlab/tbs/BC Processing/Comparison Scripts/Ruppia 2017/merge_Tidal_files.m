clear all; close all;

load BC_files_tide.mat;

data.BK_2017_v2 = data.BK_2017;

vars = fieldnames(data.BK_2017_v2);


for i = 1:length(vars)
    if strcmpi(vars{i},'WL') == 0 & ...
            strcmpi(vars{i},'SAL') == 0 & ...
            strcmpi(vars{i},'DATE') == 0 
        if isfield(data.VH3_t2,vars{i})
            data.BK_2017_v2.(vars{i}) = [];
            data.BK_2017_v2.(vars{i})(:,1) = interp1(data.VH3_t2.DATE,data.VH3_t2.(vars{i}),data.BK_2017_v2.DATE,'linear','extrap');
        end
    end
end

% Hack for temp
ttt = find(data.VH3_t2.DATE > datenum(2015,01,01) & data.VH3_t2.DATE < datenum(2016,01,01));

tdate = data.VH3_t2.DATE(ttt);
tdata = data.VH3_t2.TEMP(ttt);
tdate = tdate + 365;

sss = find(data.VH3_t2.DATE < datenum(2016,01,01));

adate = [data.VH3_t2.DATE(sss);tdate];
adata = [data.VH3_t2.TEMP(sss);tdata];
data.BK_2017_v2.TEMP = [];
data.BK_2017_v2.TEMP = interp1(adate,adata,data.BK_2017_v2.DATE,'linear','extrap');



sites = fieldnames(data);

vars = fieldnames(data.(sites{1}));

for i = 1:length(vars)
    if strcmpi(vars{i},'DATE') == 0
        figure
    
        for j = 1:length(sites)
            if isfield(data.(sites{j}),vars{i})
                plot(data.(sites{j}).DATE,data.(sites{j}).(vars{i}),'displayname',regexprep(sites{j},'_',' '));hold on
            end
            
        end
        
        legend(gca,'location','northeast');
        
        title(regexprep(vars{i},'_',' '));
        
        xlim([datenum(2014,01,01) datenum(2017,01,01)]);
        
        datearray = datenum(2014,01:06:49,01);
        
        set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'mm-yy'));
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 16;
        ySize = 12;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])
        
        saveas(gcf,[vars{i},'_tide.png']);
        
        close all;
        
    end
end

fid = fopen('BK_Tide_2017.csv','wt');
fprintf(fid,'ISOTIME,');
for i = 2:length(vars)
    if i == length(vars)
        fprintf(fid,'%s\n',lower(vars{i}));
    else
        fprintf(fid,'%s,',lower(vars{i}));
    end
end

for i = 1:length(data.BK_2017_v2.DATE)
    fprintf(fid,'%s,',datestr(data.BK_2017_v2.DATE(i),'dd/mm/yyyy HH:MM:SS'));
    for j = 2:length(vars)
        if j == length(vars)
            fprintf(fid,'%4.4f\n',data.BK_2017_v2.(vars{j})(i));
        else
            fprintf(fid,'%4.4f,',data.BK_2017_v2.(vars{j})(i));
        end
    end
end
fclose(fid);
            


        


