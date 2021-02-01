% Configuration____________________________________________________________

fielddata = 'coorong_mini';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% varname = {'H'};
% def.cAxis(1).value = [0 2];

varname = {...
    'SAL',...
    'H',...
    'TEMP',...
%         'WQ_DIAG_MAG_PAR',...
%     'WQ_DIAG_TOT_TN',...
%     'WQ_DIAG_TOT_TP',...
%     'WQ_DIAG_PHY_TCHLA',...
%     'WQ_DIAG_MAG_TMALG',...
%     'WQ_MAG_ULVA',...
%     'WQ_TRC_SS1',...
%     'WQ_PHS_FRP',...
%     'WQ_NIT_AMM',...
};



def.cAxis(1).value = [0 50];
def.cAxis(2).value = [-1 2];
def.cAxis(3).value = [0 35];

% def.cAxis(4).value = [0 155];
% def.cAxis(5).value = [0 15];
% def.cAxis(6).value = [10 250];
% def.cAxis(7).value = [10 250];
% def.cAxis(8).value = [0 10];
% def.cAxis(9).value = [0 5];
% def.cAxis(10).value = [0 125];
% def.cAxis(11).value = [0 100];
% def.cAxis(12).value = [0 15];
% def.cAxis(13).value = [0 50];
% def.cAxis(14).value = [0 25];
% def.cAxis(15).value = [0 25];
% def.cAxis(16).value = [0 100];
% def.cAxis(17).value = [0 100];
% def.cAxis(18).value = [0 75];
% def.cAxis(19).value = [0 3000];
% def.cAxis(20).value = [0 2500];
% def.cAxis(21).value = [0 2.5];
% def.cAxis(22).value = [0 45];
% def.cAxis(23).value = [10 45];
% def.cAxis(24).value = [0 100];
% def.cAxis(25).value = [0 750];
% def.cAxis(26).value = [0 40];
% def.cAxis(27).value = [0 4000];
% def.cAxis(28).value = [0 250];
% def.cAxis(29).value = [0 2];
% def.cAxis(30).value = [0 15];
% def.cAxis(31).value = [0 10];

convert_units = 1; %1 ro 0;

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface'};%;'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;

filetype = 'eps';
def.expected = 0; % plot expected WL

outputdirectory = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\011_Ruppia_2014_2015_1\Point\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

%ncfile(1).name = 'I:\Lowerlakes\Coorong Only Simulations\004_Ruppia_2015_2016_Old_2DM_Daily_SC\Output\lower_lakes.nc';
%ncfile(1).symbol = {'-';'-'};
%ncfile(1).colour = {'k','k'}; % Surface and Bottom
%ncfile(1).legend = 'Old';
%ncfile(1).translate = 1;


ncfile(1).name = 'I:\Lowerlakes\Coorong Only Simulations\Scenarios\011_Ruppia_2014_2015_1\Output\coorong.nc';
ncfile(1).symbol = {'-';'--'};
ncfile(1).colour = {'k','k'}; % Surface and Bottom
ncfile(1).legend = '009';
ncfile(1).translate = 1;

yr = 2014;



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,01:12:49,01);

def.datearray = datenum(yr,01:03:13,01);
%def.datearray = datenum(yr,01,01:04:21);


%def.datearray = datenum(2011,06,07.2:0.05:7.45);

%def.datearray = datenum(yr-1,11:2:23,01);
def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [12 7]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)


def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'k','b'}; % Cell with same number of levels

def.font = 'Candara';

def.xlabelsize = 9;
def.ylabelsize = 9;
def.titlesize = 12;
def.legendsize = 6;
def.legendlocation = 'NE';

def.visible = 'on'; % on or off
