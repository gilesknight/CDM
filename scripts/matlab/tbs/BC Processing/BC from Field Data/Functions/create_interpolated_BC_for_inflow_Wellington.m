function create_interpolated_BC_for_inflow_Wellington(swan,headers,datearray,filename)


ISOTime = datearray;




%__________________________________________________________________________

varname = 'Flow';

t_depth = swan.SWS10.(varname).Depth;
tt = find(t_depth > -0.1);

[t_date,ind] = unique(swan.SWS10.(varname).Date(tt));
t_data = swan.SWS10.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

Flow = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(Flow);title('Flow');

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








