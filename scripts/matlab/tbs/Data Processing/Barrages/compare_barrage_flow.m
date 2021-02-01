clear all; close all;

load barrages_daily.mat;
load barrages.mat;

figure;
plot(barrages.Tauwitchere.Date,barrages.Tauwitchere.Flow,'k');hold on
plot(barrages_daily.Tauwitchere.Date,barrages_daily.Tauwitchere.Flow,'r');hold on

xlim([datenum(2015,01,01) datenum(2015,13,01)]);

ss = get(gca,'xtick');
set(gca,'xticklabel',datestr(ss));



figure;
plot(barrages.Ewe.Date,barrages.Ewe.Flow,'k');hold on
plot(barrages_daily.Ewe.Date,barrages_daily.Ewe.Flow,'r');hold on

xlim([datenum(2015,01,01) datenum(2015,13,01)]);

ss = get(gca,'xtick');
set(gca,'xticklabel',datestr(ss));


sss = find(barrages.Tauwitchere.Date >= datenum(2015,07,01) & barrages.Tauwitchere.Date < datenum(2015,08,01));

tot_hourly = sum(barrages.Tauwitchere.Raw(sss));


sss = find(barrages_daily.Tauwitchere.Date >= datenum(2015,07,01) & barrages_daily.Tauwitchere.Date < datenum(2015,08,01));

tot_daily = sum(barrages_daily.Tauwitchere.Raw(sss));
