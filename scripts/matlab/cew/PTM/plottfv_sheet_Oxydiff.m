clear all; close all; fclose all;

addpath(genpath('tuflowfv'));

sitename = 'Lowerlakes';



ncfile_Base = ['I:\GCLOUD\PTM_Results\',sitename,'\Output_1_0\run.nc'];
ncfile_Diff = ['I:\GCLOUD\PTM_Results_v3\',sitename,'\Output_1_1\run.nc'];
%ncfile_Diff = 'I:\Simulations\Lowerlakes\Lowerlakes_PTM_Test_v5\Output\run.nc';

ptmfile = ['I:\GCLOUD\PTM_Results_v3\',sitename,'\Output_1_1\run_ptm.nc'];

outdir = ['I:\GCLOUD\Report Images\',sitename,'_Updated\'];

varname = 'WQ_OXY_OXY';



cax = [0 3];

title = 'Oxygen (mg/L)';

% These two slow processing down. Only set to 1 if required
create_movie = 1; % 1 to save movie, 0 to just display on screen
save_images = 0;

plot_interval = 1;

shp = shaperead('MatGrids/Lowerlakes_Ag.shp');

%shp = shaperead('MatGIS/Lowerlakes.shp');

clip_depth = 0.1;% In m
%clip_depth = 999;% In m

isTop = 1;

%____________

[ptm_data,x,y,z] = tfv_readPTM(ptmfile);




if create_movie | save_images
    
    if ~exist(outdir,'dir')
        mkdir(outdir);
    end
end


if create_movie
    sim_name = [outdir,varname,'_PTM.mp4'];
    
    hvid = VideoWriter(sim_name,'MPEG-4');
    set(hvid,'Quality',100);
    set(hvid,'FrameRate',6);
    framepar.resolution = [1024,768];
    
    open(hvid);
end
%__________________


dat = tfv_readnetcdf(ncfile_Base,'time',1);
timesteps = dat.Time;

dat = tfv_readnetcdf(ncfile_Base,'timestep',1);
clear funcions


vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

first_plot = 1;

[~,int] = min(abs(timesteps - datenum(2016,07,01)));

for i = 1:1:length(timesteps)%1:plot_interval:length(timesteps)
        [~,ind] = min(abs(ptm_data.mdate - timesteps(i)));

        stat = find(ptm_data.stat(:,ind) == 2);
    stat2 = find(ptm_data.stat(:,ind) == 3);  
    
    
    tdat = tfv_readnetcdf(ncfile_Base,'timestep',i);clear functions
    tdat_comp = tfv_readnetcdf(ncfile_Diff,'timestep',i);clear functions

    switch isTop
        case 1
            if strcmpi(varname,'H') == 0
        
        
            cdata1 = tdat.(varname)(tdat.idx3(tdat.idx3 > 0));
            cdata2 = tdat_comp.(varname)(tdat_comp.idx3(tdat.idx3 > 0));

          else

            cdata = tdat.(varname);
          end
        case 2
            
            bottom_cells(1:length(tdat.idx3)-1) = tdat.idx3(2:end) - 1;
            bottom_cells(length(tdat.idx3)) = length(tdat.idx3);

            cdata1 = tdat.(varname)(bottom_cells);
            cdata2 = tdat_comp.(varname)(bottom_cells);
            
        case 3
            
        otherwise
            
    end
   
      
    cdata = cdata1 - cdata2;

    
    Depth = tdat.D;
    
    
    if clip_depth < 900
    
        Depth(Depth < clip_depth) = 0;
    
        cdata(Depth == 0) = NaN;
    end
    
    if strcmpi(varname,'WQ_TRC_RET') == 1
        cdata = cdata ./ 86400;
    end
    
    if strcmpi(varname,'WQ_OXY_OXY') == 1
        cdata = cdata .* (32/1000);
    end
    
    if first_plot
        
        hfig = figure('visible','on','position',[304         166        1271         812]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 20.32 15.24])
        
        ax1 = axes('position',[0 0 1 1]);
        

        
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        mapshow(shp,'EdgeColor','k','facecolor','none');hold on
        
        sc1 = scatter(ptm_data.x_raw(stat,ind),ptm_data.y_raw(stat,ind),0.05,'.b');
        sc2 = scatter(ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),0.05,'.r');
        
        x_lim = get(gca,'xlim');
        y_lim = get(gca,'ylim');
        
        caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.9 0.1 0.01 0.25],...
            'units','normalized','ycolor','k');
        
        colorTitleHandle = get(cb,'Title');
        %set(colorTitleHandle ,'String',regexprep(varname,'_',' '),'color','k','fontsize',10);
        
        
        axis off
        axis equal
        
        text(0.1,0.9,title,...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
        
        txtDate = text(0.1,0.1,datestr(timesteps(i),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',21,...
            'color','k');
        
        first_plot = 0;
        xlim([281975.350527484          369940.487793144]);
        ylim([6037073.10803645          6093285.87676131]);
        
%          xlim([296008.340924304          370529.652175978]);
%          ylim([6042152.30409867          6089761.51317527]);

%         xlim([294562.612607759          363234.552262931]);
%         ylim([6045021.04244045          6088893.28083541]);


        set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf,'paperposition',[0.635                      6.35                     20.32                     15.24])
    else
        
        set(patFig,'Cdata',cdata);
        drawnow;
        
        set(txtDate,'String',datestr(timesteps(i),'dd mmm yyyy HH:MM'));
        
        caxis(cax);
        
                set(sc1,'Visible','off');
        set(sc2,'Visible','off');
        
        sc1 = scatter(ax1,ptm_data.x_raw(stat,ind),ptm_data.y_raw(stat,ind),0.05,'.b');
        sc2 = scatter(ax1,ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),0.05,'.r');  
        
    end
    
    if create_movie
        
       % F = fig2frame(hfig,framepar); % <-- Use this
        
        % Add the frame to the video object
    writeVideo(hvid,getframe(hfig));
    end
    
    if save_images
    
        img_dir = [outdir,varname,'/'];
        if ~exist(img_dir,'dir')
            mkdir(img_dir);
        end
        
        img_name =[img_dir,datestr(timesteps(i),'yyyymmddHHMM'),'.png'];
        
        saveas(gcf,img_name);
        
    end
    clear data cdata
end

if create_movie
    % Close the video object. This is important! The file may not play properly if you don't close it.
    close(hvid);
end

clear all;