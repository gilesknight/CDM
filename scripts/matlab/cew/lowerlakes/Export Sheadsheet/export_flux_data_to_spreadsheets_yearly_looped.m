clear all; close all;

addpath(genpath('tuflowfv'));

% The concentration spreadsheets....

outdir = 'K:\Lowerlakes-CEW-Results\Upload/Spreadsheets_1/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end


sites = {'Obs';'noCEW';'noAll'};

sheet_names = {'With All Water Loads.csv';'No Cew Loads.csv';'No eWater Loads.csv'};


vars = {'Salt';...
    'PHS_frp';...
    'OP';...
    'NIT_amm';...
    'ON';...
    'SIL_rsi';...
    'PHY_grn'};

var_names = {'salinityLoad (kg/day)';...
    'filterableReactivePhosphorus load (kg/day)';...
    'Organic Phosphorus load (kg/day)';...
     'ammoniumLoad (kg/day)';...
    'Organic Nitrogen load (kg/day)';...
    'dissolvedSilica load (kg/day)';...
    'chlorophyll-aLoad (kg/day)'};





points = {'Wellington';'Barrage';'Murray'};

point_names = {'Wellington';'Barrage Total';'Murray Mouth'};


conv = 1000;

%__________________________________________________________________________


load flux_data.mat;

% Create the daily time array

daily_date = flux_data.Flow.Barrage.mdate;





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
                if isfield(flux_data,s_var)
                    
                    ss = find(floor(flux_data.(s_var).(s_point).mdate) == s_date);
                    
                    s_val = mean(flux_data.(s_var).(s_point).(s_site)(ss));
                    
                    % Any additional conversion......
                    %                 if strcmpi(s_var,'SAL') == 1
                    %                     s_val = s_val * salt_conv;
                    %                 end
                    % Convert from tonnes/day to kg/day
                    s_val = s_val * conv;
                    
                    if l == length(var_names)
                        fprintf(fid,'%10.0f\n',s_val);
                    else
                        fprintf(fid,'%10.0f,',s_val);
                    end
                end
            end
        end
        
    end
    
end
