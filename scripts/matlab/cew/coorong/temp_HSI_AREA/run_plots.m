% All these scripts plot to the illustator directory. 
% 
plottfv_averaged_4_panel_coorong_sheet_inserts_malg;

  % Plots to the sheets directory
   plottfv_averaged_4_panel_coorong_sheet_inserts_lims_1_combo; 
   plottfv_averaged_4_panel_coorong_sheet_inserts_lims_2_combo; 
   plottfv_averaged_4_panel_coorong_sheet_inserts_lims_3_combo; 
   plottfv_averaged_4_panel_coorong_sheet_inserts_lims_4_combo; 
   plottfv_averaged_4_panel_coorong_sheet_inserts_lims_5_combo; 
% 
 hsi1= load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\1_adult_new\HSI_adult_.mat')
 hsi2= load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\2_flower_new\HSI_flower_south.mat')
 hsi3= load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\3_seed_new\HSI_seed_south.mat')
 hsi4= load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\4_turion_new\HSI_turion_south.mat')
 hsi5= load('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\5_sprout_new\HSI_sprout_south.mat')

 outdir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\009_2015_rolling_0SC_0B\Sheets\';


%___________________________________________________________
hsi_asexual = [ hsi1.min_cdata hsi4.min_cdata hsi5.min_cdata];
min_cdata = min(hsi_asexual,[],2);
chsi=1.0;


sss = find(min_cdata < 0.3);
min_cdata(sss) = 0.;


if ~exist(outdir,'dir')
    mkdir(outdir);
end


hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 707.3333]);

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 20.32 15.24])


axes('position',[ 0.0 0.05  0.5 1]);
%axes('position',[ 0.0 0.0  0.5 1]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi1.min_cdata);shading flat
    set(gca,'box','on');

    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    %camroll(-20)
    cb = colorbar('location','South','orientation','horizontal');
    set(cb,'position',[0.05 0.15 0.25 0.01]);

    text(0.1,0.65,'Adult','fontsize',12,'units','normalized');

%axes('position',[0.5 0.66 0.5 .33]);
axes('position',[ 0.1 0.1  0.5 1]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi4.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    text(0.1,0.65,'Turion','Units','Normalized','fontsize',12);

axes('position',[ 0.2 0.15  0.5 1]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi5.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    text(0.1,0.65,'Sprout','Units','Normalized','fontsize',12);

axes('position',[ 0.48 0.25  0.5 1]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    text(0.21,0.80,'HSI (asexual)','Units','Normalized','fontsize',12);



set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 21;
ySize = 12.5;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,[outdir,'HSI_asexual_north.png']);
save([outdir,'HSI_asexual_north.mat'],'min_cdata','-mat');

export_area([outdir,'HSI_asexual_north.csv'],min_cdata,Area);




hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 707.3333]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 20.32 15.24])


axes('position',[ 0.0 0.1  0.5 0.9]);
%axes('position',[ 0.0 0.0  0.5 1]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi1.min_cdata);shading flat
    set(gca,'box','on');

    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    %camroll(-20)
    cb = colorbar('location','South','orientation','horizontal');
    set(cb,'position',[0.05 0.15 0.25 0.01]);

    text(0.25,0.95,'Adult','fontsize',12,'units','normalized');

%axes('position',[0.5 0.66 0.5 .33]);
axes('position',[ 0.1 0.1  0.5 0.9]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi4.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    text(0.25,0.95,'Turion','Units','Normalized','fontsize',12);

axes('position',[ 0.2 0.1  0.5 0.9]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi5.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    text(0.25,0.95,'Sprout','Units','Normalized','fontsize',12);

axes('position',[ 0.48 0.10  0.5 0.9]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    text(0.31,0.95,'HSI (asexual)','Units','Normalized','fontsize',12);



set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 21;
ySize = 12.5;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,[outdir,'HSI_asexual_south.png']);
save([outdir,'HSI_asexual_south.mat'],'min_cdata','-mat');

export_area([outdir,'HSI_asexual_south.csv'],min_cdata,Area);

clear min_cdata;



%___________________________________________________________
%___________________________________________________________
%___________________________________________________________
%___________________________________________________________
%___________________________________________________________
hsi_sexual = [ hsi1.min_cdata hsi2.min_cdata hsi3.min_cdata];
min_cdata = min(hsi_sexual,[],2);
chsi=1.0;

sss = find(min_cdata < 0.3);
min_cdata(sss) = 0.;

hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 707.3333]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 20.32 15.24])


axes('position',[ 0.0 0.05  0.5 1]);
%axes('position',[ 0.0 0.0  0.5 1]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi1.min_cdata);shading flat
    set(gca,'box','on');

    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    %camroll(-20)
    cb = colorbar('location','South','orientation','horizontal');
    set(cb,'position',[0.05 0.15 0.25 0.01]);

    text(0.1,0.65,'Adult','fontsize',12,'units','normalized');

%axes('position',[0.5 0.66 0.5 .33]);
axes('position',[ 0.1 0.1  0.5 1]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi2.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    text(0.1,0.65,'Flower','Units','Normalized','fontsize',12);

axes('position',[ 0.2 0.15  0.5 1]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi3.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    text(0.1,0.65,'Seed','Units','Normalized','fontsize',12);

axes('position',[ 0.48 0.25  0.5 1]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.1008e+05 3.6120e+05]);
    ylim([6.0275e+06 6.0704e+06]);
    text(0.21,0.80,'HSI (sexual)','Units','Normalized','fontsize',12);



set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 21;
ySize = 12.5;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,[outdir,'HSI_sexual_north.png']);
save([outdir,'HSI_sexual_north.mat'],'min_cdata','-mat');

export_area([outdir,'HSI_sexual_north.csv'],min_cdata,Area);



hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 707.3333]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 20.32 15.24])


axes('position',[ 0.0 0.1  0.5 0.9]);
%axes('position',[ 0.0 0.0  0.5 1]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi1.min_cdata);shading flat
    set(gca,'box','on');

    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    %camroll(-20)
    cb = colorbar('location','South','orientation','horizontal');
    set(cb,'position',[0.05 0.15 0.25 0.01]);

    text(0.25,0.95,'Adult','fontsize',12,'units','normalized');

%axes('position',[0.5 0.66 0.5 .33]);
axes('position',[ 0.1 0.1  0.5 0.9]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi2.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    text(0.25,0.95,'Flower','Units','Normalized','fontsize',12);

axes('position',[ 0.2 0.1  0.5 0.9]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi3.min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    text(0.25,0.95,'Seed','Units','Normalized','fontsize',12);

axes('position',[ 0.48 0.10  0.5 0.9]);
%axes('position',[0.5 0.33 0.5 .33]);
    patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',min_cdata);shading flat
    set(gca,'box','on');
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis([ 0 chsi]);
    axis equal
    axis off;%set(gca,'xticklabel',[],'yticklabel',[]);
    xlim([3.4280e+05 3.9398e+05]);
    ylim([5.9896e+06 6.0326e+06]);
    text(0.31,0.95,'HSI (sexual)','Units','Normalized','fontsize',12);



set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 21;
ySize = 12.5;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,[outdir,'HSI_sexual_south.png']);
save([outdir,'HSI_sexual_south.mat'],'min_cdata','-mat');

export_area([outdir,'HSI_sexual_south.csv'],min_cdata,Area);





close all
clear all


%STOP


% Plots to the Points directory
%plottfv_prof prof; % change config_prof
%plottfv_prof sal; % Needed for the high SAL values around salt creek: Change config_sal

% Plots to the region directory
plottfv_polygon poly; % Change config prof


% All stuff found in scripts, 
% this script also creates a csv file of area * HSI values, as well data
% cdata*area for each of the sub-groups. The eact script that may need
% tweaking is export_area.