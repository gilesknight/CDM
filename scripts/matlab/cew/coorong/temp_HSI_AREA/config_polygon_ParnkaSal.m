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
'WQ_DIAG_MAG_PAR',...
};

def.cAxis(1).value = [0 20];
def.cAxis(2).value = [0 125];


polygon_file = 'GIS/Ruppia_Zones.shp';

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = false; % true or false

plotdepth = {'surface'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;

filetype = 'eps';
def.expected = 1; % plot expected WL


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\Parnka_Salinity\Region\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

ncfile(1).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_2_SC40_Parnka_Fixed_TS\Output\coorong.nc';
ncfile(1).symbol = {'-';'--'};
ncfile(1).colour = {'k','k'}; % Surface and Bottom
ncfile(1).legend = 'Parnka SC40';
 ncfile(1).translate = 1;
 ncfile(1).timeshift = 0;
 
ncfile(2).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_11_Parnka_SC40_SAL\Output\coorong.nc';
ncfile(2).symbol = {'-';'--'};
ncfile(2).colour = {'r','r'}; % Surface and Bottom
ncfile(2).legend = 'Parnka SC40 High Salinity';
ncfile(2).translate = 1;
ncfile(2).timeshift = 0;

 
ncfile(3).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_12_noWeir_SC40_SAL_PGrid\Output\coorong.nc';
ncfile(3).symbol = {'-';'--'};
ncfile(3).colour = {'b','b'}; % Surface and Bottom
ncfile(3).legend = 'No Weir SC40 High Salinity';
ncfile(3).translate = 1;
 ncfile(3).timeshift = 0;


 
yr = 2014;



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,01:12:49,01);

def.datearray = datenum(yr,04:04:24,01);

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
