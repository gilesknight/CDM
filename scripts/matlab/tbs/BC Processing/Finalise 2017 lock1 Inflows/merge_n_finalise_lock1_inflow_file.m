clear all; close all;

l2016 = tfv_readBCfile('Lock1_2016.csv');
l2017 = tfv_readBCfile('Lock1_Obs.csv');

ss = find(l2017.Date <= l2016.Date(end));

mtime = l2017.Date(ss);

don = interp1(l2016.Date,l2016.DON,mtime,'linear','extrap');
pon = interp1(l2016.Date,l2016.PON,mtime,'linear','extrap');
sal = interp1(l2016.Date,l2016.SAL,mtime,'linear','extrap');

don = don * 0.5;
pon = pon * 0.5;


l2017.DON(ss) = don;
l2017.PON(ss) = pon;
l2017.SAL(ss) = sal;

clear mtime;
stime = datevec(l2016.Date);
stime(:,1) = stime(:,1) + 1;

ttime = datenum(stime);

ss = find(l2017.Date >= ttime(1));
mtime = l2017.Date(ss);

don = interp1(ttime,l2016.DON,mtime,'linear','extrap');
pon = interp1(ttime,l2016.PON,mtime,'linear','extrap');

don = don * 0.5;
pon = pon * 0.5;

l2017.DON(ss) = don;
l2017.PON(ss) = pon;

figure;plot(l2017.DON);hold on;plot(l2017.PON);


vars = fieldnames(l2017);


fid = fopen('2017_Lock1_Obs.csv','wt');
fprintf(fid,'ISOTime,');
for i = 1:length(vars)
    if strcmpi(vars{i},'Date') == 0
        if i == length(vars)
            fprintf(fid,'%s\n',vars{i});
        else
            fprintf(fid,'%s,',vars{i});
        end
    end
end

for j = 1:length(l2017.Date)
    for i = 1:length(vars)
        
        if strcmpi(vars{i},'Date') == 0
            if i == length(vars)
                fprintf(fid,'%6.4f\n',l2017.(vars{i})(j));
            else
                fprintf(fid,'%6.4f,',l2017.(vars{i})(j));
            end
        else
            fprintf(fid,'%s,',datestr(l2017.Date(j),'dd/mm/yyyy HH:MM:SS'));
        end
    end
end
fclose(fid);


%_________________________________________________________________


headers = {...
'FLOW',...
'SAL',...
'TEMP',...
'TRACE_1',...
'SS1',...
'RET',...
'OXY',...
'RSI',...
'AMM',...
'NIT',...
'FRP',...
'FRP_ADS',...
'DOC',...
'POC',...
'DON',...
'PON',...
'DOP',...
'POP',...
'GRN',...
    };



outdir = 'Scenarios/';
if ~exist(outdir,'dir')
    mkdir(outdir);
end

create_scenarios_flows(outdir,l2017,headers);


l2017c = tfv_readBCfile([outdir,'2017_Lock1_noCEW.csv']);
l2017a = tfv_readBCfile([outdir,'2017_Lock1_noALL.csv']);
l2017 = tfv_readBCfile('2017_Lock1_Obs.csv');
pdir = 'Images/';
if ~exist(pdir,'dir')
    mkdir(pdir);
end
for i = 1:length(headers)
    
    figure
    
    plot(l2017.Date,l2017.(headers{i}));hold on
    plot(l2017c.Date,l2017c.(headers{i}));
    plot(l2017a.Date,l2017a.(headers{i}));
    plot(l2016.Date,l2016.(headers{i}));
    
    
    xlim([datenum(2015,07,01) datenum(2017,07,01)]);
    title(headers{i});
    legend({'Obs';'noCEW';'noALL';'2016'});
    savename = [pdir,headers{i},'.png'];
    
    
    
    saveas(gcf,savename);
    close
    
end