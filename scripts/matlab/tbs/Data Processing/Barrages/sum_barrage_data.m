clear all; close all;

load barrages.mat;

sites = fieldnames(barrages);

alldate = barrages.Goolwa.Date;

[yy,mm,dd] = datevec(alldate);

uYears = unique(yy);
uMonths = unique(mm);

oct_2015 = 0;

fid = fopen('Totals.csv','wt');
fprintf(fid,'Year,Month,Total\n');

for i = 1:length(uYears)
    for j = 1:length(uMonths)
        
        tot = 0;
        for k = 1:length(sites);
                            sss = find(barrages.(sites{k}).Date >= datenum(uYears(i),uMonths(j),1) & barrages.(sites{k}).Date < datenum(uYears(i),uMonths(j)+1,01));

            if ~isempty(sss)
                
                tot = tot + sum(barrages.(sites{k}).Raw(sss));
            end
        end
        fprintf(fid,'%d,%d,%8.4f\n',uYears(i),uMonths(j),tot);
    end
    
end

fclose(fid);