% Configuration____________________________________________________________

fielddata = 'coorong_sal';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% varname = {'H'};
% def.cAxis(1).value = [0 2];

varname = {...
    'SAL',...
    };



def.cAxis(1).value = [0 150];

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

convert_units = 0; %1 ro 0;

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

outputdirectory = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\008_2015\Point_Scenario_s\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

%ncfile(1).name = 'I:\Lowerlakes\Coorong Only Simulations\004_Ruppia_2015_2016_Old_2DM_Daily_SC\Output\lower_lakes.nc';
%ncfile(1).symbol = {'-';'-'};
%ncfile(1).colour = {'k','k'}; % Surface and Bottom
%ncfile(1).legend = 'Old';
%ncfile(1).translate = 1;


ncfile(1).name = 'I:\Lowerlakes\Coorong Only Simulations\008_Ruppia_2015_2016_Matt_0SC\Output\coorong.nc';
ncfile(1).symbol = {'-';'--'};
ncfile(1).colour = {'c','c'}; % Surface and Bottom
ncfile(1).legend = '0SC';
ncfile(1).translate = 1;

ncfile(2).name = 'I:\Lowerlakes\Coorong Only Simulations\008_Ruppia_2015_2016_Matt\Output\coorong.nc';
ncfile(2).symbol = {'-';'--'};
ncfile(2).colour = {'k','k'}; % Surface and Bottom
ncfile(2).legend = '1SC';
ncfile(2).translate = 1;

ncfile(3).name = 'I:\Lowerlakes\Coorong Only Simulations\008_Ruppia_2015_2016_Matt_2SC\Output\coorong.nc';
ncfile(3).symbol = {'-';'--'};
ncfile(3).colour = {'r','r'}; % Surface and Bottom
ncfile(3).legend = '2SC';
ncfile(3).translate = 1;

ncfile(4).name = 'I:\Lowerlakes\Coorong Only Simulations\008_Ruppia_2015_2016_Matt_5SC\Output\coorong.nc';
ncfile(4).symbol = {'-';'--'};
ncfile(4).colour = {'g','g'}; % Surface and Bottom
ncfile(4).legend = '5SC';
ncfile(4).translate = 1;

ncfile(5).name = 'I:\Lowerlakes\Coorong Only Simulations\008_Ruppia_2015_2016_Matt_HighIC_5SC\Output\coorong.nc';
ncfile(5).symbol = {'-';'--'};
ncfile(5).colour = {'b','b'}; % Surface and Bottom
ncfile(5).legend = '5SC+IC';
ncfile(5).translate = 1;

ncfile(6).name = 'I:\Lowerlakes\Coorong Only Simulations\008_Ruppia_2015_2016_Matt_5SC_Nuts\Output\coorong.nc';
ncfile(6).symbol = {'-';'--'};
ncfile(6).colour = {'y','y'}; % Surface and Bottom
ncfile(6).legend = '5SC+2Nuts';
ncfile(6).translate = 1;

ncfile(7).name = 'I:\Lowerlakes\Coorong Only Simulations\008_Ruppia_2015_2016_Matt_10SC_Nuts\Output\coorong.nc';
ncfile(7).symbol = {'-';'--'};
ncfile(7).colour = {'m','m'}; % Surface and Bottom
ncfile(7).legend = '10SC+2Nuts';
ncfile(7).translate = 1;

yr = 2015;


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
def.legendlocation = 'SW';

def.visible = 'on'; % on or off
