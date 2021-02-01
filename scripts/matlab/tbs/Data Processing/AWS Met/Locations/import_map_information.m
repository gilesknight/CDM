clear all; close all;

sites = [];
inc = 1;
line_id = 1;
fid = fopen('gm.txt','rt');
line = fgetl(fid);

while ~feof(fid)
    disp(num2str(line_id))
    if length(line) > 15
        
        if strcmpi(line(1:13),'varaws_marker') == 1
            ss = strsplit(line,'=');
            tt = ss{1};
            sites(inc).id = regexprep(tt,'varaws_marker','');
            
            
            disp(sites(inc).id);
            
            line = fgetl(fid);
            
            tt = regexprep(line,'position:newgoogle.maps.LatLng','');
            tt = regexprep(tt,'(','');
            tt = regexprep(tt,')','');
            ww = strsplit(tt,',');
            
            sites(inc).lat = str2num(ww{1});
            sites(inc).lon = str2num(ww{2});
            line = fgetl(fid);
            line = fgetl(fid);
            tt = regexprep(line,'title:"','');
            sites(inc).name = regexprep(tt,'",','');
            inc = inc + 1;
            
        else
            line = fgetl(fid);
        end
    else
        line = fgetl(fid);
    end
    line_id = line_id + 1;
end

fclose(fid);

fid = fopen('AWS Sites.csv','wt');

fprintf(fid,'ID,Name,Lat,Lon\n');

for i = 1:length(sites)
    fprintf(fid,'%s,%s,%4.4f,%4.4f\n',sites(i).id,sites(i).name,sites(i).lat,sites(i).lon);
end
fclose(fid);

save sites.mat sites -mat;