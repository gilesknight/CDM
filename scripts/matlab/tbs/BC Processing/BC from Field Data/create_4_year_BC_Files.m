clear all; close all;

addpath(genpath('Functions'));

outdir = 'BCs_4_year/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

datenew(:,1) = datenum(2012,01,01,00,00,00):60/(60*24):datenum(2016,01,01,00,00,00);


headers = {...
    'FLOW',...
    'SAL',...
    'TEMP',...
    'TRACE_1',...
    'WQ_TRC_SS1',...
    'WQ_TRC_RET',...
    'WQ_OXY_OXY',...
    'WQ_CAR_DIC',...
    'WQ_CAR_PH',...
    'WQ_CAR_CH4',...
    'WQ_SIL_RSI',...
    'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_NIT_N2O',...
    'WQ_PHS_FRP',...
    'WQ_PHS_FRP_ADS',...
    'WQ_OGM_DOC',...
    'WQ_OGM_POC',...
    'WQ_OGM_DON',...
    'WQ_OGM_PON',...
    'WQ_OGM_DOP',...
    'WQ_OGM_POP',...
    'WQ_PHY_GRN',...
    'WQ_ZOO_GRAZER',...
    'WQ_GEO_PE',...
    'WQ_GEO_UBALCHG',...
    'WQ_LND_TRACER',...
    'WQ_SBG_TRACER',...
    'WQ_SBG_DOM_LEACHATE',...
    };

dirs = {...
    'Lock1_Obs',...
    };

% dirs = {...
%     'Lock1_Obs',...
%     };


% for i = 1:length(dirs)
%     
%     load(['BCs_2013/',dirs{i},'/data.mat']);
%     filename = [outdir,dirs{i},'.csv'];
%     disp(filename);
%     if length(ISOTime) == length(datenew)
% 
%         write_tfvfile(tfv_data,headers,datenew,filename);
%         
%     else
%         vars = fieldnames(tfv_data);
%         
%         diff = length(datenew) - length(ISOTime);
%         
%         if diff > 0
%             for j = 1:diff
%                 for k = 1:length(vars)
%                     tfv_data.(vars{k})(end + j) = tfv_data.(vars{k})(end);
%                 end
%             end
%             write_tfvfile(tfv_data,headers,datenew,filename);
%         end
%     end
% end

%________________________________________________________________

load('BCs_2000\Lock1_Obs\data.mat');

datechange(:,1) = datenum(2006,01,01,00,00,00):60/(60*24):datenum(2010,01,01,00,00,00);
sss = find(ISOTime >= datechange(1) & ISOTime <= datechange(end));

old_time = ISOTime(sss);
old_flow = tfv_data.FLOW(sss);

load('BCs_2013\Lock1_Obs\data.mat');

if length(datechange) == length(ISOTime);
    tfv_data.FLOW = [];
    tfv_data.FLOW = old_flow;
    filename = [outdir,'Lock1_Obs_2006.csv'];
    write_tfvfile(tfv_data,headers,datenew,filename);
else
    stop;
end

%________________________________________________________________

load('BCs_2000\Lock1_Obs\data.mat');

datechange(:,1) = datenum(1995,01,01,00,00,00):60/(60*24):datenum(1999,01,01,00,00,00);
sss = find(ISOTime >= datechange(1) & ISOTime <= datechange(end));

old_time = ISOTime(sss);
old_flow = tfv_data.FLOW(sss);

load('BCs_2013\Lock1_Obs\data.mat');

if length(datechange) == length(ISOTime);
    tfv_data.FLOW = [];
    tfv_data.FLOW = old_flow;
    filename = [outdir,'Lock1_Obs_1995.csv'];
    write_tfvfile(tfv_data,headers,datenew,filename);
else
    stop;
end

%________________________________________________________________

load('BCs_2000\Lock1_Obs\data.mat');

datechange(:,1) = datenum(2013,01,01,00,00,00):60/(60*24):datenum(2017,01,01,00,00,00);
sss = find(ISOTime >= datechange(1) & ISOTime <= datechange(end));

old_time = ISOTime(sss);
old_flow = tfv_data.FLOW(sss);

load('BCs_2013\Lock1_Obs\data.mat');

if length(datechange) == length(ISOTime);
    tfv_data.FLOW = [];
    tfv_data.FLOW = old_flow;
    filename = [outdir,'Lock1_Obs_2013.csv'];
    write_tfvfile(tfv_data,headers,datenew,filename);
else
    stop;
end



% 
% %________________________________________________________________
% 
% datenew(:,1) = datenum(2013,01,01,00,00,00):60/(60*24):datenum(2016,01,01,00,00,00);
% 
% headers = {...
%     'WL',...
%     'SAL',...
%     'TEMP',...
%     'TRACE_1',...
%     'WQ_TRC_SS1',...
%     'WQ_TRC_RET',...
%     'WQ_OXY_OXY',...
%     'WQ_CAR_DIC',...
%     'WQ_CAR_PH',...
%     'WQ_CAR_CH4',...
%     'WQ_SIL_RSI',...
%     'WQ_NIT_AMM',...
%     'WQ_NIT_NIT',...
%     'WQ_NIT_N2O',...
%     'WQ_PHS_FRP',...
%     'WQ_PHS_FRP_ADS',...
%     'WQ_OGM_DOC',...
%     'WQ_OGM_POC',...
%     'WQ_OGM_DON',...
%     'WQ_OGM_PON',...
%     'WQ_OGM_DOP',...
%     'WQ_OGM_POP',...
%     'WQ_PHY_GRN',...
%     'WQ_ZOO_GRAZER',...
%     'WQ_GEO_PE',...
%     'WQ_GEO_UBALCHG',...
%     'WQ_LND_TRACER',...
%     'WQ_SBG_TRACER',...
%     'WQ_SBG_DOM_LEACHATE',...
%     };
% 
% 
% 
% 
% dirs = {...
% 'VH3_noFan',...
% };
% 
% for i = 1:length(dirs)
%     
%     load(['BCs_2013/',dirs{i},'/data.mat']);
%     filename = [outdir,dir{i},'.csv'];
%     disp(filename);
%     if length(ISOTime) == length(datenew)
% 
%         write_tfvfile(tfv_data,headers,datenew,filename);
%         
%     else
%         vars = fieldnames(tfv_data);
%         
%         diff = length(datenew) - length(ISOTime);
%         
%         if diff > 0
%             for j = 1:diff
%                 for k = 1:length(vars)
%                     tfv_data.(vars{k})(end + j) = tfv_data.(vars{k})(end);
%                 end
%             end
%             write_tfvfile(tfv_data,headers,datenew,filename);
%         end
%     end
% end