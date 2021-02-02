
load(['E:\Lowerlakes\fishHSI\MER_Coorong_eWater_2020_v1\mat\Base\SAL.mat']);
tmp=savedata.Time;

% outdir=['E:\Lowerlakes\fishHSI\MER_Coorong_eWater_2020_v1\plots\',scenario{n},'\'];

yr_array = 2019;

for y=1:length(yr_array)
ts=datenum(yr_array(y),7,1);tf=datenum(yr_array(y)+1,7,1);
tsind=find(abs(tmp-ts)==min(abs(tmp-ts))); % time start index
tfind=find(abs(tmp-tf)==min(abs(tmp-tf)));

newTime=tmp(tsind:tfind);
sal_bot=savedata.SAL(:,tsind:tfind);
 
end 
 
    %% plotting S
    hfig = figure('visible','on','position',[304         166        1800         900]);

    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf,'paperposition',[0.635 6.35 36 18])

    %load geo.mat;
    ncfile=['E:\Lowerlakes\Busch_Ruppia_modeloutput\MER_',scenario{n},'_20170701_20200701.nc'];
    dat = tfv_readnetcdf(ncfile,'timestep',1);

    vert(:,1) = dat.node_X;
    vert(:,2) = dat.node_Y;
    faces = dat.cell_node';

    %--% Fix the triangles
    faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

     pos9=[0.96 0.28 0.01 0.3];
     dim=[0.94 0.53 0.1 0.1];

     %%
%      var=fieldnames(dataHSI);
%      time=dataHSI.(var{1}).(['scen_',scenario{n}]).mdates;

    %time=breamHSI.(['scen_',scens{ii}]).mdates;
    dv=datevec(newTime);
    dm=dv(:,2); %month
    dy=dv(:,1);  %year
    months={'Jan2020','Feb2020','Mar2020','Apr2020','May2020','Jun2020','Jul2019','Aug2019','Sep2019','Oct2019','Nov2019','Dec2019'};
%     months={'Jan2019','Feb2019','Mar2019','Apr2019','May2019','Jun2019','Jul2018','Aug2018','Sep2018','Oct2018','Nov2018','Dec2018'};
%     months={'Jan2018','Feb2018','Mar2018','Apr2018','May2018','Jun2018','Jul2017','Aug2017','Sep2017','Oct2017','Nov2017','Dec2017'};
%     annos={'sal'};%'overall','salt','temp','DO','Amm',};
%     vars={'sal'};%'HSI','fS','fT','fO','fA'};
%     seasons={'summer','autumn','winter','spring'};

    cax=[0 200];

%     for kk=1:length(vars)
%         data=dataHSI.(var{1}).(['scen_',scenario{n}]).(vars{kk});
%         %data=breamHSI.(['scen_',scens{ii}]).(vars{kk});

    for vv=1:12
    %clf;
    
    
    if vv<7 %to swap jan-jun to bottom, jul-dec to top
    subplot(2,6,vv+6) %2 rows, 6 coloumns, index of figs
    else
        subplot(2,6,vv-6);
    end
    
    
    
    inds=find(dm==vv); %find month in all years
    cdata=mean(sal_bot(:,inds),2); 
    
    %HSIdata.(annos{vv}).(months{sinds(1)})=cdata;
    patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat;
    set(gca,'box','on');

    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');

    caxis(cax);
    axis off;        axis equal;

    text(0.1,0.9,months{vv},...
        'Units','Normalized',...
        'Fontname','Candara',...
        'Fontsize',12,...
        'fontweight','Bold',...
        'color','k');

    if vv==12
    cb = colorbar;

    set(cb,'position',pos9,...
        'units','normalized','ycolor','k','fontsize',6);

    end
    %annotation('textbox',dim,'String',[annos{vv},' HSI'],'FitBoxToText','on','FontSize',10,'LineStyle','none');

    end

%     end
    
%     img_name =[fish{m},annos{kk},'_',scenario{n},'_-1.png'];

    
%      saveas(gcf,[outdir,img_name]);