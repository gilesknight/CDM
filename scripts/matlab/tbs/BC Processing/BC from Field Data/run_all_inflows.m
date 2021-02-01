clear all; close all;

addpath(genpath('Functions'));

outdir = 'BCs_2015_well/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

load lowerlakes.mat;


%lowerlakes = limit_datasites(lowerlakes,1);

datearray(:,1) = datenum(2015,01,01,00,00,00):1:datenum(2017,01,01,00,00,00);


% headers = {...
%     'FLOW',...
%     'SAL',...
%     'TEMP',...
%     'TRACE_1',...
%     'WQ_TRC_SS1',...
% 'WQ_TRC_RET',...
% 'WQ_OXY_OXY',...
% 'WQ_CAR_DIC',...
% 'WQ_CAR_PH',...
% 'WQ_CAR_CH4',...
% 'WQ_SIL_RSI',...
% 'WQ_NIT_AMM',...
% 'WQ_NIT_NIT',...
% 'WQ_NIT_N2O',...
% 'WQ_PHS_FRP',...
% 'WQ_PHS_FRP_ADS',...
% 'WQ_OGM_DOC',...
% 'WQ_OGM_POC',...
% 'WQ_OGM_DON',...
% 'WQ_OGM_PON',...
% 'WQ_OGM_DOP',...
% 'WQ_OGM_POP',...
% 'WQ_PHY_GRN',...
% 'WQ_ZOO_GRAZER',...
% 'WQ_GEO_PE',...
% 'WQ_GEO_UBALCHG',...
% 'WQ_LND_TRACER',...
% 'WQ_SBG_TRACER',...
% 'WQ_SBG_DOM_LEACHATE',...
%     };

headers = {...
    'FLOW',...
    'SAL',...
    'TEMP',...
    'TRACE_1',...
    'WQ_TRC_AGE',...
    'WQ_NCS_SS1',...
'WQ_OXY_OXY',...
'WQ_SIL_RSI',...
'WQ_NIT_AMM',...
'WQ_NIT_NIT',...
'WQ_PHS_FRP',...
'WQ_PHS_FRP_ADS',...
'WQ_OGM_DOC',...
'WQ_OGM_POC',...
'WQ_OGM_DON',...
'WQ_OGM_PON',...
'WQ_OGM_DOP',...
'WQ_OGM_POP',...
'WQ_PHY_GRN',...
    };

% filename = [outdir,'Chowilla_Lock6.csv'];
% subdir = [outdir,'Chowilla_Lock6/'];
% 
% X = 489466.7;
% Y = 6238325.5;
% 
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Chowilla_Lock6');
% 
% 
% 
% 
% %
% 
% filename = [outdir,'Chowilla_Lock5.csv'];
% subdir = [outdir,'Chowilla_Lock5/'];
% 
% X = 478506.1;
% Y = 6216905.4;
% 
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Chowilla_Lock5');
% 
% 
% %headers{1} = 'H';
% filename = [outdir,'Chowilla_Chowilla_Creek.csv'];
% subdir = [outdir,'Chowilla_Chowilla_Creek/'];
% 
% X = 487239;
% Y = 6239358;
% 
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Chowilla_Chowilla_Creek');
% 


% % 
% % % 
% % % % % % % ____________________________________________________
% % % filename = [outdir,'Lock1_Obs.csv'];
% % % subdir = [outdir,'Lock1_Obs/'];
% % % 
% % % X = 372816.2;
% % % Y = 6197980.5;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Lock1_Obs');
% % % % % % 
% % % create_scenarios_flows(outdir,'Lock1_Obs',headers);
% % % 
% % % 
% % % % % %  
% % % % % % % % % % % ____________________________________________________
% % % filename = [outdir,'MALP_Offtake.csv'];
% % % subdir = [outdir,'MALP_Offtake/'];
% % % 
% % % X = 345925.70;
% % % Y = 6135137.64;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'MALP_Offtake');
% % % 
% % % % % ____________________________________________________
% % % % %____________________________________________________
% % % filename = [outdir,'MBO_Offtake.csv'];
% % % subdir = [outdir,'MBO_Offtake/'];
% % % 
% % % X = 343220.92;
% % % Y = 6112719.63;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'MBO_Offtake');
% % % 
% % % % % ____________________________________________________
% % % filename = [outdir,'SRS_Offtake.csv'];
% % % subdir = [outdir,'SRS_Offtake/'];
% % % 
% % % X = 371170.12;
% % % Y = 6174209.94;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'SRS_Offtake');
% % % 
% % % % % ____________________________________________________
% % % % % ____________________________________________________
% % % filename = [outdir,'TB_Offtake.csv'];
% % % subdir = [outdir,'TB_Offtake/'];
% % % 
% % % X = 359254.30;
% % % Y = 6097452.90;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'TB_Offtake');
% % % 
% % % % %____________________________________________________
% % % filename = [outdir,'SR_Offtake.csv'];
% % % subdir = [outdir,'SR_Offtake/'];
% % % 
% % % X = 350782.77;
% % % Y = 6120567.39;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'SR_Offtake');
% % % % % 
% % % % % 
% % % % % ____________________________________________________
filename = [outdir,'Wellington.csv'];
subdir = [outdir,'Wellington/'];

X = 352265.2;
Y = 6085784.0;

create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Wellington_BC_v2');
% % % % % 
% % % % % %____________________________________________________
% % % % % filename = [outdir,'Albert_Pumping.csv'];
% % % % % subdir = [outdir,'Albert_Pumping/'];
% % % % % 
% % % % % X = 333970.0;
% % % % % Y = 6072540.0;
% % % % % 
% % % % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Albert_Pumping');
% % % % % 
% % % % % ____________________________________________________
% % % % % filename = [outdir,'Goolwa_Pumping.csv'];
% % % % % subdir = [outdir,'Goolwa_Pumping/'];
% % % % % 
% % % % % X = 312092.0;
% % % % % Y = 6069136.0;
% % % % % 
% % % % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Goolwa_Pumping');
% % % % % 
% % % % % ____________________________________________________
% % % % % filename = [outdir,'Alex_Excess.csv'];
% % % % % subdir = [outdir,'Alex_Excess/'];
% % % % % 
% % % % % X = 326228.6;
% % % % % Y = 6070265.93;
% % % % % 
% % % % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Alex_Excess');
% % % 
% % % 
% % % %__________________________________________________
% % % 


% % % filename = [outdir,'Bremer.csv'];
% % % subdir = [outdir,'Bremer/'];
% % % 
% % % X = 322978.0;
% % % Y = 6082138.0;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Bremer_BC_v2');
% % % 
% % % % %__________________________________________________
% % % 
% % % filename = [outdir,'Angus.csv'];
% % % subdir = [outdir,'Angus/'];
% % % 
% % % X = 304939.0;
% % % Y = 6099634.0;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Angus_BC_v2');
% % % 
% % % 
% % % % %__________________________________________________
% % % filename = [outdir,'Finniss.csv'];
% % % subdir = [outdir,'Finniss/'];
% % % 
% % % X = 302934.0;
% % % Y = 6080419.0;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Finniss_BC_v2');
% % % % % 
% % % % % __________________________________________________
% % % filename = [outdir,'Salt_2017.csv'];
% % % subdir = [outdir,'Salt_2017/'];
% % % 
% % % X = 378834.;
% % % Y = 6001351.5;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Salt_2017');
% % % % % 
% % % % % 
% % % % % __________________________________________________
% % % filename = [outdir,'Currency.csv'];
% % % subdir = [outdir,'Currency/'];
% % % 
% % % X = 298066.0;
% % % Y = 6074055.0;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Currency_BC_v2');
% % % % % % % % 
% % % % % % % % __________________________________________________
% % % % % % 
% % % % % % % 
% % % clear datearray;
% % % datearray(:,1) = datenum(2015,01,01,00,00,00):15/(60*24):datenum(2018,07,01,00,00,00);
% % % 
% % % headers{1} = 'H';
% % % 
% % % filename = [outdir,'BK_2017.csv'];
% % % subdir = [outdir,'BK_2017/'];
% % % 
% % % X = 309703.3;
% % % Y = 6062973;
% % % 
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'BK_2017');
% % % % % % 


headers{1} = 'H';
filename = [outdir,'Wellington_H.csv'];
subdir = [outdir,'Wellington/'];

X = 352265.2;
Y = 6085784.0;

create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Wellington_BC_v2');




% 
%merge_files_cewh;
