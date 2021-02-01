function create_AWS_variable_netcdf(varname,ncname,mtime,longname,shortname,units,grid)

addpath(genpath('Functions'));

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


%________________________________

% varname = 'Rad_Model';
% 
% ncname = 'AWS_SW_2015_2017.nc';
% 
% mtime = [datenum(2015,01,01):15/(60*24):datenum(2017,07,01)];
% 
% longname = 'downward shortwave radiation';
% shortname = 'dswr';
% units = 'W m^-2';

if strcmpi(varname,'Rain_interp') == 1
    checkval = 2; % 2 days
else
    checkval = 20/(60*24); % 20 minutes;
end


% Below should be automated....

data = join_sites_by_variable(varname);

% grid = 'Grids/LL_Full_Domain.2dm';

[XX,YY,nodeID,faces,X,Y,ID] = tfv_get_node_from_2dm(grid);


% Create the mesh grid that completely covers the 2dm zone
xarray = [(min(XX)-1000):2000:max(XX)+1000];
yarray = [(min(YY)-1000):2000:max(YY)+1000];
[xx,yy] = meshgrid(xarray',yarray');

% Netcdf variable data
nT = zeros(size(xx,1),size(xx,2),length(mtime));

sites = fieldnames(data);

for i = 1:length(sites)
    [sX(i,1),sY(i,1)] = ll2utm(data.(sites{i}).Lat,data.(sites{i}).Lon);
end

for i = 1:length(mtime)
    
    mT = []; % The variable to scatter
    X = [];
    Y = [];
    
    inc = 1;
    
    for j = 1:length(sites)    
        [val,ind] = min(abs(data.(sites{j}).Date - mtime(i)));
        if val < checkval
            mT(inc) = data.(sites{j}).(varname)(ind);
            X(inc) = sX(j,1);
            Y(inc) = sY(j,1);
            inc = inc + 1;
        end
    end
    
    disp([num2str((i/length(mtime))*100),'%',' with ',num2str(length(mT))]);

    if ~isempty(mT)   
        if length(mT) > 5
            Fx = scatteredInterpolant(X',Y',mT','linear','nearest'); 
            nT(:,:,i) = Fx(xx,yy);
        else
            nT(:,:,i) = mean(mT(~isnan(mT)));
        end
    else
        stop;
    end
end


% Netcdf writing portion...

ncid = netcdf.create(ncname, 'NC_CLOBBER');



% Need to change from [row,col,time] to [x,y,time];
nT_netcdf = permute(nT,[2,1,3]);




[sx,sy,sz] = size(nT_netcdf);

% I think time is hours since 01/01/1990 00:00:00
mhours = (mtime - datenum(1990,01,01,00,00,00)) * 24;

% Create a test file...


time_dimID = netcdf.defDim(ncid,'time',netcdf.getConstant('NC_UNLIMITED')); %time
y_dimID = netcdf.defDim(ncid,'lat',sy);%latitude
x_dimID = netcdf.defDim(ncid,'lon',sx);%longitude

% Define variables

time_varid = netcdf.defVar(ncid,'time','double',time_dimID);
x_varid = netcdf.defVar(ncid,'lon','double',x_dimID);
y_varid = netcdf.defVar(ncid,'lat','double',y_dimID);
u_varid = netcdf.defVar(ncid,shortname,'double',[x_dimID,y_dimID,time_dimID]);

% Time
netcdf.putAtt(ncid,time_varid,'long_name','time in decimal hours since 01/01/1990 00:00');
netcdf.putAtt(ncid,time_varid,'units','hours');
% Lat
netcdf.putAtt(ncid,y_varid,'units','m');
netcdf.putAtt(ncid,y_varid,'long_name','latitude');
netcdf.putAtt(ncid,y_varid,'projection','UTM');
% Long
netcdf.putAtt(ncid,x_varid,'units','m');
netcdf.putAtt(ncid,x_varid,'long_name','longitude');
netcdf.putAtt(ncid,x_varid,'projection','UTM');
% Our write variable
netcdf.putAtt(ncid,u_varid,'units',units);
netcdf.putAtt(ncid,u_varid,'long_name',longname);

netcdf.endDef(ncid);

% Add the data
disp('Writing Time');
netcdf.putVar(ncid,time_varid,0,length(mhours),mhours);
netcdf.putVar(ncid,y_varid,0,sy,yarray);
netcdf.putVar(ncid,x_varid,0,sx,xarray);

% U Data
disp('Writing Variable');
netcdf.putVar(ncid,u_varid,[0,0,0],[sx,sy,sz],nT_netcdf);


netcdf.close(ncid)% Close the file.
    