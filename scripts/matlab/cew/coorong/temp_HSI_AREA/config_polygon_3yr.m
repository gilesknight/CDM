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


%  varname = {...
% 'WQ_DIAG_TOT_TN',...
% 'WQ_DIAG_TOT_TP',...
% 'WQ_DIAG_PHY_TCHLA',...
% 'WQ_TRC_SS1',...
% 'WQ_DIAG_MAG_TMALG',...
% 'SAL',...
% 'H'
% };
% 
% 
% def.cAxis(1).value = [0 20];
% def.cAxis(2).value = [0 2];
% def.cAxis(3).value = [0 150];
% def.cAxis(4).value = [0 250];
% def.cAxis(5).value = [0 50];
% def.cAxis(6).value = [0 50];
% def.cAxis(7).value = [-0.5 1.5];

 varname = {...
'WQ_DIAG_MAG_TMALG',...
'SAL',...
};


def.cAxis(1).value = [0 50];
def.cAxis(2).value = [0 75];


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


outputdirectory = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\3Yr\Region\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'I:\Lowerlakes\Coorong Only Simulations\Scenarios\010_Ruppia_2015_2016_1\Output\coorong.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {'k','k'}; % Surface and Bottom
 ncfile(1).legend = '2015';
 ncfile(1).translate = 1;
 ncfile(1).timeshift = 0;
 
 ncfile(2).name = 'I:\Lowerlakes\Coorong Only Simulations\Scenarios\009_Ruppia_2014_2015_Matt\Output\coorong.nc';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {'b','b'}; % Surface and Bottom
 ncfile(2).legend = '2014';
 ncfile(2).translate = 1;
 ncfile(2).timeshift = 365;

 
 ncfile(3).name = 'I:\Lowerlakes\Coorong Only Simulations\Scenarios\009_Ruppia_2016_2017_Matt\Output\coorong.nc';
 ncfile(3).symbol = {'-';'--'};
 ncfile(3).colour = {'g','g'}; % Surface and Bottom
 ncfile(3).legend = '2016';
 ncfile(3).translate = 1;
 ncfile(3).timeshift = -365;
 

 
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
