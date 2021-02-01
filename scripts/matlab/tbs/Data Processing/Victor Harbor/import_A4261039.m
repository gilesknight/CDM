clear all; close all;

filename = 'A4261039_2014.csv';

fid = fopen(filename,'rt');

x  = 3;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',3,'Delimiter',',');
fclose(fid);

Flow(:,1) = str2double(datacell{2});
mDate(:,1) = datenum(datacell{1},'dd/mm/yyyy HH:MM'); 


filename = 'A4261039_2015.csv';

fid = fopen(filename,'rt');

x  = 3;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',3,'Delimiter',',');
fclose(fid);

Flow1(:,1) = str2double(datacell{2});
mDate1(:,1) = datenum(datacell{1},'dd/mm/yyyy HH:MM'); 


sss = find(mDate < mDate1(1));

% data.mDate = [mDate(sss);mDate1];
% data.Tide = [Flow(sss);Flow1];

filename = 'A4261039_2013.csv';

fid = fopen(filename,'rt');

x  = 3;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',3,'Delimiter',',');
fclose(fid);

Flow2(:,1) = str2double(datacell{2});
mDate2(:,1) = datenum(datacell{1},'HH:MM:SS dd/mm/yyyy'); 


ttt = find(mDate2 < mDate(1));

data.mDate = [mDate2(ttt);mDate(sss);mDate1];
data.Tide = [Flow2(ttt);Flow(sss);Flow1];


save A4261039.mat data -mat;

load VH.mat;


% T1 = VH(:,2) - 0.6;
% 
% 
% plot(VH(:,1),T1,'r','displayname','0.6');hold on
% 
% T2 = VH(:,2) - 0.5;
% 
% 
% plot(VH(:,1),T2,'r','displayname','0.5');hold on


T3 = VH(:,2) - 0.4;


plot(VH(:,1),T3,'b','displayname','0.4');hold on



plot(data.mDate,data.Tide,'k','displayname','Inside');

xlim([datenum(2013,01,01) datenum(2013,01,40)]);

legend('location','northeast');
% 
% 