outdir = 'Scenarios/';
l2017c = tfv_readBCfile([outdir,'2017_Lock1_noCEW.csv']);
l2017a = tfv_readBCfile([outdir,'2017_Lock1_noALL.csv']);
l2017 = tfv_readBCfile('2017_Lock1_Obs.csv');


figure

plot(l2017.Date,l2017.FLOW,'b');hold on
plot(l2017c.Date,l2017c.FLOW,'r');hold on
plot(l2017a.Date,l2017a.FLOW,'g');hold on

xlim([datenum(2015,07,01) datenum(2017,07,01)]);

yr = 2015;



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);
def.datearray = datenum(yr,07:03:33,01);


set(gca,'xtick',def.datearray,'xticklabel',datestr(def.datearray,'mm-yy'));


legend({'With All Water';'No CEW';'No eWater'});