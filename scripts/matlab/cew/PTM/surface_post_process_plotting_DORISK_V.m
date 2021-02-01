clear all; close all;

addpath(genpath('functions'));


sitelist = dir('I:\GCLOUD\PTM_Results\');

for kk = 5%3:length(sitelist)
    
    outputdirectory = ['I:\GCLOUD\Report Images\',...
        sitelist(kk).name,'\Surface_PTM_Polygons\'];
    
    if ~exist(outputdirectory,'dir')
        mkdir(outputdirectory);
    end
    
    main_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
    
    dirlist = dir(main_dir);
    
    inc = 1;
    
    shp = shaperead(['Polygons/',sitelist(kk).name,'.shp']);
    
    base = load([base_dir,'proc.mat']);
    
    
    
    
    for i = 3:length(dirlist)
        
        str = strsplit(dirlist(i).name,'_');
        
        
        
        if strcmpi(str{1},'Output') == 1
            flow_fac(inc) = str2num(str{2});
            aed_fac(inc) = str2num(str{3});
            
            sim = load([main_dir,dirlist(i).name,'/proc.mat']);
            Ddata = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D'});

            for k = 1:length(shp)
                oxy_data_c = 0;
                tot_cell = 0;
                inpol = inpolygon(sim.data.cell_X,sim.data.cell_Y,shp(k).X,shp(k).Y);
                numpol = find(inpol == 1);
                for l = 1:size(sim.data.OXY_DIFF,2)
                    sss = find(Ddata.D(numpol,l) > 0.037);
                    ttt = find(sim.data.OXY_Bot_1(numpol(sss),l) < 4);
                    oxy_data_c = oxy_data_c + length(ttt);
                    tot_cell = tot_cell + length(numpol(sss));
                    
                end
                
                oxy_data(inc,k) = oxy_data_c/tot_cell;
                
            end
            
            inc = inc + 1;
            
            
            
        end
    end
    %
    %
    [xx,yy] = meshgrid([min(aed_fac):0.01:max(aed_fac)],[min(flow_fac):0.01:max(flow_fac)]);
    
    for i = 1:length(shp)
        
        figure
        
        f = scatteredInterpolant(aed_fac',flow_fac',oxy_data(:,i),'linear');
        %     g = scatteredInterpolant(aed_fac',flow_fac',oxy_data_s(:,i),'linear');
        %     h = scatteredInterpolant(aed_fac',flow_fac',oxy_data_b(:,i),'linear');
        
        zz = f(xx,yy);
        %     zzs = g(xx,yy);
        %     zzb = h(xx,yy);
        
        s1 = surf(xx,yy,zz,'edgecolor','none');hold on;
        colormap jet;
        %surf(xx,yy,zzs,'edgecolor','none');hold on;
        %s2 = surf(xx,yy,zzb,'edgecolor','none');hold on;
        
        %scatter3(0,1,0,'*r');
        
        xlabel('Biomass Factor');
        ylabel('Flow Factor');
        zlabel('Risk');
        title(regexprep(shp(i).Name,'_',' '));
        
        saveas(gcf,[outputdirectory,'Risk_',shp(i).Name,'.png']);
        clear zz;
        
        close
    end
    clear xx yy aed_fac flow_fac oxy_data;
    
end
