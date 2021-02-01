sites = fieldnames(lowerlakes);

datearray(:,1) = datenum(2014,07:1:19,01);


for i = 1:length(sites)
    
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TN') & isfield(lowerlakes.(sites{i}),'WQ_NIT_AMM') & isfield(lowerlakes.(sites{i}),'WQ_NIT_NIT') & isfield(lowerlakes.(sites{i}),'WQ_OGM_DON')
        disp([sites{i},':  WQ_OGM_PON']);
        
        
        TN = create_interpolated_dataset(lowerlakes,'WQ_DIAG_TOT_TN',sites{i},'Surface',datearray);
        Amm = create_interpolated_dataset(lowerlakes,'WQ_NIT_AMM',sites{i},'Surface',datearray);
        Nit = create_interpolated_dataset(lowerlakes,'WQ_NIT_NIT',sites{i},'Surface',datearray);
        DON = create_interpolated_dataset(lowerlakes,'WQ_OGM_DON',sites{i},'Surface',datearray);
        
        
        if ~isempty(TN) & ~isempty(Amm) & ~isempty(Nit) & ~isempty(DON)
            
            lowerlakes.(sites{i}).WQ_OGM_PON = lowerlakes.(sites{i}).WQ_OGM_DON;
            lowerlakes.(sites{i}).WQ_OGM_PON.Data = TN - Amm - Nit - DON;
            
            lowerlakes.(sites{i}).WQ_OGM_PON.Date = datearray;
            lowerlakes.(sites{i}).WQ_OGM_PON.Depth(1:length(datearray),1) = 0;
            
            clear TN Amm Nit DON;
        end
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP')
        
        disp([sites{i},':  WQ_PHS_FRP_ADS']);
        
        
        WQ_PHS_FRP = create_interpolated_dataset(lowerlakes,'WQ_PHS_FRP',sites{i},'Surface',datearray);
        
        
        if ~isempty(WQ_PHS_FRP)
            
            lowerlakes.(sites{i}).WQ_PHS_FRP_ADS = lowerlakes.(sites{i}).WQ_PHS_FRP;
            
            lowerlakes.(sites{i}).WQ_PHS_FRP_ADS.Data = WQ_PHS_FRP .* 0.1;
            lowerlakes.(sites{i}).WQ_PHS_FRP_ADS.Date = datearray;
            lowerlakes.(sites{i}).WQ_PHS_FRP_ADS.Depth(1:length(datearray),1) = 0;
            
            clear WQ_PHS_FRP;
        end
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TP') & isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP') & isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP_ADS')
        
        disp([sites{i},':  WQ_OGM_DOP']);
        
        TP = create_interpolated_dataset(lowerlakes,'WQ_DIAG_TOT_TP',sites{i},'Surface',datearray);
        FRP = create_interpolated_dataset(lowerlakes,'WQ_PHS_FRP',sites{i},'Surface',datearray);
        FRP_ADS = create_interpolated_dataset(lowerlakes,'WQ_PHS_FRP_ADS',sites{i},'Surface',datearray);
        
        if ~isempty(TP) & ~isempty(FRP)& ~isempty(FRP_ADS)
            
            
            lowerlakes.(sites{i}).WQ_OGM_DOP = lowerlakes.(sites{i}).WQ_PHS_FRP;
            lowerlakes.(sites{i}).WQ_OGM_DOP.Data = (TP-FRP-FRP_ADS).* 0.4;
            
            lowerlakes.(sites{i}).WQ_OGM_DOP.Date = datearray;
            lowerlakes.(sites{i}).WQ_OGM_DOP.Depth(1:length(datearray),1) = 0;
            
            clear TP FRP FRP_ADS;
        end
        
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TP') & isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP') & isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP_ADS')
        
        disp([sites{i},':  WQ_OGM_POP']);
        
        
        TP = create_interpolated_dataset(lowerlakes,'WQ_DIAG_TOT_TP',sites{i},'Surface',datearray);
        FRP = create_interpolated_dataset(lowerlakes,'WQ_PHS_FRP',sites{i},'Surface',datearray);
        FRP_ADS = create_interpolated_dataset(lowerlakes,'WQ_PHS_FRP_ADS',sites{i},'Surface',datearray);
        if ~isempty(TP) & ~isempty(FRP)& ~isempty(FRP_ADS)
            
            lowerlakes.(sites{i}).WQ_OGM_POP = lowerlakes.(sites{i}).WQ_PHS_FRP;
            lowerlakes.(sites{i}).WQ_OGM_POP.Data = (TP-FRP-FRP_ADS).* 0.5;
            
            lowerlakes.(sites{i}).WQ_OGM_POP.Date = datearray;
            lowerlakes.(sites{i}).WQ_OGM_POP.Depth(1:length(datearray),1) = 0;
            
            clear TP FRP FRP_ADS;
        end
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TP') & isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP') & isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP_ADS')
        
        disp([sites{i},':  WQ_OGM_POP']);
        
        TP = create_interpolated_dataset(lowerlakes,'WQ_DIAG_TOT_TP',sites{i},'Surface',datearray);
        FRP = create_interpolated_dataset(lowerlakes,'WQ_PHS_FRP',sites{i},'Surface',datearray);
        FRP_ADS = create_interpolated_dataset(lowerlakes,'WQ_PHS_FRP_ADS',sites{i},'Surface',datearray);
        if ~isempty(TP) & ~isempty(FRP)& ~isempty(FRP_ADS)
            
            lowerlakes.(sites{i}).WQ_OGM_POP = lowerlakes.(sites{i}).WQ_PHS_FRP;
            lowerlakes.(sites{i}).WQ_OGM_POP.Data = (TP-FRP-FRP_ADS).* 0.5;
            
            lowerlakes.(sites{i}).WQ_OGM_POP.Date = datearray;
            lowerlakes.(sites{i}).WQ_OGM_POP.Depth(1:length(datearray),1) = 0;
            clear TP FRP FRP_ADS;
        end
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_PHY_GRN') & ~isfield(lowerlakes.(sites{i}),'WQ_DIAG_PHY_TCHLA')
        
        disp([sites{i},':  WQ_PHY_GRN']);
        
        lowerlakes.(sites{i}).WQ_DIAG_PHY_TCHLA = lowerlakes.(sites{i}).WQ_PHY_GRN;
        lowerlakes.(sites{i}).WQ_DIAG_PHY_TCHLA.Data = lowerlakes.(sites{i}).WQ_PHY_GRN.Data ./ 4.166667;
        
    end
    if ~isfield(lowerlakes.(sites{i}),'WQ_PHY_GRN') & isfield(lowerlakes.(sites{i}),'WQ_DIAG_PHY_TCHLA')
        
        disp([sites{i},':  WQ_DIAG_PHY_TCHLA']);
        
        lowerlakes.(sites{i}).WQ_PHY_GRN = lowerlakes.(sites{i}).WQ_DIAG_PHY_TCHLA;
        lowerlakes.(sites{i}).WQ_PHY_GRN.Data = lowerlakes.(sites{i}).WQ_DIAG_PHY_TCHLA.Data .* 4.166667;
        
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TURBIDITY') & ~isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TSS')
        
        disp([sites{i},':  WQ_DIAG_TOT_TSS']);
        
        lowerlakes.(sites{i}).WQ_DIAG_TOT_TSS = lowerlakes.(sites{i}).WQ_DIAG_TOT_TURBIDITY;
        
        % TURB = 0.43.*TSS + 9.2
        
        lowerlakes.(sites{i}).WQ_DIAG_TOT_TSS.Data = 0.43 .* lowerlakes.(sites{i}).WQ_DIAG_TOT_TURBIDITY.Data   +  9.2;
        
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TURBIDITY')
        
        disp([sites{i},':  WQ_TRC_SS1']);
        
        lowerlakes.(sites{i}).WQ_TRC_SS1 = lowerlakes.(sites{i}).WQ_DIAG_TOT_TURBIDITY;
        
        % TURB = 0.43.*TSS + 9.2
        
        lowerlakes.(sites{i}).WQ_TRC_SS1.Data = 0.43 .* lowerlakes.(sites{i}).WQ_DIAG_TOT_TURBIDITY.Data   +  9.2;
        
    end
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TKN') & ...
            isfield(lowerlakes.(sites{i}),'WQ_NIT_AMM')
        
        
        % First variable
        Fdate = lowerlakes.(sites{i}).WQ_DIAG_TOT_TKN.Date;
        Fdata = lowerlakes.(sites{i}).WQ_DIAG_TOT_TKN.Data;
        % Second Variable
        Sdate = lowerlakes.(sites{i}).WQ_NIT_AMM.Date;
        Sdata = lowerlakes.(sites{i}).WQ_NIT_AMM.Data;
        % Third Variable
        
        
        xdate = [min(Fdate):1:max(Fdate)]';
        
        if length(~isnan(Fdata)) > 3
            
            FIdata = interp1(Fdate(~isnan(Fdata)),Fdata(~isnan(Fdata)),xdate,'linear',mean(Fdata(~isnan(Fdata))));
            
            SIdata = interp1(Sdate(~isnan(Sdata)),Sdata(~isnan(Sdata)),xdate,'linear',mean(Sdata(~isnan(Sdata))));
            
            
            
            
            
            temp_val = FIdata - SIdata;
            
            % Set the variable
            lowerlakes.(sites{i}).ON = lowerlakes.(sites{i}).WQ_DIAG_TOT_TKN;
            
            lowerlakes.(sites{i}).ON.Data = [];
            lowerlakes.(sites{i}).ON.Depth = [];
            lowerlakes.(sites{i}).ON.Date=[];
            
            for ii = 1:length(Fdate)
                ss = find(floor(xdate) == floor(Fdate(ii)));
                if ~isempty(ss)
                    lowerlakes.(sites{i}).ON.Data(ii,1) = temp_val(ss);
                    lowerlakes.(sites{i}).ON.Date(ii,1) = xdate(ss);
                    lowerlakes.(sites{i}).ON.Depth(ii,1) = 0;
                end
            end
            lowerlakes.(sites{i}).ON.Title = {'Organic Nitrogen'};
        end
        clear Fdate Fdata Sdate Sdata SIdata FIdata temp_val;
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TP') & ...
            isfield(lowerlakes.(sites{i}),'WQ_PHS_FRP')
        
        
        % First variable
        Fdate = lowerlakes.(sites{i}).WQ_DIAG_TOT_TP.Date;
        Fdata = lowerlakes.(sites{i}).WQ_DIAG_TOT_TP.Data;
        % Second Variable
        Sdate = lowerlakes.(sites{i}).WQ_PHS_FRP.Date;
        Sdata = lowerlakes.(sites{i}).WQ_PHS_FRP.Data;
        % Third Variable
        
        
        xdate = [min(Fdate):1:max(Fdate)]';
        
        if length(~isnan(Fdata)) > 3
            
            FIdata = interp1(Fdate(~isnan(Fdata)),Fdata(~isnan(Fdata)),xdate,'linear',mean(Fdata(~isnan(Fdata))));
            
            SIdata = interp1(Sdate(~isnan(Sdata)),Sdata(~isnan(Sdata)),xdate,'linear',mean(Sdata(~isnan(Sdata))));
            
            
            
            
            
            temp_val = FIdata - SIdata;
            
            % Set the variable
            lowerlakes.(sites{i}).OP = lowerlakes.(sites{i}).WQ_DIAG_TOT_TP;
            
            lowerlakes.(sites{i}).OP.Data = [];
            lowerlakes.(sites{i}).OP.Depth = [];
            lowerlakes.(sites{i}).OP.Date=[];
            
            for ii = 1:length(Fdate)
                ss = find(floor(xdate) == floor(Fdate(ii)));
                if ~isempty(ss)
                    lowerlakes.(sites{i}).OP.Data(ii,1) = temp_val(ss);
                    lowerlakes.(sites{i}).OP.Date(ii,1) = xdate(ss);
                    lowerlakes.(sites{i}).OP.Depth(ii,1) = 0;
                end
            end
            lowerlakes.(sites{i}).OP.Title = {'Organic Phosphorus'};
        end
        clear Fdate Fdata Sdate Sdata SIdata FIdata temp_val;
        
    end
    
    
end