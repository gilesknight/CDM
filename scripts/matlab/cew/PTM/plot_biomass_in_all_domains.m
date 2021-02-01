clear all; close all;

addpath(genpath('functions'));

mod_ncfile = 'I:\GCLOUD\PTM_Results_v3\Moonie\Output_1_1\run.nc';

%ptm = import_PTM_BC_Files('E:\Github 2018\Carp_PTM\Murray\Input\PTM\1\PTM\');

%save moonie_ptm.mat ptm -mat;
load moonie_ptm.mat;


savename = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\FINALREPORT\8. Biomass\Moonie.png';

mDate = datenum(2016,04,07);

data = tfv_readnetcdf(mod_ncfile,'names',{'D';'WQ_DIAG_PTM_TOTAL_MASS';'WQ_DIAG_PTM_TOTAL_COUNT';'V_x';'V_y';'cell_A'});

dat = tfv_readnetcdf(mod_ncfile,'time',1);
time = dat.Time;

for i = 1:size(ptm.Date,2)
    sss = find(ptm.Balls(:,i) > 0);
    if i >1
        pBalls(i,1) = length(sss) + pBalls(i-1,1);
    else
        pBalls(i,1) = length(sss);
    end
    pDate(i,1) = ptm.Date(1,i);
end



for i = 1:length(time)
    


    
    ttt = find(data.D(:,i) > 0.1);
  
    
    Deep_Ball(i) = sum(data.WQ_DIAG_PTM_TOTAL_COUNT(ttt,i));
    Deep_Ball_NA(i) = Deep_Ball(i) * 50;% /(area / 10000);
    
    area = sum(data.cell_A(ttt));
    Deep_Ball(i) = Deep_Ball(i) * 50 /(area / 10000);
    
    
    
    
    sss = find(data.D(:,i) <= 0.5 & data.D(:,i) > 0.1);
    Shallow_Ball(i) = sum(data.WQ_DIAG_PTM_TOTAL_COUNT(sss,i));
    Shallow_Ball_NA(i) = Shallow_Ball(i) * 50;%
    
    Shallow_Ball(i) = Shallow_Ball(i) * 50 /(sum(data.cell_A(sss)) / 10000);
    
    
    
    ttt = find(data.D(:,i) > 0.1);
    Deep_mass(i) = sum(data.WQ_DIAG_PTM_TOTAL_MASS(ttt,i));
    
    area = sum(data.cell_A(ttt));
    Deep_mass(i) = Deep_mass(i) /(area / 10000)/1000;
    Deep_mass_NA(i) = sum(data.WQ_DIAG_PTM_TOTAL_MASS(ttt,i)) / 1000;
    
    sss = find(data.D(:,i) <= 0.5 & data.D(:,i) > 0.1);
    Shallow_mass(i) = sum(data.WQ_DIAG_PTM_TOTAL_MASS(sss,i));
    Shallow_mass(i) = Shallow_mass(i) /(sum(data.cell_A(sss)) / 10000)/1000;
    Shallow_mass_NA(i) = sum(data.WQ_DIAG_PTM_TOTAL_MASS(sss,i)) / 1000;
    
    
end

mtime = time - mDate;
ppDate = pDate - mDate;  
figure
set(0,'defaultAxesFontSize',8);

subplot(1,2,1)

plot(mtime,Deep_Ball,'--r');hold on
plot(mtime,Shallow_Ball,'r');hold on

plot(mtime,Deep_mass,'--g');hold on
plot(mtime,Shallow_mass,'g');hold on

legend({'$B_{{deep}_0}$';'$B_{{shallow}_0}$';'$B_{deep}$';'$B_{shallow}$'},'location','northwest','Interpreter','latex','fontsize',6);

ylabel('Biomass Density (kg/Ha)','fontsize',8);
xlabel('Days','fontsize',8);

xlim([-7 28]);

subplot(1,2,2)

plot(mtime,Deep_Ball_NA,'--r');hold on
plot(mtime,Shallow_Ball_NA,'r');hold on

plot(mtime,Deep_mass_NA,'--g');hold on
plot(mtime,Shallow_mass_NA,'g');hold on

plot(ppDate,pBalls*50,'k')

% N_{P}_{gen} \. P_{DW}_0. 
% N_{P}_{gen} \. P_{DW}. 



legend({'$N_{P_{deep}}$ $P_{DW_0}$';'$N_{P_{shallow}}$ $P_{{DW}_0}$';'$N_{P_{deep}}$ $P_{DW}$';'$N_{P_{shallow}}$ $P_{DW}$'},'location','northwest','Interpreter','latex','fontsize',6);

ylabel('Biomass (kg)','fontsize',8);
xlabel('Days','fontsize',8);
xlim([-7 28]);

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 14;
ySize = 7;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize]);

print(gcf,savename,'-dpng','-r200');

close;
