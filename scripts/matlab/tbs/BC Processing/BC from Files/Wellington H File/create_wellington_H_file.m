clear all; close all;

addpath(genpath('../tuflowfv'));

wel = tfv_readBCfile('Wellington_v3.csv');

load('F:\Dropbox\Data_Lowerlakes\Data Processing\DEWNR Web\dwlbc.mat');

msite = 'A4261159';

mdate = min(dwlbc.(msite).H.Date);

ss = find(dwlbc.A4260575.H.Date < mdate);% &dwlbc.A4260575.H.Date >= datenum(2008,01,01));

plot(dwlbc.A4260575.H.Date(ss),dwlbc.A4260575.H.Data(ss));hold on
plot(dwlbc.(msite).H.Date,dwlbc.(msite).H.Data);

pD = [dwlbc.A4260575.H.Date(ss);dwlbc.(msite).H.Date];
pH = [dwlbc.A4260575.H.Data(ss);dwlbc.(msite).H.Data];

nH = interp1(pD(~isnan(pH)),pH(~isnan(pH)),wel.Date);

wel.FLOW = nH;

write_tfv_file('Wellington_H.csv',wel);