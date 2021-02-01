clear all; close all;

addpath(genpath('functions'));


ncfile = 'I:\GCLOUD\PTM_Results_v2\Chowilla\Output_1_2\run_PTM.nc';


[data,x,y,z] = tfv_readPTM(ncfile);

%ss = find(data.stat == 2);

% X = double(data.x_raw);
% Y = double(data.y_raw);
% Z = double(data.z_raw);

shp = shaperead('Grids/Chowilla.shp');


%axis equal

time = data.Time./24 + datenum(1990,01,01);

%time = time - time(1);

% 

% xx = data.x_raw;
% yy = data.y_raw;
% zz = data.z_raw;




% xxx = (X .*x_scalevalue)+  init_x;%  ;
% yyy = (Y .*y_scalevalue) + init_y;% ;





first = 1;

sim_name = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\FINALREPORT\6.ChowillaStickynessSims\Chowilla_MR3_v2_F1_B2.mp4';


hvid = VideoWriter(sim_name,'MPEG-4');
set(hvid,'Quality',100);
set(hvid,'FrameRate',6);
framepar.resolution = [1024,768];

open(hvid);

sss = find(time < 14);

for i = 1:3:length(time)
    
    dat = tfv_readnetcdf(ncfile,'timestep',i);
    
    dat.x = double(dat.x);
    dat.y = double(dat.y);
    dat.z = double(dat.z);
    
    init_x = 368823.0;
    init_y = 6180880.0;
    
    x_offset = x.add_offset;
    y_offset = y.add_offset;
    z_offset = z.add_offset;

    x_fillvalue = x.fill_value;
    y_fillvalue = y.fill_value;
    z_fillvalue = z.fill_value;

    dat.x(dat.x == x_fillvalue) = NaN;
    dat.y(dat.y == y_fillvalue) = NaN;

    x_scalevalue = x.scale_factor;
    y_scalevalue = y.scale_factor;
    z_scalevalue = z.scale_factor;

    xx = (dat.x .*x_scalevalue)+  x_offset;%  ;
    yy = (dat.y .*y_scalevalue) + y_offset;% ;
    zz = (dat.z .*z_scalevalue) + z_offset;%  ;
    
    
    sx = xx(:);
    sy = yy(:);
    
    %inpol = inpolygon(sx,sy,shp.X,shp.Y);
    
    ss = find(dat.stat > 0);
    
    if first
 %       hfig = figure('position',[1013          618.333333333333          778.666666666667          532.666666666667]);
        hfig = figure('position',[605         219        1029         732]);
        
        
        mapshow(shp,'facecolor','none');hold on
        
        %mapshow background.png; hold on
        
        
        axis off;
        axis equal;
        %scatter(x_offset,y_offset,'facecolor','r');
        %scatter(x_offset+(X(ss(1))*x_scalevalue),y_offset+(Y(ss(1))*y_scalevalue) ,'facecolor','b');
        sc1 = scatter(sx(ss),sy(ss),'.' ,'b');
        
        %sc2 = scatter(xx(ss,i),yy(ss,i),'.' ,'r');
        
        legend({'Travelling';'Deposited'});
        
        %scatter(368823.0,6180880.0,'*r');
        
        
        
           xlim([477090.153577231          478846.161917798]);
           ylim([6225365.59822347          6226678.81833356]);
%           xlim([294371.429868364          359568.887501585]);
%           ylim([6046240.25400512          6094997.77440646]);

        



        first = 0;
        
        txtDate = text(0.5,0.1,['Simulation Days ',datestr(time(i),'dd/mm HH:MM')],...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',21,...
            'color','k');
        
        
    else
        set(sc1,'Visible','off');
        %set(sc2,'Visible','off');
        
        sc1 = scatter(sx(ss),sy(ss),'.' ,'b');
        
        %sc2 = scatter(xx(ss,i),yy(ss,i),'.' ,'r');
        set(txtDate,'String',['Simulation Days ',datestr(time(i),'dd/mm HH:MM')]);
        
        
    end
    
    writeVideo(hvid,getframe(hfig));
    
end

close(hvid);


% figure
% for i = 1:size(zz,1)
% plot(time,data.stat(i,:))
% datetick('x');hold on
% ylim([-2 4])
% scatter(time,data.stat(i,:),'.');
% end
% title('Stat for Fishball 1');
%
% figure
%
% for i = 1:100;size(zz,1)
%
% plot(time,zz(i,:));
% datetick('x');hold on
% ylim([-4 0])
% scatter(time,zz(i,:),'.');
% end
% title('Z for Fishball 1');

