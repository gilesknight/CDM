clear all; close all;

flow = tfv_readBCfile('Lock1_All.csv');

flow.ML = flow.FLOW * 86400/1000;

dvec = datevec(flow.Date);

years = unique(dvec(:,1));

inc = 1;

for i = 1:length(years)
    for j = 1:12
        
        mdate(inc,1) = datenum(years(i),j,1);
        
        sss = find(dvec(:,1) == years(i) & dvec(:,2) == j);
        
        monthly(inc,1) = sum(flow.ML(sss)) / 1000;
        
        inc = inc + 1;
        
    end
end

load barrages_daily.mat;


bdate = barrages_daily.Total.Date;
bflow = barrages_daily.Total.Flow * (86400/1000);

dvec = datevec(bdate);

u_years = unique(dvec(:,1));

inc = 1;
for i = 1:length(u_years)
    for j = 1:12
        
        ddate(inc,1) = datenum(u_years(i),j,1);
        sss = find(dvec(:,1) == u_years(i) & ...
            dvec(:,2) == j);
        
        if ~isempty(sss)
            total(inc,1) = sum(bflow(sss)) / 1000;
        else
            total(inc,1) = 0;
        end
        inc = inc + 1;
        
    end
end


[snum,sstr] = xlsread('Barrage.csv','A2:C100');

moddate = datenum(snum(:,2),snum(:,1),01);
modflow = snum(:,3);


target = tfv_readBCfile('Target.csv');
evap = tfv_readBCfile('NetEvap_1.0.csv');



figure('position',[44         558        1743         420]);
plot(mdate,monthly);hold on;
plot(ddate,total);
plot(moddate,modflow);

ylabel('Flow (GL / Month)');

yyaxis right

plot(target.Date,target.target_value);hold on;

plot([datenum(2013,08,01) datenum(2013,08,01)],[0 1],'--k');
plot([datenum(2013,12,01) datenum(2013,12,01)],[0 1],'--k');
ylim([0.5 0.9]);

xlim([datenum(2013,01,01) datenum(2013,12,01)]);

set(gca,'xtick',datenum(2013,01:01:12,01),'xticklabel',datestr(datenum(2013,01:01:12,01),'mm-yyyy'));


grid on;


sss = find(evap.Date >= datenum(2013,08,01) & evap.Date <= datenum(2013,12,01));

mean_evap = mean(evap.NetEvap_mmd(sss));

alex_area =   649000000;
albert_area = 168000000;

total_area = alex_area + albert_area;


evap = (total_area * (mean_evap/1000)) * 1000;
evap = evap * 1e-9;




sss = find(mdate >= datenum(2013,08,1) & mdate < datenum(2013,12,01));
ttt = find(ddate >= datenum(2013,08,1) & ddate < datenum(2013,12,01));
www = find(moddate >= datenum(2013,08,1) & moddate < datenum(2013,12,01));

total_flow = sum(monthly(sss));
calc_barrage = sum(total(ttt));
model_barrage = sum(modflow(www));

datearray = datenum(2013,08,01:01:122);

total_evap = evap * length(datearray);





saveas(gcf,'Lock1 Flow.png');