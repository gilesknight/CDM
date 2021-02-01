function tfv_plot_init_condition(X,Y,faces,data,filename,title)

vert(:,1) = X;
vert(:,2) = Y;

disp(['Plotting: ',title]);


figure

axes('position',[0.1 0.6 0.4 0.3])
plot([1:length(data)],data,'k');
set(gca,'box','on');

set(gca,'XTick',get(gca,'XTick'),'fontsize',6);
set(gca,'YTick',get(gca,'YTick'),'fontsize',6);


axes('position',[0 0 1 1]);

cdata = data;
fig.ax = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
axis equal

set(gca,'Color','None',...
    'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

axis off
set(gca,'box','off');

text(0.1,0.95,regexprep(title,'_',' - '),...
        'Units','Normalized',...
        'Fontname','Candara',...
        'Fontsize',16);


cb = colorbar;

set(cb,'position',[0.9 0.2 0.01 0.4],...
    'units','normalized');

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 18;
ySize = 10;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

print(gcf,'-dpng',filename,'-opengl');

close;


