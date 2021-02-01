clear all; close all;
addpath(genpath('tuflowfv'));

ncfile = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_2_SC40_Parnka_Cell_Elevation\Output\coorong.nc';
geofile = 'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_2_SC40_Parnka_Cell_Elevation\Input\log\coorong_geo.nc';
linefile = 'GIS/Needles1.txt';

ylimit = [-3 1.5];
xlimit = [0 24]; % in km
cax = [0 150];

varname = 'SAL';

title = 'Salinity (psu)';

remove_zeroes = 1;

outdir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\013_Weir_2_SC40_Parnka_Cell_Elevation\Curtain_Needles\';

   if ~exist(outdir,'dir')
        mkdir(outdir);
    end
%__________________________________________________________________________
frames_per_second = 6; % Lowest is 6

clear hvid;
 hvid = VideoWriter([outdir,varname,'.mp4'],'MPEG-4');
    set(hvid,'Quality',100);
    set(hvid,'FrameRate',frames_per_second);
    framepar.resolution = [1024,768];
    
    open(hvid);


line = load(linefile);


dat = tfv_readnetcdf(ncfile,'time',1);
timesteps = dat.Time;

geo = tfv_readnetcdf(geofile);
[pt_id,geodata,cells_idx2] = tfv_searchnearest(line,geo);

sXX = geodata.X(1:end);
sYY = geodata.Y(1:end);


curt.dist(1:length(geodata.X)) = 0;
for ii = 1:length(geodata.X)-1
    temp_d = sqrt((sXX(ii+1)-sXX(ii)) .^2 + (sYY(ii+1) - sYY(ii)).^2);
    curt.dist(ii+1) = curt.dist(ii) + temp_d;
end

DX(:,1) = sXX;
DX(:,2) = sYY;
curt.base = geodata.Z;


inc = 1;

% Bathymetry Fills
fillX = [min(curt.dist /1000) sort(curt.dist /1000) max(curt.dist /1000)];
fillY =[-70;curt.base;-70];

for TL = 1:4:length(timesteps)
    
    data = tfv_readnetcdf(ncfile,'timestep',TL);
    
    clear functions
    %
    % Build Patch Grid_________________________________________________
    N = length(geodata.X);
    
    for n = 1 : (N - 1)
        i2 = cells_idx2(n);
        % Traditionl
        NL = data.NL(i2);
        i3 = data.idx3(i2);
        i3z = i3 + i2 -1;
        
        xv{n} = repmat([curt.dist(n);...
            curt.dist(n);...
            curt.dist(n+1);...
            curt.dist(n+1)],...
            [1 NL]);
        
        zv{n} = zeros(4,NL);
        for i = 1 : NL
            zv{n}(:,i) = [data.layerface_Z(i3z); ...
                data.layerface_Z(i3z+1); ...
                data.layerface_Z(i3z+1); ...
                data.layerface_Z(i3z)];
            i3z = i3z + 1;
        end
        
        SAL{n} = data.(varname)(i3:i3+NL-1);
    end
    
    model.x = cell2mat(xv);
    model.z = cell2mat(zv);
    
    model.SAL = cell2mat(SAL');
    
    if remove_zeroes
        model.SAL(model.SAL == 0) = NaN;
    end
    
    
    hfig = figure('position',[191 200.3 1768 721.33],'color','k');
    
    axes('position',[0.075 0.05 0.8 0.8],'color','k'); % Bottom Left
    
    P1 = patch(model.x /1000,model.z,model.SAL','edgecolor','none');hold on
    F1 = fill(fillX,fillY,[0.6 0.6 0.6]);
    
    xlim(xlimit);
    ylim(ylimit);
    xlabel('Distance(km)','fontsize',12,'FontWeight','bold','color','w');
    ylabel('Depth (mAHD)','fontsize',12,'FontWeight','bold','color','w');
    set(gca,'YColor','w','XColor','w','box','on');
    text(0.05,0.1,title,'Color','w','units','normalized','fontsize',16,'FontWeight','bold');
    
    txtDate = text(0.6,0.1,datestr(timesteps(TL),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',21,...
            'color','w');
    
    
    
    caxis(cax);
    
    cb = colorbar;
    
    set(cb,'position',[0.88 0.05 0.01 0.8],'YColor','w');
    colorTitleHandle = get(cb,'Title');
    set(colorTitleHandle ,'String','','color','w','fontsize',8);
    inc = inc + 1;
        writeVideo(hvid,getframe(hfig));

     stop   
        
    close
    
   end
 
          close(hvid);

