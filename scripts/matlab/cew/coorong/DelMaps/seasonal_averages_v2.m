function seasonal_averages_v2(var,base_caxis,conv)

basedir = 'Y:\Peel Final Report\Processed_v12_joined\';
outdir = 'Y:\Peel Final Report\Seasonal_Averages\';
scenlist = dir(basedir);

shp = shaperead('Peel_Boundary.shp');
pre = shaperead('Per_Cut.shp');

cut = shaperead('GIS\Cut.shp');
%var = 'WQ_DIAG_TOT_TN';

%conv = 14/1000;

base1 = 'run_2016_2018_joined';
base2 = 'run_1979_1981';
% base_caxis = [2 10];

% del_caxis = [-2 2];
% del_clip = [-0.5 0.5];

%base_caxis = [0 2];

del_caxis = [-0.5 0.5];
del_clip = [-0.05 0.05];

do_crit = 0; %Only for oxygen;

% base_caxis = [0 0.5];
% 
% del_caxis = [-0.1 0.1];
% del_clip = [-0.01 0.01];
depth = 'Bot';

themonths(1).val = [9 11];
themonths(1).year = [1979 1979];
themonths(2).val = [9 11];
themonths(2).year = [1981 1981];
themonths(3).val = [9 11];
themonths(3).year = [1982 1982];
themonths(4).val = [9 11];
themonths(4).year = [1991 1991];
themonths(5).val = [9 11];
themonths(5).year = [1996 1996];
themonths(6).val = [9 11];
themonths(6).year = [2005 2005];
themonths(7).val = [9 11];
themonths(7).year = [2013 2013];
themonths(8).val = [9 11];
themonths(8).year = [2017 2017];

pos(1).a = [0.00 0.55 0.25 0.4];
pos(2).a = [0.25 0.55 0.25 0.4];
pos(3).a = [0.50 0.55 0.25 0.4];
pos(4).a = [0.75 0.55 0.25 0.4];

pos(5).a = [0.00 0.1 0.25 0.4];
pos(6).a = [0.25 0.1 0.25 0.4];
pos(7).a = [0.50 0.1 0.25 0.4];
pos(8).a = [0.75 0.1 0.25 0.4];


pos(1).b = [0.05 0.55 0.2 0.2];
pos(2).b = [0.30 0.55 0.2 0.2];
pos(3).b = [0.55 0.55 0.2 0.2];
pos(4).b = [0.80 0.55 0.2 0.2];

pos(5).b = [0.05 0.1 0.2 0.2];
pos(6).b = [0.30 0.1 0.2 0.2];
pos(7).b = [0.55 0.1 0.2 0.2];
pos(8).b = [0.80 0.1 0.2 0.2];






theorder = {...
    'run_1979_1981',...
    'run_1981_1983_joined',...
    'run_1982_1983_joined',...
    'run_1991_1993_joined',...
    'run_1996_1998_joined',...
    'run_2005_2007',...
    'run_2013_2015_joined',...    
    'run_2016_2018_joined',...
    };

thenames = {...
    '1979',...
    '1981',...
    '1982',...
    '1991',...
    '1996',...
    '2005',...
    '2013',...
    '2017',...
    };




datetext = [num2str(themonths(1).year(1)),'-',num2str(themonths(1).val(1)),'_',num2str(themonths(1).year(2)),'-',num2str(themonths(1).val(2))];


[XX,YY,ZZ,nodeID,faces,cellX,cellY,Z,ID,MAT,cellArea] = tfv_get_node_from_2dm('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm');

inpol = inpolygon(cellX,cellY,cut.X,cut.Y);


for i = 3:length(scenlist)
    
    outdata.(scenlist(i).name) = load([basedir,scenlist(i).name,'\',var,'.mat']);
    
end

%%
if strcmpi(var,'WQ_OXY_OXY') == 0
    do_crit = 0;
end



scen = fieldnames(outdata);

figure('position',[750.333333333333                        99          1573.33333333333          1094.66666666667]);



for i = 1:length(theorder)
    
    theday = eomday(themonths(i).year(2),themonths(i).val(2));
    
    sss = find(outdata.(theorder{i}).savedata.Time >= datenum(themonths(i).year(1),themonths(i).val(1),01,00,00,00) & ...
        outdata.(theorder{i}).savedata.Time <= datenum(themonths(i).year(2),themonths(i).val(2),theday,23,59,59));
    
    if strcmpi(var,'WQ_OXY_OXY') == 1 & ...
            do_crit == 1
        delmap.raw.(theorder{i}) = calc_crit(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),conv);
    else
        
        delmap.raw.(theorder{i}) = mean(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),2) * conv;
        
    end
    
    if themonths(i).year(1) < 1995
        delmap.raw.(theorder{i})(inpol) = NaN;
    end
    
    
    %delmap.raw.(theorder{i})
    %subplot(2,4,i)
    axes('position',pos(i).a)
    
    tx = regexprep(theorder{i},'_',' ');
    tx = regexprep(tx,'run scenario ','');
    
    text(0.75,0.95,thenames{i},'units','normalized','fontsize',14,'fontweight','bold');
    
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap.raw.(theorder{i}));shading flat
    set(gca,'box','on');hold on
    if themonths(i).year(1) > 1995
        mapshow(shp,'facecolor','none','edgecolor','k');
    else
        mapshow(pre,'facecolor','none','edgecolor','k');
    end
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([370110.057100533          416668.669836211]);
    ylim([6359765.17857549          6412339.57259274]);
    
    caxis(base_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box;
    plot_box2;
    
    %____________
    
    axes('position',pos(i).b,'color',[0.7 0.7 0.7])
    text(0.6,0.95,'Murray River','units','normalized','fontsize',10,'fontweight','bold');
    
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
    
    xlim([386576.219342587          395241.577797865]);
    ylim([6388502.80301868          6395691.43997054]);
    
    caxis(base_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box2;
    
    if i == 8
        cb = colorbar('location','southoutside');
        set(cb,'position',[0.35 0.05 0.3 0.01]);
        
    end
    
    
end

if ~do_crit
    saveas(gcf,[outdir,var,'_',depth,'_',datetext,'_raw.png']);close;
else
    saveas(gcf,[outdir,'Oxy_Crit','_',depth,'_',datetext,'_raw.png']);close;
end

%%
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
%     theDel = delmap.raw.(theorder{i}) - delmap.raw.(base1);
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
%     saveas(gcf,[outdir,var,'_',depth,'_',datetext,'_delMap_minus_',base1,'.png']);close;
%     
% else
%     saveas(gcf,[outdir,'Oxy_Crit','_',depth,'_',datetext,'_delMap_minus_',base1,'.png']);close;
% end
% 
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









