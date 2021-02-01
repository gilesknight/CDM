clear all; close all;

dat = load('Sealevel_2014.dat');
dat2 = load('Sealevel_update.dat');

mtime = [datenum(1900,01,dat(:,1));datenum(1900,01,dat2(:,1))];
tide = [dat(:,2);dat2(:,2)];

[mtime,ind] = sort(mtime);
tide = tide(ind);


[mtime,ind] = unique(mtime);
tide = tide(ind);

VH(:,1) = mtime;
VH(:,2) = tide;

%______________________

load('../DEWNR Web/dwlbc.mat');

CR(:,1) = dwlbc.A4261039.H.Date;
CR(:,2) = dwlbc.A4261039.H.Data;

datearray = datenum(2010,01,01):01:datenum(2010,06,01);

inc = 1;

for i = 1:length(datearray)
    
    disp(datestr(datearray(i)));
    
    ss = find(floor(VH(:,1)) == datearray(i));
    
    tt = find(CR(:,1) == datearray(i));
    
    if ~isempty(tt) & ~isempty(ss)
        
        daily_ave = mean(VH(ss,2));
        
        offset(inc,1) = daily_ave - CR(tt(1),2);
        
        inc = inc + 1;
    end
end

mean(offset)

plot(datearray,offset,'k');