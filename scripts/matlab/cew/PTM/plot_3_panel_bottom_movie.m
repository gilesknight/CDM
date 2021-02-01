clear all; close all;

addpath(genpath('functions'));

ptm_nc = 'I:\GCLOUD\PTM_Results\Murray\Output_1_1\run_ptm.nc';
grid_nc = 'I:\GCLOUD\PTM_Results\Murray\Output_1_1\run.nc';


base = load('I:\GCLOUD\PTM_Results\Murray\Output_1_0\proc.mat');

comp = load('I:\GCLOUD\PTM_Results\Murray\Output_1_1\proc.mat');

HSI = load('I:\GCLOUD\PTM_Results\Murray\Output_1_1\proc_cyano.mat');

sag = base.data.OXY_BOT - comp.data.OXY_BOT;

shp = shaperead('MatGrids/Murray_Ag.shp');

sim_name = 'I:\GCLOUD\Report Images\Murray_Oxy_Sag_3_Panel_x1_11.mp4';

hvid = VideoWriter(sim_name,'MPEG-4');
set(hvid,'Quality',100);
set(hvid,'FrameRate',6);
framepar.resolution = [1024,768];

open(hvid);






mdate = base.data.tdate;


[ptm_data,x,y,z] = tfv_readPTM(ptm_nc);


dat = tfv_readnetcdf(grid_nc,'timestep',1);

vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);




first_plot = 1;

hfig = figure('position',[535.6 605 1676 670]);




for i = 1:length(mdate)
    [~,ind] = min(abs(ptm_data.mdate - mdate(i)));
    
    stat2 = find(ptm_data.stat(:,ind) == 2);
    stat3 = find(ptm_data.stat(:,ind) == 3);
    if first_plot
        
        ax1 = axes('position',[0.05 0.05 0.3 0.9])
        
        mapshow(shp,'facecolor','none');hold on
        
        
        
        sc1 = scatter(ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),0.25,'.b');
        sc2 = scatter(ptm_data.x_raw(stat3,ind),ptm_data.y_raw(stat3,ind),0.25,'.b');
       
        
        text(0,0.8,'Particles (50kg)','fontsize',16,'units','normalized','horizontalalignment','left');
       
        
        
        xlim([353942.743609022          378473.130349353]);
        ylim([6127303.24809411          6176364.02157477]);
        axis off;
        
        
        %__________________________________________________________________________
        ax2 = axes('position',[0.3 0.05 0.3 0.9])
        
        mapshow(shp,'facecolor','none');hold on
        
        
        patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',sag(:,i));shading flat
        
        
        
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        axis off;
        
        cb = colorbar;
        set(cb,'position',[0.6 0.2 0.01 0.4]);
        
        text(0,0.8,'\Delta Oxygen (mg/L)','fontsize',16,'units','normalized','horizontalalignment','left');
        
        xlim([353942.743609022          378473.130349353]);
        ylim([6127303.24809411          6176364.02157477]);
        caxis([0 0.3]);
        
        
        %__________________________________________________________________________
        ax3 = axes('position',[0.6 0.05 0.3 0.9])
        
        mapshow(shp,'facecolor','none');hold on
        
        
        patFig2 = patch('faces',faces,'vertices',vert,'FaceVertexCData',HSI.data.CYANO_data(:,i));shading flat
        
        
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        caxis([0 1]);
        
        xlim([353942.743609022          378473.130349353]);
        ylim([6127303.24809411          6176364.02157477]);
         text(0,0.8,'HSI Index','fontsize',16,'units','normalized','horizontalalignment','left');

        cb = colorbar;
        set(cb,'position',[0.9 0.2 0.01 0.4]);
        
        axis off;
        
        first_plot = 0;
        
        tx = text(0,0,datestr(mdate(i),'dd-mm-yyyy HH:MM'),'fontsize',21,'fontweight','bold','units','normalized');
    else

        
        set(sc1,'Visible','off');
        set(sc2,'Visible','off');
     
        sc1 = scatter(ax1,ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),0.25,'.b');
        sc2 = scatter(ax1,ptm_data.x_raw(stat3,ind),ptm_data.y_raw(stat3,ind),0.25,'.b');        
        

        set(patFig1,'Cdata',sag(:,i));
        drawnow;
        

        set(patFig2,'Cdata',HSI.data.CYANO_data(:,i));
        drawnow;
        
        set(tx,'String',datestr(mdate(i),'dd-mm-yyyy HH:MM'));
        
    end
    
    
    
    
        writeVideo(hvid,getframe(hfig));

    
    
    
end

close(hvid);


