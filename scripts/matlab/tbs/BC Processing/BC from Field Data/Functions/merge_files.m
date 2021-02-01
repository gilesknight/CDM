
load elcd_data.mat

headers{1} = 'FLOW';
ISOTime = datenum(2008,01,01,00,00,00):60/(60*24):datenum(2014,12,31,11,59,00);


% Wellington

load('BCs\Wellington\data.mat');

var = 'FLOW';
temp = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.(var),ISOTime,'linear','extrap');
ss = find(ISOTime <= datenum(2010,09,05));
tfv_data.FLOW(ss) = temp(ss);

var = 'AMM';
temp = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.(var),ISOTime,'linear','extrap');
ss = find(ISOTime <= datenum(2009,01,01));
tfv_data.WQ_NIT_AMM(ss) = temp(ss);

var = 'CL';
temp = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.(var),ISOTime,'linear','extrap');
ss = find(ISOTime <= datenum(2009,01,01));
tfv_data.WQ_GEO_CL(ss) = temp(ss);

var = 'GRN';
temp = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.(var),ISOTime,'linear','extrap');
ss = find(ISOTime <= datenum(2011,01,01));
tfv_data.WQ_PHY_GRN(ss) = temp(ss);

var = 'OXY';
temp = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.(var),ISOTime,'linear','extrap');
ss = find(ISOTime <= datenum(2011,01,01));
tfv_data.WQ_OXY_OXY(ss) = temp(ss);


%__________________________________________________________________________
vars = {'PE'...
'MG'...
'K'...
'NA'...
'CH4'...
'RSI'...
'FRP'...
'FRP_ADS'...
'DOC'...
'POC'...
'DON'...
'DOP'...
'POP'...
'FEII'...
'FEIII'...
'SO4'...
};
%'DIC'...
vars2 = {'WQ_GEO_PE'...
'WQ_GEO_MG'...
'WQ_GEO_K'...
'WQ_GEO_NA'...
'WQ_CAR_CH4'...
'WQ_SIL_RSI'...
'WQ_PHS_FRP'...
'WQ_PHS_FRP_ADS'...
'WQ_OGM_DOC'...
'WQ_OGM_POC'...
'WQ_OGM_DON'...
'WQ_OGM_DOP'...
'WQ_OGM_POP'...
'WQ_GEO_FEII'...
'WQ_GEO_FEIII'...
'WQ_GEO_SO4'...
};
%'WQ_CAR_DIC'...
for ii = 1:length(vars)
    var = vars{ii};
    
    temp = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.(var),ISOTime,'linear','extrap');
    ss = find(ISOTime <= datenum(2012,02,01));
    tfv_data.(vars2{ii})(ss) = temp(ss);
    
end

%tfv_data.WQ_CAR_DIC = tfv_data.WQ_CAR_DIC * 0.5

%tfv_data.WQ_GEO_UBALCHG = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.UBALCHG,ISOTime,'linear','extrap');

var = 'WQ_GEO_UBALCHG';
% temp = interp1(elcd_data.ELCD.Wellington.Date,elcd_data.ELCD.Wellington.UBALCHG,ISOTime,'linear','extrap');
% 
% ss = find(ISOTime <= datenum(2011,01,01));
% 
% tfv_data.(var)(ss) = temp(ss);

tfv_data.WQ_GEO_UBALCHG = calc_chgbal(tfv_data);


plot_tfvdata(tfv_data,ISOTime,'BCs/Wellington_v3/')

write_tfvfile(tfv_data,headers,ISOTime,'BCs/Wellington_v3.csv');

% Finniss

load('BCs\Finniss\data.mat');


var = 'FLOW';
temp = interp1(elcd_data.ELCD.Finniss.Date,elcd_data.ELCD.Finniss.(var),ISOTime,'linear','extrap');

ss = find(ISOTime <= datenum(2011,06,01));

tfv_data.(var)(ss) = temp(ss);


var = 'UBALCHG';
%tfv_data.WQ_GEO_UBALCHG = interp1(elcd_data.ELCD.Finniss.Date,elcd_data.ELCD.Finniss.(var),ISOTime,'linear','extrap');
% var = 'DIC';
% tfv_data.WQ_CAR_DIC = interp1(elcd_data.ELCD.Currency.Date,elcd_data.ELCD.Currency.(var),ISOTime,'linear','extrap');
var = 'POC';
tfv_data.WQ_OGM_POC = interp1(elcd_data.ELCD.Currency.Date,elcd_data.ELCD.Currency.(var),ISOTime,'linear','extrap');


tfv_data.WQ_GEO_UBALCHG = calc_chgbal(tfv_data);


plot_tfvdata(tfv_data,ISOTime,'BCs/Finniss_v3/')
write_tfvfile(tfv_data,headers,ISOTime,'BCs/Finniss_v3.csv');

% Finniss

load('BCs\Currency\data.mat');


var = 'FLOW';
temp = interp1(elcd_data.ELCD.Currency.Date,elcd_data.ELCD.Currency.(var),ISOTime,'linear','extrap');

ss = find(ISOTime <= datenum(2011,06,01));

tfv_data.(var)(ss) = temp(ss);


var = 'UBALCHG';
%tfv_data.WQ_GEO_UBALCHG = interp1(elcd_data.ELCD.Currency.Date,elcd_data.ELCD.Currency.(var),ISOTime,'linear','extrap');
% var = 'DIC';
% tfv_data.WQ_CAR_DIC = interp1(elcd_data.ELCD.Currency.Date,elcd_data.ELCD.Currency.(var),ISOTime,'linear','extrap');
var = 'POC';
tfv_data.WQ_OGM_POC = interp1(elcd_data.ELCD.Currency.Date,elcd_data.ELCD.Currency.(var),ISOTime,'linear','extrap');

tfv_data.WQ_GEO_UBALCHG = calc_chgbal(tfv_data);


plot_tfvdata(tfv_data,ISOTime,'BCs/Currency_v3/')
write_tfvfile(tfv_data,headers,ISOTime,'BCs/Currency_v3.csv');


