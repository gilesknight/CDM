addpath(genpath('tuflowfv'));

scenarios = {...
    '011_Ruppia_2014_2015_1',...
    '011_Ruppia_2015_2016_1',...
    '010_Ruppia_2016_2017_1',...
    };

year_array = [2014 2015 2016];
min_size = 30000000000;

%download_files;%(min_size);

for i = 1:length(scenarios)
    
    filename = ['I:\Lowerlakes\Coorong Only Simulations\Scenarios\',scenarios{i},'/Output/coorong.nc'];
    
    % determine file size
    
    if exist(filename,'file')
        
        f = dir(filename);
        
        if f.bytes > min_size;
            
            outdir_malg_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\malg\'];
            plottfv_averaged_4_panel_coorong_sheet_inserts_malg_f(filename,outdir_malg_f,year_array(i));
%             outdir_malg_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\malg\'];
%             plottfv_averaged_4_panel_coorong_sheet_inserts_malg_f(filename,outdir_malg_f);
%             
%             % Plots to the sheets directory
            outdir_lim1_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\1_adult_new\'];
            outdir_lim2_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\2_flower_new\'];
            outdir_lim3_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\3_seed_new\'];
            outdir_lim4_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\4_turion_new\'];
            outdir_lim5_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\5_sprout_new\'];
%             
%             
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_1_combo_f(filename,outdir_lim1_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_2_combo_f(filename,outdir_lim2_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_3_combo_f(filename,outdir_lim3_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_4_combo_f(filename,outdir_lim4_f,scenarios{i},year_array(i));
            plottfv_averaged_4_panel_coorong_sheet_inserts_lims_5_combo_f(filename,outdir_lim5_f,scenarios{i},year_array(i));
%             
            
            % The stand alone plot
            
            hsi1= load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\1_adult_new\HSI_adult.mat']);
            hsi2= load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\2_flower_new\HSI_flower.mat']);
            hsi3= load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\3_seed_new\HSI_seed.mat']);
            hsi4= load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\4_turion_new\HSI_turion.mat']);
            hsi5= load(['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\5_sprout_new\HSI_sprout.mat']);
            
            
            outdir = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\'];
	
            %___________________________________________________________
%MH BUM        
dat = tfv_readnetcdf(filename,'time',1);
timesteps = dat.Time;
dat = tfv_readnetcdf(filename,'timestep',1);
tt = tfv_readnetcdf(filename,'names',{'cell_A'});
Area = tt.cell_A;

data = tfv_readnetcdf(filename,'names',{'SAL';'D'});
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
            
            
            %___________________________________________________________
            hsi_sexual = [ hsi1.min_cdata hsi2.min_cdata hsi3.min_cdata];
            min_cdata = min(hsi_sexual,[],2);
            chsi=1.0;
            
            
      
            sss = find(min_cdata < 0.3);
            min_cdata(sss) = 0.;
            
            

             hsi.(['year',num2str(year_array(i))]).min_cdata = min_cdata;
             hsi.(['year',num2str(year_array(i))]).hsi1 = hsi1;
    
            
            
 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % TRACER PLOTS
%            outdir_trcs_f = ['D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\',scenarios{i},'\Sheets\tracers\'];
%            plottfv_averaged_4_panel_coorong_sheet_inserts_trcs_f(filename,outdir_trcs_f);
          
            
            
            
        end
        
    end
    
end
save('D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\3_year_HSI.mat','hsi','-mat');
chsl = 0.3;
chsi = 1;
% 
% %%%%%%---------------------------------%%%%%%
% %% .    Plot comparing years
% % 
%             %%%%%%%%%%%%%%%%%%''
            hfig = figure('visible','on','position',[2.7497e+03 406.3333 1.2813e+03 1207.3333]);
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            set(gcf,'paperposition',[0.635 6.35 20.32 30.24])


            axes('position',[ -0.30 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi.year2014.min_cdata);shading flat
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

                text(0.435,0.75,'2014','fontsize',12,'units','normalized');

            axes('position',[ -0.18 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi.year2015.min_cdata);shading flat
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

                text(0.435,0.75,'2015','Units','Normalized','fontsize',12);

            axes('position',[ -0.06 0.0  1.0 1.0]);
                patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',hsi.year2016.min_cdata);shading flat
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

                text(0.45,0.75,'2016','Units','Normalized','fontsize',12);



            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            xSize = 18;
            ySize = 20;
            xLeft = (21-xSize)/2;
            yTop = (30-ySize)/2;
            set(gcf,'paperposition',[0 0 xSize ySize])

            saveas(gcf,[outdir,'HSI_2014-2016.png']);
