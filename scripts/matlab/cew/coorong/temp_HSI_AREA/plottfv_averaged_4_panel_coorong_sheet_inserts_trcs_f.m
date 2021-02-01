function plottfv_averaged_4_panel_coorong_sheet_inserts_trcs_f(ncfile,outdir)

% clear all; close all;

% addpath(genpath('tuflowfv'));

%ncfile = 'I:\Lowerlakes\Coorong Only Simulations\009_Ruppia_2015_2016_Matt_0SC_0B\Output\coorong.nc';
%ncfile = '~/Desktop/010_Ruppia_2015_2016_Matt/Output/coorong.nc';

%outdir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\malg\';
%outdir = '~/Dropbox/Data_Lowerlakes/MacProcessing/010_2015/Sheets/malg/';
yr = 2015
cmax = 1;

%__________________________________________________________________________
windowLength = 120.0;

var(1).name = 'TRACE_1';
var(1).cax = [0 1];
var(1).title = 'Barrage Water';
var(1).SaveName = 'BarrageTracer';
var(1).daterange = [datenum(yr,04,01) (datenum(yr,04,01)+windowLength) ]; %>= 1 < 2

var(2).name = 'TRACE_2';
var(2).cax = [0 1];
var(2).title = 'Salt Creek Water';
var(2).SaveName = 'SaltCreekTracer';
var(2).daterange = [datenum(yr,04,01) (datenum(yr,04,01)+windowLength) ]; %>= 1 < 2

var(3).name = 'WQ_TRC_RET';
var(3).cax = [0 1e10];
var(3).title = 'Retention Time';
var(3).SaveName = 'RetentionTime';
var(2).daterange = [datenum(yr,04,01) (datenum(yr,04,01)+windowLength) ]; %>= 1 < 2

clip_dry_cells = 0;


%__________________________________________________________________________
if ~exist(outdir,'dir')
    mkdir(outdir);
end






dat = tfv_readnetcdf(ncfile,'time',1);
timesteps = dat.Time;

dat = tfv_readnetcdf(ncfile,'timestep',1);
clear funcions


tt = tfv_readnetcdf(ncfile,'names',{'cell_A'});

Area = tt.cell_A;


%__________________________________________________________________________

for i = 1:length(var)


data = tfv_readnetcdf(ncfile,'names',{var(i).name;'D'});


vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

%__________________________________________________


sss = find(timesteps >= var(i).daterange(1) & timesteps < var(i).daterange(2));


ave_data = mean(data.(var(i).name)(:,sss),2);

max_data(:,i) = ave_data;

%___________________________________________________________
hfig = figure('visible','on','position',[1116.33333333333          676.333333333333          1136.66666666667          477.333333333333]);

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 20.32 15.24])

axes('position',[0 0 0.5 1]);

patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',ave_data);shading flat
set(gca,'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

caxis(var(i).cax);

axis equal

axis off;%set(gca,'xticklabel',[],'yticklabel',[]);

cb = colorbar('location','South','orientation','horizontal');
set(cb,'position',[0.05 0.15 0.25 0.01]);


text(0.05,0.3,var(i).title,'fontsize',12,'units','normalized');
text(0.05,0.2,[datestr(var(i).daterange(1),'mmm'),' to ',datestr(var(i).daterange(2)-1,'mmm'),' ',datestr(var(i).daterange(2),'yyyy')],'fontsize',10,'units','normalized');

axes('position',[0.5 0.66 0.5 .33]);

patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',ave_data);shading flat
set(gca,'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

caxis(var(i).cax);

axis equal
axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
xlim([293699.100578432          342582.121196988]);
ylim([6054325.94393016          6068383.91584442]);


text(0.75,0.8,'Barrages','Units','Normalized','fontsize',12);


axes('position',[0.5 0.33 0.5 .33]);


patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',ave_data);shading flat
set(gca,'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

caxis(var(i).cax);

axis equal
axis off;%set(gca,'xticklabel',[],'yticklabel',[]);

xlim([332035.93220827          380918.952826826]);
ylim([6025490.24496481          6039548.21687907]);

text(0.75,0.8,'Parnka','Units','Normalized','fontsize',12);

axes('position',[0.5 0.0 0.5 .33]);

patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',ave_data);shading flat
set(gca,'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

caxis(var(i).cax);

axis equal
axis off;%set(gca,'xticklabel',[],'yticklabel',[]);

xlim([375273.32707425           381639.04598862]);
ylim([5999842.12226421          6001672.80082253]);

text(0.75,0.8,'Salt Creek','Units','Normalized','fontsize',12);

            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            xSize = 21;
            ySize = 10;
            xLeft = (21-xSize)/2;
            yTop = (30-ySize)/2;
            set(gcf,'paperposition',[0 0 xSize ySize])



saveas(gcf,[outdir,var(i).SaveName,'.png']);
save([outdir,var(i).SaveName,'.mat'],'ave_data','-mat');

export_area([outdir,var(i).SaveName,'.csv'],ave_data,Area);

close

end






%__________________________________________________________________________
% TRACER

max_cdata = max(max_data,[],2);

% Need to get rid of the 0.
sss = find(max_data == 0);

max_data(:,3) = (1.0-max_data(:,2)-max_data(:,1));

min_data = [ max_data(:,1) max_data(:,2)  ];
% min_data(sss) = 999;

min_cdata = min(min_data,[],2);
% min_cdata(min_cdata == 999) = 0;

clear min_data;
% sss = find(min_cdata > 0);
% 
% total_area = sum(Area(sss));

export_area([outdir,'Tracer_Area.csv'],min_cdata,Area)





chsi=1.0
chsl=0.0

%%%%%%%%%%%%%%%%%%''
hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 1207.3333]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 20.32 30.24])


axes('position',[ -0.3 0.0  1.0 1.0]);
%axes('position',[ 0.0 0.0  0.5 1]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData', max_data(:,1));shading flat
    set(gca,'box','on');

    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ chsl chsi]);
    axis equal
    camroll(-25)
    
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    cb = colorbar('location','South','orientation','horizontal');
    set(cb,'position',[0.05 0.15 0.25 0.01]);

    text(0.435,0.75,'Barrage','fontsize',12,'units','normalized');

axes('position',[ -0.18 0.0  1.0 1.0]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',max_data(:,2));shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ chsl chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    camroll(-25)

    text(0.435,0.75,'Salt Creek','Units','Normalized','fontsize',12);

axes('position',[ -0.06 0.0  1.0 1.0]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',max_data(:,3));shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ chsl chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    camroll(-25)

    text(0.45,0.75,'Other','Units','Normalized','fontsize',12);
% 
% axes('position',[ 0.25 0.0  1.0 1.0]);
%     patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',min_cdata);shading flat
%     set(gca,'box','on');
%     set(findobj(gca,'type','surface'),...
%         'FaceLighting','phong',...
%         'AmbientStrength',.3,'DiffuseStrength',.8,...
%         'SpecularStrength',.9,'SpecularExponent',25,...
%         'BackFaceLighting','unlit');
% 
%     caxis([ chsl chsi]);
%     axis equal
%     axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
%     camroll(-25)
% 
%     text(0.40,0.95,'HSI (Ulva)','Units','Normalized','fontsize',12);


set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 18;
ySize = 20;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,[outdir,'Tracer.png']);
save([outdir,'Tracer.mat'],'min_cdata','-mat');

export_area([outdir,'Tracer.csv'],min_cdata,Area);




close