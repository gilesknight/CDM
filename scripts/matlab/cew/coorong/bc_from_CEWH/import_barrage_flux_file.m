clear all; close all;

% [snum,sstr] = xlsread('Daily_Flux_File/barrage.csv','A2:D20000');
% 
% dat.mdate = datenum(sstr(:,1),'dd/mm/yyyy');
% dat.barrage_ML = snum(:,1) * 1000;
% dat.barrage = barrage_ML * (1000 / 86400);
% 
% save barrage.mat dat -mat;
%Cross check code with observed data
% ss = find(mdate >= datenum(2016,07,01) & mdate <= datenum(2017,07,01));
% 
% 
% plot(mdate(ss),barrage(ss) * 1000);hold on
% 
% 
% [snum,sstr] = xlsread('Daily_Flux_File/recorded_barrages.xlsx','A2:D20000');
% 
% mdate1 = datenum(sstr(:,1),'dd/mm/yyyy');
% barrage1 = snum(:,1);
% 
% plot(mdate1,barrage1,'b');


dirlist = dir(['Daily_Flux_File/Barrages/','*.csv']);

for i = 1:length(dirlist)
    site = regexprep(dirlist(i).name,'.csv','');
    
    [snum,sstr] = xlsread(['Daily_Flux_File/Barrages/',dirlist(i).name],'A2:D20000');
    
    barrages.(site).Date = datenum(sstr(:,1),'dd/mm/yyyy');
    barrages.(site).Flow = (snum(:,1) * 1000) * (1000/86400);
    
end
save barrages.mat barrages -mat;