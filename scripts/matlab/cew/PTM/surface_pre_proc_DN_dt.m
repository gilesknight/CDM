clear all; close all;

addpath(genpath('functions'));
sitelist = dir('I:\GCLOUD\PTM_Results_v2\');

for kk = 3:length(sitelist)
    
    main_dir = ['I:\GCLOUD\PTM_Results_v2\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
    dirlist = dir(main_dir);
        
       % bound = shaperead('MatGrids/Lowerlakes_Area.shp');
        
        
        base = tfv_readnetcdf([base_dir,'run.nc'],'names',{'D';'WQ_NIT_NIT';'WQ_NIT_AMM';'WQ_OGM_DON';'cell_A';'cell_X';'cell_Y';'idx2'});
        clear functions
        base.DN = base.WQ_NIT_NIT + base.WQ_NIT_AMM + base.WQ_OGM_DON;
        base.DN = base.DN * 14/1000;
        %base.WQ_OXY_OXY = base.WQ_OXY_OXY * 32/1000;
        ucells = unique(base.idx2);
        for jj = 1:length(ucells)
        sss = find(base.idx2 == ucells(jj));
        for ii = 1:size(base.DN,2)
            base.DNM(jj,ii) = mean(base.DN(sss,ii));
            base.DN_BOT(jj,ii) = base.DN(sss(end),ii);
            base.DN_SUF(jj,ii) = base.DN(sss(1),ii);
        end
        end
        
        
        
        for i = 3:length(dirlist)
            
            str = strsplit(dirlist(i).name,'_');
            
            if strcmpi(str{1},'Output') == 1
                if exist([main_dir,dirlist(i).name,'/run.nc'],'file')
                    if ~exist([main_dir,dirlist(i).name,'/proc_DN.mat'],'file')
                    
                    disp([main_dir,dirlist(i).name,'/run.nc']);
                    
                    data = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D';'WQ_NIT_NIT';'WQ_NIT_AMM';'WQ_OGM_DON';'cell_A';'cell_X';'cell_Y';'idx2'});
                    clear functions
                    data.DN = data.WQ_NIT_NIT + data.WQ_NIT_AMM + data.WQ_OGM_DON;
                    data.DN = data.DN * 14/1000;
                    dat = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'time',1);
                    data.tdate = dat.Time;
                    
                    %data.WQ_OXY_OXY = data.WQ_OXY_OXY * 32/1000;
                    
                    ucells = unique(data.idx2);
                    for jj = 1:length(ucells)
                        sss = find(data.idx2 == ucells(jj));
                        %for ii = 1:size(data.DN,2)
                            %data.DNM(jj,ii) = mean(data.DN(sss,ii));
                            data.DN_BOT(jj,1:size(data.DN,2)) = base.DN_BOT(jj,1:size(data.DN,2)) - data.DN(sss(end),1:size(data.DN,2));
                            data.DN_SUF(jj,1:size(data.DN,2)) = base.DN_SUF(jj,1:size(data.DN,2)) - data.DN(sss(1),1:size(data.DN,2));
                            %data.DN_DIFF(jj,ii) = base.DNM(jj,ii) - data.DNM(jj,ii);
                            data.NH4_Bot_1(jj,:) = data.WQ_NIT_AMM(sss(end),:) * 14/1000;
                        %end
                    end
                    
                    
                    save([main_dir,dirlist(i).name,'/proc_DN.mat'],'data','-mat');
                    end
                    
                end
            end
        end
end