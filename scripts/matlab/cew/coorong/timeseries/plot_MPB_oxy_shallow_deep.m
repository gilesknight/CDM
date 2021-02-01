clear all; close all;

mpb = load('Y:\Coorong Report\Process_Final\ORH_Base_3D_20140101_20170101\WQ_OXY_OXY.mat');
orh = load('Y:\Coorong Report\Process_Final\ORH_Base_20140101_20170101\WQ_OXY_OXY.mat');

north_deep = 5950;
north_shallow = 6425;


south_deep = 23564;
south_shallow = 24348;

mtime = mpb.savedata.Time;
moxy_deep = mpb.savedata.WQ_OXY_OXY.Bot(south_deep,:) * 32/1000;
moxy_shallow = mpb.savedata.WQ_OXY_OXY.Bot(south_shallow,:) * 32/1000;

otime = orh.savedata.Time;
ooxy_deep = orh.savedata.WQ_OXY_OXY.Bot(south_deep,:) * 32/1000;
ooxy_shallow = orh.savedata.WQ_OXY_OXY.Bot(south_shallow,:) * 32/1000;

xarray = datenum(2014,11:01:15,01);

figure('position',[881          596.333333333333          1321.33333333333          445.333333333333]);
axes('position',[0.05 0.53 0.9 0.45]);
plot(otime,ooxy_shallow,'color',[0.749019607843137 0.227450980392157 0.0039215686274509]);hold on
plot(mtime,moxy_shallow,'color','b');hold on
xlim([xarray(1) xarray(end)]);
ylim([2 14]);
set(gca,'xtick',xarray,'xticklabel',[]);
grid on
legend({'ORH Shallow';'MPB Shallow'});
ylabel('Oxygen (mg/L)');

axes('position',[0.05 0.05 0.9 0.45]);
plot(otime,ooxy_deep,'color',[0.749019607843137 0.227450980392157 0.0039215686274509]);hold on
plot(mtime,moxy_deep,'color','b');hold on
xlim([xarray(1) xarray(end)]);
set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'mmm-yy'));
grid on
legend({'ORH Deep';'MPB Deep'});
ylim([2 14]);
ylabel('Oxygen (mg/L)');
xlabel('Date');
saveas(gcf,'South Coorong MPB Oxygen.png');