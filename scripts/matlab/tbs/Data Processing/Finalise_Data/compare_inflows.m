clear all; close all;

load lowerlakes.mat;

bigmod = lowerlakes.Lock1.FLOW;
dewnr = lowerlakes.A4260903.FLOW;

 plot(bigmod.Date,bigmod.Data,'k');hold on
 plot(dewnr.Date,dewnr.Data,'r');
% plot(lowerlakes.A4260903.Flow_ML_Calc.Date,lowerlakes.A4260903.Flow_ML_Calc.Data,'--b');
 
 xlim([datenum(2013,01,01) datenum(2016,01,01)]);
 
xarray = datenum(2013:01:2016,01,01);

set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'yyyy'));