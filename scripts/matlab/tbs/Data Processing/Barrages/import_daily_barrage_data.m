clear all; close all;

filename = 'ACTUAL Hourly_barrage releases_01072013_17032017.xlsx';
sheetname = 'DailyData_01072013-31122014';

[snum,sstr] = xlsread(filename,sheetname,'A2:F30000');


conv = 1000 / 86400;

% Dates.....

for i = 1:length(sstr)
    temp = strsplit(sstr{i},' ');
    
    if length(temp) == 3
        
        mdate(i) = datenum([temp{1},' ',temp{2}],'dd/mm/yyyy HH:MM:SS');
        
        if strcmpi(temp{3},'AM');
            rem = mdate(i) - floor(mdate(i));
            
            if rem == 0.5
                mdate(i) = floor(mdate(i));
            end
            
        end
        if strcmpi(temp{3},'PM');
            rem = mdate(i) - floor(mdate(i));
           if rem < 0.5 
            
                mdate(i) = mdate(i) + 0.5;
           end
               
        end
        
    else
        mdate(i) = datenum([temp{1}],'dd/mm/yyyy');
    end
end


barrages_daily.Goolwa.Flow = snum(:,1) * conv;
barrages_daily.Goolwa.Date = mdate;
barrages_daily.Goolwa.Raw = snum(:,1);

barrages_daily.Mundoo.Flow = snum(:,2) * conv;
barrages_daily.Mundoo.Date = mdate;
barrages_daily.Mundoo.Raw = snum(:,2);


barrages_daily.Boundary.Flow = snum(:,3) * conv;
barrages_daily.Boundary.Date = mdate;
barrages_daily.Boundary.Raw = snum(:,3);


barrages_daily.Ewe.Flow = snum(:,4) * conv;
barrages_daily.Ewe.Date = mdate;
barrages_daily.Ewe.Raw = snum(:,4);


barrages_daily.Tauwitchere.Flow = snum(:,5) * conv;
barrages_daily.Tauwitchere.Date = mdate;
barrages_daily.Tauwitchere.Raw = snum(:,5);


save barrages_daily.mat barrages_daily -mat;
