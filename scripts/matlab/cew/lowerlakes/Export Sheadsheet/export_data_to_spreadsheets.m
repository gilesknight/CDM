clear all; close all;

addpath(genpath('tuflowfv'));

% The concentration spreadsheets....

outdir = 'H:\Lowerlakes-CEW-Results\Upload/Spreadsheets/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end


sites = {'Obs';'noCEW';'noAll'};

sheet_names = {'With All Water Concentration.csv';'No Cew Concentration.csv';'No eWater Concentration.csv'};


vars = {'SAL';...
    'WQ_PHS_FRP';...
    'OP';...
    'WQ_NIT_AMM';...
    'ON';...
    'WQ_SIL_RSI';...
    'WQ_DIAG_PHY_TCHLA'};

var_names = {'Salinity (psu)';...
    'filterableReactivePhosphorus concentration (mg/L)';...
    'Organic Phosphorus Concentration (mg/L)';...
    'ammoniumConcentration (mg/L)';...
    'Organic Nitrogen Concentration (mg/L)';...
    'dissolvedSilica concentration (mg/L)';...
    'chlorophyll-aConcentration (ug/L)'};


points = {'s0001_Wellington';'s0005_Lake_Alex_Mid';'s0023_Mouth'};

point_names = {'RM3 - Wellington';'LAx4 - Lake Alexandrina Middle';'C5 - Murray Mouth'};


salt_conv = 1;%1000 / 0.56;
oxy_conv = 32/1000;
%__________________________________________________________________________


load ts_data.mat;

% Create the daily time array

daily_date = [min(floor(ts_data.H.s0005_Lake_Alex_Mid.mdate)):1:max(floor(ts_data.H.s0005_Lake_Alex_Mid.mdate))];





for i = 1:length(sheet_names)
    
    s_site = sites{i};
    
    fid = fopen([outdir,sheet_names{i}],'wt');
    
    % Header
    fprintf(fid,'Sample Point Name,sampleDate,');
    
    for ii = 1:length(var_names)
        if ii == length(var_names)
            fprintf(fid,'%s\n',var_names{ii});
        else
            fprintf(fid,'%s,',var_names{ii});
        end
    end

    
    
    for j = 1:length(daily_date)
        
        s_date = daily_date(j);
       
        for k = 1:length(point_names)
            s_point = points{k};
            s_point_name = point_names{k};
            
            fprintf(fid,'%s,%s,',s_point_name,datestr(s_date,'dd/mm/yyyy'));
            
            for l = 1:length(var_names)
                
                s_var = vars{l};
                
                if isfield(ts_data,s_var)
                
                ss = find(floor(ts_data.(s_var).(s_point).mdate) == s_date);
                
                s_val = mean(ts_data.(s_var).(s_point).(s_site)(ss));
                
                % Any additional conversion......
                if strcmpi(s_var,'SAL') == 1
                    s_val = s_val * salt_conv;
                end
				
				if strcmpi(s_var,'WQ_OXY_OXY') == 1
                    s_val = s_val * oxy_conv;
                end
				
				
                
                if l == length(var_names)
                    fprintf(fid,'%10.3f\n',s_val);
                else
                    fprintf(fid,'%10.3f,',s_val);
                end
                end
            end
        end
        
    end
    
end
