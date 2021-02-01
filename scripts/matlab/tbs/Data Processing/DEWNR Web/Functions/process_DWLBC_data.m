function process_DWLBC_data

addpath(genpath('functions'));

dirlist = dir('Data');

tic

load sdata.mat;

dwlbc = [];

for i = 3:length(dirlist)
    
    disp([num2str(round(((i-2)/(length(dirlist)-2)) * 100)),'% Complete']);
    
    temp = regexp(dirlist(i).name,'_','split');
    %temp = strsplit(dirlist(i).name,'_');
    
    
    type = regexprep(temp{2},'.csv','');
    
    if strcmpi(type,'FlowMRec') == 1
        data = importDWLBCcsv2(['Data/',dirlist(i).name]);
    else
    
        data = importDWLBCcsv(['Data/',dirlist(i).name]);
    end
    
    vars = fieldnames(data);
    
    sitename = data.(vars{1}).site;
    
    dwlbc.(sitename).(vars{1}).Date = data.(vars{1}).Date;
    dwlbc.(sitename).(vars{1}).Data = data.(vars{1}).Data;
    dwlbc.(sitename).(vars{1}).Variable_Name = data.(vars{1}).Description;
    dwlbc.(sitename).(vars{1}).Units = data.(vars{1}).Units;
end


sites = fieldnames(dwlbc);

for i = 1:length(sites)
    
    vars = fieldnames(dwlbc.(sites{i}));
    
    for j = 1:length(vars)
        
        if isfield(sdata,sites{i})
            
            dwlbc.(sites{i}).(vars{j}).X = sdata.(sites{i}).X;
            dwlbc.(sites{i}).(vars{j}).Y = sdata.(sites{i}).Y;
            dwlbc.(sites{i}).(vars{j}).Title = {sdata.(sites{i}).disc};
        else
            if isfield(dwlbc,sites{i})
                dwlbc = rmfield(dwlbc,sites{i});
                disp(['No data for site: ',sites{i}]);
            end
        end
    end
    
end

sites = fieldnames(dwlbc);

disp('Converting Conductivity to Salinity');

for i = 1:length(sites)
    if isfield(dwlbc.(sites{i}),'Conductivity')
        dwlbc.(sites{i}).SAL = dwlbc.(sites{i}).Conductivity;
        
        dwlbc.(sites{i}).SAL.Data = conductivity2salinity(dwlbc.(sites{i}).Conductivity.Data);
        
    end
    if isfield(dwlbc.(sites{i}),'Level')
        dwlbc.(sites{i}).H = dwlbc.(sites{i}).Level;
    end
    
    if isfield(dwlbc.(sites{i}),'Tide')
        dwlbc.(sites{i}).H = dwlbc.(sites{i}).Tide;
    end
    
    if isfield(dwlbc.(sites{i}),'Flow_ML')
        dwlbc.(sites{i}).Flow_m3 = dwlbc.(sites{i}).Flow_ML;
        dwlbc.(sites{i}).Flow_m3.Data = dwlbc.(sites{i}).Flow_ML.Data * 1000/86400;
        dwlbc.(sites{i}).Flow_m3.Units = 'm3/s';
        dwlbc.(sites{i}) = rmfield(dwlbc.(sites{i}),'Flow_ML');
        
    end   
    
    if isfield(dwlbc.(sites{i}),'Flow')
        dwlbc.(sites{i}).Flow = dwlbc.(sites{i}).Flow;
        dwlbc.(sites{i}).Flow.Data = dwlbc.(sites{i}).Flow.Data * 1000/86400;
        dwlbc.(sites{i}).Flow.Units = 'm3/s';
    end  

    if isfield(dwlbc.(sites{i}),'Flow_ML_Calc')
        dwlbc.(sites{i}).Flow_m3_Calc = dwlbc.(sites{i}).Flow_ML_Calc;
        dwlbc.(sites{i}).Flow_m3_Calc.Data = dwlbc.(sites{i}).Flow_ML_Calc.Data * 1000/86400;
        dwlbc.(sites{i}).Flow_m3_Calc.Units = 'm3/s';
        dwlbc.(sites{i}) = rmfield(dwlbc.(sites{i}),'Flow_ML_Calc');
    end  
    
    
    vars = fieldnames(dwlbc.(sites{i}));
    
end
for i = 1:length(sites)
    
    vars = fieldnames(dwlbc.(sites{i}));
    
    for j = 1:length(vars)
        dwlbc.(sites{i}).(vars{j}).Variable_Name = vars(j);
        dwlbc.(sites{i}).(vars{j}).Depth(1:length(dwlbc.(sites{i}).(vars{j}).Data),1) = 0;
    end
end




save dwlbc.mat dwlbc -mat -v7.3
%save ../../Matlab/Inflows/Matfiles/DWLBC.mat dwlbc -mat -v7.3
disp('******************************************************************');
toc
disp('******************************************************************');

end
function data = importDWLBCcsv(filename)
% A simple function to import in the Data.RiverMurray (DWLBC) spreadsheets.
% The original import function used xlsread which is too slow.
% Written by Brendan Busch

%filename = 'E:\Studysites\RiverMurray\CEWH_2014\Data\DWLBC\brendan-busch/A4260902_Data_Water_Temperature.csv';

warning('off');  % Odd warning on date conversion
disp('****************************************************************');
% Get header information (Site and variable name);
tic;

disp(filename)

fid= fopen(filename,'rt');

header1 = fgetl(fid);

temp = regexp(header1,',','split');
%temp = strsplit(header1,',');

sitename = regexprep(temp{2},'"','');

header2 = fgetl(fid);

%temp = strsplit(header2,',');
temp = regexp(header2,',','split');

var = regexprep(temp{2},'"','');



% Convert Variable name

switch var
    case 'Water Temp. (Deg.C)'
        varname = 'TEMP';
        disp('Importing Tempertaure');
        Description = 'Temperature';
        Units = 'C';
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        
    case 'EC corrected (uS/cm)'
        varname = 'Conductivity';
        disp('Importing Conductivity');
        
        Description = 'EC corrected';
        Units = 'uS/cm';
        
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
    case 'Lake Level (m)'
        varname = 'Level';
        disp('Importing Level');
        
        Description = 'Height';
        Units = 'mAHD';
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        
   case 'Discharge (ML)'
        varname = 'Flow_ML';
        disp('Importing Level');
        
        Description = 'Flow';
        Units = 'ML';
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
    case 'Discharge (Ml/day)'
        varname = 'Flow_ML_Calc';
        disp('Importing Level');
        
        Description = 'Flow';
        Units = 'ML';
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';       
    case 'Level (m)'
        varname = 'Level';
        disp('Importing Level');
        
        Description = 'Height';
        Units = 'mAHD';    
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        
    case 'Tide/Estuary Lev (m)'
        varname = 'Tide';
        disp('Importing Tide');
        dateformat = 32;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Height';
        Units = 'mAHD';
        
    case 'Wind Vel. (km/hr)'
        varname = 'Wind';
        disp('Importing Tide');
        dateformat = 32;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Wind Speed';
        Units = 'km/h';
        
     case 'Wind Direc (Deg)'
        varname = 'Wind_Dir';
        disp('Importing Tide');
        dateformat = 32;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Wind Direction';
        Units = 'Deg';
        
           
    otherwise
        varname = 'Unknown';
        disp('Variable Unknown');
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Unknown';
        Units = '-';
end

data.(varname).site = sitename;
data.(varname).Description = Description;
data.(varname).Units = Units;

% The actual data import.__________________________________________________
frewind(fid)
x  = 3;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',3,'Delimiter',',');
fclose(fid);

% Data Processing__________________________________________________________

data.(varname).Data(:,1) = str2doubleq(datacell{2});


data.(varname).Date(:,1) = datenum(datacell{1},dateformatlong);


% Simple screen outputs____________________________________________________
totaltime = toc;

disp([num2str(length(datacell{1})),' Total Records Imported']);
disp(['Total Time: ',num2str(totaltime),' seconds']);
disp('****************************************************************');

end

function data = importDWLBCcsv2(filename)
% A simple function to import in the Data.RiverMurray (DWLBC) spreadsheets.
% The original import function used xlsread which is too slow.
% Written by Brendan Busch

%filename = 'E:\Studysites\RiverMurray\CEWH_2014\Data\DWLBC\brendan-busch/A4260902_Data_Water_Temperature.csv';

warning('off');  % Odd warning on date conversion
disp('****************************************************************');
% Get header information (Site and variable name);
tic;

disp(filename)

fid= fopen(filename,'rt');

header1 = fgetl(fid);

temp = regexp(header1,',','split');
%temp = strsplit(header1,',');

sitename = regexprep(temp{2},'"','');

header2 = fgetl(fid);

%temp = strsplit(header2,',');
temp = regexp(header2,',','split');

var = regexprep(temp{2},'"','');

var = 'Flow';

% Convert Variable name

switch var
    case 'Water Temp. (Deg.C)'
        varname = 'TEMP';
        disp('Importing Tempertaure');
        Description = 'Temperature';
        Units = 'C';
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        
    case 'EC corrected (uS/cm)'
        varname = 'Conductivity';
        disp('Importing Conductivity');
        
        Description = 'EC corrected';
        Units = 'uS/cm';
        
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
    case 'Lake Level (m)'
        varname = 'Level';
        disp('Importing Level');
        
        Description = 'Height';
        Units = 'mAHD';
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        
   case 'Discharge (ML)'
        varname = 'Flow_ML';
        disp('Importing Level');
        
        Description = 'Flow';
        Units = 'ML';
                dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        
    case 'Level (m)'
        varname = 'Level';
        disp('Importing Level');
        
        Description = 'Height';
        Units = 'mAHD';    
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        
    case 'Tide/Estuary Lev (m)'
        varname = 'Tide';
        disp('Importing Tide');
        dateformat = 32;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Height';
        Units = 'mAHD';
        
    case 'Wind Vel. (km/hr)'
        varname = 'Wind';
        disp('Importing Tide');
        dateformat = 32;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Wind Speed';
        Units = 'km/h';
        
     case 'Wind Direc (Deg)'
        varname = 'Wind_Dir';
        disp('Importing Tide');
        dateformat = 32;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Wind Direction';
        Units = 'Deg';

        
    case 'Flow'
        varname = 'Flow_ML';
        disp('Importing Flow');
        dateformat = 32;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Flow';
        Units = 'm3/s';
        
        
           
    otherwise
        varname = 'Unknown';
        disp('Variable Unknown');
        dateformat = 31;
        dateformatlong = 'dd/mm/yyyy HH:MM';
        Description = 'Unknown';
        Units = '-';
end

data.(varname).site = sitename;
data.(varname).Description = Description;
data.(varname).Units = Units;

% The actual data import.__________________________________________________
frewind(fid)
x  = 4;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',3,'Delimiter',',');
fclose(fid);

% Data Processing__________________________________________________________

data.(varname).Data(:,1) = str2doubleq(datacell{2});


data.(varname).Date(:,1) = datenum(datacell{1},dateformatlong);


% Simple screen outputs____________________________________________________
totaltime = toc;

disp([num2str(length(datacell{1})),' Total Records Imported']);
disp(['Total Time: ',num2str(totaltime),' seconds']);
disp('****************************************************************');

end

