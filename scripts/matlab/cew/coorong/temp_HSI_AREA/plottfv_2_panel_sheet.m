clear all; close all;

addpath(genpath('tuflowfv'));

ncfile1 = 'I:\Lowerlakes\Coorong Weir Simulations\012_Weir_1_SC40_Needles\Output\coorong.nc';

ncfile2 = 'I:\Lowerlakes\Coorong Weir Simulations\012_Weir_3_SC40_noWeir\Output\coorong.nc';


outdir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\012_ORH_2014_2016_1\Sheets_Needles\';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

varname = 'TRACE_1';

cax = [0 1];

title = 'Barrage Tracer';

shp = shaperead('Matfiles/Coorong_Boundary1.shp');


remove_zeroes = 1;

mod1 = 'Needles';
mod2 = 'No Weir';

sim_name = [outdir,varname,'.mp4'];

hvid = VideoWriter(sim_name,'MPEG-4');
set(hvid,'Quality',100);
set(hvid,'FrameRate',8);
framepar.resolution = [1024,768];

open(hvid);





dat = tfv_readnetcdf(ncfile1,'time',1);
timesteps1 = dat.Time;

dat = tfv_readnetcdf(ncfile2,'time',1);
timesteps2 = dat.Time;

dat = tfv_readnetcdf(ncfile1,'timestep',1);
clear funcions

% Height plot stuff.
ndat =  tfv_readnetcdf(ncfile1,'names',{'H'});

North(1,1) = 349814.0;
North(1,2) = 6033712.0;

South(1,1) = 355755.7;
South(1,2) = 6025571.1;


geo_x = double(dat.cell_X);
geo_y = double(dat.cell_Y);
dtri = DelaunayTri(geo_x,geo_y);


nID = nearestNeighbor(dtri,North);
sID = nearestNeighbor(dtri,South);

nH = ndat.H(nID,:);
sH = ndat.H(sID,:);

dH = nH - sH;


vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';
%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

first_plot = 1;

for i = 1:1:length(timesteps1)
    
    tdat1 = tfv_readnetcdf(ncfile1,'timestep',i);
    clear functions
    
    [~,ind] = min(abs(timesteps2 - timesteps1(i)));
    
    tdat2 = tfv_readnetcdf(ncfile2,'timestep',ind);
    clear functions
    
    cdata1 = tdat1.(varname)(tdat1.idx3(tdat1.idx3 > 0));
    cdata2 = tdat2.(varname)(tdat2.idx3(tdat2.idx3 > 0));
    
     clear functions
   
    if remove_zeroes
        cdata1(cdata1 == 0) = NaN;
        cdata2(cdata2 == 0) = NaN;
    end
    
    
    if first_plot
        
        hfig = figure('visible','on','position',[304         166        1271         812]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 20.32 15.24])
        
        axes('position',[0  0 .5 1]);
        
        patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata1);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
                mapshow(shp,'EdgeColor','k','facecolor','none');hold on

        caxis(cax);
        
        cb = colorbar;
        axis off
        axis equal
        set(cb,'position',[0.45 0.3 0.01 0.25],...
            'units','normalized','ycolor','k');
        
        
        text(0.1,0.9,title,...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
  
        
         text(0.1,0.5,mod1,...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
        
        
        axes('position',[0.1 0.2 0.3 0.1]);
        
        nP = plot(timesteps1,dH,'k');hold on
        nT = plot([timesteps1(i) timesteps1(i)],[-2 2],'--r');
        
        datearray = min(timesteps1):(max(timesteps1)-min(timesteps1))/5:max(timesteps1);
        
        set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'mm-yy'),'fontsize',6);
        
        ylim([-1 1]);
        
        xlim([min(timesteps1) max(timesteps1)]);
        
        ylabel('Height (mAHD)','fontsize',6);
        text(0.1,1.1,'Height Difference (North - South)','fontsize',7,'units','normalized');
        %____________________________________
        
 %       axes('position',[0.7 0.2 0.2 0.1]);
        
%         sP = plot(timesteps1,sH,'k');hold on
%         sT = plot([timesteps1(i) timesteps1(i)],[-2 2],'--r');
%         
%         datearray = min(timesteps1):(max(timesteps1)-min(timesteps1))/5:max(timesteps1);
%         
%         set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'mm-yy'),'fontsize',6);
%         
%         ylim([-1 1.5]);
%         
%         xlim([min(timesteps1) max(timesteps1)]);
%         
%         ylabel('Height (mAHD)','fontsize',6);
%         text(0.1,1.1,'South of Weir','fontsize',7,'units','normalized');
        %____________________________________
        
        
        
        
        axes('position',[0.5  0 .5 1]);
        
        patFig2 = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata2);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
                mapshow(shp,'EdgeColor','k','facecolor','none');hold on

        caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.95 0.3 0.01 0.25],...
            'units','normalized','ycolor','k');
        
        axis off
        axis equal
        
        
        
        
        txtDate = text(0.1,0.9,datestr(timesteps1(i),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'color','k');
        
        text(0.1,0.5,mod2,...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
        first_plot = 0;
    else
        
        set(patFig1,'Cdata',cdata1);
        set(patFig2,'Cdata',cdata2);
        
        drawnow;
        
        set(txtDate,'String',datestr(timesteps1(i),'dd mmm yyyy HH:MM'));
        
        caxis(cax);
        
        %____________________________________________
        
        set(nP,'Visible','off');
        set(nT,'Visible','off');
%          set(sP,'Visible','off');
%         set(sT,'Visible','off');
        
        axes('position',[0.1 0.2 0.3 0.1]);
        
        nP = plot(timesteps1,dH,'k');hold on
        nT = plot([timesteps1(i) timesteps1(i)],[-2 2],'--r');
        
        datearray = min(timesteps1):(max(timesteps1)-min(timesteps1))/5:max(timesteps1);
        
        set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'mm-yy'),'fontsize',6);
        
        ylim([-1 1]);
        
        xlim([min(timesteps1) max(timesteps1)]);
        
        ylabel('Height (mAHD)','fontsize',6);
        text(0.1,1.1,'Height Difference (North - South)','fontsize',7,'units','normalized');

        %____________________________________
        
%         axes('position',[0.7 0.2 0.2 0.1]);
%         
%         sP = plot(timesteps1,sH,'k');hold on
%         sT = plot([timesteps1(i) timesteps1(i)],[-2 2],'--r');
%         
%         datearray = min(timesteps1):(max(timesteps1)-min(timesteps1))/5:max(timesteps1);
%         
%         set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'mm-yy'),'fontsize',6);
%         
%         ylim([-1 1.5]);
%         
%         xlim([min(timesteps1) max(timesteps1)]);
%         
%         ylabel('Height (mAHD)','fontsize',6);
%         text(0.1,1.1,'South of Weir','fontsize',7,'units','normalized');

        
        
        
        
        
        
        
        
        
        
        
    end
    writeVideo(hvid,getframe(hfig));
end

close(hvid);

