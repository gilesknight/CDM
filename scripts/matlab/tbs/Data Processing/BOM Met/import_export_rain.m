clear all; close all;

fid = fopen('IDCJAC0009_043109_1800_Data.csv','rt');
x  = 7;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',3,'Delimiter',',');
fclose(fid);

year = str2double(datacell{3});
mon = str2double(datacell{4});
day = str2double(datacell{5});
rain = str2double(datacell{6});
rain(isnan(rain)) = 0;
sdate = datenum(2015,01,01);
edate = datenum(2018,01,01);

rDate = datenum(year,mon,day);
rData = rain / 1000;
all_date = sdate:01:edate;

fid = fopen('tfv_rain_St_George_AP.csv','wt');
fprintf(fid,'ISOTime,Precip\n');
for i = 1:length(all_date)
    ss = find(rDate == all_date(i));
    fprintf(fid,'%s,%4.6f\n',datestr(rDate(ss),'dd/mm/yyyy HH:MM:SS'),rData(ss));
end
fclose(fid);