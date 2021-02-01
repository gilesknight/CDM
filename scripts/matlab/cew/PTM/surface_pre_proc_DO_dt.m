clear all; close all;

addpath(genpath('functions'));

sitelist = dir('I:\GCLOUD\PTM_Results_v2\');

for kk = [6 5 4 3]
    


    
    
    
    main_dir = ['I:\GCLOUD\PTM_Results_v2\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
        
    dirlist = dir(main_dir);
    
    disp(main_dir);
    
   % bound = shaperead('MatGrids/Lowerlakes_Area.shp');
    
    
    base = tfv_readnetcdf([base_dir,'run.nc'],'names',{'D';'WQ_OXY_OXY';'cell_A';'cell_X';'cell_Y';'idx2'});
    base.WQ_OXY_OXY = base.WQ_OXY_OXY * 32/1000;
    ucells = unique(base.idx2);
    for jj = 1:length(ucells)
    sss = find(base.idx2 == ucells(jj));
    for ii = 1:size(base.WQ_OXY_OXY,2)
        base.OXY(jj,ii) = mean(base.WQ_OXY_OXY(sss,ii));
        base.OXY_BOT(jj,ii) = base.WQ_OXY_OXY(sss(end),ii);
        base.OXY_SUF(jj,ii) = base.WQ_OXY_OXY(sss(1),ii);
    end
    end
    
    
    
    for i = 3:length(dirlist)
        
        str = strsplit(dirlist(i).name,'_');
        
        if strcmpi(str{1},'Output') == 1
            if exist([main_dir,dirlist(i).name,'/run.nc'],'file')
                disp([main_dir,dirlist(i).name,'/run.nc']);
                
                if ~exist([main_dir,dirlist(i).name,'/proc.mat'],'file')
                
                
                data = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D';'WQ_OXY_OXY';'cell_A';'cell_X';'cell_Y';'idx2'});
                
                dat = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'time',1);
                data.tdate = dat.Time;
                
                data.WQ_OXY_OXY = data.WQ_OXY_OXY * 32/1000;
                
                ucells = unique(data.idx2);
                for jj = 1:length(ucells)
                    sss = find(data.idx2 == ucells(jj));
                    for ii = 1:size(data.WQ_OXY_OXY,2)
                        data.OXY(jj,ii) = mean(data.WQ_OXY_OXY(sss,ii));
                        data.OXY_BOT(jj,ii) = base.OXY_BOT(jj,ii) - data.WQ_OXY_OXY(sss(end),ii);
                        data.OXY_SUF(jj,ii) = base.OXY_SUF(jj,ii) - data.WQ_OXY_OXY(sss(1),ii);
                        data.OXY_DIFF(jj,ii) = base.OXY(jj,ii) - data.OXY(jj,ii);
                        data.OXY_Bot_1(jj,ii) = data.WQ_OXY_OXY(sss(end),ii);
                    end
                end
                
                
                save([main_dir,dirlist(i).name,'/proc.mat'],'data','-mat');
                
                end
            end
        end
    end
end