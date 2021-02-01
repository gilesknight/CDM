%function seasonal_averages_v2(var,base_caxis,conv)
clear all; close all;
basedir = 'Y:\Coorong Report\Process_Final\';
outdir = 'Y:\Coorong Report\Seasonal_Averages\';
scenlist = dir(basedir);

shp = shaperead('Bound.shp');
% pre = shaperead('Per_Cut.shp');

cut = shaperead('GIS\Cut.shp');
var = 'WQ_OXY_OXY';

conv = 32/1000;

base1 = 'ORH_Base_20140101_20170101';

scen_name = 'MPB_Summer_DO';

% del_caxis = [-2 2];
% del_clip = [-0.5 0.5];

%base_caxis = [0 2];
base_caxis = [0 12];
del_caxis = [-2 2];
del_clip = [-0.1 0.1];

time_offset = 0.0;

do_daily = 0;
do_crit = 0; %Only for oxygen;
do_delDO = 0;

% base_caxis = [0 0.5];
%
% del_caxis = [-0.1 0.1];
% del_clip = [-0.01 0.01];
depth = 'Bot';

themonths(1).val = [12 2];
themonths(1).year = [2014 2015];
themonths(2).val = [12 2];
themonths(2).year = [2014 2015];
% themonths(3).val = [9 11];
% themonths(3).year = [2014 2014];
% themonths(4).val = [9 11];
% themonths(4).year = [2014 2014];
% themonths(5).val = [9 11];
% themonths(5).year = [2014 2014];
% themonths(6).val = [9 11];
% themonths(6).year = [2014 2014];
% themonths(7).val = [9 11];
% themonths(7).year = [2014 2014];
% themonths(8).val = [9 11];
% themonths(8).year = [2014 2014];

pos(1).a = [0.00 0.1 0.5 0.8];
pos(2).a = [0.5 0.1 0.5 0.8];
% pos(3).a = [0.66 0.1 0.33 0.8];
% pos(4).a = [0.75 0.55 0.25 0.4];
%
% pos(5).a = [0.00 0.1 0.25 0.4];
% pos(6).a = [0.25 0.1 0.25 0.4];
% pos(7).a = [0.50 0.1 0.25 0.4];
% pos(8).a = [0.75 0.1 0.25 0.4];


pos(1).b = [-0.05  0.15 0.4 0.4];
pos(2).b = [0.45 0.15 0.4 0.4];
% pos(3).b = [0.56 0.15 0.4 0.4];
% pos(4).b = [0.75 0.55 0.2 0.2];
%
% pos(5).b = [0.00 0.1 0.2 0.2];
% pos(6).b = [0.25 0.1 0.2 0.2];
% pos(7).b = [0.50 0.1 0.2 0.2];
% pos(8).b = [0.75 0.1 0.2 0.2];






theorder = {...
    'ORH_Base_20140101_20170101',...
    'ORH_Base_3D_20140101_20170101',...
    %     'ORH_Base_FSED2_20140101_20170101',...
    %     'ORH_Base_FSED2_20140101_20170101',...
    %     'ORH_SLR_02_20140101_20170101',...
    %     'SC40_Base_20140101_20170101',...
    %     'SC40_NUT_1_5_20140101_20170101',...
    %     'SC40_NUT_2_0_20140101_20170101',...
    };

thenames = {...
    'ORH',...
    'MPB 2000',...
    %     'FSED 2',...
    %     'FSED 2',...
    %     'SLR 0.2',...
    %     'SC40',...
    %     'SC40 NUT1.5',...
    %     'SC40 NUT2.0',...
    };



if ~exist(outdir,'dir')
    mkdir(outdir);
end


datetext = [num2str(themonths(1).year(1)),'-',num2str(themonths(1).val(1)),'_',num2str(themonths(1).year(2)),'-',num2str(themonths(1).val(2))];


[XX,YY,ZZ,nodeID,faces,cellX,cellY,Z,ID,MAT,cellArea] = tfv_get_node_from_2dm('014_Coorong_Salt_Crk_Mouth_Channel_MZ3_Culverts.2dm');

inpol = inpolygon(cellX,cellY,cut.X,cut.Y);


for i = 1:length(theorder)
    
    switch var
        case 'DIN'
        AMM = load([basedir,theorder{i},'\','WQ_NIT_AMM','.mat']);
        NIT = load([basedir,theorder{i},'\','WQ_NIT_NIT','.mat']);
        
        outdata.(theorder{i}) = AMM;
        outdata.(theorder{i}).savedata.DIN.Bot = AMM.savedata.WQ_NIT_AMM.Bot + NIT.savedata.WQ_NIT_NIT.Bot;
        
        clear AMM NIT;
        case 'DIP'
        FRP = load([basedir,theorder{i},'\','WQ_PHS_FRP','.mat']);
        %ADS = load([basedir,theorder{i},'\','WQ_PHS_FRP_ADS','.mat']);
        
        outdata.(theorder{i}) = FRP;
        outdata.(theorder{i}).savedata.DIP.Bot = FRP.savedata.WQ_PHS_FRP.Bot;% + ADS.savedata.WQ_PHS_FRP_ADS.Bot;
        
        clear AMM NIT;
        otherwise
            outdata.(theorder{i}) = load([basedir,theorder{i},'\',var,'.mat']);
    end
end

%%
if strcmpi(var,'WQ_OXY_OXY') == 0
    do_crit = 0;
end



scen = fieldnames(outdata);

figure('position',[594.333333333333          546.333333333333          1171.33333333333          704.666666666667]);



for i = 1:length(theorder)
    
    theday = eomday(themonths(i).year(2),themonths(i).val(2));
    
    sss = find(outdata.(theorder{i}).savedata.Time >= datenum(themonths(i).year(1),themonths(i).val(1),01,00,00,00) & ...
        outdata.(theorder{i}).savedata.Time <= datenum(themonths(i).year(2),themonths(i).val(2),theday,23,59,59));
    
    if strcmpi(var,'WQ_OXY_OXY') == 1 & do_delDO == 1
       % delmap.raw.(theorder{i}) = calc_crit(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),conv);
        delmap.raw.(theorder{i}) = calc_delDO(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),conv,outdata.(theorder{i}).savedata.Time(sss));
    else
        if ~do_daily
            delmap.raw.(theorder{i}) = mean(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),2) * conv;
        else
            utime = unique(floor(outdata.(theorder{i}).savedata.Time(sss)));
            for ngb = 1:length(utime)
                [~,tind] = min(abs(outdata.(theorder{i}).savedata.Time - (utime(ngb)+time_offset)));
                scratch(:,ngb) = outdata.(theorder{i}).savedata.(var).(depth)(:,tind);
            end
            delmap.raw.(theorder{i}) = mean(scratch,2) * conv;
            clear scratch;
        end
        
    end
    
    if themonths(i).year(1) < 1995
        delmap.raw.(theorder{i})(inpol) = NaN;
    end
    
    
    %delmap.raw.(theorder{i})
    %subplot(2,4,i)
    axes('position',pos(i).a)
    
    tx = regexprep(theorder{i},'_',' ');
    tx = regexprep(tx,'run scenario ','');
    
    text(0.65,0.95,thenames{i},'units','normalized','fontsize',14,'fontweight','bold');
    
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap.raw.(theorder{i}));shading flat
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
    
    xlim([317036.905847561          381330.704568632]);
    ylim([ 5982900.42419779          6054473.58860457]);
    
    caxis(base_caxis);
    
    %colorbar
    
    axis off;
    
    
    
    plot_box;
    plot_box2;
    
    %____________
    
    axes('position',pos(i).b,'color',[0.7 0.7 0.7])
    text(0.6,0.95,'Salt Creek','units','normalized','fontsize',10,'fontweight','bold');
    
    %     sss = find(theDel >= del_clip(1) & ...
    %         theDel <= del_clip(2));
    %     theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap.raw.(theorder{i}));shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
    %     map = flipud(parula);
    %
    %     colormap(patFig,map);
    
    xlim([377272.523852488          378711.341991304]);
    ylim([6000098.54304419          6001700.26466042]);
    
    caxis(base_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box2;
    %
    if i == 2
        cb = colorbar('location','southoutside');
        set(cb,'position',[0.35 0.05 0.3 0.01]);
        
    end
    
    
end

if ~do_crit
    saveas(gcf,[outdir,scen_name,'_',var,'_',depth,'_',datetext,'_raw.png']);close;
else
    saveas(gcf,[outdir,scen_name,'_','Oxy_Crit','_',depth,'_',datetext,'_raw.png']);close;
end

%%
%


figure('position',[594.333333333333          546.333333333333          1171.33333333333          704.666666666667]);

newmap = blank_col(del_caxis,del_clip);
colormap(newmap);
for i = 1:length(theorder)
    
    
    theDel = delmap.raw.(theorder{i}) - delmap.raw.(base1);
    
    
    %subplot(2,4,i)
    axes('position',pos(i).a)
    
    tx = regexprep(theorder{i},'_',' ');
    tx = regexprep(tx,'run scenario ','');
    
    text(0.65,0.95,thenames{i},'units','normalized','fontsize',14,'fontweight','bold');
    
    sss = find(theDel >= del_clip(1) & ...
        theDel <= del_clip(2));
    theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
    %     map = flipud(parula);
    %
    %     colormap(patFig,map);
    
    xlim([317036.905847561          381330.704568632]);
    ylim([ 5982900.42419779          6054473.58860457]);
    caxis(del_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box;
    %plot_box2;
    
    %____________
    
    axes('position',pos(i).b,'color',[0.7 0.7 0.7])
    text(0.6,0.95,'Salt Creek','units','normalized','fontsize',10,'fontweight','bold');
    
    sss = find(theDel >= del_clip(1) & ...
        theDel <= del_clip(2));
    theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
    %     map = flipud(parula);
    %
    %     colormap(patFig,map);
    
    xlim([377272.523852488          378711.341991304]);
    ylim([6000098.54304419          6001700.26466042]);
    
    caxis(del_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box2;
    %
    if i == 2
        cb = colorbar('location','southoutside');
        set(cb,'position',[0.35 0.05 0.3 0.01]);
        %
    end
end

if ~do_crit
    saveas(gcf,[outdir,scen_name,'_',var,'_',depth,'_',datetext,'_delMap_minus_',base1,'.png']);close;
    
else
    saveas(gcf,[outdir,scen_name,'_','Oxy_Crit','_',depth,'_',datetext,'_delMap_minus_',base1,'.png']);close;
end

%
% %%
%
%
%
% figure('position',[750.333333333333                        99          1573.33333333333          1094.66666666667]);
%
% newmap = blank_col(del_caxis,del_clip);
% colormap(newmap);
% for i = 1:length(theorder)
%
%
%     theDel = delmap.raw.(theorder{i}) - delmap.raw.(base2);
%
%
%     %subplot(2,4,i)
%     axes('position',pos(i).a)
%
%     tx = regexprep(theorder{i},'_',' ');
%     tx = regexprep(tx,'run scenario ','');
%
%     text(0.75,0.95,thenames{i},'units','normalized','fontsize',14,'fontweight','bold');
%
%     sss = find(theDel >= del_clip(1) & ...
%         theDel <= del_clip(2));
%     theDel(sss) = NaN;
%
%     patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
%     set(gca,'box','on');hold on
%
%     mapshow(shp,'facecolor','none','edgecolor','k')
%
%     set(findobj(gca,'type','surface'),...
%         'FaceLighting','phong',...
%         'AmbientStrength',.3,'DiffuseStrength',.8,...
%         'SpecularStrength',.9,'SpecularExponent',25,...
%         'BackFaceLighting','unlit');
%
%     axis equal
%
% %     map = flipud(parula);
% %
% %     colormap(patFig,map);
%
%     xlim([370110.057100533          416668.669836211]);
%     ylim([6359765.17857549          6412339.57259274]);
%
%     caxis(del_caxis);
%
%     %colorbar
%
%     axis off;
%
%     plot_box;
%     plot_box2;
%
%     %____________
%
%     axes('position',pos(i).b,'color',[0.7 0.7 0.7])
%     text(0.6,0.95,'Murray River','units','normalized','fontsize',10,'fontweight','bold');
%
%     sss = find(theDel >= del_clip(1) & ...
%         theDel <= del_clip(2));
%     theDel(sss) = NaN;
%
%     patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
%     set(gca,'box','on');hold on
%
%     mapshow(shp,'facecolor','none','edgecolor','k')
%
%     set(findobj(gca,'type','surface'),...
%         'FaceLighting','phong',...
%         'AmbientStrength',.3,'DiffuseStrength',.8,...
%         'SpecularStrength',.9,'SpecularExponent',25,...
%         'BackFaceLighting','unlit');
%
%     axis equal
%
% %     map = flipud(parula);
% %
% %     colormap(patFig,map);
%
%     xlim([386576.219342587          395241.577797865]);
%     ylim([6388502.80301868          6395691.43997054]);
%
%     caxis(del_caxis);
%
%     %colorbar
%
%     axis off;
%
%     plot_box2;
%
%     if i == 8
%         cb = colorbar('location','southoutside');
%         set(cb,'position',[0.35 0.05 0.3 0.01]);
%
%     end
% end
%
% if ~do_crit
%     saveas(gcf,[outdir,var,'_',depth,'_',datetext,'_delMap_minus_',base2,'.png']);close;
%
% else
%     saveas(gcf,[outdir,'Oxy_Crit','_',depth,'_',datetext,'_delMap_minus_',base2,'.png']);close;
% end
%
%








