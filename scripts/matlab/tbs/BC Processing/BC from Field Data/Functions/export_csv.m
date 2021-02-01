clear all; close all;

load lowerlakes.mat
tdate = lowerlakes.A4261158.H.Date;
tdata = lowerlakes.A4261158.H.Data;

fid = fopen('Lake Alexandrina 4km West Pomanda Point.csv','wt');

fprintf(fid,'Date,Height (mAHD)\n');
for i = 1:length(tdate)
    fprintf(fid,'%s,%4.4f\n',datestr(tdate(i),'dd/mm/yyyy HH:MM'),tdata(i));
end
fclose(fid);

scatter(tdate,tdata,'.k');

xtik = min(tdate):(max(tdate) - min(tdate))/5:max(tdate);

set(gca,'xtick',xtik,'xticklabel',xtik);

