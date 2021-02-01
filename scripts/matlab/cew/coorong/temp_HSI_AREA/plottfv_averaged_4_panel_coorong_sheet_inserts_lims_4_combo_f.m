function plottfv_averaged_4_panel_coorong_sheet_inserts_lims_4_combo_f(ncfile,outdir,scenario,year,windowLength,averageLength);
% clear all; close all;
% 
% addpath(genpath('tuflowfv'));
% 
% ncfile = 'I:\Lowerlakes\Coorong Only Simulations\009_Ruppia_2015_2016_Matt_0SC_0B\Output\coorong.nc';
% 
% outdir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\4_turion_new\';

yr = year;

loopy_doop =1;

%__________________________________________________________________________
% windowLength  = 150.0;
% averageLength = 90.0;

var(1).name = 'WQ_DIAG_HAB_RUPPIA_HSI_FSAL_4';
var(1).cax = [0 1];
var(1).title = ' f(S)';
var(1).SaveName = '4_fsal';
var(1).daterange = [datenum(yr,08,01) (datenum(yr,08,01)+windowLength) ]; %>= 1 < 2

var(2).name = 'WQ_DIAG_HAB_RUPPIA_HSI_FTEM_4';
var(2).cax = [0 1];
var(2).title = ' f(T)';
var(2).SaveName = '4_ftem';
var(2).daterange = [datenum(yr,08,01) (datenum(yr,08,01)+windowLength) ]; %>= 1 < 2

var(3).name = 'WQ_DIAG_HAB_RUPPIA_HSI_FLGT_4';
var(3).cax = [0 1];
var(3).title = ' f(I)';
var(3).SaveName = '4_flgt';
var(3).daterange = [datenum(yr,08,01) (datenum(yr,08,01)+windowLength) ]; %>= 1 < 2

var(4).name = 'WQ_DIAG_HAB_RUPPIA_HSI_FALG_4';
var(4).cax = [0 1];
var(4).title = ' f(FA)';
var(4).SaveName = '4_falg';
var(4).daterange = [datenum(yr,08,01) (datenum(yr,08,01)+windowLength) ]; %>= 1 < 2

var(5).name = 'WQ_DIAG_HAB_RUPPIA_HSI_FDEP_4';
var(5).cax = [0 1];
var(5).title = ' f(WL)';
var(5).SaveName = '4_fdep';
var(5).daterange = [datenum(yr,08,01) (datenum(yr,08,01)+windowLength) ]; %>= 1 < 2

%range = [datenum(2015,01,01) datenum(2015,04,01)];
%movie_name = '001_Ruppia_HSI_Averaged.png';

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
% Loop through the limiting vars
for i = 1:length(var)

	data = tfv_readnetcdf(ncfile,'names',{var(i).name;'D'});

	vert(:,1) = dat.node_X;
	vert(:,2) = dat.node_Y;

	faces = dat.cell_node';
	%--% Fix the triangles
	faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

	%__________________________________________________
	if(loopy_doop==1)
	    % check for maximum rolling average within the window
	    max_ave_data = mean(data.(var(i).name)(:,:),2) * 0.;
		for w = 0:(windowLength-averageLength)
	  		sss = find(timesteps >= (var(i).daterange(1)+w) & timesteps < (var(i).daterange(1)+averageLength+w) );
	  		ave_data = mean(data.(var(i).name)(:,sss),2);

            mmm = find(ave_data(:) > max_ave_data(:) );
            max_ave_data(mmm) = ave_data(mmm);

            clear sss mmm;
%        if(i==4)
%        		malg=load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\008_2015_10SC_Nuts\Sheets\malg\Ulva_TotalBiomass.mat')
%      		ave_data = malg.min_cdata;
%      		ssss = find(ave_data > 25.);
%      		ave_data(:) = 1.0;
%      		ave_data(ssss) = 0.;
%       end
        end
        ave_data(:) = max_ave_data(:);
	else
	  	% just do average over the window
	  	sss = find(timesteps >= var(i).daterange(1) & timesteps < var(i).daterange(2));
	  	ave_data = mean(data.(var(i).name)(:,sss),2);
	  	% Special post-processing of FA (malg) for this dude
	  	if(i==4)
      		malg=load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenario,'\Sheets\malg\Ulva_TotalBiomass.mat'])
    		ave_data = malg.min_cdata;
    		ssss = find(ave_data > 25.);
    		ave_data(:) = 1.0;
    		ave_data(ssss) = 0.;
     	end
	end

	max_data(:,i) = ave_data;

end
%%%%%%%%%%%%%%%%%


min_cdata = min(max_data,[],2);


sss = find(min_cdata < 0.3);   % critical overall HSI we clip at
min_cdata(sss) = 0.;


chsi=1
chsl=0.3

%%%%%%%%%%%%%%%%%%''
hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 1207.3333]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 20.32 30.24])


axes('position',[ -0.31 0.0  1.0 1.0]);
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

    text(0.435,0.75,'f(S)','fontsize',12,'units','normalized');

axes('position',[ -0.19 0.0  1.0 1.0]);
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

    text(0.435,0.75,'f(I)','Units','Normalized','fontsize',12);

axes('position',[ -0.07 0.0  1.0 1.0]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',max_data(:,5));shading flat
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

    text(0.45,0.75,'f(WL)','Units','Normalized','fontsize',12);

axes('position',[ 0.05 0.0  1.0 1.0]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',max_data(:,4));shading flat
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

    text(0.45,0.75,'f(FA)','Units','Normalized','fontsize',12);

axes('position',[ 0.29 0.0  1.0 1.0]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',min_cdata);shading flat
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

    text(0.41,0.95,'HSI (Turion)','Units','Normalized','fontsize',12);


set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 18;
ySize = 20;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,[outdir,'HSI_turion.png']);
save([outdir,'HSI_turion.mat'],'min_cdata','-mat');

export_area([outdir,'HSI_turion.csv'],min_cdata,Area);






















































