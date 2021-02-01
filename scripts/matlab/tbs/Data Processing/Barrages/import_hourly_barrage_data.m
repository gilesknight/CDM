clear all; close all;

filename = 'ACTUAL Hourly_barrage releases_01072013_17032017.xlsx';
sheetname = 'HourlyData';

[snum,sstr] = xlsread(filename,sheetname,'A2:F30000');


conv = 1000 / (60*60);

% Dates.....

for i = 1:length(sstr)
    temp = strsplit(sstr{i},' ');
    
    if length(temp) == 3

        if strcmpi(temp{3},'AM');
             mdate(i) = datenum(sstr{i},'dd/mm/yyyy HH:MM:SS AM');
            
        end
        if strcmpi(temp{3},'PM');
            
            mdate(i) = datenum(sstr{i},'dd/mm/yyyy HH:MM:SS PM');
        end
        
    else
        mdate(i) = datenum([temp{1}],'dd/mm/yyyy');
    end
end


barrages.Goolwa.Flow = snum(:,1) * conv;
barrages.Goolwa.Date = mdate;
barrages.Goolwa.Raw = snum(:,1);

barrages.Mundoo.Flow = snum(:,2) * conv;
barrages.Mundoo.Date = mdate;
barrages.Mundoo.Raw = snum(:,2);


barrages.Boundary.Flow = snum(:,3) * conv;
barrages.Boundary.Date = mdate;
barrages.Boundary.Raw = snum(:,3);


barrages.Ewe.Flow = snum(:,4) * conv;
barrages.Ewe.Date = mdate;
barrages.Ewe.Raw = snum(:,4);


barrages.Tauwitchere.Flow = snum(:,5) * conv;
barrages.Tauwitchere.Date = mdate;
barrages.Tauwitchere.Raw = snum(:,5);


save barrages.mat barrages -mat;
