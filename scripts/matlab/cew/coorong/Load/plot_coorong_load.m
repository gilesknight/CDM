clear all; close all;

[snum1,sstr1] = xlsread('Salt_daily_loading.csv','A2:D1829');

temp1 = datenum(sstr1,'dd/mm/yyyy');
ttt = find(temp1 >= datenum(2013,07,01) & temp1 < datenum(2016,07,01));
flow(:,1) = snum1(ttt,1);
tn(:,1) = snum1(ttt,2) / 1000;
tp(:,1) = snum1(ttt,3) / 1000;


datearray = temp1(ttt);

xarray = datenum(2013,07:06:43,01);

%_____________________________________________________________________

[snum,sstr]= xlsread('Flow/Barrage.csv','A2:B2193');

temp   = datenum(sstr,'dd/mm/yyyy');

sss = find(temp >= datenum(2013,07,01) & temp < datenum(2016,07,01));

flow(:,2) = snum(sss,1);

[snum,sstr]= xlsread('Flow/Murray.csv','A2:B2193');

temp   = datenum(sstr,'dd/mm/yyyy');

sss = find(temp >= datenum(2013,07,01) & temp < datenum(2016,07,01));

flow(:,3) = snum(sss,1) * -1;

%_____________________________________________________________________

[snum,sstr]= xlsread('TN/Barrage.csv','A2:B2193');

temp   = datenum(sstr,'dd/mm/yyyy');

sss = find(temp >= datenum(2013,07,01) & temp < datenum(2016,07,01));

tn(:,2) = snum(sss,1);

[snum,sstr]= xlsread('TN/Murray.csv','A2:B2193');

temp   = datenum(sstr,'dd/mm/yyyy');

sss = find(temp >= datenum(2013,07,01) & temp < datenum(2016,07,01));

tn(:,3) = snum(sss,1)* -1;

%_____________________________________________________________________

[snum,sstr]= xlsread('TP/Barrage.csv','A2:B2193');

temp   = datenum(sstr,'dd/mm/yyyy');

sss = find(temp >= datenum(2013,07,01) & temp < datenum(2016,07,01));

tp(:,2) = snum(sss,1);

[snum,sstr]= xlsread('TP/Murray.csv','A2:B2193');

temp   = datenum(sstr,'dd/mm/yyyy');

sss = find(temp >= datenum(2013,07,01) & temp < datenum(2016,07,01));

tp(:,3) = snum(sss,1)* -1;



%________________________________________________________________________

% figure
% 
% subplot(3,1,1)
% area(datearray,flow);legend({'Salt Creek';'Barrages';'Murray Mouth'});datetick('x')
% 
% subplot(3,1,2)
% 
% area(datearray,tn);legend({'Salt Creek';'Barrages';'Murray Mouth'});datetick('x')
% 
% subplot(3,1,3)
% 
% area(datearray,tp);legend({'Salt Creek';'Barrages';'Murray Mouth'});datetick('x')

%________________________________________________________________________

figure%('position',[1000.33333333333          277.666666666667                      1144                      1060]);

axes('position',[0.1 0.7 0.8 0.25])

plot(datearray,flow(:,2),'b');hold on
plot(datearray,flow(:,3),'r');hold on

ylabel('Flow (GL/day)','fontsize',8);

yyaxis right
plot(datearray,flow(:,1));
ylabel('Flow (GL/day)','fontsize',8);

set(gca,'xtick',xarray,'xticklabel',[]);

xlim([xarray(1) xarray(end)]);

leg = legend({'Barrages';'Murray Mouth';'Salt Creek'},'fontsize',6);
set(leg,'location','southeast');
grid on

axes('position',[0.1 0.4 0.8 0.25])

plot(datearray,tn(:,2),'b');hold on
plot(datearray,tn(:,3),'r');hold on

ylabel('TN (Tonnes/day)','fontsize',8);

yyaxis right
plot(datearray,tn(:,1));
ylabel('TN (Tonnes/day)','fontsize',8);

set(gca,'xtick',xarray,'xticklabel',[]);

xlim([xarray(1) xarray(end)]);

leg = legend({'Barrages';'Murray Mouth';'Salt Creek'},'fontsize',6);
set(leg,'location','southeast');
grid on
%subplot(3,1,3)
axes('position',[0.1 0.1 0.8 0.25])

plot(datearray,tp(:,2),'b');hold on
plot(datearray,tp(:,3),'r');hold on

ylabel('TP (Tonnes/day)','fontsize',8);

yyaxis right
plot(datearray,tp(:,1));
ylabel('TP (Tonnes/day)','fontsize',8);

set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'mmm-yyyy'),'fontsize',8);

xlim([xarray(1) xarray(end)]);

leg = legend({'Barrages';'Murray Mouth';'Salt Creek'},'fontsize',6);
set(leg,'location','southeast');
grid on

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 16;
ySize = 18;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])



saveas(gcf,'Load.png');