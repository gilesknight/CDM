clear all; close all;

addpath(genpath('functions'));

sitelist = dir('I:\GCLOUD\PTM_Results\');

for kk = 3:length(sitelist)
    


    
    
    
    main_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
        
    dirlist = dir(main_dir);
    
    disp(main_dir);
    
    %bound = shaperead('MatGrids/Lowerlakes_Area.shp');
    
    
    base = tfv_readnetcdf([base_dir,'run.nc'],'names',{'D';'WQ_NIT_AMM';'cell_A';'cell_X';'cell_Y';'idx2'});
    base.WQ_NIT_AMM = base.WQ_NIT_AMM * 14/1000;
    ucells = unique(base.idx2);
    for jj = 1:length(ucells)
    sss = find(base.idx2 == ucells(jj));
    for ii = 1:size(base.WQ_NIT_AMM,2)
        base.AMM(jj,ii) = mean(base.WQ_NIT_AMM(sss,ii));
        base.AMM_BOT(jj,ii) = base.WQ_NIT_AMM(sss(end),ii);
        base.AMM_SUF(jj,ii) = base.WQ_NIT_AMM(sss(1),ii);
    end
    end
    
    
    
    for i = 3:length(dirlist)
        
        str = strsplit(dirlist(i).name,'_');
        
        if strcmpi(str{1},'Output') == 1
            if exist([main_dir,dirlist(i).name,'/run.nc'],'file')
                disp([main_dir,dirlist(i).name,'/run.nc']);
                
                data = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D';'WQ_NIT_AMM';'cell_A';'cell_X';'cell_Y';'idx2'});
                
                dat = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'time',1);
                data.tdate = dat.Time;
                
                data.WQ_NIT_AMM = data.WQ_NIT_AMM * 14/1000;
                
                ucells = unique(data.idx2);
                for jj = 1:length(ucells)
                    sss = find(data.idx2 == ucells(jj));
                    for ii = 1:size(data.WQ_NIT_AMM,2)
                        data.AMM(jj,ii) = mean(data.WQ_NIT_AMM(sss,ii));
                        data.AMM_BOT(jj,ii) = base.AMM_BOT(jj,ii) - data.WQ_NIT_AMM(sss(end),ii);
                        data.AMM_SUF(jj,ii) = base.AMM_SUF(jj,ii) - data.WQ_NIT_AMM(sss(1),ii);
                        data.AMM_DIFF(jj,ii) = base.AMM(jj,ii) - data.AMM(jj,ii);
                        data.AMM_Bot_1(jj,ii) = data.WQ_NIT_AMM(sss(end),ii);
                    end
                end
                
                
                save([main_dir,dirlist(i).name,'/proc_amm.mat'],'data','-mat');
                
            end
        end
    end
end