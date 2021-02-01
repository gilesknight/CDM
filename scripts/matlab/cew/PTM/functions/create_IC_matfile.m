function IC = create_IC_matfile(sdate)
addpath(genpath('functions'));

%load Matfiles/swan_small.mat; 
load Matfiles/Tidaldata.mat;
load swan_small.mat;
fdata = swan_small;

clear swan_small;

sites = fieldnames(fdata);

IC = [];

datearray(:,1) = (sdate-1):15/(60*24):datenum(2014,12,31,11,59,00);

%__________________________________________________________________________

% Water level code....

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




for i = 1:length(sites)
    
    disp(sites{i});
    
    vnames = fieldnames(fdata.(sites{i}));
    X = fdata.(sites{i}).(vnames{1}).X;
    Y = fdata.(sites{i}).(vnames{1}).Y;
    
    IC.(sites{i}).H.Data = wl;
    IC.(sites{i}).H.Date = datearray;
    IC.(sites{i}).H.X = X;
    IC.(sites{i}).H.Y = Y;

    IC.(sites{i}).U.Data(1:length(datearray)) = 0;
    IC.(sites{i}).U.Date = datearray;
    IC.(sites{i}).U.X = X;
    IC.(sites{i}).U.Y = Y;
    
    IC.(sites{i}).V.Data(1:length(datearray)) = 0;
    IC.(sites{i}).V.Date = datearray;
    IC.(sites{i}).V.X = X;
    IC.(sites{i}).V.Y = Y;
    %__________________________________________________________________________
    
    varname = 'SAL';
    
    
    
    
    Sal = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    ss = find(Sal > 1000);
    Sal(ss) = 23;
    
    if ~isempty(Sal)
        IC.(sites{i}).Sal.Data = Sal;
        IC.(sites{i}).Sal.Date = datearray;
        IC.(sites{i}).Sal.X = X;
        IC.(sites{i}).Sal.Y = Y;
    end
    
    
    %__________________________________________________________________________
    
    varname = 'TEMP';
    
    Temp = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(Temp)
        IC.(sites{i}).Temp.Data = Temp;
        IC.(sites{i}).Temp.Date = datearray;
        IC.(sites{i}).Temp.X = X;
        IC.(sites{i}).Temp.Y = Y;
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_OXY_OXY';
    
    Oxy = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(Oxy)
        IC.(sites{i}).Oxy.Data = Oxy;
        IC.(sites{i}).Oxy.Date = datearray;
        IC.(sites{i}).Oxy.X = X;
        IC.(sites{i}).Oxy.Y = Y;
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_SIL_RSI';
    
    Sil = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(Sil)
        IC.(sites{i}).Sil.Data = Sil;
        IC.(sites{i}).Sil.Date = datearray;
        IC.(sites{i}).Sil.X = X;
        IC.(sites{i}).Sil.Y = Y;
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_NIT_AMM';
    
    Amm = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    
    if ~isempty(Amm)
        IC.(sites{i}).Amm.Data = Amm;
        IC.(sites{i}).Amm.Date = datearray;
        IC.(sites{i}).Amm.X = X;
        IC.(sites{i}).Amm.Y = Y;
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_DIAG_TOT_TN';
    
    TN = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    
    if ~isempty(TN)
        IC.(sites{i}).TN.Data = TN;
        IC.(sites{i}).TN.Date = datearray;
        IC.(sites{i}).TN.X = X;
        IC.(sites{i}).TN.Y = Y;
    end
    
    
    
    %__________________________________________________________________________
    
    varname = 'WQ_PHS_FRP';
    
    FRP = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(FRP)
        IC.(sites{i}).FRP.Data = FRP;
        IC.(sites{i}).FRP.Date = datearray;
        IC.(sites{i}).FRP.X = X;
        IC.(sites{i}).FRP.Y = Y;
    end
    
    %__________________________________________________________________________
    %BB
    
    varname = 'WQ_PHS_FRP';
    
    if ~isempty(FRP)
        FRP_ADS = FRP .* 0.1;
        IC.(sites{i}).FRP_ADS.Data = FRP .* 0.1;
        IC.(sites{i}).FRP_ADS.Date = datearray;
        IC.(sites{i}).FRP_ADS.X = X;
        IC.(sites{i}).FRP_ADS.Y = Y;
    else
        FRP_ADS = [];
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_OGM_DON';
    
    DON_T = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    
    if ~isempty(DON_T)
        DON = DON_T .* 0.3;
        IC.(sites{i}).DON.Data = DON;
        IC.(sites{i}).DON.Date = datearray;
        IC.(sites{i}).DON.X = X;
        IC.(sites{i}).DON.Y = Y;
    else
        DON = [];
    end
    
    
    
    %__________________________________________________________________________
    
    varname = 'WQ_DIAG_TOT_TKN';
    
    TKN = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    
    if ~isempty(TKN)
        IC.(sites{i}).TKN.Data = TKN;
        IC.(sites{i}).TKN.Date = datearray;
        IC.(sites{i}).TKN.X = X;
        IC.(sites{i}).TKN.Y = Y;
    end
    
    %__________________________________________________________________________
    
    
    if ~isempty(TKN) & ~isempty(Amm)
        TON = TKN-Amm;
        IC.(sites{i}).TON.Data = TON;
        IC.(sites{i}).TON.Date = datearray;
        IC.(sites{i}).TON.X = X;
        IC.(sites{i}).TON.Y = Y;
    else
        TON = [];
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_NIT_NIT';
    
    Nit = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(Nit)
        IC.(sites{i}).Nit.Data = Nit;
        IC.(sites{i}).Nit.Date = datearray;
        IC.(sites{i}).Nit.X = X;
        IC.(sites{i}).Nit.Y = Y;
    end
    
    
    %__________________________________________________________________________
    
    
    if ~isempty(TN) & ~isempty(Amm) & ~isempty(Nit) & ~isempty(DON)
        PON = TN - Amm - Nit - DON;
        IC.(sites{i}).PON.Data = PON;
        IC.(sites{i}).PON.Date = datearray;
        IC.(sites{i}).PON.X = X;
        IC.(sites{i}).PON.Y = Y;
    else
        PON = [];
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_DIAG_TOT_TP';
    
    TP = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(TP)
        IC.(sites{i}).TP.Data = TP;
        IC.(sites{i}).TP.Date = datearray;
        IC.(sites{i}).TP.X = X;
        IC.(sites{i}).TP.Y = Y;
    end
    
    %__________________________________________________________________________
    
    
    if ~isempty(TP) & ~isempty(FRP) & ~isempty(FRP_ADS)
        DOP = (TP-FRP-FRP_ADS).* 0.4;
        IC.(sites{i}).DOP.Data = DOP;
        IC.(sites{i}).DOP.Date = datearray;
        IC.(sites{i}).DOP.X = X;
        IC.(sites{i}).DOP.Y = Y;
    else
        DOP = [];
    end
    
    %__________________________________________________________________________
    
    if ~isempty(TP) & ~isempty(FRP) & ~isempty(FRP_ADS)
        POP = (TP-FRP-FRP_ADS).* 0.5;
        IC.(sites{i}).POP.Data = POP;
        IC.(sites{i}).POP.Date = datearray;
        IC.(sites{i}).POP.X = X;
        IC.(sites{i}).POP.Y = Y;
    else
        POP = [];
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_OGM_DOC';
    
    DOC_T = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(DOC_T)
        DOC = DOC_T .* 0.4;
        IC.(sites{i}).DOC.Data = DOC
        IC.(sites{i}).DOC.Date = datearray;
        IC.(sites{i}).DOC.X = X;
        IC.(sites{i}).DOC.Y = Y;
    else
        DOC = [];
    end
    
    %__________________________________________________________________________
    
    varname = 'WQ_OGM_POC';
    
    POC = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(POC)
        IC.(sites{i}).POC.Data = POC ;
        IC.(sites{i}).POC.Date = datearray;
        IC.(sites{i}).POC.X = X;
        IC.(sites{i}).POC.Y = Y;
    end
    
    %__________________________________________________________________________
    
    varname = 'TRC_SS1';
    
    SS1_T = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
    if ~isempty(SS1_T)
        IC.(sites{i}).SS1.Data = SS1_T * 0.7 ;
        IC.(sites{i}).SS1.Date = datearray;
        IC.(sites{i}).SS1.X = X;
        IC.(sites{i}).SS1.Y = Y;
    end
    
    if ~isempty(SS1_T)
        IC.(sites{i}).SS2.Data = SS1_T * 0.3 ;
        IC.(sites{i}).SS2.Date = datearray;
        IC.(sites{i}).SS2.X = X;
        IC.(sites{i}).SS2.Y = Y;
    end
    
    for iii = 3:20
        var_temp = ['SS',num2str(iii)];
        IC.(sites{i}).(var_temp).Data(1:length(datearray)) = 0;
        IC.(sites{i}).(var_temp).Date(1:length(datearray)) = datearray;
        IC.(sites{i}).(var_temp).X = X;
        IC.(sites{i}).(var_temp).Y = Y;
        
    end
    % ______________________________________________________________________
    
    varname = 'WQ_DIAG_PHY_TCHLA';
    
    CHLA = create_interpolated_dataset(fdata,varname,sites{i},'Surface',datearray);
    
	CHLA = CHLA .* 4; %BB and MH
	
    if ~isempty(CHLA)
        GRN = CHLA .* 0.04;
        IC.(sites{i}).GRN.Data = GRN;
        IC.(sites{i}).GRN.Date = datearray;
        IC.(sites{i}).GRN.X = X;
        IC.(sites{i}).GRN.Y = Y;
    else
        GRN = [];
    end
    
    
    % ______________________________________________________________________
    
    if ~isempty(CHLA)
        BGA = CHLA .* 0.03;
        IC.(sites{i}).BGA.Data = BGA;
        IC.(sites{i}).BGA.Date = datearray;
        IC.(sites{i}).BGA.X = X;
        IC.(sites{i}).BGA.Y = Y;
    else
        BGA = [];
    end
    
    % ______________________________________________________________________
    
    
    if ~isempty(CHLA)
        FDIAT = CHLA .* 0.08;
        IC.(sites{i}).FDIAT.Data = FDIAT;
        IC.(sites{i}).FDIAT.Date = datearray;
        IC.(sites{i}).FDIAT.X = X;
        IC.(sites{i}).FDIAT.Y = Y;
        
        IC.(sites{i}).CRYPT = IC.(sites{i}).FDIAT;
    else
        FDIAT = [];
    end
    
    % ______________________________________________________________________
    
    
    if ~isempty(CHLA)
        MDIAT = CHLA .* 0.55;
        IC.(sites{i}).MDIAT.Data = MDIAT;
        IC.(sites{i}).MDIAT.Date = datearray;
        IC.(sites{i}).MDIAT.X = X;
        IC.(sites{i}).MDIAT.Y = Y;
        
        IC.(sites{i}).DIATOM = IC.(sites{i}).MDIAT;
    else
        MDIAT = [];
    end
    
    
    % ______________________________________________________________________
    
    
    if ~isempty(CHLA)
        KARLO = CHLA .* 0.3;
        IC.(sites{i}).KARLO.Data = KARLO;
        IC.(sites{i}).KARLO.Date = datearray;
        IC.(sites{i}).KARLO.X = X;
        IC.(sites{i}).KARLO.Y = Y;
        
        IC.(sites{i}).DINO = IC.(sites{i}).KARLO;
    else
        KARLO = [];
    end
    
    % ______________________________________________________________________
    
    
    IC.(sites{i}).TRACE_1.Data(1:length(datearray)) = 0;
    IC.(sites{i}).TRACE_1.Date = datearray;
    IC.(sites{i}).TRACE_1.X = X;
    IC.(sites{i}).TRACE_1.Y = Y;
    
    % ______________________________________________________________________
    
    IC.(sites{i}).RET.Data(1:length(datearray)) = 0;
    IC.(sites{i}).RET.Date = datearray;
    IC.(sites{i}).RET.X = X;
    IC.(sites{i}).RET.Y = Y;
    
    % ______________________________________________________________________
    
    
    if ~isempty(DOC_T)
        DOCR = DOC_T .* 0.6;
        IC.(sites{i}).DOCR.Data = DOCR;
        IC.(sites{i}).DOCR.Date = datearray;
        IC.(sites{i}).DOCR.X = X;
        IC.(sites{i}).DOCR.Y = Y;
    else
        DOCR = [];
    end
    
    % ______________________________________________________________________
    
    
    if ~isempty(DON)
        DONR = DON_T .* 0.7;
        IC.(sites{i}).DONR.Data = DONR;
        IC.(sites{i}).DONR.Date = datearray;
        IC.(sites{i}).DONR.X = X;
        IC.(sites{i}).DONR.Y = Y;
    else
        DONR = [];
    end
    
    % ______________________________________________________________________
    
    
    if ~isempty(TP) & ~isempty(FRP) & ~isempty(FRP_ADS)
        DOPR = (TP - FRP - FRP_ADS) .* 0.1;
        IC.(sites{i}).DOPR.Data = DOPR;
        IC.(sites{i}).DOPR.Date = datearray;
        IC.(sites{i}).DOPR.X = X;
        IC.(sites{i}).DOPR.Y = Y;
    else
        DOPR = [];
    end
    
    % ______________________________________________________________________
    
    
    if ~isempty(POC)
        CPOM = POC .* 0.05;
        IC.(sites{i}).CPOM.Data = CPOM;
        IC.(sites{i}).CPOM.Date = datearray;
        IC.(sites{i}).CPOM.X = X;
        IC.(sites{i}).CPOM.Y = Y;
    else
        CPOM = [];
    end
    
     

    

     
    
    
end

%save Matfiles/IC.mat IC -mat -v7.3;