clear all; close all;

load barrages_daily.mat;


mdate = barrages_daily.Total.Date;
flow = barrages_daily.Total.Flow * (86400/1000);

dvec = datevec(mdate);

u_years = unique(dvec(:,1));

fid = fopen('Monthly_Barrage_total.csv','wt');
fprintf(fid,'Date,Total\n');

for i = 1:length(u_years)
    for j = 1:12
        
        fprintf(fid,'%s,',datestr(datenum(u_years(i),j,01)));
        
        sss = find(dvec(:,1) == u_years(i) & ...
            dvec(:,2) == j);
        
        if ~isempty(sss)
            total = sum(flow(sss));
            fprintf(fid,'%10.4f',total);
        end
        
        fprintf(fid,'\n');
    end
end