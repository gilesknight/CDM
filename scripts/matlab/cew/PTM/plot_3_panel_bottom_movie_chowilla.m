clear all; close all;

addpath(genpath('functions'));

ptm_nc = 'I:\GCLOUD\PTM_v2\rrResults-02\p034-chowilla-1-1\Output_1_1\run_ptm.nc';
grid_nc = 'I:\GCLOUD\PTM_v2\rrResults-02\p034-chowilla-1-1\Output_1_1\run.nc';


base = load('I:\GCLOUD\PTM_Results\Chowilla\Output_1_0\proc.mat');

comp = load('I:\GCLOUD\PTM_Results_v2\Chowilla\Output_1_1\proc.mat');

HSI = load('I:\GCLOUD\PTM_Results_v2\Chowilla\Output_1_1\proc_cyano.mat');

sag = base.data.OXY_BOT - comp.data.OXY_BOT;

shp = shaperead('MatGrids/Chowilla_Ag.shp');

sim_name = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\FINALREPORT\6.ChowillaStickynessSims\Chowilla_Oxy_Sag_3_Panel_x1_Full Domain_rerun 1 DISP NoClip.mp4';

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

hfig = figure('position',[96         341        1680         643]);




for i = 1:length(mdate)
    
    dry = find(comp.data.D(:,i) < 0.04);
    
%     sag(dry,i) = NaN;
%     HSI.data.CYANO_data(dry,i) = NaN;
    [~,ind] = min(abs(ptm_data.mdate - mdate(i)));
    
    stat2 = find(ptm_data.stat(:,ind) == 2);
    stat3 = find(ptm_data.stat(:,ind) == 3);
    
    if first_plot
        
        ax1 = axes('position',[0.05 0.05 0.3 0.9])
        
        mapshow(shp,'facecolor','none');hold on
        
        patFig0 = patch('faces',faces,'vertices',vert,'FaceVertexCData',sag(:,i));shading flat
        hold on
                caxis([0 0.3]);

        sc1 = scatter(ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),0.25,'.g');
        sc2 = scatter(ptm_data.x_raw(stat3,ind),ptm_data.y_raw(stat3,ind),0.25,'.r');
        
        
        text(0,1,'Particles (50kg)','fontsize',16,'units','normalized','horizontalalignment','left');
       
        
        
           xlim([477019.765581363          478873.453223286]);
           ylim([6224491.98703515          6227066.55320448]);

        axis off;
        
        
        
        
        %__________________________________________________________________________
        ax2 = axes('position',[0.3 0.05 0.3 0.9]);
        
        mapshow(shp,'facecolor','none');hold on
        
        
        
        
        patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',sag(:,i));shading flat
        
        
        
        
% %         set(findobj(gca,'type','surface'),...
%             'FaceLighting','phong',...
%             'AmbientStrength',.3,'DiffuseStrength',.8,...
%             'SpecularStrength',.9,'SpecularExponent',25,...
%             'BackFaceLighting','unlit');
        axis off;
        
        cb = colorbar;
        set(cb,'position',[0.6 0.2 0.01 0.4]);
        
        text(0,1,'\Delta Oxygen (mg/L)','fontsize',16,'units','normalized','horizontalalignment','left');
        
           xlim([477019.765581363          478873.453223286]);
           ylim([6224491.98703515          6227066.55320448]);

        caxis([0 0.3]);
        
        
        %__________________________________________________________________________
        ax3 = axes('position',[0.6 0.05 0.3 0.9]);
        
        mapshow(shp,'facecolor','none');hold on
        
        
        patFig2 = patch('faces',faces,'vertices',vert,'FaceVertexCData',HSI.data.CYANO_data(:,i));shading flat
        
        
        
%         set(findobj(gca,'type','surface'),...
%             'FaceLighting','phong',...
%             'AmbientStrength',.3,'DiffuseStrength',.8,...
%             'SpecularStrength',.9,'SpecularExponent',25,...
%             'BackFaceLighting','unlit');
        
        caxis([0 1]);
%         
           xlim([477019.765581363          478873.453223286]);
           ylim([6224491.98703515          6227066.55320448]);
         text(0,1,'HSI Index','fontsize',16,'units','normalized','horizontalalignment','left');

        cb = colorbar;
        set(cb,'position',[0.9 0.2 0.01 0.4]);
        
        axis off;
        
        first_plot = 0;
        
        tx = text(0,0,datestr(mdate(i),'dd-mm-yyyy HH:MM'),'fontsize',21,'fontweight','bold','units','normalized');
        
        
    else

        
        set(sc1,'Visible','off');
        set(sc2,'Visible','off');
        
        sc1 = scatter(ax1,ptm_data.x_raw(stat2,ind),ptm_data.y_raw(stat2,ind),0.25,'.g');
        sc2 = scatter(ax1,ptm_data.x_raw(stat3,ind),ptm_data.y_raw(stat3,ind),0.25,'.r');
        
        set(patFig0,'Cdata',sag(:,i));
        drawnow;        

        set(patFig1,'Cdata',sag(:,i));
        drawnow;
        

        set(patFig2,'Cdata',HSI.data.CYANO_data(:,i));
        drawnow;
        
        set(tx,'String',datestr(mdate(i),'dd-mm-yyyy HH:MM'));
        
    end
    
    
    
    
        writeVideo(hvid,getframe(hfig));

    
    
    
end

close(hvid);


