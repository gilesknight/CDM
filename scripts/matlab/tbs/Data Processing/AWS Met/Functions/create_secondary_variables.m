function met = create_secondary_variables(met,TZ)

addpath(genpath('Functions'));

startdate = min(met.Date);
enddate = max(met.Date);

tt = find(met.Date >= startdate & met.Date <= enddate);

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

lat = met.Lat;
lon = met.Lon;
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