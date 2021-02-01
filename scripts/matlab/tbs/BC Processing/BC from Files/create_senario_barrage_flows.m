function create_scenario_barrage_flow

addpath(genpath('tuflowfv'));

site.ewe = tfv_readBCfile('Ewe_2017.csv');disp('Importing EwE');
site.mun = tfv_readBCfile('Mundoo_2017.csv');disp('Importing Mundoo');
site.glw = tfv_readBCfile('Goolwa_2017.csv');disp('Importing Goolwa');
site.tau = tfv_readBCfile('Tauwitchere_2017.csv');disp('Importing Tau');
site.bnd = tfv_readBCfile('Boundary_2017.csv');disp('Importing Boundary');

u_days = site.tau.Date;


all_sites = fieldnames(site);


% Convert each day (for each site) to ML/day
for i = 1:length(u_days)
    for j = 1:length(all_sites)
        daily.(all_sites{j})(i) = site.(all_sites{j}).Flow(i) * (86400 / 1000);
    end
end


% Example of 30 Goolwa 70 Tau split.

for i = 1:length(u_days)
    daily_tot = 0;
    for j = 1:length(all_sites)
        daily_tot = daily_tot + daily.(all_sites{j})(i);
    end
    
    split.tau(i) = daily_tot * 0.7;
    split.glw(i) = daily_tot * 0.3;
    
    
end

% Convert back to m3/s

split.tau = split.tau .* (1000/86400);
split.glw = split.glw .* (1000/86400);

%__________________________________________________________________
datatau = site.tau;
datatau.Flow = split.tau;

filename = 'Tauwitchere_70.csv';
write_tfv_file(filename,datatau);

dataglw = site.glw;
dataglw.glw = split.glw;

filename = 'Goolwa_30.csv';
write_tfv_file(filename,dataglw);

plot(datatau.Date,datatau.Flow,'k');hold on
plot(dataglw.Date,dataglw.Flow,'r');
legend({'Tauwitchere','Goolwa'});
datetick('x','mm-yy');
ylabel('Flow (m^3/s');

saveas(gcf,'70_30_split_barrage_flow.png');
close;

end

