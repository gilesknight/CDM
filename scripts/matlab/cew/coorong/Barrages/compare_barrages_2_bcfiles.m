clear all; close all;

dirlist = dir(['BC/','*.csv']);

for i = 1:length(dirlist)
    site = regexprep(dirlist(i).name,'.csv','');
    
    data.(site) = tfv_readBCfile(['BC/',dirlist(i).name]);
    
    
end


bar = tfv_readBCfile('Barrage_flows_20121212_20160914_no_backflow.csv');


sites = fieldnames(data);

%[snum,sstr] = xlsread('Barrage_flows_20121212_20160914_no_backflow.xlsx','A2:F50000');

xarray = datenum(2014,04:04:17,01);




for i = 1:length(sites)
    
    subplot(5,1,i)
    plot(data.(sites{i}).Date,data.(sites{i}).Flow,'b');hold on
    plot(bar.Date,bar.(sites{i}),'r');
    xlim([xarray(1) xarray(end)]);
    set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'mm-yyyy'));
    title(regexprep(sites{i},'_2017',''));
    legend({'From Model';'From CEW Recorded'});
    
end

%A4261207

figure;

plot(lowerlakes.A4261207.SAL.Date,lowerlakes.A4261207.SAL.Data);
xlim([xarray(1) xarray(end)]);
    set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'mm-yyyy'));
    hold on
    
    plot(data.Tauwitchere_2017.Date,data.Tauwitchere_2017.SAL);
    
    legend({'Field SAL';'Tuawitchere BC SAL'});