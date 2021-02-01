clear all; close all;

restoredefaultpath
addpath(genpath('Functions'));

load ../DEWNR' Web'/dwlbc.mat;

lowerlakes = dwlbc;


load ../'DEWNR Offline'/BK_All.mat

lowerlakes.A4261039.H.Date = [];
lowerlakes.A4261039.H.Data = [];
lowerlakes.A4261039.H.Depth = [];

lowerlakes.A4261039.H.Date = nDate;
lowerlakes.A4261039.H.Data = Tide;
lowerlakes.A4261039.H.Depth(1,length(Tide),1) = 0;

load ../'Lock1 Flow'/well.mat;

sites = fieldnames(well);

for i = 1:length(sites);
    lowerlakes.(sites{i}) = well.(sites{i});
end


load ../SA' EPA'/Matfiles/epa_2016.mat;

sites = fieldnames(epa_2016);

for i = 1:length(sites);
    lowerlakes.(['EPA_',sites{i}]) = epa_2016.(sites{i});
end

load ../SA' Water'/saw_r.mat;

sites = fieldnames(saw);

for i = 1:length(sites);
    lowerlakes.(['SAW_',sites{i}]) = saw.(sites{i});
end

load ../SA' Water'/saw_2017.mat;

sites = fieldnames(saw_2017);

for i = 1:length(sites);
    lowerlakes.(['SAW2017_',sites{i}]) = saw_2017.(sites{i});
end

load ../SA' Water'/saw_2018.mat;

sites = fieldnames(saw_2018);

for i = 1:length(sites);
    lowerlakes.(['SAW2018_',sites{i}]) = saw_2018.(sites{i});
end


load ../MR' Offtake'/pump.mat;

sites = fieldnames(pump);

for i = 1:length(sites);
    lowerlakes.(['OFFTAKE_',sites{i}]) = pump.(sites{i});
end

load ../'SA EPA Pre 2014'/Matfiles/epa_2014.mat;

sites = fieldnames(epa_2014);

for i = 1:length(sites);
    lowerlakes.(['EPA2014_',sites{i}]) = epa_2014.(sites{i});
end

%load ../'Victor Harbor'/VH_Conv.mat;
%
%lowerlakes.VictorHarbor.H.Date = VH(:,1);
%lowerlakes.VictorHarbor.H.Data = VH(:,2);
%lowerlakes.VictorHarbor.H.Depth(1:length(VH),1) = 0;
%lowerlakes.VictorHarbor.H.X = 306755.0;
%lowerlakes.VictorHarbor.H.Y = 6060194.0;

lowerlakes = check_XY(lowerlakes);

lowerlakes = add_offset(lowerlakes);

datearray(:,1) = datenum(2008,01:132,01);

lowerlakes = cleanse_sites(lowerlakes);


lowerlakes = add_secondary_data(lowerlakes,datearray);

save lowerlakes_precleanse.mat lowerlakes -mat;



save lowerlakes.mat lowerlakes -mat;


save('../../BC Processing/BC from Field Data/lowerlakes.mat','lowerlakes','-mat');
save('../../Grid Processing/CEWH 2017/lowerlakes.mat','lowerlakes','-mat');
save('../../Sim Processing/Ruppia 2017/Matfiles/lowerlakes.mat','lowerlakes','-mat');
save('../../Sim Processing/CEWH 2017/Plotting/Matfiles/lowerlakes.mat','lowerlakes','-mat');

%save E:\Dropbox\Coorong_2013\Processing\Plotting\Matfiles\lowerlakes.mat lowerlakes -mat;


coorong = remove_Lake_Sites(lowerlakes,'GIS/Coorong_Boundary1.shp');

save('../../Sim Processing/Ruppia 2017/Matfiles/coorong.mat','coorong','-mat');
save('../../Grid Processing/CEWH 2017/coorong.mat','coorong','-mat');
save('../../Grid Processing/CEWH 2017/Matfiles/coorong.mat','coorong','-mat');

%summerise_data('lowerlakes.mat','lowerlakes/');

%plot_data_polygon_regions;
