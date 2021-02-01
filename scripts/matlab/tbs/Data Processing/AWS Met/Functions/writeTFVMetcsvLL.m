%function writeTFVMetcsvLL(startdate,enddate,TZ,site,varargin)
function writeTFVMetcsvLL(startdate,enddate,TZ,site,varargin)
% Creates TFVMetcsv files for a pair of BoM sites
% Ensure that the data extraction scripts have been used and the .mat files
% exist in the relevant path folder. All calculations are hourly.
% "remove_nans" is used to remove any nans in the data. Typical input -
% startdate = datenum(2001,01,01,09,00,00);
% enddate = datenum(2002,01,01,09,00,00);
% site = 'airport';
% TZ = 7.5;
% IMPORTANT - Comment out the file writing part to just generate the plots.

removeNaNs = 0;

if length(varargin) == 0
    disp('Using data from one site');
end

if length(varargin) == 1
    disp('To add data from another site you need to include the site name, and the variables');
end

if length(varargin) == 2
    disp(['Replacing data from ',site,' with ',varargin{1}]);
    
    
    load llmetdata.mat;
    % %
    met = llmetdata.(site);
    
    
    tt = find(met.Date >= startdate & met.Date <= enddate);
    
    newmet = llmetdata.(varargin{1});
    
    newdate = newmet.Date;
    
    switch varargin{2}
        case 'Clouds'
            met.CloudAmount_First = [];
            met.CloudAmount_First = interp1(newdate,newmet.CloudAmount_First,met.Date,'linear','extrap');
            met.CloudAmount_Second = [];
            met.CloudAmount_Second = interp1(newdate,newmet.CloudAmount_Second,met.Date,'linear','extrap');
            met.CloudAmount_Third = [];
            met.CloudAmount_Third = interp1(newdate,newmet.CloudAmount_Third,met.Date,'linear','extrap');
        case 'Temperature'
            met.AirTemperature = [];
            met.AirTemperature = interp1(newdate,newmet.AirTemperature,met.Date,'linear','extrap');
        case 'WindSpeed'
            met.WindSpeed = [];
            met.WindSpeed = interp1(newdate,newmet.WindSpeed,met.Date,'linear','extrap');
            %
            
        case 'WindDir'
            met.WindDir = [];
            met.WindDir = interp1(newdate,newmet.WindDir,met.Date,'linear','extrap');
            
            disp('Hi')
            
        case 'RH'
            met.RelativeHumidity = [];
            met.RelativeHumidity = interp1(newdate,newmet.RelativeHumidity,met.Date,'linear','extrap');
        otherwise
            disp('Variable unknown');
    end
else
    
    load llmetdata.mat;
    % %
    met = llmetdata.(site);
    
    tt = find(met.Date >= startdate & met.Date <= enddate);
    
end



% Calculating Wind





% Relative Humidity

% if removeNaNs == 1
%
%     met.RH = remove_nans(met.RelativeHumidity(tt),1);
%     met.Temp = remove_nans(met.AirTemperature(tt),1);
%
%     met.WIND = remove_nans(met.WindSpeed(tt),1);
%     met.DIRN = remove_nans(met.WindDir(tt),1);
%
% else
%
met.RH = met.RelativeHumidity(tt);
met.Temp = met.AirTemperature(tt);
met.WIND = met.WindSpeed(tt);
met.DIRN = met.WindDir(tt);
met.DIRN;
%
% end

met.Ws_conv =  met.WIND * (1000/(60*60));
met.Wd_conv =  met.DIRN;

met.Wx = (round(-1.0.*(met.WIND).*sin((pi/180).*met.DIRN)*1000000)/1000000)/3.6;
met.Wy = (round(-1.0.*(met.WIND).*cos((pi/180).*met.DIRN)*1000000)/1000000)/3.6;
% Get Bird Model Data

lat = met.lat;
lon = met.lon;
[GHI ZenithAngle NewDate] = genBirdSolarData(lat,lon,startdate,enddate,TZ);
met.GHI = GHI;

% Dates

met.Date_1 = met.Date(tt);
met.NewDate = NewDate;
met.Day = floor(met.NewDate);
met.Day_unique = unique(met.Day);

% Rain

met.Rain1 = met.Rain(tt) ./ 1000;

for i = 1:length(met.Day_unique)
    zz = find(floor(met.Date_1) == met.Day_unique(i));
    met.Rainfall(i) = sum(met.Rain1(zz));
end

met.Date_daily = [startdate:1:enddate];

met.Rain_interp = interp1(met.Day_unique,met.Rainfall,met.Date_daily);
nn = find (isnan(met.Rain_interp));
met.Rain_interp(nn) = 0;

% Calculate the cloud cover
met.Rad_Model = interp1(met.Date_1,met.Solar_Rad(tt),met.NewDate);

for i = 1:length(met.Rad_Model)
    if met.Rad_Model(i) < 10
        Cloud_Frac(i) = 0;
    else
        Cloud_Frac(i) = met.Rad_Model(i)/met.GHI(i);
    end
end

mm = find(Cloud_Frac > 0.93);
Cloud_Frac(mm) = 0.93;

mm = find(Cloud_Frac < 0.15);
Cloud_Frac(mm) = 0.15;

for i = 1:length(Cloud_Frac)
    
    a = 0.66182;
    b = -1.5236;
    c(i) = 0.98475 - Cloud_Frac(i);
    
    d(i) = sqrt(power(b,2) - 4*a*c(i));
    met.TC_interp(i) = ( -b - d(i) ) / (2*a);
    
end


% Interpolating to get data in same dimensions

met.Wx_interp = interp1(met.Date_1,met.Wx,met.NewDate);
met.Wy_interp = interp1(met.Date_1,met.Wy,met.NewDate);
met.RH_interp = interp1(met.Date_1,met.RH,met.NewDate);
met.Temp_interp = interp1(met.Date_1,met.Temp,met.NewDate);
met.W_Speed_interp = interp1(met.Date_1,met.Ws_conv,met.NewDate);
met.W_Dir_interp = interp1(met.Date_1,met.Wd_conv,met.NewDate);

for i = 1:length(met.Rain_interp)
    
    if met.Rain_interp(i) < 0
        met.Rain_interp(i) = 0;
    end
end




% Create Directory
dirname = ['Output/',site,' met output/'];

if ~exist(dirname,'dir')
    mkdir(dirname);
end


% % Make the file
%
formatout = 'dd/mm/yyyy HH:MM:SS';
Iso_Time = datestr(met.NewDate,formatout);

filename = [dirname,strcat('tfv_ll_met_', site, '.csv')];

fid = fopen(filename,'wt');
fprintf(fid,'ISOTime,Wx,Wy,Atemp,Rel_Hum,Sol_Rad,Clouds,W_Speed,W_Dir \n');

for ii = 1:length(GHI)
    fprintf(fid,'%s,%f,%f,%f,%f,%f,%f,%f,%f \n',...
        datestr(met.NewDate(ii),formatout),...
        met.Wx_interp(ii),...
        met.Wy_interp(ii),...
        met.Temp_interp(ii),...
        met.RH_interp(ii),...
        met.Rad_Model(ii),...
        met.TC_interp(ii),...
        met.W_Speed_interp(ii),...
        met.W_Dir_interp(ii));
end
fclose(fid);


metout.NewDate = met.NewDate;
metout.Wx_interp = met.Wx_interp;
metout.Wy_interp = met.Wy_interp;
metout.Temp_interp = met.Temp_interp;
metout.RH_interp = met.RH_interp;
metout.Rad_Model = met.Rad_Model;
metout.TC_interp = met.TC_interp;
metout.W_Speed_interp = met.W_Speed_interp;
metout.W_Dir_interp = met.W_Dir_interp;




matname = regexprep(filename,'.csv','.mat');


filename = [dirname,strcat('tfv_ll_rain_', site, '.csv')];

fid = fopen(filename,'wt');
fprintf(fid,'ISOTime,Precip \n');

for ii = 1:length(met.Rain_interp)
    fprintf(fid,'%s,%f \n',...
        datestr(met.Date_daily(ii),formatout),...
        met.Rain_interp(ii));
end
fclose(fid);

metout.RainDate = met.Date_daily;
metout.Rain = met.Rain_interp;

save(matname,'metout','-mat');


% Create the summary plots

startyear = datevec(startdate);
endyear = datevec(enddate);

YEARS = endyear(1,1) - startyear(1,1);

for i = 0:YEARS-1
    firstdate = datenum(startyear(1,1)+i,startyear(1,2),startyear(1,3),startyear(1,4),startyear(1,5),startyear(1,6));
    lastdate = datenum(startyear(1,1)+i+1,startyear(1,2),startyear(1,3),startyear(1,4),startyear(1,5),startyear(1,6));
    cc = find(met.Date_daily >= firstdate & met.Date_daily <= lastdate);
    met.Date_daily_vec = datevec(met.Date_daily(cc));
    Unique_month = unique(met.Date_daily_vec(1:end,2));
    for j = 1:length(Unique_month)
        dd = find(met.Date_daily_vec(1:end,2) == Unique_month(j));
        met.Rain_monthly(j) = sum(met.Rain_interp(cc(dd)));
    end
    
    axes_plot
end

end

