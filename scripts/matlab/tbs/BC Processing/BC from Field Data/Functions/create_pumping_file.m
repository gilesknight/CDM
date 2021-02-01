clear all; close all;

data = load('ELCD Files/LA_Inf_Pumping_Albert_2200.dat');

years = floor(data(:,1) / 1000);

days = (data(:,1) - (years*1000));

mtime = datenum(years,01,days);

inf = data(:,2);

newdata = load('ELCD Files/LA_Inf_Pumping_Albert_2200_WQ.dat');

years2= floor(newdata(:,1) / 1000);

days2 = (newdata(:,1) - (years2*1000));

mtime2 = datenum(years2,01,days2);

t = newdata(:,2);

s = newdata(:,3);



ISOTime = datenum(2008,01,01):1:datenum(2020,01,01);

sss = find(ISOTime > datenum(2010,09,01));

INFLOW = interp1(mtime,inf,ISOTime);

INFLOW(sss) = 0;

SAL = interp1(mtime2,s,ISOTime);

TEMP = interp1(mtime2,t,ISOTime);

fid = fopen('BCs/Albert_Pumping.csv','wt');

fprintf(fid,'ISOTime,INFLOW,SAL,TEMP\n');

for i = 1:length(ISOTime)
    fprintf(fid,'%s,%4.2f,%4.2f,%4.2f\n',datestr(ISOTime(i),'dd/mm/yyyy'),INFLOW(i),SAL(i),TEMP(i));
end
fclose(fid);


