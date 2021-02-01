clear all; close all;

load BCs_2000\Lock1_Obs\data.mat;

sss = find(ISOTime >= datenum(2002,01,01) & ISOTime < datenum(2005,01,01));

n2002_n2004.Date = ISOTime(sss);
n2002_n2004.Flow = tfv_data.FLOW(sss);

sss = find(ISOTime >= datenum(2008,01,01) & ISOTime < datenum(2010,01,01));

n2008_n2010.Date = ISOTime(sss);
n2008_n2010.FLOW = tfv_data.FLOW(sss);

sss = find(ISOTime >= datenum(2012,01,01) & ISOTime < datenum(2015,01,01));

n2012_n2014.Date = ISOTime(sss);
n2012_n2014.Flow = tfv_data.FLOW(sss);


bar([mean(n2002_n2004.Flow) mean(n2008_n2010.FLOW) mean(n2012_n2014.Flow)]);


set(gca,'xticklabel',{'2002 - 2004';'2008 - 2009';'2012 - 2014'});
ylabel('Average Flow (m^3/s)');

saveas(gcf,'Grouped_Averages.png');

close;

[yy,~,~] = datevec(ISOTime);

u_yy = unique(yy);

for i = 1:length(u_yy)
    sss = find(yy == u_yy(i));
    bData(i,1) = mean(tfv_data.FLOW(sss));
end
bar(u_yy,bData);
xlim([1994 2017]);
ylabel('Yearly Average Flow (m^3/s)');
saveas(gcf,'Yearly_Averages.png');
close;

