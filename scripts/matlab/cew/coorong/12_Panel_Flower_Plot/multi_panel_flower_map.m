clear all; close all;

basedir = 'Y:\Coorong Report\Process_Final\';
outdir = 'Y:\Coorong Report\Seasonal_Averages\';

shp = shaperead('Bound.shp');


base_caxis = [0.3 1];

leg_text = 'Adult';
filename = 'Adult_12_panel.png';

theorder = {...
    'ORH_Base_20140101_20170101',...
    'ORH_Base_FSED2_20140101_20170101',...
    'ORH_SLR_02_20140101_20170101',...
    'ORH_Base_3D_20140101_20170101',...
    %     'Sprout',...
    %     'HSI',...
    %     'SC40_NUT_1_5_20140101_20170101',...
    %     'SC40_NUT_2_0_20140101_20170101',...
    };

thenames = {...
    'ORH',...
    'FSED 2',...
    'SLR',...
    'MPB 2000',...
    %     'Sprout',...
    %     'HSI',...
    %     'SC40 NUT1.5',...
    %     'SC40 NUT2.0',...
    };



if ~exist(outdir,'dir')
    mkdir(outdir);
end

[XX,YY,ZZ,nodeID,faces,cellX,cellY,Z,ID,MAT,cellArea] = tfv_get_node_from_2dm('014_Coorong_Salt_Crk_Mouth_Channel_MZ3_Culverts.2dm');


for i = 1:length(theorder)
    % basedata.Adult = load('Y:\Coorong Report\Ruppia_Life_Stages\ORH_Base_20140101_20170101\Sheets\2014\1_adult_new\HSI_adult.mat');
   % basedata.(theorder{i}) = load(['Y:\Coorong Report\Ruppia_Life_Stages\',theorder{i},'\Sheets\2014\2_flower_new\HSI_flower.mat']);
    basedata.(theorder{i}) = load(['Y:\Coorong Report\Ruppia_Life_Stages\',theorder{i},'\Sheets\2014\1_adult_new\HSI_adult.mat']);
    basedata.(theorder{i}).min_cdata(basedata.(theorder{i}).min_cdata < base_caxis(1)) = NaN;
end


ax(1).pos = [0.00 0.7 0.25 0.3];
ax(2).pos = [0.25 0.7 0.25 0.3];
ax(3).pos = [0.50 0.7 0.25 0.3];
ax(4).pos = [0.75 0.7 0.25 0.3];

ax(5).pos = [0.00 0.4 0.25 0.3];
ax(6).pos = [0.25 0.4 0.25 0.3];
ax(7).pos = [0.50 0.4 0.25 0.3];
ax(8).pos = [0.75 0.4 0.25 0.3];

ax(9).pos = [0.00 0.1 0.25 0.3];
ax(10).pos = [0.25 0.1 0.25 0.3];
ax(11).pos = [0.50 0.1 0.25 0.3];
ax(12).pos = [0.75 0.1 0.25 0.3];

xl(1).x = [318447.265919283          335788.512962594];
xl(1).y = [6041100.9795706          6060405.60848255];
xl(2).x = [349558.910500454          363787.626023169];
xl(2).y = [6019614.70539634          6035454.40091383];
xl(3).x = [365368.59082871          379597.306351425];
xl(3).y = [5998775.14825501           6014614.8437725];

locs = 3;
mods = 4;
int = 1;

loctext = {'North Coorong';'Parnka Point';'South Coorong'};

figure('position',[1000.33333333333          194.333333333333                      1264          1143.33333333333]);

for i = 1:locs
    for j = 1:mods
        axes('position',ax(int).pos);
        text(0.05,0.1,loctext{i},'units','normalized','fontsize',14,'fontweight','bold');
       
        patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',basedata.(theorder{j}).min_cdata);shading flat
        set(gca,'box','on');hold on
        %     if themonths(i).year(1) > 1995
        mapshow(shp,'facecolor','none','edgecolor','k');
        %     else
        %         mapshow(pre,'facecolor','none','edgecolor','k');
        %     end
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        axis equal
        
        %     map = flipud(parula);
        %
        %     colormap(patFig,map);
        
        xlim(xl(i).x);
        ylim(xl(i).y);
        
        caxis(base_caxis);
        
        plot_box(xl(i).x,xl(i).y)
        
        %colorbar
        
        axis off;
        
        if int > 8
              text(0.05,-0.075,thenames{j},'units','normalized','fontsize',14,'fontweight','bold');
        end

        if int == 12
            cb = colorbar('location','southoutside');
        set(cb,'position',[0.35 0.025 0.3 0.01]);

        title(cb,leg_text,'fontsize',12,'fontweight','bold');
        end
        
        int = int + 1;
    end
end

saveas(gcf,filename);
        
        
        
        
        
