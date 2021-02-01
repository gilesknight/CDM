clear all; close all;

addpath(genpath('Functions'));

load Locations\sites.mat;

for i = 1:length(sites)
    sitenames{i} = sites(i).name;
end

dirlist = dir('Raw/');


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


for i = 3:length(dirlist)
    
    
    siteN = dirlist(i).name;
    
    tt = find(strcmpi(sitenames,siteN) == 1);
    
    siteID = sites(tt).id;
    
    disp(siteID)
    
    filelist = dir(['Raw_backup/',dirlist(i).name,'/','*.csv']);
    
    metdata = [];
    
    for j = 1:length(filelist)
        disp(filelist(j).name)
        
        fid = fopen(['Raw_backup/',dirlist(i).name,'/',filelist(j).name],'rt');
        x  = length(cHeader);
        textformat = [repmat('%s ',1,x)];
        datacell = textscan(fid,textformat,...
            'Headerlines',2,...
            'Delimiter',',');
        fclose(fid);
        
        for iHeader = 1:length(cHeader)
           % disp(cHeader{iHeader});
            
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
                    met.(cHeader{iHeader}) = str2doubleq(datacell{iHeader});
            end
        end
        
        
        if j == 1
            metdata.(siteID) = met;
        else
            for iHeader = 1:length(cHeader)
                
                metdata.(siteID).(cHeader{iHeader}) = [metdata.(siteID).(cHeader{iHeader});met.(cHeader{iHeader})];
            end
        end
    end
    
    
    metdata.(siteID) = remove_duplicates(metdata.(siteID));
    
    
    
    metdata.(siteID).Lat = sites(tt).lat;
    metdata.(siteID).Lon = sites(tt).lon;
    
    disp('PRocessing Secondary Variables');
    try
        metdata.(siteID).Processed = create_secondary_variables(metdata.(siteID),9.5);
    catch
        
    end
    
    save(['Raw_backup/',dirlist(i).name,'/metdata.mat'],'metdata','-mat','-v7.3');

    
end

