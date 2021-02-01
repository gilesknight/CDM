clear all; close all;
datearray = datenum(2008,01,1):1:datenum(2018,08,10);


load ../'BC from Field Data'/lowerlakes.mat;




mDate = [datenum(2008,01,01,00,00,00);datenum(2008,11,23);datenum(2008,12,12);lowerlakes.A4261156.H.Date];
mData = [0.5;0.5;-0.4830;lowerlakes.A4261156.H.Data];




intData = interp1(mDate(~isnan(mData)),mData(~isnan(mData)),datearray,'linear','extrap');



fid = fopen('Target.csv','wt');

fprintf(fid,'time,target_value\n');



for i = 1:length(datearray)

    fprintf(fid,'%s,%5.5f\n',datestr(datearray(i),'dd/mm/yyyy HH:MM'),intData(i));
    
end
fclose(fid);

target.A4261156.Date = datearray;
target.A4261156.Data = intData;



mDate = [datenum(2008,01,01,00,00,00);datenum(2008,11,23,00,00 ,00);lowerlakes.A4261123.H.Date];
mData = [0.5;0.5;lowerlakes.A4261123.H.Data];


intData = interp1(mDate(~isnan(mData)),mData(~isnan(mData)),datearray,'linear','extrap');



fid = fopen('Goolwa_Target.csv','wt');

fprintf(fid,'time,target_value\n');



for i = 1:length(datearray)

    fprintf(fid,'%s,%5.5f\n',datestr(datearray(i),'dd/mm/yyyy HH:MM'),intData(i));
    
end
fclose(fid);

target.A4261123.Date = datearray;
target.A4261123.Data = intData;

save target.mat target -mat;


figure;

plot(target.A4261156.Date,target.A4261156.Data);hold on
plot(target.A4261123.Date,target.A4261123.Data);hold on
%datetick('x','mmm yyyy');
xlim([datenum(2008,01,01) datenum(2018,07,01)]);
legend({'Pnt Mcleay';'Goolwa Channel'});

saveas(gcf,'Trigger Levels.png');







