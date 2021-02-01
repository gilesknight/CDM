clear all; close all;

load barrages_daily.mat;
load barrage_2017.mat;

plot(barrages_daily.Tauwitchere.Date,barrages_daily.Tauwitchere.Flow);hold on
plot(bar.Tauwitchere.Date,bar.Tauwitchere.Flow,'--');

oS = fieldnames(barrages_daily);
% 
for i = 1:length(oS)
    
    
    sss = find(barrages_daily.(oS{i}).Date < bar.(oS{i}).Date(1));
    
    mflow = [barrages_daily.(oS{i}).Flow(sss);bar.(oS{i}).Flow];
    mDate = [barrages_daily.(oS{i}).Date(sss)';bar.(oS{i}).Date];
    
    fid = fopen([oS{i},'_Flow.csv'],'wt');
    fprintf(fid,'Time,Q\n');
    for j = 1:length(mDate)
        fprintf(fid,'%s,%4.4f\n',datestr(mDate(j),'dd/mm/yyyy HH:MM:SS'),mflow(j));
    end
    fclose(fid);
    figure;
    plot(mDate,mflow);datetick('x');saveas(gcf,[oS{i},'.png']);close;
end