% lowerlakes
clear all; close all; fclose all;

rmdir('MatOutput','s');

mkdir('MatOutput');

% domain = 'Lowerlakes';
% startdate = datenum(2015,10,07);
% enddate = datenum(2015,10,22);
% cellsize = 200;
% 
% %b_facs = [1 0.1 0.4 0.8 2 5];
% b_facs = [3];
% 
% 
% for i = 1:length(b_facs)
% 
%     create_random_fish_v4_material_zones_gridded(domain,startdate,enddate,cellsize,b_facs(i),50,50);
% 
% end
% 
% domain = 'Murray';
% startdate = datenum(2015,10,07);
% enddate = datenum(2015,10,22);
% cellsize = 100;
% 
% b_facs = [3];
% 
% 
% for i = 1:length(b_facs)
% 
%     create_random_fish_v4_material_zones_gridded(domain,startdate,enddate,cellsize,b_facs(i),50,50);
% 
% end

domain = 'Chowilla';
startdate = datenum(2016,04,07);
enddate = datenum(2016,04,22);
cellsize = 100;

b_facs = [1 0.1 0.4 0.8 2 5];


for i = 1:length(b_facs)

    create_random_fish_v4_material_zones_gridded(domain,startdate,enddate,cellsize,b_facs(i),50,50);

end

% domain = 'Moonie';
% startdate = datenum(2016,04,07);
% enddate = datenum(2016,04,22);
% cellsize = 50;
% 
% b_facs = [1 0.1 0.4 0.8 2 5];
% 
% 
% for i = 1:length(b_facs)
% 
%     create_random_fish_v4_material_zones_gridded(domain,startdate,enddate,cellsize,b_facs(i),50,50);
% 
% end