clear all; close all;

load lowerlakes.mat;

sites = fieldnames(lowerlakes);

for i = 1:length(sites)
    
    
    
    
    if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TN') & ...
        isfield(lowerlakes.(sites{i}),'WQ_NIT_NIT') & ...
        isfield(lowerlakes.(sites{i}),'WQ_NIT_AMM')
    
    
     % First variable
        Fdate = lowerlakes.(sites{i}).WQ_DIAG_TOT_TN.Date;
        Fdata = lowerlakes.(sites{i}).WQ_DIAG_TOT_TN.Data;
        % Second Variable
        Sdate = lowerlakes.(sites{i}).WQ_NIT_NIT.Date;
        Sdata = lowerlakes.(sites{i}).WQ_NIT_NIT.Data;
        % Third Variable
        Tdate = lowerlakes.(sites{i}).WQ_NIT_AMM.Date;
        Tdata = lowerlakes.(sites{i}).WQ_NIT_AMM.Data;
        
        xdate = [min(Fdate):1:max(Fdate)]';
        
        if length(~isnan(Fdata)) > 1
            
            FIdata = interp1(Fdate(~isnan(Fdata)),Fdata(~isnan(Fdata)),xdate,'linear',mean(Fdata(~isnan(Fdata))));
            
            SIdata = interp1(Sdate(~isnan(Sdata)),Sdata(~isnan(Sdata)),xdate,'linear',mean(Sdata(~isnan(Sdata))));
            
            TIdata = interp1(Tdate(~isnan(Tdata)),Tdata(~isnan(Tdata)),xdate,'linear',mean(Tdata(~isnan(Tdata))));
            
            
            
            
            temp_val = (FIdata - SIdata - TIdata);
            
            % Set the variable
            lowerlakes.(sites{i}).ON = lowerlakes.(sites{i}).WQ_DIAG_TOT_TN;
            
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
        clear Fdate Fdata Sdate Sdata Tdate Tdata TIdata SIdata FIdata temp_val;
   
    end
%     if isfield(lowerlakes.(sites{i}),'WQ_DIAG_TOT_TKN') & ...
%         isfield(lowerlakes.(sites{i}),'WQ_NIT_AMM') 
%     
%     
%      % First variable
%         Fdate = lowerlakes.(sites{i}).WQ_DIAG_TOT_TKN.Date;
%         Fdata = lowerlakes.(sites{i}).WQ_DIAG_TOT_TKN.Data;
%         % Second Variable
%         Sdate = lowerlakes.(sites{i}).WQ_NIT_AMM.Date;
%         Sdata = lowerlakes.(sites{i}).WQ_NIT_AMM.Data;
%         % Third Variable
% 
%         
%         xdate = [min(Fdate):1:max(Fdate)]';
%         
%         if length(~isnan(Fdata)) > 1
%             
%             FIdata = interp1(Fdate(~isnan(Fdata)),Fdata(~isnan(Fdata)),xdate,'linear',mean(Fdata(~isnan(Fdata))));
%             
%             SIdata = interp1(Sdate(~isnan(Sdata)),Sdata(~isnan(Sdata)),xdate,'linear',mean(Sdata(~isnan(Sdata))));
%             
%             
%             
%             
%             
%             temp_val = FIdata - SIdata;
%             
%             % Set the variable
%             lowerlakes.(sites{i}).ON = lowerlakes.(sites{i}).WQ_DIAG_TOT_TKN;
%             
%             lowerlakes.(sites{i}).ON.Data = [];
%             lowerlakes.(sites{i}).ON.Depth = [];
%             lowerlakes.(sites{i}).ON.Date=[];
%             
%             for ii = 1:length(Fdate)
%                 ss = find(floor(xdate) == floor(Fdate(ii)));
%                 if ~isempty(ss)
%                     lowerlakes.(sites{i}).ON.Data(ii,1) = temp_val(ss);
%                     lowerlakes.(sites{i}).ON.Date(ii,1) = xdate(ss);
%                     lowerlakes.(sites{i}).ON.Depth(ii,1) = 0;
%                 end
%             end
%             lowerlakes.(sites{i}).ON.Title = {'Organic Nitrogen'};
%         end
%         clear Fdate Fdata Sdate Sdata SIdata FIdata temp_val;
%    
%     end
    
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
        
        if length(~isnan(Fdata)) > 1
            
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

save lowerlakes.mat lowerlakes -mat

