clear all; close all;

addpath(genpath('tuflowfv'));

tau = tfv_readBCfile('New Files/Tauwitchere_2017.csv');

glw = tfv_readBCfile('New Files/Tauwitchere_2017.csv');

[snum,~] = xlsread('Scenario_Barrage_Flow.xlsx','A2:B13');

mon = snum(:,1);
GL = snum(:,2);
ML = GL*1000;


% 1) 50:50 split over Goolwa and Tauwitchere and 
% 2) 10:90 split over Goolwa and Tauwitchere.

[yyyy,mm] = datevec(tau.Date);

u_months = unique(mm);
u_years = unique(yyyy); % Needed for leap years

tau_50 = tau;
tau_90 = tau;
glw_50 = glw;
glw_10 = glw;
bar_100 = tau;

for k = 1:length(u_years)
    for i = 1:length(u_months)

        sss = find(mm == u_months(i) & yyyy == u_years(k));

        num_days = length(sss);

        tt = find(mon == u_months(i));
        
        ML_month = ML(tt);
        
        % 1 barrage file at 100%
        m3_s = (ML_month) * (1000 / (86400 * num_days));

        bar_100.Flow(sss) = m3_s;
        
        % tau_90
        m3_s = (ML_month*0.9) * (1000 / (86400 * num_days));
        
        tau_90.Flow(sss) = m3_s;
        
        % tau_50 & glw 50
        m3_s = (ML_month*0.5) * (1000 / (86400 * num_days));
        
        tau_50.Flow(sss) = m3_s;
        glw_50.Flow(sss) = m3_s;
        
        % glw 10
        m3_s = (ML_month*0.1) * (1000 / (86400 * num_days));
        
        glw_10.Flow(sss) = m3_s;
    end
end

write_tfv_file('New Files/Tauwitchere_90.csv',tau_90);
write_tfv_file('New Files/Tauwitchere_50.csv',tau_50); 
write_tfv_file('New Files/Goolwa_50.csv',glw_50);
write_tfv_file('New Files/Goolwa_10.csv',glw_10);
write_tfv_file('New Files/Barrage_100.csv',bar_100);


figure;

plot(tau_90.Date,tau_90.Flow,'k');hold on
plot(tau_50.Date,tau_50.Flow,'r');hold on
plot(glw_50.Date,glw_50.Flow,'--g');hold on
plot(glw_10.Date,glw_10.Flow,'b');hold on
plot(bar_100.Date,bar_100.Flow,'b');hold on


legend({'Tau 90%';'Tau 50%';'Goolwa 50%';'Goolwa 10%';'Barrage 100%'});
datetick('x','mm-yy');

ylabel('Flow (m^3/s)');

saveas(gcf,'Barrage_Scenario_Comarpison.png');       

close



