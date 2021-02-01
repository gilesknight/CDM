clear all; close all;

addpath(genpath('functions'));


sitelist = dir('I:\GCLOUD\PTM_Results\');


amm_limit = 0.5;


for kk = 3:length(sitelist)
    
    outputdirectory = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_CarpProjects\Simulation Results\FINALREPORT\2.Surfaces\',...
        sitelist(kk).name,'\Surface_PTM_Polygons\'];
    
    if ~exist(outputdirectory,'dir')
        mkdir(outputdirectory);
    end
    
        fid = fopen([outputdirectory,'AMM_RISK.csv'],'wt');
    fprintf(fid,'Site,Region,Flow,Biomass\n');
    fprintf(fid,',,,0,0.1,0.4,0.8,1,2,5\n');
    
    main_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
    
    dirlist = dir(main_dir);
    
    inc = 1;
    
    shp = shaperead(['Polygons/',sitelist(kk).name,'.shp']);
    
    base = load([base_dir,'proc_amm.mat']);
    
    
    
    
    for i = 3:length(dirlist)
        
        str = strsplit(dirlist(i).name,'_');
        
        
        
        if strcmpi(str{1},'Output') == 1
            flow_fac(inc) = str2num(str{2});
            aed_fac(inc) = str2num(str{3});
            
            sim = load([main_dir,dirlist(i).name,'/proc_amm.mat']);
            Ddata = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D'});

            for k = 1:length(shp)
                oxy_data_c = 0;
                tot_cell = 0;
                inpol = inpolygon(sim.data.cell_X,sim.data.cell_Y,shp(k).X,shp(k).Y);
                numpol = find(inpol == 1);
                for l = 1:size(sim.data.AMM_DIFF,2)
                    sss = find(Ddata.D(numpol,l) > 0.037);
                    ttt = find(sim.data.AMM_Bot_1(numpol(sss),l) > amm_limit);
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
        fprintf(fid,'%s,%s,',sitelist(kk).name,shp(i).Name);
        
        for bb = [0.5 1 2]
            fprintf(fid,'%i,',bb);
            for nb = [0 0.1 0.4 0.8 1 2 5]
                
                ggg = find(aed_fac == nb & flow_fac == bb);
                
                if ~isempty(ggg)
                    fprintf(fid,'%4.4f,',oxy_data(ggg,i));
                else
                    fprintf(fid,',');
                end
            end
            fprintf(fid,'\n');
            fprintf(fid,',,');
        end
        fprintf(fid,'\n');        
        s1 = surf(xx,yy,zz,'edgecolor','none');hold on;
        colormap jet;
        switch sitelist(kk).name
            case 'Chowilla'
                        zlim([0 1]);
                        caxis([0 1]);
            case 'Murray'
                        zlim([0 0.25]);
                        caxis([0 0.25]);
            case 'Lowerlakes'
                        zlim([0 0.5]);
                        caxis([0 0.5]);
            case 'Moonie'
                        zlim([0 0.03]);
                        caxis([0 0.03]);
            otherwise
        end
        
        xlabel('Biomass Factor');
        ylabel('Flow Factor');
        zlabel(['${P}(NH_4 \geq NH_4^{crit})$'],'interpreter','latex');
        %zlabel('\mathbb{P}(NH_4 \geq NH_4^{crit})');
        title(regexprep(shp(i).Name,'_',' '));
        
        saveas(gcf,[outputdirectory,'AMMRisk_',num2str(amm_limit),'_',shp(i).Name,'.png']);
        clear zz;
        
        close
    end
    fclose(fid);
    clear xx yy aed_fac flow_fac oxy_data;
    
end