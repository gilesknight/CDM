%clear;close;

infolder='Z:\Sherry\Lowerlakes fish HSI\MER_Coorong_eWater_2020_v1\mat\Base\';
load([infolder,'breamHSI_2019.mat']);

%load fishHSI_2017.mat;

outdir='Z:\Sherry\Lowerlakes fish HSI\MER_Coorong_eWater_2020_v1\plots\2019\';


%% plotting S
hfig = figure('visible','on','position',[304         166        1800         900]);

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 36 18])

%load geo.mat;
ncfile='Z:\Busch\Studysites\Lowerlakes\Ruppia\MER_Coorong_eWater_2020_v1\Output\MER_Base_20170701_20200701.nc';
dat = tfv_readnetcdf(ncfile,'timestep',1);

vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;
faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

 pos9=[0.96 0.28 0.01 0.3];
 dim=[0.94 0.53 0.1 0.1];
%time=breamHSI.scen_Base.mdates;
time=breamHSI.(['scen_',scens{ii}]).mdates;
dv=datevec(time);
dm=dv(:,2);
dy=dv(:,1);
months={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
annos={'overall'};%'salt','temp','DO','Amm',};
vars={'HSI'};%'fS','fT','fO','fA'};
seasons={'summer','autumn','winter','spring'};

cax=[0 1];

for kk=1:length(vars)
    %data=fishHSI.scen_Base.(vars{kk});
    data=breamHSI.(['scen_',scens{ii}]).(vars{kk});
    
for vv=1:12
%clf;
subplot(2,6,vv)
inds=find(dm==vv);
cdata=mean(data(:,inds),2);
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


img_name =['breamHSI_Month_',annos{kk},'.png'];

%saveas(gcf,img_name);
saveas(gcf,[outdir,img_name]);

end