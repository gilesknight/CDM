clear all; close all;

addpath(genpath('functions'));

sitelist = dir('I:\GCLOUD\PTM_Results\');

for kk = 3:length(sitelist)
    
    outputdirectory = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\FINALREPORT\2.Surfaces\',...
        sitelist(kk).name,'\Surface_PTM_Polygons\'];
    
    

    
    
    if ~exist(outputdirectory,'dir')
        mkdir(outputdirectory);
    end
    
        fid = fopen([outputdirectory,'DO.csv'],'wt');
    fprintf(fid,'Site,Region,Flow,Biomass\n');
    fprintf(fid,',,,0,0.1,0.4,0.8,1,2,5\n');
    
    main_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
    
    dirlist = dir(main_dir);
    
    inc = 1;
    
    shp = shaperead(['Polygons/',sitelist(kk).name,'.shp']);
    
    base = load([base_dir,'proc.mat']);
    
    oxy_data = [];
    oxy_data_s = [];
    oxy_data_b = [];
    
    
    for i = 3:length(dirlist)
        
        str = strsplit(dirlist(i).name,'_');
        
        
        
        if strcmpi(str{1},'Output') == 1
            flow_fac(inc) = str2num(str{2});
            aed_fac(inc) = str2num(str{3});
            
            sim = load([main_dir,dirlist(i).name,'/proc.mat']);
            
            Ddata = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D'});
            
            
            for k = 1:length(shp)
                inpol = inpolygon(sim.data.cell_X,sim.data.cell_Y,shp(k).X,shp(k).Y);
                numpol = find(inpol == 1);
                for l = 1:size(sim.data.OXY_DIFF,2)
                    sss = find(Ddata.D(numpol,l) > 0.037);
                    
                    if isempty(sss)
                        stop
                    end
                    
                    DO(l) = sum(sim.data.OXY_DIFF(numpol(sss),l)) / length((sss));
                    DOS(l) = sum(sim.data.OXY_SUF(numpol(sss),l)) / length((sss));
                    DOB(l) = sum(sim.data.OXY_BOT(numpol(sss),l)) / length((sss));
                    
                    
                    
                    
                end
                oxy_data(inc,k) = sum(DO)/length(DO);
                oxy_data_s(inc,k) = sum(DOS)/length(DOS);
                oxy_data_b(inc,k) = sum(DOB)/length(DOB);
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
        g = scatteredInterpolant(aed_fac',flow_fac',oxy_data_s(:,i),'linear');
        h = scatteredInterpolant(aed_fac',flow_fac',oxy_data_b(:,i),'linear');
        
        
        fprintf(fid,'%s,%s,',sitelist(kk).name,shp(i).Name);
        
        for bb = [0.5 1 2]
            fprintf(fid,'%i,',bb);
            for nb = [0 0.1 0.4 0.8 1 2 5]
                
                ggg = find(aed_fac == nb & flow_fac == bb);
                
                if ~isempty(ggg)
                    fprintf(fid,'%4.4f,',oxy_data_b(ggg,i));
                else
                    fprintf(fid,',');
                end
            end
            fprintf(fid,'\n');
            fprintf(fid,',,');
        end
        fprintf(fid,'\n');        
                
        
        
        
        
        zz = f(xx,yy);
        zzs = g(xx,yy);
        zzb = h(xx,yy);
        
        %s1 = surf(xx,yy,zz,'edgecolor','none');hold on;
        
        
        h1 = surf(xx,yy,zzb,'edgecolor','none');hold on;
        colormap jet
        
        
        
        
        h2 = surf(xx,yy,zzs,'edgecolor','none');hold on;
        
        switch sitelist(kk).name
            case 'Chowilla'
                        zlim([-5 5]);
                        caxis([-5 5]);
            case 'Murray'
                        zlim([0 3]);
                        caxis([0 3]);
            case 'Lowerlakes'
                        zlim([0 1]);
                        caxis([0 1]);
            case 'Moonie'
                        zlim([-0.05 0.05]);
                        caxis([-0.05 0.05]);
            otherwise
        end
        
        
        %         zlim([0 5]);
        %         caxis([0 5]);
        
        xlabel('Biomass Factor');
        ylabel('Flow Factor');
        zlabel('\Delta DO (mg/L)');
        title(regexprep(shp(i).Name,'_',' '));
        
%         text(0.8,0.4,0.8,'Surface','units','normalized');
%         text(0.3,0.8,0.8,'Bottom','units','normalized');
        
        saveas(gcf,[outputdirectory,'DO_',shp(i).Name,'.png']);
        
        clear zzb zzs;
        
        close
    end
    fclose(fid);
    clear xx yy aed_fac flow_fac oxy_data oxy_data_s oxy_data_b;
end

