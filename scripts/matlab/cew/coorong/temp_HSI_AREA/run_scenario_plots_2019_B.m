addpath(genpath('tuflowfv'));

scenarios = {...
    'ORH_Base_3D_20140101_20170101',...
    'ORH_Base_20140101_20170101',...
    'SC40_NUT_2.0_20140101_20170101',...
%     'SC40_NUT_1.5_20140101_20170101',...
%     'ORH_Base_WAVE_20140101_20140401',...
};


% scenarios = {...
%     '012_Weir_6_SC70_noWeir',...
%     '013_Weir_5_SC70_Parnka',...
% 	'013_Weir_4_SC70_Needles',...
% 	'013_Weir_7_SC55_Needles',...
% 	'012_Weir_6_SC70_noWeir',...
%     '013_Weir_5_SC70_Parnka',...
% 	'013_Weir_4_SC70_Needles',...
% 	'013_Weir_7_SC55_Needles',...
% };
   % '011_Weir_3_B6000_SC40_noWeir',...
    %'011_Weir_3_B6000_SC40_noWeir',...

%     '010_Ruppia_2015_2016_3_BTau',...
%     '010_Ruppia_2015_2016_4_BGoo',...
%     '010_Ruppia_2015_2016_5_BL_SC100',...
%     '010_Ruppia_2015_2016_11_lgt',...
%     '010_Ruppia_2015_2016_6_SC0',...
%     '010_Ruppia_2015_2016_8_SC100',...
%     '010_Ruppia_2015_2016_9_SC40_2Nut',...
%     '010_Ruppia_2015_2016_10_SC40_0_5Nut',...
%    '010_Ruppia_2016_2017_1',...
 %   };

min_size = 30000000000;

year_array = [2015 2015 2015];% 2014 2014 2014];% 2014 2014 2014 2015 2015 2015 2015];%,2015,2015];



%download_files;%(min_size);

for i = 1:length(scenarios)
    
    filename = ['R:\Coorong-Local\Netcdf\',scenarios{i},'.nc'];
    
    % determine file size
    
    if exist(filename,'file')
        
        f = dir(filename);
        
        if f.bytes > min_size
            
            
            outdir_malg_f = ['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\malg\'];
                    plottfv_averaged_4_panel_coorong_sheet_inserts_malg_f(filename,outdir_malg_f,year_array(i));
            
            
            % Plots to the sheets directory
            outdir_lim1_f = ['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\1_adult_new\'];
            outdir_lim2_f = ['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\2_flower_new\'];
            outdir_lim3_f = ['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\3_seed_new\'];
            outdir_lim4_f = ['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\4_turion_new\'];
            outdir_lim5_f = ['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\5_sprout_new\'];
            
            
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_1_combo_fa(filename,outdir_lim1_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_2_combo_fa(filename,outdir_lim2_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_3_combo_fa(filename,outdir_lim3_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_4_combo_fa(filename,outdir_lim4_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_5_combo_fa(filename,outdir_lim5_f,scenarios{i},year_array(i));
            
            
            % The stand alone plot
            
            hsi1= load(['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\1_adult_new\HSI_adult.mat']);
            hsi2= load(['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\2_flower_new\HSI_flower.mat']);
            hsi3= load(['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\3_seed_new\HSI_seed.mat']);
            hsi4= load(['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\4_turion_new\HSI_turion.mat']);
            hsi5= load(['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\5_sprout_new\HSI_sprout.mat']);
            
            
            outdir = ['Y:\Coorong Report\Ruppia_Life_Stages\',scenarios{i},'\Sheets\',num2str(year_array(i)),'\'];
	
            %___________________________________________________________
%MH BUM        
dat = tfv_readnetcdf(filename,'time',1);
timesteps = dat.Time;
dat = tfv_readnetcdf(filename,'timestep',1);
tt = tfv_readnetcdf(filename,'names',{'cell_A'});
Area = tt.cell_A;

data = tfv_readnetcdf(filename,'names',{'SAL';'D'});

vert = [];
faces = [];

vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;
faces = dat.cell_node';
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);
%MH BUM        
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
            
            
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % WHOLE COORONG PLOTS
            chsi=1
            chsl=0.3

            %%%%%%%%%%%%%%%%%%''
            hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 1207.3333]);
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            set(gcf,'paperposition',[0.635 6.35 20.32 30.24])


            axes('position',[ -0.30 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi1.min_cdata);shading flat
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

                text(0.40,0.75,'Adult','fontsize',12,'units','normalized');

            axes('position',[ -0.18 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi2.min_cdata);shading flat
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

                text(0.40,0.75,'Flower','Units','Normalized','fontsize',12);

            axes('position',[ -0.06 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi3.min_cdata);shading flat
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

                text(0.41,0.75,'Seed','Units','Normalized','fontsize',12);

            axes('position',[ 0.26 0.0  1.0 1.0]);
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

                text(0.42,0.95,'HSI (sexual)','Units','Normalized','fontsize',12);


            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            xSize = 18;
            ySize = 20;
            xLeft = (21-xSize)/2;
            yTop = (30-ySize)/2;
            set(gcf,'paperposition',[0 0 xSize ySize])

            saveas(gcf,[outdir,'HSI_sexual.png']);

            save([outdir,'HSI_sexual.mat'],'min_cdata','-mat');
            export_area([outdir,'HSI_sexual.csv'],min_cdata,Area);


          %%%%%%%%%%%%%%%%%%''
          hsi_asexual = [ hsi1.min_cdata hsi4.min_cdata hsi5.min_cdata];
          min_cdata = min(hsi_asexual,[],2);
          
          %%%%%%%%%%%%%%%%%%''
            hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 1207.3333]);
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            set(gcf,'paperposition',[0.635 6.35 20.32 30.24])


            axes('position',[ -0.30 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi1.min_cdata);shading flat
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

                text(0.40,0.75,'Adult','fontsize',12,'units','normalized');

            axes('position',[ -0.18 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi4.min_cdata);shading flat
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

                text(0.40,0.75,'Turion','Units','Normalized','fontsize',12);

            axes('position',[ -0.06 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi5.min_cdata);shading flat
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

                text(0.40,0.75,'Sprout','Units','Normalized','fontsize',12);

            axes('position',[ 0.26 0.0  1.0 1.0]);
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

                text(0.42,0.95,'HSI (asexual)','Units','Normalized','fontsize',12);


            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            xSize = 18;
            ySize = 20;
            xLeft = (21-xSize)/2;
            yTop = (30-ySize)/2;
            set(gcf,'paperposition',[0 0 xSize ySize])

            saveas(gcf,[outdir,'HSI_asexual.png']);

            save([outdir,'HSI_asexual.mat'],'min_cdata','-mat');
            export_area([outdir,'HSI_asexual.csv'],min_cdata,Area);




            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % TRACER PLOTS
%            outdir_trcs_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\tracers\'];
%            plottfv_averaged_4_panel_coorong_sheet_inserts_trcs_f(filename,outdir_trcs_f);
          
            
            
            
        end
        
    end
    close all;
end
