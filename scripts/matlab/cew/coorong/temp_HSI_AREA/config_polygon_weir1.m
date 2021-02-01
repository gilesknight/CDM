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


outputdirectory = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\Weir_Option_1\Region\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

%ncfile(1).name = 'I:\Lowerlakes\Coorong Only Simulations\004_Ruppia_2015_2016_Old_2DM_Daily_SC\Output\lower_lakes.nc';
%ncfile(1).symbol = {'-';'-'};
%ncfile(1).colour = {'k','k'}; % Surface and Bottom
%ncfile(1).legend = 'Old';
%ncfile(1).translate = 1;


ncfile(1).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_4_SC70_Needles\Output\coorong.nc';
ncfile(1).symbol = {'-';'--'};
ncfile(1).colour = {'k','k'}; % Surface and Bottom
ncfile(1).legend = 'Needles SC70 (Sill 0.6m)';
ncfile(1).translate = 1;

ncfile(2).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_10_SC70_Needles_Sill04\Output\coorong.nc';
ncfile(2).symbol = {'-';'--'};
ncfile(2).colour = {'r','r'}; % Surface and Bottom
ncfile(2).legend = 'Needles SC70 (Sill 0.4m)';
ncfile(2).translate = 1;

ncfile(3).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_ORH_2014_2016_Needles_Sill\Output\coorong.nc';
ncfile(3).symbol = {'-';'--'};
ncfile(3).colour = {'g','g'}; % Surface and Bottom
ncfile(3).legend = 'Needles ORH (Sill 0.4m)';
ncfile(3).translate = 1;

ncfile(4).name = 'I:\Lowerlakes\Coorong Weir Simulations\012_Weir_6_SC70_noWeir\Output\coorong.nc';
ncfile(4).symbol = {'-';'--'};
ncfile(4).colour = {'b','b'}; % Surface and Bottom
ncfile(4).legend = 'No Weir SC70';
ncfile(4).translate = 1;
% 
ncfile(5).name = 'I:\Lowerlakes\Coorong Weir Simulations\012_ORH_2014_2016_1\Output\coorong.nc';
ncfile(5).symbol = {'-';'--'};
ncfile(5).colour = {'m','m'}; % Surface and Bottom
ncfile(5).legend = 'ORH';
ncfile(5).translate = 1;

% ncfile(4).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_2_SC40_Parnka_Fixed_TS\Output\coorong.nc';
% ncfile(4).symbol = {'-';'--'};
% ncfile(4).colour = {'g','g'}; % Surface and Bottom
% ncfile(4).legend = 'Parnka Weir SC40';
% ncfile(4).translate = 1;
% 
% ncfile(5).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_8_SC55_Parnka\Output\coorong.nc';
% ncfile(5).symbol = {'-';'--'};
% ncfile(5).colour = {'m','m'}; % Surface and Bottom
% ncfile(5).legend = 'Parnka Weir SC55';
% ncfile(5).translate = 1;
% 
% ncfile(6).name = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_5_SC70_Parnka\Output\coorong.nc';
% ncfile(6).symbol = {'-';'--'};
% ncfile(6).colour = {'y','y'}; % Surface and Bottom
% ncfile(6).legend = 'Parnka Weir SC70';
% ncfile(6).translate = 1;

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
