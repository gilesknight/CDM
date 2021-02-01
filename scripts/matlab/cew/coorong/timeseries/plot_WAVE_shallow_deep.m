clear all; close all;

var = 'WVHT';

mpb = tfv_readnetcdf('R:\Coorong-Local\NetCDF_WAVE\ORH_Base_WAVE_20140101_20140201.nc','names',{var});
orh = tfv_readnetcdf('R:\Coorong-Local\NetCDF_WAVE\ORH_Base_20140101_20170101_noAED.nc','names',{var});

mpbt = tfv_readnetcdf('R:\Coorong-Local\NetCDF_WAVE\ORH_Base_WAVE_20140101_20140201.nc','time',1);
orht = tfv_readnetcdf('R:\Coorong-Local\NetCDF_WAVE\ORH_Base_20140101_20170101_noAED.nc','time',1);

%wave = tfv_readnetcdf('R:\Coorong-Local\NetCDF_WAVE\WAVE.nc');

% dat = tfv_readnetcdf('R:\Coorong-Local\NetCDF_WAVE\ORH_Base_WAVE_20140101_20140201.nc','timestep',1);
% clear funcions
% bottom_cells(1:length(dat.idx3)-1) = dat.idx3(2:end) - 1;
% bottom_cells(length(dat.idx3)) = length(dat.idx3);


north_deep = 5950;
north_shallow = 6425;


south_deep = 23564;
south_shallow = 24348;

mtime = mpbt.Time;
moxy_deep = mpb.(var)(south_deep,:);
moxy_shallow = mpb.(var)(south_shallow,:);

otime = orht.Time;
ooxy_deep = orh.(var)(south_deep,:);
ooxy_shallow = orh.(var)(south_shallow,:);

xarray = datenum(2014,01,01:01:05);

figure('position',[881          596.333333333333          1321.33333333333          445.333333333333]);
axes('position',[0.05 0.53 0.9 0.45]);
plot(otime,ooxy_shallow,'color',[0.749019607843137 0.227450980392157 0.0039215686274509]);hold on
plot(mtime,moxy_shallow,'--','color','b');hold on
xlim([xarray(1) xarray(end)]);
%ylim([2 14]);
set(gca,'xtick',xarray,'xticklabel',[]);
grid on
legend({'ORH Shallow';'WAVE Shallow'});
ylabel(var);

axes('position',[0.05 0.05 0.9 0.45]);
plot(otime,ooxy_deep,'color',[0.749019607843137 0.227450980392157 0.0039215686274509]);hold on
plot(mtime,moxy_deep,'--','color','b');hold on
xlim([xarray(1) xarray(end)]);
set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'dd-mmm'));
grid on
legend({'ORH Deep';'WAVE Deep'});
%ylim([2 14]);
ylabel(var);
xlabel('Date');
saveas(gcf,['South Coorong ',var,'.png']);