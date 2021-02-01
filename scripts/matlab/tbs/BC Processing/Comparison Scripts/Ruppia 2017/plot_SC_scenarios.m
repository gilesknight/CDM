addpath(genpath('tuflowfv'));

clear all; close all;

% SC40
% Salt_Creek_Existing_1889_2016 @ 1.143
% 
% Sc70
% Salt_Creek_Current_SEFRP_1889_2016 @  0.9122
% 
% SC55
% Salt_Creek_Current_SEFRP_1889_2016 @ 0.7168

data = tfv_readBCfile('SC/Salt_2017.csv');

orh_time = data.Date;
orh_flow = data.FLOW;

data = tfv_readBCfile('SC/Salt_Creek_Existing_1889_2016.csv');

sc40_time = data.Date;
sc40_flow = data.FLOW * 1.143;

data = tfv_readBCfile('SC/Salt_Creek_Current_SEFRP_1889_2016.csv');

sc70_time = data.Date;
sc70_flow = data.FLOW * 0.9122;

sc55_time = data.Date;
sc55_flow = data.FLOW * 0.7168;

%%


plot(orh_time,orh_flow,'b');hold on;
plot(sc70_time,sc70_flow,'r');hold on;
plot(sc55_time,sc55_flow,'g');hold on;
plot(sc40_time,sc40_flow,'k');hold on;


xlim([datenum(2014,01,01) datenum(2017,01,01)]);

xarray = datenum(2014,01:06:37,01);

set(gca,'xtick',xarray,'xticklabel',datestr(xarray,'mm-yyyy'));

legend({'ORH';'SC70';'Sc55';'SC40'},'location','northwest');

ylabel('Flow (m^3/s)')

grid on

plot([datenum(2014,04,01) datenum(2014,04,01)],[0 25],'--k'); 
plot([datenum(2015,12,01) datenum(2015,12,01)],[0 25],'--k'); 

ylim([0 20]);
