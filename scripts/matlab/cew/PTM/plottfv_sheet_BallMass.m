clear all; close all; fclose all;

addpath(genpath('tuflowfv'));


ncfile = 'Z:\Busch\Studysites\Lowerlakes\2019_Modelling\Lowerlakes_PTM_Test_v5\Output\run.nc';
ptmfile = 'Z:\Busch\Studysites\Lowerlakes\2019_Modelling\Lowerlakes_PTM_Test_v5\Output_PTM\run_ptm.nc';

outdir = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\Lowerlakes\Oxydiff\';

%varname = 'WQ_DIAG_LND_SB';
varname = 'WQ_DIAG_PTM_TOTAL_MASS';
varname2 = 'WQ_DIAG_PTM_TOTAL_COUNT';


cax = [0 50000];

title = 'Ball Mass (Surface)';

% These two slow processing down. Only set to 1 if required
create_movie = 1; % 1 to save movie, 0 to just display on screen
save_images = 0;

plot_interval = 1;


shp = shaperead('MatGIS/Lowerlakes.shp');

clip_depth = 0.1;% In m
%clip_depth = 999;% In m

isTop = 1;

%____________

[ptmd,x,y,z] = tfv_readPTM(ptmfile);




if create_movie | save_images
    
    if ~exist(outdir,'dir')
        mkdir(outdir);
    end
end


if create_movie
    sim_name = [outdir,varname,'.mp4'];
    
    hvid = VideoWriter(sim_name,'MPEG-4');
    set(hvid,'Quality',100);
    set(hvid,'FrameRate',12);
    framepar.resolution = [1024,768];
    
    open(hvid);
end
%__________________


dat = tfv_readnetcdf(ncfile,'time',1);
timesteps = dat.Time;

dat = tfv_readnetcdf(ncfile,'timestep',1);
clear funcions


vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

first_plot = 1;

%[~,int] = min(abs(timesteps - datenum(2016,07,01)));

for i = 1:1:length(timesteps)%1:plot_interval:length(timesteps)
    
    tdat = tfv_readnetcdf(ncfile,'timestep',i);
    clear functions
    
    [~,int] = min(abs(ptmd.mdate - timesteps(i)));
    
    %[sx,sy] = get_ball_TS(ptmfile,int,ptmd,x,y,z);
    
    if isTop
      if strcmpi(varname,'H') == 0
        
        
        cdata1 = tdat.(varname)(tdat.idx3(tdat.idx3 > 0));
        cdata2 = tdat.(varname2)(tdat.idx3(tdat.idx3 > 0));
      else
          
        cdata = tdat.(varname);
      end
      cdata = cdata1 ./ cdata2;
    else
        
        
    
    bottom_cells(1:length(tdat.idx3)-1) = tdat.idx3(2:end) - 1;
    bottom_cells(length(tdat.idx3)) = length(tdat.idx3);
    
    cdata = tdat.(varname)(bottom_cells);
    
    end
    
    Depth = tdat.D;
    
    
    if clip_depth < 900
    
        Depth(Depth < clip_depth) = 0;
    
        cdata(Depth == 0) = NaN;
    end
    
    if strcmpi(varname,'WQ_TRC_RET') == 1
        cdata = cdata ./ 86400;
    end
    
    if first_plot
        
        hfig = figure('visible','on','position',[304         166        1271         812]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 20.32 15.24])
        
        axes('position',[0 0 1 1]);
        

        
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        mapshow(shp,'EdgeColor','k','facecolor','none');hold on
        
        
        %sc1 = scatter(sx,sy,0.25,'.' ,'b');
        
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
        
        
         xlim([296008.340924304          370529.652175978]);
         ylim([6042152.30409867          6089761.51317527]);

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
        %set(sc1,'Visible','off');
        %sc1 = scatter(sx,sy,0.25,'.' ,'b');

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