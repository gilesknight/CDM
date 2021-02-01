clear all; close all;


load Langhorne_Crk' met output'\tfv_ll_met_Langhorne_Crk.mat;

LC = metout; clear metout;

load Narrung' met output'\tfv_ll_met_narrung.mat;

NR = metout; clear metout;

load Currency_crk' met output'\tfv_ll_met_currency_crk.mat;

CC = metout; clear metout;


%__________________________________________________________________________

% This has to be done mostly by hand....

finmet  = [];

%__________________________________________________________________________

yr = 2008;

daterange = [datenum(yr,01,01,00,00,00) datenum(yr+1,01,01,00,00,00)];

ss = find(LC.NewDate >= daterange(1) & LC.NewDate < daterange(2));
ss2 = find(LC.RainDate >= daterange(1) & LC.RainDate < daterange(2));


finmet.NewDate(:,1) = LC.NewDate(ss);

finmet.Temp_interp(:,1) = LC.Temp_interp(ss);
finmet.RH_interp(:,1) = LC.RH_interp(ss);
finmet.Rad_Model(:,1) = LC.Rad_Model(ss);
finmet.TC_interp(:,1) = LC.TC_interp(ss);

finmet.W_Speed_interp(:,1) = LC.W_Speed_interp(ss);
finmet.W_Dir_interp(:,1) = LC.W_Dir_interp(ss);

finmet.RainDate(:,1) = LC.RainDate(ss2);
finmet.Rain(:,1) = LC.Rain(ss2);

%__________________________________________________________________________

yr = 2009;

daterange = [datenum(yr,01,01,00,00,00) datenum(yr+1,01,01,00,00,00)];

ss = find(LC.NewDate >= daterange(1) & LC.NewDate < daterange(2));
ss2 = find(LC.RainDate >= daterange(1) & LC.RainDate < daterange(2));

tt = find(NR.NewDate >= daterange(1) & NR.NewDate < daterange(2));
tt2 = find(NR.RainDate >= daterange(1) & NR.RainDate < daterange(2));

uu = find(CC.NewDate >= daterange(1) & CC.NewDate < daterange(2));
uu2 = find(CC.RainDate >= daterange(1) & CC.RainDate < daterange(2));

finmet.NewDate = [finmet.NewDate;LC.NewDate(ss)'];

finmet.Temp_interp = [finmet.Temp_interp;NR.Temp_interp(tt)'];
finmet.RH_interp = [finmet.RH_interp;NR.RH_interp(tt)'];
finmet.Rad_Model = [finmet.Rad_Model;NR.Rad_Model(tt)'];
finmet.TC_interp = [finmet.TC_interp;NR.TC_interp(tt)'];

finmet.W_Speed_interp = [finmet.W_Speed_interp;CC.W_Speed_interp(uu)'];
finmet.W_Dir_interp = [finmet.W_Dir_interp;LC.W_Dir_interp(ss)'];

finmet.RainDate = [finmet.RainDate;NR.RainDate(tt2)'];
finmet.Rain = [finmet.Rain;NR.Rain(tt2)'];

%__________________________________________________________________________

yr = 2010;

daterange = [datenum(yr,01,01,00,00,00) datenum(yr+1,01,01,00,00,00)];

ss = find(LC.NewDate >= daterange(1) & LC.NewDate < daterange(2));
ss2 = find(LC.RainDate >= daterange(1) & LC.RainDate < daterange(2));

tt = find(NR.NewDate >= daterange(1) & NR.NewDate < daterange(2));
tt2 = find(NR.RainDate >= daterange(1) & NR.RainDate < daterange(2));

uu = find(CC.NewDate >= daterange(1) & CC.NewDate < daterange(2));
uu2 = find(CC.RainDate >= daterange(1) & CC.RainDate < daterange(2));

finmet.NewDate = [finmet.NewDate;LC.NewDate(ss)'];

finmet.Temp_interp = [finmet.Temp_interp;CC.Temp_interp(uu)'];
finmet.RH_interp = [finmet.RH_interp;CC.RH_interp(uu)'];
finmet.Rad_Model = [finmet.Rad_Model;CC.Rad_Model(uu)'];
finmet.TC_interp = [finmet.TC_interp;CC.TC_interp(uu)'];

finmet.W_Speed_interp = [finmet.W_Speed_interp;CC.W_Speed_interp(uu)'];
finmet.W_Dir_interp = [finmet.W_Dir_interp;LC.W_Dir_interp(uu)'];

finmet.RainDate = [finmet.RainDate;CC.RainDate(uu2)'];
finmet.Rain = [finmet.Rain;CC.Rain(uu2)'];

%__________________________________________________________________________

yr = 2011;

daterange = [datenum(yr,01,01,00,00,00) datenum(yr+1,01,01,00,00,00)];


daterange1 = [datenum(yr-1,01,01,00,00,00) datenum(yr,01,01,00,00,00)];
daterange2 = [datenum(yr+1,01,01,00,00,00) datenum(yr+2,01,01,00,00,00)];


ss = find(LC.NewDate >= daterange1(1) & LC.NewDate < daterange1(2));
ss2 = find(LC.RainDate >= daterange1(1) & LC.RainDate < daterange1(2));

tt = find(NR.NewDate >= daterange2(1) & NR.NewDate < daterange2(2));
tt2 = find(NR.RainDate >= daterange2(1) & NR.RainDate < daterange2(2));

uu = find(CC.NewDate >= daterange(1) & CC.NewDate < daterange(2));
uu2 = find(CC.RainDate >= daterange(1) & CC.RainDate < daterange(2));

finmet.NewDate = [finmet.NewDate;CC.NewDate(uu)'];

finmet.Temp_interp = [finmet.Temp_interp;NR.Temp_interp(tt)'];
finmet.RH_interp = [finmet.RH_interp;NR.RH_interp(tt)'];
finmet.Rad_Model = [finmet.Rad_Model;LC.Rad_Model(ss)'];
finmet.TC_interp = [finmet.TC_interp;NR.TC_interp(tt)'];

finmet.W_Speed_interp = [finmet.W_Speed_interp;NR.W_Speed_interp(tt)'];
finmet.W_Dir_interp = [finmet.W_Dir_interp;LC.W_Dir_interp(ss)'];

finmet.RainDate = [finmet.RainDate;NR.RainDate(tt2)'];
finmet.Rain = [finmet.Rain;NR.Rain(tt2)'];

%__________________________________________________________________________

yr = 2012;

daterange = [datenum(yr,01,01,00,00,00) datenum(yr+1,01,01,00,00,00)];


daterange1 = [datenum(yr-2,01,01,00,00,00) datenum(yr-1,01,01,00,00,00)];
daterange2 = [datenum(yr+1,01,01,00,00,00) datenum(yr+2,01,01,00,00,00)];


ss = find(LC.NewDate >= daterange1(1) & LC.NewDate < daterange1(2));
ss2 = find(LC.RainDate >= daterange1(1) & LC.RainDate < daterange1(2));

tt = find(NR.NewDate >= daterange(1) & NR.NewDate < daterange(2));
tt2 = find(NR.RainDate >= daterange(1) & NR.RainDate < daterange(2));

uu = find(CC.NewDate >= daterange(1) & CC.NewDate < daterange(2));
uu2 = find(CC.RainDate >= daterange(1) & CC.RainDate < daterange(2));

finmet.NewDate = [finmet.NewDate;CC.NewDate(uu)'];

finmet.Temp_interp = [finmet.Temp_interp;NR.Temp_interp(tt)'];
finmet.RH_interp = [finmet.RH_interp;NR.RH_interp(tt)'];
finmet.Rad_Model = [finmet.Rad_Model;LC.Rad_Model(ss)'];
finmet.TC_interp = [finmet.TC_interp;NR.TC_interp(tt)'];

finmet.W_Speed_interp = [finmet.W_Speed_interp;NR.W_Speed_interp(tt)'];
finmet.W_Dir_interp = [finmet.W_Dir_interp;LC.W_Dir_interp(ss)'];

finmet.RainDate = [finmet.RainDate;NR.RainDate(tt2)'];
finmet.Rain = [finmet.Rain;NR.Rain(tt2)'];

%__________________________________________________________________________

yr = 2013;

daterange = [datenum(yr,01,01,00,00,00) datenum(yr+1,01,01,00,00,00)];


daterange1 = [datenum(yr-3,01,01,00,00,00) datenum(yr-2,01,01,00,00,00)];
daterange2 = [datenum(yr+1,01,01,00,00,00) datenum(yr+2,01,01,00,00,00)];


ss = find(LC.NewDate >= daterange1(1) & LC.NewDate < daterange1(2));
ss2 = find(LC.RainDate >= daterange1(1) & LC.RainDate < daterange1(2));

tt = find(NR.NewDate >= daterange(1) & NR.NewDate < daterange(2));
tt2 = find(NR.RainDate >= daterange(1) & NR.RainDate < daterange(2));

uu = find(CC.NewDate >= daterange(1) & CC.NewDate < daterange(2));
uu2 = find(CC.RainDate >= daterange(1) & CC.RainDate < daterange(2));

finmet.NewDate = [finmet.NewDate;CC.NewDate(uu)'];

finmet.Temp_interp = [finmet.Temp_interp;NR.Temp_interp(tt)'];
finmet.RH_interp = [finmet.RH_interp;NR.RH_interp(tt)'];
finmet.Rad_Model = [finmet.Rad_Model;LC.Rad_Model(ss)'];
finmet.TC_interp = [finmet.TC_interp;NR.TC_interp(tt)'];

finmet.W_Speed_interp = [finmet.W_Speed_interp;NR.W_Speed_interp(tt)'];
finmet.W_Dir_interp = [finmet.W_Dir_interp;LC.W_Dir_interp(ss)'];

finmet.RainDate = [finmet.RainDate;NR.RainDate(tt2)'];
finmet.Rain = [finmet.Rain;NR.Rain(tt2)'];









