clear all; close all;

addpath(genpath('tuflowfv'));

files = {'Tauwitchere';'Ewe';'Boundary';'Mundoo';'Goolwa';};

for i = 1:length(files)
    
    data = tfv_readBCfile([files{i},'_2017.csv']);
    
    old.(files{i}).mDate = data.Date;
    old.(files{i}).Flow = data.Flow;
    
    
    data = tfv_readBCfile([files{i},'_v3.csv']);
    
    new.(files{i}).mDate = data.Date;
    new.(files{i}).Flow = data.Flow;
    
    plot(old.(files{i}).mDate,old.(files{i}).Flow,'r');hold on
    plot(new.(files{i}).mDate,new.(files{i}).Flow,'k');hold on
    
    datetick('x','mm-yy');
    
    saveas(gcf,[files{i},'.png']);
    close;
end
    

