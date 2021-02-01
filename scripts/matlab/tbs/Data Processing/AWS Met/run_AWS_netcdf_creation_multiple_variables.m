clear all; close all;

% Possible varnames

%           Wind to do both Wx & Wx
%           Rad_Model: [1×80364 double]
%            TC_interp: [1×80364 double]
%            Wx_interp: [1×80364 double]
%            Wy_interp: [1×80364 double]
%            RH_interp: [1×80364 double]
%          Temp_interp: [1×80364 double]
%           W_Speed_interp: [1×80364 double]
%         W_Dir_interp: [1×80364 double]
%       Rain_interp

% Netcdf units


% rhum
% longname = 'relative humidity'
% units = 'percent'
% 
% dswr
% longname = 'downward shortwave radiation'
% units = 'W m^-2'
% 
% dlwr
% longname = 'downward longwave radiation'
% units = 'W m^-2'
% 
% rain
% longname = 'precipitation'
% units = 'm d^-1'
% 
% u
% longname = 'u'
% units = 'm s^-1'
% 
% 
% v
% longname = 'v'
% units = 'm s^-1'
% 
% temp
% longname = 'air temperature'
% units = 'degC'


mtime = [datenum(2015,01,01):1/24:datenum(2017,07,01)];

varname = 'RH_interp';

ncname = 'AWS_RH_2015_2017.nc';


longname = 'relative humidity';
shortname = 'rhum';
units = 'percent';

grid = 'Grids/LL_Full_Domain.2dm';


create_AWS_variable_netcdf(varname,ncname,mtime,longname,shortname,units,grid);
clear function
%___________________________________________________________

mtime = [datenum(2015,01,01):1:datenum(2017,07,01)];

varname = 'Rain_interp';

ncname = 'AWS_Rain_2015_2017.nc';


longname = 'precipitation';
shortname = 'rain';
units = 'm d^-1';

grid = 'Grids/LL_Full_Domain.2dm';

create_AWS_variable_netcdf(varname,ncname,mtime,longname,shortname,units,grid);

clear function
%___________________________________________________________

mtime = [datenum(2015,01,01):1/24:datenum(2017,07,01)];
% % % 
varname = 'Temp_interp';

ncname = 'AWS_AT_2015_2017.nc';


longname = 'air temperature';
shortname = 'temp';
units = 'degC';

grid = 'Grids/LL_Full_Domain.2dm';


create_AWS_variable_netcdf(varname,ncname,mtime,longname,shortname,units,grid);
clear function
%___________________________________________________________

mtime = [datenum(2015,01,01):1/24:datenum(2017,07,01)];
% % % 
varname = 'Rad_Model';

ncname = 'AWS_SW_2015_2017.nc';


longname = 'downward shortwave radiation';
shortname = 'dswr';
units = 'W m^-2'

grid = 'Grids/LL_Full_Domain.2dm';


create_AWS_variable_netcdf(varname,ncname,mtime,longname,shortname,units,grid);
clear function
%___________________________________________________________
