clear all; close all;

addpath(genpath('functions'));
sitelist = dir('I:\GCLOUD\PTM_Results_v3\');

for kk = 3:length(sitelist)
    
    main_dir = ['I:\GCLOUD\PTM_Results_v3\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
    dirlist = dir(main_dir);
    
    % bound = shaperead('MatGrids/Lowerlakes_Area.shp');
    
    
    base = tfv_readnetcdf([base_dir,'run.nc'],'names',{'D';'WQ_NIT_NIT';...
        'WQ_NIT_AMM';'WQ_OGM_DON';...
        'WQ_PHS_FRP';'WQ_OGM_DOP';...
        'WQ_OXY_OXY';...
        'cell_A';'cell_X';'cell_Y';'idx2'});
    clear functions
    base.DN = base.WQ_NIT_NIT + base.WQ_NIT_AMM + base.WQ_OGM_DON;
    base.DN = base.DN * 14/1000;
    base.DP = base.WQ_PHS_FRP + base.WQ_OGM_DOP;
    base.DP = base.DP * 31/1000;
    base.WQ_OXY_OXY = base.WQ_OXY_OXY * 32/1000;
    %base.WQ_OXY_OXY = base.WQ_OXY_OXY * 32/1000;
    ucells = unique(base.idx2);
    for jj = 1:length(ucells)
        sss = find(base.idx2 == ucells(jj));
        base.DN_BOT(jj,:) = base.DN(sss(end),:);
        base.DN_SUF(jj,:) = base.DN(sss(1),:);
        base.DP_BOT(jj,:) = base.DP(sss(end),:);
        base.DP_SUF(jj,:) = base.DP(sss(1),:);
        base.OXY_BOT(jj,:) = base.WQ_OXY_OXY(sss(end),:);
        base.OXY_SUF(jj,:) = base.WQ_OXY_OXY(sss(1),:);
    end
    
    
    
    for i = 3:length(dirlist)
        disp(dirlist(i).name);
        str = strsplit(dirlist(i).name,'_');
        
        if strcmpi(str{1},'Output') == 1
            if exist([main_dir,dirlist(i).name,'/run.nc'],'file')
                if ~exist([main_dir,dirlist(i).name,'/proc_multi.mat'],'file')
                    
                    disp([main_dir,dirlist(i).name,'/run.nc']);
                    
                    data = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D';'WQ_NIT_NIT';...
                        'WQ_NIT_AMM';'WQ_OGM_DON';...
                        'WQ_PHS_FRP';'WQ_OGM_DOP';...
                        'WQ_OXY_OXY';...
                        'cell_A';'cell_X';'cell_Y';'idx2'});
                    
                    clear functions;
                    
                    data.DN = data.WQ_NIT_NIT + data.WQ_NIT_AMM + data.WQ_OGM_DON;
                    data.DN = data.DN * 14/1000;
                    data.DP = data.WQ_PHS_FRP + data.WQ_OGM_DOP;
                    data.DP = data.DP * 31/1000;
                    data.WQ_OXY_OXY = data.WQ_OXY_OXY * 32/1000;
                    dat = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'time',1);
                    data.tdate = dat.Time;
                    
                    %data.WQ_OXY_OXY = data.WQ_OXY_OXY * 32/1000;
                    
                    ucells = unique(data.idx2);
                    for jj = 1:length(ucells)
                        sss = find(data.idx2 == ucells(jj));

                        data.DN_BOT(jj,1:size(data.DN,2)) = base.DN_BOT(jj,1:size(data.DN,2)) - data.DN(sss(end),1:size(data.DN,2));
                        data.DN_SUF(jj,1:size(data.DN,2)) = base.DN_SUF(jj,1:size(data.DN,2)) - data.DN(sss(1),1:size(data.DN,2));
                        data.NH4_Bot_1(jj,:) = data.WQ_NIT_AMM(sss(end),:) * 14/1000;
                        data.AMM_Bot_1(jj,:) = data.WQ_NIT_AMM(sss(end),:) * 14/1000;
                        
                        data.DP_BOT(jj,1:size(data.DP,2)) = base.DP_BOT(jj,1:size(data.DP,2)) - data.DP(sss(end),1:size(data.DP,2));
                        data.DP_SUF(jj,1:size(data.DP,2)) = base.DP_SUF(jj,1:size(data.DP,2)) - data.DP(sss(1),1:size(data.DP,2));
                        data.DP_Bot_1(jj,:) = data.DP(sss(end),:);                        
                        
                        data.OXY_BOT(jj,1:size(data.DP,2)) = base.OXY_BOT(jj,1:size(data.DP,2)) - data.WQ_OXY_OXY(sss(end),1:size(data.DP,2));
                        data.OXY_SUF(jj,1:size(data.DP,2)) = base.OXY_SUF(jj,1:size(data.DP,2)) - data.WQ_OXY_OXY(sss(1),1:size(data.DP,2));
                        
                        data.OXY_Bot_1(jj,1:size(data.DP,2)) = data.WQ_OXY_OXY(sss(end),1:size(data.DP,2));
                    end
                    
                    
                    save([main_dir,dirlist(i).name,'/proc_multi.mat'],'data','-mat');
                end
                
            end
        end
    end
end