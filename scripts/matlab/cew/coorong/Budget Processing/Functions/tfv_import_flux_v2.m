function data = tfv_import_flux_v2(fluxfile,columnfile);
% A simple function to import in the flux data and export to a structured
% type, renaming the columns based on the Flux File xlsx spreadsheet.

d = dir(fluxfile);

MB = d.bytes * 1.0e-6;

disp(['File Size: ',num2str(MB),' Megabytes']);
disp('*******************************************************************');

[~,col_headers] = xlsread(columnfile,'A2:A1000');


if MB < 2000
    
    data = quick_import(fluxfile,col_headers);
    
else
    
    data = slow_import(fluxfile,col_headers);
    
end

end

function data = quick_import(fluxfile,col_headers)

disp(' Using the quicker import routine as the flux file is smaller than 2 gigs');

fid = fopen(fluxfile,'rt');

headers = strsplit(fgetl(fid),',');

num_cols = length(headers);

frewind(fid)
x  = num_cols;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',1,'Delimiter',',');
fclose(fid);

% Dates are the first column.
disp('************** Processing Dates... *********************************');
mDates = datenum(datacell{:,1},'dd/mm/yyyy HH:MM:SS');
disp('************** Finished Dates...   *********************************');


nodestrings = {};
for i = 1:length(headers)
    tt = strsplit(headers{i},'_');
    nodestrings(i) = tt(1);
end

uni_NS = unique(nodestrings,'stable');

data = [];

inc = 2;

for i = 2:length(uni_NS)
    for j = 1:length(col_headers)
        data.(uni_NS{i}).(col_headers{j}) = str2double(datacell{inc});
        inc = inc + 1;
        data.(uni_NS{i}).mDate = mDates;
    end
end

end

function data = slow_import(fluxfile,col_headers)

disp(' Using the slower import routine as the flux file is larger than 2 gigs');


data = [];


fid = fopen(fluxfile,'rt');

headers = strsplit(fgetl(fid),',');

num_cols = length(headers);

nodestrings = {};
for i = 1:length(headers)
    tt = strsplit(headers{i},'_');
    nodestrings(i) = tt(1);
end

uni_NS = unique(nodestrings,'stable');

inc = 1;

while ~feof(fid)
    
    newline = strsplit(fgetl(fid),',');
    
    if length(newline) > 10
        mDates(inc,1) = datenum(newline{1},'dd/mm/yyyy HH:MM:SS');
        
        inc_1 = 2;
        
        for i = 2:length(uni_NS)
            for j = 1:length(col_headers)
                
                output = str2double(newline{inc_1});
                
                data.(uni_NS{i}).(col_headers{j})(inc) = output;
                inc_1 = inc_1 + 1;
                
                clear output
            end
        end
        
        disp(num2str(inc));
        
        
        inc = inc + 1;
        
    end
end
for i = 2:length(uni_NS)
    data.(uni_NS{i}).mDate = mDates;
end

end

