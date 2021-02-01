clear all; close all;

addpath(genpath('Functions'));

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

save VH.mat VH -mat;


load VH_pred.mat;

plot(VH(:,1),VH(:,2) - 0.45,'r');hold on
plot(VH_pred(:,1),VH_pred(:,2),'k');

xlim([datenum(2013,01,01) datenum(2016,01,01)]);

% stop
% tidal = tidalfit(VH,'fm','robust','DetrendData',false);
% 
% VH_Detrend(:,1) =[datenum(2015,07,1):1/24:datenum(2016,07,01)];
% VH_Detrend(:,2) = tidalval(tidal,VH_Detrend(:,1));
% VH_Detrend(:,2) = VH_Detrend(:,2) + 0.7;
% 
% plot(mtime,tide,'k');hold on;
% 
% plot(VH_Detrend(:,1),VH_Detrend(:,2),'r');
% 
% fid = fopen('VH_Detrand.csv','wt');
% 
% for i = 1:length(VH_Detrend)
%     fprintf(fid,'%4.4f\n',VH_Detrend(i,2));
% end
% fclose(fid);

