
getLLmetdata;

load llmetdata.mat;

sites = fieldnames(llmetdata);

%  sites = {...
%      'caurnamont',...
%     'currency_crk',...
%     'Langhorne_Crk_Central',...
%     'Langhorne_Crk',...
%     'mypolonga',...
%     'narrung',...
%     'swan_reach',...
%     };

startdate = datenum(2015,01,01);
enddate = datenum(2016,08,01);
TZ = 9.5;

for i = 1:length(sites)

    site = sites{i};
    
    disp(['Writing file: ',site]);
    writeTFVMetcsvLL(startdate,enddate,TZ,site)
    close all;
    
end