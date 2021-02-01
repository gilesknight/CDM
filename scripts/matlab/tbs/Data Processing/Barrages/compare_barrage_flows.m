clear all; close all;

load Flux.mat;

load barrage_2017.mat;

load ../'DEWNR Web'/dwlbc.mat;

site = 'A4260903';




[snum,sstr] = xlsread('Tauwitchere_Flow.csv','A2:B10000');

mDate = datenum(sstr(:,1),'dd/mm/yyyy');
Flow = snum;


% plot(bar.Tauwitchere.Date,bar.Tauwitchere.Flow,'--');hold on

% plot(mDate,Flow);
% 
% 
% plot(flux.Lock1.mDate,flux.Lock1.Flow);hold on
% 
% plot(flux.Tauwitchere.mDate,flux.Tauwitchere.Flow);hold on
% legend({'recorded';'File';'Lock 1';'model';});
% 
%  datetick('x')
 
 
 figure
 
 
 lock_1 = dwlbc.(site).Flow_m3.Data * (86400 / 1000);
 
plot(dwlbc.(site).Flow_m3.Date,dwlbc.(site).Flow_m3.Data);hold on
plot(bar.Total.Date,bar.Total.Flow);


u_days = unique(floor(flux.Boundary.mDate));

for i = 1:length(u_days)
    ss = find(floor(flux.Boundary.mDate) == u_days(i));
    
    

    bar_total(i) = sum(flux.Boundary.Flow(ss) * (7200/1000)) + ...
        sum(flux.Tauwitchere.Flow(ss) * (7200/1000)) + ...
        sum(flux.Ewe.Flow(ss) * (7200/1000)) + ...
        sum(flux.Goolwa.Flow(ss) * (7200/1000)) + ...
        sum(flux.Mundoo.Flow(ss) * (7200/1000)) ;
    
end
        
figure

plot(u_days,bar_total);hold on
%(dwlbc.(site).Flow_m3.Date,lock_1);
plot(bar.Total.Date,bar.Total.Raw);
 
 
tt = find(dwlbc.(site).Flow_m3.Date >= u_days(1) & dwlbc.(site).Flow_m3.Date <= u_days(end));

ll = sum(lock_1(tt));

bb = sum(bar_total);

leftover = ll - bb;

surface_area = 964183662;

leftover_m3 = leftover * 1000;



