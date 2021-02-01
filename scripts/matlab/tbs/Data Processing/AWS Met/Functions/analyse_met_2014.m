clear all; close all;

load Langhorne_Crk' met output'\tfv_ll_met_Langhorne_Crk.mat;

LC = metout; clear metout;

load Narrung' met output'\tfv_ll_met_narrung.mat;

NR = metout; clear metout;

load Currency_crk' met output'\tfv_ll_met_currency_crk.mat;

CC = metout; clear metout;

load Mypolonga' met output'\tfv_ll_met_mypolonga.mat;

MY = metout; clear metout;


daterange = [datenum(2014,01,01) datenum(2014,07,01)];

tt = find(LC.NewDate >= daterange(1) & LC.NewDate < daterange(2));
tt1 = find(LC.RainDate >= daterange(1) & LC.RainDate < daterange(2));


% Air Temp

varname = 'Temp_interp';

[xdata,LC1.(varname)] = daily_ave(LC.NewDate(tt)',LC.(varname)(tt)');

[~,CC1.(varname)] = daily_ave(CC.NewDate(tt)',CC.(varname)(tt)');

[~,NR1.(varname)] = daily_ave(NR.NewDate(tt)',NR.(varname)(tt)');

[~,MY1.(varname)] = daily_ave(MY.NewDate(tt)',MY.(varname)(tt)');

% Rel Hum

varname = 'RH_interp';

[xdata,LC1.(varname)] = daily_ave(LC.NewDate(tt)',LC.(varname)(tt)');

[~,CC1.(varname)] = daily_ave(CC.NewDate(tt)',CC.(varname)(tt)');

[~,NR1.(varname)] = daily_ave(NR.NewDate(tt)',NR.(varname)(tt)');

[~,MY1.(varname)] = daily_ave(MY.NewDate(tt)',MY.(varname)(tt)');

% Sol Rad

varname = 'Rad_Model';

[xdata,LC1.(varname)] = daily_ave(LC.NewDate(tt)',LC.(varname)(tt)');

[~,CC1.(varname)] = daily_ave(CC.NewDate(tt)',CC.(varname)(tt)');

[~,NR1.(varname)] = daily_ave(NR.NewDate(tt)',NR.(varname)(tt)');

[~,MY1.(varname)] = daily_ave(MY.NewDate(tt)',MY.(varname)(tt)');

% Clouds

varname = 'TC_interp';

[xdata,LC1.(varname)] = daily_ave(LC.NewDate(tt)',LC.(varname)(tt)');

[~,CC1.(varname)] = daily_ave(CC.NewDate(tt)',CC.(varname)(tt)');

[~,NR1.(varname)] = daily_ave(NR.NewDate(tt)',NR.(varname)(tt)');

[~,MY1.(varname)] = daily_ave(MY.NewDate(tt)',MY.(varname)(tt)');

% Wind Speed

varname = 'W_Speed_interp';

[xdata,LC1.(varname)] = daily_ave(LC.NewDate(tt)',LC.(varname)(tt)');

[~,CC1.(varname)] = daily_ave(CC.NewDate(tt)',CC.(varname)(tt)');

[~,NR1.(varname)] = daily_ave(NR.NewDate(tt)',NR.(varname)(tt)');

[~,MY1.(varname)] = daily_ave(MY.NewDate(tt)',MY.(varname)(tt)');

% Rain

varname = 'Rain';

[xdata_rain,LC1.(varname)] = daily_ave(LC.RainDate(tt1)',LC.(varname)(tt1)');

[~,CC1.(varname)] = daily_ave(CC.RainDate(tt1)',CC.(varname)(tt1)');

[~,NR1.(varname)] = daily_ave(NR.RainDate(tt1)',NR.(varname)(tt1)');

[~,MY1.(varname)] = daily_ave(MY.RainDate(tt1)',MY.(varname)(tt1)');


xlab = datenum(2014,01:01:07,01);

fid = fopen('Met_Analysis.csv','wt');
fprintf(fid,'Site,Variable,P1,P2\n');

figure('position',[1993          49         935         942]);

set(gcf, 'DefaultAxesFontSize',7)

axes('position',[0.05 0.04 0.65 0.14])

plot(xdata_rain,LC1.Rain,'r');hold on
plot(xdata_rain,CC1.Rain,'k');hold on
plot(xdata_rain,NR1.Rain,'g');hold on
plot(xdata_rain,MY1.Rain,'m');hold on

text(0.9,0.9,num2str(mean(LC1.Rain)),'color','r','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.8,num2str(mean(CC1.Rain)),'color','k','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.7,num2str(mean(NR1.Rain)),'color','g','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.6,num2str(mean(MY1.Rain)),'color','m','units','normalized','fontsize',7,'fontweight','bold');



set(gca,'xtick',xlab,'xticklabel',datestr(xlab,'mmm'));

text(0.05,1.075,'Rain','units','normalized','fontsize',12);

legend({'LC';'CC';'NR';'MY'},'location','NorthWest','fontsize',10)

axes('position',[0.75 0.04 0.14 0.14])

scatter(NR1.Rain,LC1.Rain,'.r');hold on
scatter(NR1.Rain,CC1.Rain,'.k');hold on
scatter(NR1.Rain,MY1.Rain,'.m');hold on

box on;

[str] =add_polyfit_line(NR1.Rain,LC1.Rain,fid,'r','LC','Rain');
text(1.1,0.9,str,'color','r','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.Rain,CC1.Rain,fid,'k','CC','Rain');
text(1.1,0.8,str,'color','k','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.Rain,MY1.Rain,fid,'m','MY','Rain');
text(1.1,0.7,str,'color','m','units','normalized','fontsize',7,'fontweight','bold');

%xlim([0 0.06]);ylim([0 0.06]);


axes('position',[0.05 0.20 0.65 0.14])

plot(xdata,LC1.W_Speed_interp,'r');hold on
plot(xdata,CC1.W_Speed_interp,'k');hold on
plot(xdata,NR1.W_Speed_interp,'g');hold on
plot(xdata,MY1.W_Speed_interp,'m');hold on

set(gca,'xtick',xlab,'xticklabel',[]);
text(0.05,1.075,'Wind Speed','units','normalized','fontsize',12);

text(0.9,0.9,num2str(mean(LC1.W_Speed_interp)),'color','r','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.8,num2str(mean(CC1.W_Speed_interp)),'color','k','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.7,num2str(mean(NR1.W_Speed_interp)),'color','g','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.6,num2str(mean(MY1.W_Speed_interp)),'color','m','units','normalized','fontsize',7,'fontweight','bold');



axes('position',[0.75 0.20 0.14 0.14])

scatter(NR1.W_Speed_interp,LC1.W_Speed_interp,'.r');hold on
scatter(NR1.W_Speed_interp,CC1.W_Speed_interp,'.k');hold on
scatter(NR1.W_Speed_interp,MY1.W_Speed_interp,'.m');hold on

box on;

[str] =add_polyfit_line(NR1.W_Speed_interp,LC1.W_Speed_interp,fid,'r','LC','WS');
text(1.1,0.9,str,'color','r','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.W_Speed_interp,CC1.W_Speed_interp,fid,'k','CC','WS');
text(1.1,0.8,str,'color','k','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.W_Speed_interp,MY1.W_Speed_interp,fid,'m','MY','WS');
text(1.1,0.7,str,'color','m','units','normalized','fontsize',7,'fontweight','bold');

%xlim([0 10]);ylim([0 10]);


axes('position',[0.05 0.36 0.65 0.14])

plot(xdata,LC1.TC_interp,'r');hold on
plot(xdata,CC1.TC_interp,'k');hold on
plot(xdata,NR1.TC_interp,'g');hold on
plot(xdata,MY1.TC_interp,'m');hold on

set(gca,'xtick',xlab,'xticklabel',[]);
text(0.05,1.075,'Cloud Cover','units','normalized','fontsize',12);

text(0.9,0.5,num2str(mean(LC1.TC_interp)),'color','r','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.4,num2str(mean(CC1.TC_interp)),'color','k','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.3,num2str(mean(NR1.TC_interp)),'color','g','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.2,num2str(mean(MY1.TC_interp)),'color','m','units','normalized','fontsize',7,'fontweight','bold');


axes('position',[0.75 0.36 0.14 0.14])

scatter(NR1.TC_interp,LC1.TC_interp,'.r');hold on
scatter(NR1.TC_interp,CC1.TC_interp,'.k');hold on
scatter(NR1.TC_interp,MY1.TC_interp,'.m');hold on

box on;

[str] =add_polyfit_line(NR1.TC_interp,LC1.TC_interp,fid,'r','LC','Clouds');
text(1.1,0.9,str,'color','r','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.TC_interp,CC1.TC_interp,fid,'k','CC','Clouds');
text(1.1,0.8,str,'color','k','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.TC_interp,MY1.TC_interp,fid,'m','MY','Clouds');
text(1.1,0.7,str,'color','m','units','normalized','fontsize',7,'fontweight','bold');

%xlim([0 1]);ylim([0 1]);



axes('position',[0.05 0.52 0.65 0.14])

plot(xdata,LC1.Rad_Model,'r');hold on
plot(xdata,CC1.Rad_Model,'k');hold on
plot(xdata,NR1.Rad_Model,'g');hold on
plot(xdata,MY1.Rad_Model,'m');hold on

set(gca,'xtick',xlab,'xticklabel',[]);
text(0.05,1.075,'Sol Rad','units','normalized','fontsize',12);

text(0.9,0.9,num2str(mean(LC1.Rad_Model)),'color','r','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.8,num2str(mean(CC1.Rad_Model)),'color','k','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.7,num2str(mean(NR1.Rad_Model)),'color','g','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.6,num2str(mean(MY1.Rad_Model)),'color','m','units','normalized','fontsize',7,'fontweight','bold');

axes('position',[0.75 0.52 0.14 0.14])

scatter(NR1.Rad_Model,LC1.Rad_Model,'.r');hold on
scatter(NR1.Rad_Model,CC1.Rad_Model,'.k');hold on
scatter(NR1.Rad_Model,MY1.Rad_Model,'.m');hold on

box on;


[str] =add_polyfit_line(NR1.Rad_Model,LC1.Rad_Model,fid,'r','LC','Sol Rad');
text(1.1,0.9,str,'color','r','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.Rad_Model,CC1.Rad_Model,fid,'k','CC','Sol Rad');
text(1.1,0.8,str,'color','k','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.Rad_Model,MY1.Rad_Model,fid,'m','MY','Sol Rad');
text(1.1,0.7,str,'color','m','units','normalized','fontsize',7,'fontweight','bold');

%xlim([0 400]);ylim([0 500]);



axes('position',[0.05 0.68 0.65 0.14])

plot(xdata,LC1.RH_interp,'r');hold on
plot(xdata,CC1.RH_interp,'k');hold on
plot(xdata,NR1.RH_interp,'g');hold on
plot(xdata,MY1.RH_interp,'m');hold on

set(gca,'xtick',xlab,'xticklabel',[]);
text(0.05,1.075,'RH','units','normalized','fontsize',12);

text(0.9,0.5,num2str(mean(LC1.RH_interp)),'color','r','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.4,num2str(mean(CC1.RH_interp)),'color','k','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.3,num2str(mean(NR1.RH_interp)),'color','g','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.2,num2str(mean(MY1.RH_interp)),'color','m','units','normalized','fontsize',7,'fontweight','bold');


axes('position',[0.75 0.68 0.14 0.14])

scatter(NR1.RH_interp,LC1.RH_interp,'.r');hold on
scatter(NR1.RH_interp,CC1.RH_interp,'.k');hold on
scatter(NR1.RH_interp,MY1.RH_interp,'.m');hold on


box on;

[str] =add_polyfit_line(NR1.RH_interp,LC1.RH_interp,fid,'r','LC','Rel Hum');
text(1.1,0.9,str,'color','r','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.RH_interp,CC1.RH_interp,fid,'k','CC','Rel Hum');
text(1.1,0.8,str,'color','k','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.RH_interp,MY1.RH_interp,fid,'m','MY','Rel Hum');
text(1.1,0.7,str,'color','m','units','normalized','fontsize',7,'fontweight','bold');


%xlim([0 100]);ylim([0 100]);



axes('position',[0.05 0.84 0.65 0.14])

plot(xdata,LC1.Temp_interp,'r');hold on
plot(xdata,CC1.Temp_interp,'k');hold on
plot(xdata,NR1.Temp_interp,'g');hold on
plot(xdata,MY1.Temp_interp,'m');hold on

set(gca,'xtick',xlab,'xticklabel',[]);
text(0.05,1.075,'Air Temp','units','normalized','fontsize',12);

text(0.9,0.9,num2str(mean(LC1.Temp_interp)),'color','r','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.8,num2str(mean(CC1.Temp_interp)),'color','k','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.7,num2str(mean(NR1.Temp_interp)),'color','g','units','normalized','fontsize',7,'fontweight','bold');
text(0.9,0.6,num2str(mean(MY1.Temp_interp)),'color','m','units','normalized','fontsize',7,'fontweight','bold');



axes('position',[0.75 0.84 0.14 0.14])

scatter(NR1.Temp_interp,LC1.Temp_interp,'.r');hold on
scatter(NR1.Temp_interp,CC1.Temp_interp,'.k');hold on
scatter(NR1.Temp_interp,MY1.Temp_interp,'.m');hold on


box on;

[str] =add_polyfit_line(NR1.Temp_interp,LC1.Temp_interp,fid,'r','LC','Air Temp');
text(1.1,0.9,str,'color','r','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.Temp_interp,CC1.Temp_interp,fid,'k','CC','Air Temp');
text(1.1,0.8,str,'color','k','units','normalized','fontsize',7,'fontweight','bold');
[str] =add_polyfit_line(NR1.Temp_interp,MY1.Temp_interp,fid,'m','MY','Air Temp');
text(1.1,0.7,str,'color','m','units','normalized','fontsize',7,'fontweight','bold');

%xlim([0 40]);ylim([0 40]);


fclose(fid);

save Daily_Ave.mat CC1 LC1 MY1 NR1 -mat
