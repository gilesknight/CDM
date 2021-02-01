%function getLLmetdata(sMetDir)
% Function to import the swan met data and save to a structured type
% swanmet.mat
% sMetDir is the file path in which the BoM data files are stored. Remember
% to add "\" at the end of the path!!!
% Add or remove headers under cHeader based on your data. Import of Date in
% the right format should be checked!
clear all; close all;
addpath(genpath('Functions'));

sMetDir = 'Raw/';

dirlist = dir([sMetDir,'*.csv']);

if ~exist('llmetdata.mat','file')
    llmetdata = [];
else
    load llmetdata.mat;
end

for iMet = 1:length(dirlist)
    
    met = [];
    met1 = [];
    
    disp(['Processing File ',num2str(iMet)]);
    
     t_name = strsplit(dirlist(iMet).name,'_');
    
    Station = t_name{4};
    

    
    nSiteID = Station;
    

    filename = [sMetDir,dirlist(iMet).name];
    fid = fopen(filename,'rt');
    
if strcmpi(nSiteID,'Langhorne Crk') == 0 & strcmpi(nSiteID,'Narrung Langhorne Merge') == 0
    cHeader = { ...
        'Date';...
        'AirTemperature';...
        'AppTemperature';...
        'DewPoint';...
        'RelativeHumidity';...
        'DeltaT';...
        'SoilTemperature';...
        'Solar_Rad';...
        'WindSpeed';...
        'WindSpeed_Max';...
        'WindDir';...
        'AirPressure';...
        'Rain';...
        'LeafWet';...
        };
    
else   
    cHeader = { ...
        'Station';...
        'Date';...
        'AirTemperature';...
        'AppTemperature';...
        'DewPoint';...
        'RelativeHumidity';...
        'DeltaT';...
        'SoilTemperature';...
        'Solar_Rad';...
        'WindSpeed';...
        'WindSpeed_Max';...
        'WindDir';...
        'AirPressure';...
        'Rain';...
        'LeafWet';...
        };
    
end
    x  = length(cHeader);
    textformat = [repmat('%s ',1,x)];
    datacell = textscan(fid,textformat,...
        'Headerlines',2,...
        'Delimiter',',');
    fclose(fid);
    
    for iHeader = 1:length(cHeader)
        disp(cHeader{iHeader});
        
        switch cHeader{iHeader}
            case 'Date'
%                if strcmpi(nSiteID,'Narrung Langhorne Merge') == 0

                met.(cHeader{iHeader}) = datenum(datacell{iHeader},'yyyy-mm-dd HH:MM:SS');
%                else
%                   met.(cHeader{iHeader}) = datenum(datacell{iHeader},'dd/mm/yyyy HH:MM'); 
%                end
            case 'Station'
                met.(cHeader{iHeader}) = datacell{iHeader};
            otherwise
                met.(cHeader{iHeader}) = str2double(datacell{iHeader});
        end
    end
    
    
    [Date_uni,ia] = unique(met.Date,'sorted');
    nHeader = fieldnames(met);
    for ii = 2:length(nHeader)
        disp(nHeader{ii});
        met1.(nHeader{ii}) = met.(nHeader{ii})(ia);
    end
    
    met1.Date = Date_uni;
    
   switch nSiteID
        case 'Narrung'
            llmetdata.narrung = met1;
            llmetdata.narrung.lat = -35.571240;
            llmetdata.narrung.lon = 139.173606;
            llmetdata.narrung.Station = 'Narrung';
            
        case 'Narrung Langhorne Merge'
            llmetdata.Narrung_Langhorne_Merge = met1;
            llmetdata.Narrung_Langhorne_Merge.lat = -35.571240;
            llmetdata.Narrung_Langhorne_Merge.lon = 139.173606;
            llmetdata.Narrung_Langhorne_Merge.Station = 'Narrung_Langhorne_Merge';
        case 'Cadell'
            llmetdata.cadell = met1;
            llmetdata.cadell.lat = -34.044935;
            llmetdata.cadell.lon = 139.729249;
            llmetdata.cadell.Station = 'Cadell';
        case 'Swan Reach'
            llmetdata.swan_reach = met1;
            llmetdata.swan_reach.lat = -34.571838;
            llmetdata.swan_reach.lon = 139.615968;
            llmetdata.swan_reach.Station = 'SwanReach';
        case 'Caurnamont'
            llmetdata.caurnamont = met1;
            llmetdata.caurnamont.lat = -34.831678;
            llmetdata.caurnamont.lon = 139.534169;
            llmetdata.caurnamont.Station = 'Caurnamont';
        case 'Mypolonga'
            llmetdata.mypolonga = met1;
            llmetdata.mypolonga.lat = -34.948828;
            llmetdata.mypolonga.lon = 139.339162;
            llmetdata.mypolonga.Station = 'Mypolonga';
        case 'Langhorne Creek Central'
            llmetdata.Langhorne_Crk_Central = met1;
            llmetdata.Langhorne_Crk_Central.lat = -35.282459;
            llmetdata.Langhorne_Crk_Central.lon = 139.037038;
            llmetdata.Langhorne_Crk_Central.Station = 'Langhorne_Crk_Central';
            
       case 'Langhorne Creek North'
            llmetdata.Langhorne_Crk_N = met1;
            llmetdata.Langhorne_Crk_N.lat = -35.282459;
            llmetdata.Langhorne_Crk_N.lon = 139.037038;
            llmetdata.Langhorne_Crk_N.Station = 'Langhorne_Crk_N';
 
        case 'Langhorne Creek South East'
            llmetdata.Langhorne_Crk_SE = met1;
            llmetdata.Langhorne_Crk_SE.lat = -35.282459;
            llmetdata.Langhorne_Crk_SE.lon = 139.037038;
            llmetdata.Langhorne_Crk_SE.Station = 'Langhorne_Crk_SE';

       case 'Langhorne Crk'
            llmetdata.Langhorne_Crk = met1;
            llmetdata.Langhorne_Crk.lat = -35.282459;
            llmetdata.Langhorne_Crk.lon = 139.037038;
            llmetdata.Langhorne_Crk.Station = 'Langhorne_Crk';
            
            
       case 'Langhorne Creek West'
            llmetdata.Langhorne_Crk_W = met1;
            llmetdata.Langhorne_Crk_W.lat = -35.282459;
            llmetdata.Langhorne_Crk_W.lon = 139.037038;
            llmetdata.Langhorne_Crk_W.Station = 'Langhorne_Crk_W';
            
        case 'Currency Crk'
            llmetdata.currency_crk = met1;
            llmetdata.currency_crk.lat = -35.424706;
            llmetdata.currency_crk.lon = 138.758260;
            llmetdata.currency_crk.Station = 'Currency_Crk';
        case 'Wellington East'
            llmetdata.wellington = met1;
            llmetdata.wellington.lat = -35.293265;
            llmetdata.wellington.lon = 139.408821;
            llmetdata.wellington.Station = 'Wellington';
            
        otherwise
            disp('StationID not found');
            stop
    end
    
end

% Sort the data

sites = fieldnames(llmetdata);

for i = 1:length(sites)
    
    vars = fieldnames(llmetdata.(sites{i}));
    
    [llmetdata.(sites{i}).Date,ind] = sort(llmetdata.(sites{i}).Date);
    
    for j = 1:length(vars)
        
        switch vars{j}
            case 'Date'
            case 'lat'
            case 'lon'
            case 'Station'
            otherwise
                llmetdata.(sites{i}).(vars{j}) = llmetdata.(sites{i}).(vars{j})(ind);
        end
    end
end



save llmetdata.mat llmetdata -mat -v7