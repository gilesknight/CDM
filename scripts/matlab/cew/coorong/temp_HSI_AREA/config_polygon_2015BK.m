% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


fielddata = 'coorong';

% varname = {...
% 'SAL',...
% 'TEMP',...
% };
% 
% 
%     
% def.cAxis(1).value = [0 35];
% def.cAxis(2).value = [10 40];

varname = {...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TP',...
'WQ_NIT_AMM',...
'WQ_PHS_FRP',...
'WQ_TRC_SS1',...
'WQ_DIAG_MAG_PAR',...
'WQ_DIAG_MAG_TMALG',...
'WQ_MAG_ULVA',...
'WQ_DIAG_PHY_TCHLA',...
};

def.cAxis(1).value = [0 20];
def.cAxis(2).value = [0 2];
def.cAxis(3).value = [0 1];
def.cAxis(4).value = [0 0.25];
def.cAxis(5).value = [0 250];
def.cAxis(6).value = [0 125];
def.cAxis(7).value = [0 50];
def.cAxis(8).value = [0 1500];
def.cAxis(9).value = [0 150];
%  varname = {...
% 'WQ_DIAG_TOT_TN',...
% 'WQ_DIAG_TOT_TP',...
% 'WQ_OXY_OXY',...
% 'WQ_NIT_NIT',...
% 'WQ_NIT_AMM',...
% 'WQ_DIAG_MAG_ULVA_FI_BEN',...
% 'WQ_DIAG_MAG_ULVA_FNIT_BEN',...
% 'WQ_DIAG_MAG_ULVA_FPHO_BEN',...
% 'WQ_DIAG_MAG_ULVA_FT_BEN',...
% 'WQ_DIAG_MAG_ULVA_FSAL_BEN',...
% 'WQ_DIAG_MAG_GPP',...
% 'WQ_OGM_POC',...
% 'WQ_PHS_FRP',...
% 'WQ_DIAG_MAG_EXTC',...
% 'WQ_TRC_SS1',...
% 'WQ_DIAG_TRC_D_TAUB',...
% 'WQ_DIAG_TRC_RESUS',...
% 'WQ_DIAG_MAG_PAR',...
% 'WQ_DIAG_MAC_P_R',...
% 'WQ_DIAG_MAG_TMALG',...
% 'WQ_MAG_ULVA',...
% 'WQ_DIAG_PHY_MPB',...
% 'WQ_DIAG_PHY_TCHLA',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_PLANT',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_FLOWER',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_SEED',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_TURION',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_SPROUT',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_FSAL_1',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_FTEM_1',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_FLGT_1',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_FALG_1',...
% 'WQ_DIAG_HAB_RUPPIA_HSI_FDEP_1',...
% 'WQ_OGM_DON',...
% 'WQ_DIAG_PHY_PAR',...
% 'WQ_PHS_FRP',...
% 'WQ_PHS_FRP_ADS',...
% 'WQ_OGM_DOC',...
% 'WQ_OGM_DON',...
% 'WQ_OGM_PON',...
% 'WQ_OGM_DOP',...
% 'WQ_OGM_POP',...
% 'WQ_PHY_GRN',...
%};


% def.cAxis(1).value = [0 8];
% def.cAxis(2).value = [0 0.5];
% def.cAxis(3).value = [0 400];
% def.cAxis(4).value = [0 10];
% def.cAxis(5).value = [0 3];
% def.cAxis(6).value = [0 2];
% def.cAxis(7).value = [0 1.1];
% def.cAxis(8).value = [0 1.1];
% def.cAxis(9).value = [0 2];
% def.cAxis(10).value = [0 1.1];
% def.cAxis(11).value = [0 0.001];
% def.cAxis(12).value = [0 100];
% def.cAxis(13).value = [0 0.2];
% def.cAxis(14).value = [0 3];
% def.cAxis(15).value = [0 200];
% def.cAxis(16).value = [0 0.5];
% def.cAxis(17).value = [0 0.01];
% def.cAxis(18).value = [0 100];
% def.cAxis(19).value = [0 2];
% def.cAxis(20).value = [0 2];
% def.cAxis(21).value = [0 1000];
% def.cAxis(22).value = [0 200];
% def.cAxis(23).value = [0 100];
% def.cAxis(24).value = [0 1];
% def.cAxis(25).value = [0 1];
% def.cAxis(26).value = [0 1];
% def.cAxis(27).value = [0 1];
% def.cAxis(28).value = [0 1];
% def.cAxis(29).value = [0 1];
% def.cAxis(30).value = [0 1];
% def.cAxis(31).value = [0 1];
% def.cAxis(32).value = [0 1];
% def.cAxis(33).value = [0 1];
% def.cAxis(34).value = [0 6];
% def.cAxis(35).value = [0 1200];

% def.cAxis(9).value = [0 1];
% def.cAxis(10).value = [0 2500];
% def.cAxis(11).value = [0 500];
% def.cAxis(12).value = [0 300];
% def.cAxis(13).value = [0 200];
% def.cAxis(14).value = [0 10];
% def.cAxis(15).value = [0 10];
% def.cAxis(16).value = [0 750];
% def.cAxis(17).value = [0 750];
% def.cAxis(18).value = [0 30];
% def.cAxis(19).value = [0 10000];
% def.cAxis(20).value = [0 300];
% def.cAxis(21).value = [0 1000];
% def.cAxis(22).value = [-2 2];
% def.cAxis(23).value = [0 5];
% def.cAxis(24).value = [0 1];

%  varname = {...
%      'WQ_DIAG_PHY_TCHLA',...
%      };
% % 
%  def.cAxis(1).value = [0 50];
% def.cAxis(2).value = [0 0.75];

polygon_file = 'GIS/Ruppia_Zones.shp';

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;

filetype = 'eps';
def.expected = 1; % plot expected WL


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\010_Ruppia_2015_2016_1\Region\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'I:\Lowerlakes\Coorong Only Simulations\Scenarios\010_Ruppia_2015_2016_1\Output\coorong.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {'k','k'}; % Surface and Bottom
 ncfile(1).legend = '2015';
 ncfile(1).translate = 1;
 ncfile(1).timeshift = 0;
 
%  ncfile(2).name = 'I:\Lowerlakes\Coorong Only Simulations\009_Ruppia_2014_2015_Matt\Output\coorong.nc';
%  ncfile(2).symbol = {'-';'--'};
%  ncfile(2).colour = {'b','b'}; % Surface and Bottom
%  ncfile(2).legend = '2014';
%  ncfile(2).translate = 1;
%  ncfile(2).timeshift = 365;

 
%  ncfile(3).name = 'I:\Lowerlakes\Coorong Only Simulations\001_Ruppia_No_Wind\Output\lower_lakes.nc';
%  ncfile(3).symbol = {'-';'--'};
%  ncfile(3).colour = {'b','b'}; % Surface and Bottom
%  ncfile(3).legend = 'No Wind';
%  ncfile(3).translate = 1;
%  ncfile(3).timeshift = -365;
 

 
yr = 2015;



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,07,01:10:40);
%def.datearray = datenum(yr,01:03:13,01);
def.datearray = datenum(yr,01:03:13,01);

def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [12 7]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 7;
def.ylabelsize = 7;
def.titlesize = 12;
def.legendsize = 6;
def.legendlocation = 'northeast';

def.visible = 'off'; % on or off
