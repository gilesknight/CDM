function [data,x,y,z] = tfv_readPTM(filename)
% A simple function to read and import all relevent data from the tfv PTM
% netcdf.

x = [];
y = [];
z = [];

ncid = netcdf.open(filename,'NC_NOWRITE');

data.Time = ncread(filename,'Time');
 data.stat = ncread(filename,'stat');
 data.x_raw = ncread(filename,'x');
 data.y_raw = ncread(filename,'y');
 data.z_raw = ncread(filename,'z');

% 
% % Various conversions
% 
varid = netcdf.inqVarID(ncid,'x');

x.scale_factor = netcdf.getAtt(ncid,varid,'scale_factor');
x.add_offset = netcdf.getAtt(ncid,varid,'add_offset');
x.fill_value = netcdf.getAtt(ncid,varid,'_FillValue');

varid = netcdf.inqVarID(ncid,'y');

y.scale_factor = netcdf.getAtt(ncid,varid,'scale_factor');
y.add_offset = netcdf.getAtt(ncid,varid,'add_offset');
y.fill_value = netcdf.getAtt(ncid,varid,'_FillValue');

varid = netcdf.inqVarID(ncid,'z');

z.scale_factor = netcdf.getAtt(ncid,varid,'scale_factor');
z.add_offset = netcdf.getAtt(ncid,varid,'add_offset');
z.fill_value = netcdf.getAtt(ncid,varid,'_FillValue');

varid = netcdf.inqVarID(ncid,'Time');

t.long_name = netcdf.getAtt(ncid,varid,'long_name');

time_datum = t.long_name(end-18:end);
    %Date in matlab dates from which time is measured in seconds
start_date = datenum(time_datum,'dd/mm/yyyy HH:MM:SS');

data.Time
time_datum
data.mdate = data.Time/24 + start_date;

% % X Conversion
% data.x_raw(data.x_raw == x.fill_value) = NaN;
% %data.X = (data.x_raw .*x.scale_factor)+  x.add_offset;% 
% 
% % Y Conversion
% data.y_raw(data.y_raw == y.fill_value) = NaN;
% %data.Y = (data.y_raw .*y.scale_factor)+  y.add_offset;% 
% 
% % Z Conversion
% data.z_raw(data.z_raw == z.fill_value) = NaN;
%data.Z = (data.z_raw .*z.scale_factor)+  z.add_offset;% 