clear all; close all;

addpath(genpath('functions'));

ptm_nc = 'G:\Balls\Output_2_2\run_ptm.nc';
grid_nc = 'G:\Balls\Output_2_2\run.nc';

% 
 base = load('G:\Balls\Output_2_2\proc_multi.mat');
% 
comp = load('G:\Balls\Output_1_1\proc_multi.mat');

HSI = load('G:\Balls\Output_2_2\proc_cyano.mat');

sag = base.data.OXY_BOT - comp.data.OXY_BOT;

shp = shaperead('MatGrids/Lowerlakes_Ag.shp');

sim_name = 'G:\Output_2_2\Lowerlakes_Oxy_Sag_3_Panel_Update.mp4';

img_dir = 'G:\Balls\Images\';

hvid = VideoWriter(sim_name,'MPEG-4');
set(hvid,'Quality',100);
set(hvid,'FrameRate',6);
framepar.resolution = [1024,768];

open(hvid);


sz = 20



mdate = base.data.tdate;


[ptm_data,x,y,z] = tfv_readPTM(ptm_nc);


dat = tfv_readnetcdf(grid_nc,'timestep',1);

vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);




first_plot = 1;

hfig = figure('position',[1949         217        1111         645]);




for i = 1:length(mdate)
    [~,ind] = min(abs(ptm_data.mdate - mdate(i)));
    
    
    %ptm_data.stat(100:end,ind) = -1;
    
    stat = find(ptm_data.stat(:,ind) == 2);
    stat2 = find(ptm_data.stat(:,ind) == 3);   
    
    if first_plot
        
        ax1 = axes('position',[0.05 0.05 0.45 0.9])
        
        mapshow(shp,'facecolor','none');hold on
        
        
        
        sc1 = scatter(ptm_data.x_raw(stat,ind),ptm_data.y_raw(stat,ind),sz,'.b');
        sc2 = scatter(ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),sz,'.r');
        
        
        text(0.2,1,'Particles','fontsize',12,'units','normalized','horizontalalignment','left');
       
        
        
        xlim([354887.792735472          386787.184983702]);
        ylim([5989066.94838915          6027346.21908703]);
        axis off;
        
        
        %__________________________________________________________________________
        ax2 = axes('position',[0.55 0.05 0.45 0.9])
        
        mapshow(shp,'facecolor','none');hold on
        
        
        patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',sag(:,i));shading flat
        
        
        
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        axis off;
        
        cb = colorbar;
        set(cb,'position',[0.57 0.2 0.01 0.4]);
        
        text(0.2,1,'\Delta Oxygen (mg/L)','fontsize',12,'units','normalized','horizontalalignment','left');
        
        xlim([354887.792735472          386787.184983702]);
        ylim([5989066.94838915          6027346.21908703]);

        caxis([0 0.3]);
        
        
        %__________________________________________________________________________
%         ax3 = axes('position',[0.6 0.05 0.3 0.9])
%         
%         mapshow(shp,'facecolor','none');hold on
%         
%         
%         patFig2 = patch('faces',faces,'vertices',vert,'FaceVertexCData',HSI.data.CYANO_data(:,i));shading flat
%         
%         
%         
%         set(findobj(gca,'type','surface'),...
%             'FaceLighting','phong',...
%             'AmbientStrength',.3,'DiffuseStrength',.8,...
%             'SpecularStrength',.9,'SpecularExponent',25,...
%             'BackFaceLighting','unlit');
%         
%         caxis([0 1]);
% %         
%         xlim([354887.792735472          386787.184983702]);
%         ylim([5989066.94838915          6027346.21908703]);
% 
%          text(0,1,'HSI Index','fontsize',16,'units','normalized','horizontalalignment','left');
% 
%         cb = colorbar;
%         set(cb,'position',[0.87 0.2 0.01 0.4]);
%         
%         axis off;
%         
        first_plot = 0;
        
        tx = text(0,0,datestr(mdate(i),'dd-mm-yyyy HH:MM'),'fontsize',14,'fontweight','bold','units','normalized');
    else

        
        set(sc1,'Visible','off');
        set(sc2,'Visible','off');
        
        sc1 = scatter(ax1,ptm_data.x_raw(stat,ind),ptm_data.y_raw(stat,ind),sz,'.b');
        sc2 = scatter(ax1,ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),sz,'.r');        
        

        set(patFig1,'Cdata',sag(:,i));
        drawnow;
        

%         set(patFig2,'Cdata',HSI.data.CYANO_data(:,i));
%         drawnow;
        
        set(tx,'String',datestr(mdate(i),'dd-mm-yyyy HH:MM'));
        
    end
    
    
        filename = [img_dir,datestr(mdate(i),'yyyymmdd_HHMM'),'.png'];
    
        saveas(gcf,filename);
        
        writeVideo(hvid,getframe(hfig));

    
    
    
end

close(hvid);


