clear all; close all;

load swan.mat;

load Tidaldata.mat;

datearray(:,1) = datenum(2008,11,01,00,00,00):15/(60*24):datenum(2008,12,01,11,59,00);

ISOTime = datearray;

headers = {...
    'ISOTime',...
    'wl',...
    'Sal',...
    'Temp',...
    'TRACE_1',...
	'SS1',...
    'RET',...
    'Oxy',...
    'Sil',...
    'Amm',...
    'Nit',...
    'FRP',...
	'FRP_ADS',...
    'DOC',...
    'POC',...
    'DON',...
    'PON',...
    'DOP',...
    'POP',...
    'GRN',...
    'BGA',...
    'FDIAT',...
    'MDIAT',...
    'KARLO',...
    };

filename = 'NAR_Inflow_Depth.csv';
outdir = 'BCs/Tide/';



if ~exist(outdir,'dir')
    mkdir(outdir);
end

% %__________________________________________________________________________
% 
varname = 'height';


[t_date,ind] = unique(data.bar.date);
t_data = data.bar.height(ind);

[t_date1,ind] = unique(data.free.date);
t_data1 = data.free.height(ind);

ss = find(~isnan(t_data) == 1);
sss = find(~isnan(t_data1) == 1);

wl = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

wl1 = interp1(t_date1(sss),t_data1(sss),datearray,'linear',mean(t_data1(sss)));

ttt = find(wl < -50);
wl(ttt) = wl1(ttt);

wl(wl < 0.18) = 0.18;

figure;plot(wl);title('wl');




clear t_date t_data;




%__________________________________________________________________________

varname = 'SAL';

Sal = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

figure;plot(Sal);title('Sal');

clear t_date t_data;

%__________________________________________________________________________

varname = 'TEMP';

Temp = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

figure;plot(Temp);title('Temp');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_OXY_OXY';

Oxy = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

figure;plot(Oxy);title('Oxygen');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_SIL_RSI';

Sil = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

figure;plot(Sil);title('Silica');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_NIT_AMM';

Amm = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);


figure;plot(Amm);title('Amm');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_DIAG_TOT_TN';

TN = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);


figure;plot(TN);title('TN');

clear t_date t_data;



%__________________________________________________________________________

varname = 'WQ_PHS_FRP';

FRP = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

figure;plot(FRP);title('FRP');

clear t_date t_data;

%__________________________________________________________________________
%BB

varname = 'FRP_ADS';


FRP_ADS = FRP .* 0.1;

figure;plot(FRP_ADS);title('FRP_ADS');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_OGM_DON';

DON_T = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

DON = DON_T .* 0.4;


figure;plot(DON);title('DON');

clear t_date t_data;



%__________________________________________________________________________

varname = 'WQ_DIAG_TOT_TKN';

TKN = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);


figure;plot(TKN);title('TKN');

clear t_date t_data;

%__________________________________________________________________________

varname = 'TON';

TON = TKN-Amm;

figure;plot(TON);title('TON');

%__________________________________________________________________________

varname = 'WQ_NIT_NIT';

Nit = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

figure;plot(Nit);title('NIT');

clear t_date t_data;


%__________________________________________________________________________

varname = 'PON';

PON = TN - Amm - Nit - DON;

PON(PON < 0) = 0;

figure;plot(PON);title('PON');

%__________________________________________________________________________

varname = 'WQ_DIAG_TOT_TP';

TP = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

figure;plot(TP);title('TP');

clear t_date t_data;


%__________________________________________________________________________

varname = 'DOP';

DOP = (TP-FRP-FRP_ADS).* 0.4;

DOP(DOP < 0) = 0;


figure;plot(DOP);title('DOP');

%__________________________________________________________________________

varname = 'POP';

POP = (TP-FRP-FRP_ADS).* 0.5;

POP(POP < 0) = 0;


figure;plot(POP);title('POP');

%__________________________________________________________________________

varname = 'WQ_OGM_DOC';

DOC_T = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

DOC = DOC_T .* 0.4;

DOC(DOC < 0) = 0;


figure;plot(DOC);title('DOC');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_OGM_POC';

POC = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);

POC(POC < 0) = 0;


figure;plot(POC);title('POC');

clear t_date t_data;


%__________________________________________________________________________

varname = 'TRC_SS1';

SS1 = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);


figure;plot(SS1);title('SS1');

clear t_date t_data;

% ______________________________________________________________________

varname = 'WQ_DIAG_PHY_TCHLA';

CHLA = create_interpolated_dataset(swan,varname,'NAR','Bottom',datearray);


GRN = CHLA .* 0.3;


GRN(GRN < 0) = 0;


figure;plot(GRN);title('GRN');

clear t_date t_data;


% ______________________________________________________________________

varname = 'BGA';

BGA = CHLA .* 0.3;

BGA(BGA < 0) = 0;


figure;plot(BGA);title('BGA');

% ______________________________________________________________________

varname = 'FDIAT';

FDIAT = CHLA .* 0.05;

FDIAT(FDIAT < 0) = 0;


figure;plot(FDIAT);title('FDIAT');

% ______________________________________________________________________

varname = 'MDIAT';

MDIAT = CHLA .* 0.25;

MDIAT(MDIAT < 0) = 0;


figure;plot(MDIAT);title('MDIAT');

% ______________________________________________________________________

varname = 'KARLO';

KARLO = CHLA .* 0.1;

KARLO(KARLO < 0) = 0;


figure;plot(KARLO);title('KARLO');

% ______________________________________________________________________

varname = 'TRACE_1';

TRACE_1(1:length(GRN),1) = 0;


figure;plot(TRACE_1);title('TRACE_1');

% ______________________________________________________________________

varname = 'RET';

RET(1:length(GRN),1) = 0;


figure;plot(RET);title('RET');

% ______________________________________________________________________

varname = 'DOCR';

DOCR = DOC_T .* 0.6;

DOCR(DOCR < 0) = 0;

figure;plot(DOCR);title('DOCR');

% ______________________________________________________________________

varname = 'DONR';

DONR = DON_T .* 0.6;

DONR(DONR < 0) = 0;

figure;plot(DONR);title('DONR');

% ______________________________________________________________________

varname = 'DOPR';

DOPR = (TP - FRP - FRP_ADS) .* 0.1;

DOPR(DOPR < 0) = 0;

figure;plot(DOPR);title('DOPR');

% ______________________________________________________________________

varname = 'CPOM';

CPOM = POC .* 0.05;

CPOM(CPOM < 0) = 0;

figure;plot(CPOM);title('CPOM');


% EXPORT ROUTINE___________________________________________________________

disp('Writing the inflow file');


fid = fopen([outdir,filename],'wt');

% Headers

for i = 1:length(headers)
    if i == length(headers)
        fprintf(fid,'%s\n',headers{i});
    else
        fprintf(fid,'%s,',headers{i});
    end
end


for j = 1:length(ISOTime)
    for i = 1:length(headers)
        if i == length(headers)
            eval(['fprintf(fid,','''','%4.6f\n','''',',',headers{i},'(j));']);
        else
            if i == 1
                eval(['fprintf(fid,','''','%s,','''',',datestr(',headers{i},'(j),','''','dd/mm/yyyy HH:MM:SS','''','));']);
            else
                eval(['fprintf(fid,','''','%4.6f,','''',',',headers{i},'(j));']);
            end
        end
    end
end

fclose(fid);