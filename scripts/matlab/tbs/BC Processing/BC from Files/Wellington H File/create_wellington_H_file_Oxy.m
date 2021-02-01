clear all; close all;

addpath(genpath('../tuflowfv'));

load lowerlakes.mat;

wel = tfv_readBCfile('Wellington_v3.csv');

load('D:\Cloud\Dropbox\Data_Lowerlakes\Data Processing\DEWNR Web\dwlbc.mat');

msite = 'A4261159';

mdate = min(dwlbc.(msite).H.Date);

ss = find(dwlbc.A4260575.H.Date < mdate);% &dwlbc.A4260575.H.Date >= datenum(2008,01,01));





plot(dwlbc.A4260575.H.Date(ss),dwlbc.A4260575.H.Data(ss));hold on
plot(dwlbc.(msite).H.Date,dwlbc.(msite).H.Data);

pD = [dwlbc.A4260575.H.Date(ss);dwlbc.(msite).H.Date];
pH = [dwlbc.A4260575.H.Data(ss);dwlbc.(msite).H.Data];

nH = interp1(pD(~isnan(pH)),pH(~isnan(pH)),wel.Date);

oD = lowerlakes.EPA2014_Lake_Alexandrina_Wellington.WQ_OXY_OXY.Date;
oO = lowerlakes.EPA2014_Lake_Alexandrina_Wellington.WQ_OXY_OXY.Data;

oD1 = lowerlakes.SAW_Tailem_Bend.WQ_OXY_OXY.Date;
oO1 = lowerlakes.SAW_Tailem_Bend.WQ_OXY_OXY.Data;

uu = find(oD1 >= datenum(2014,01,01));
tt = find(oD < datenum(2014,01,01));

oD2  = [oD(tt);oD1(uu)];
oO2  = [oO(tt);oO1(uu)];

nO = interp1(oD2(~isnan(oO2)),oO2(~isnan(oO2)),wel.Date);
figure;plot(wel.Date,nO);datetick('x')

vv = find(wel.Date >= datenum(2009,01,01));

wel.FLOW = nH;
wel.OXY(vv) = nO(vv);

write_tfv_file('Wellington_H_O.csv',wel);