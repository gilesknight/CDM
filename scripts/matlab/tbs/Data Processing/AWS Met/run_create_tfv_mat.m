clear all; close all;

addpath(genpath('Functions'));

load('Raw_backup\Chaffey\metdata.mat');

load('../DEWNR Web/dwlbc.mat');


data_file = metdata.RMPW03;

metfile = 'Chaffey/Chaffey_met.csv';
rainfile = 'Chaffey/Chaffey_rain.csv';
imagefile = 'Chaffey/Chaffey.png';


startdate = datenum(2016,01,01);
enddate = datenum(2017,01,01);

TZ = 9.5;

seatemp = calc_seatemp(dwlbc,'A4260510',startdate,enddate);

new_data = convert_data_hourly(data_file,startdate,enddate);

create_TFV_Met_From_AWS(metfile,rainfile,imagefile,new_data,startdate,enddate,TZ,seatemp);