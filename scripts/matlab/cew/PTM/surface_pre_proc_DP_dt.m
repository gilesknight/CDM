clear all; close all;

addpath(genpath('functions'));

sitelist = dir('I:\GCLOUD\PTM_Results_v2\');

for kk = 3:length(sitelist)%[3 5]%3:length(sitelist)
    
    main_dir = ['I:\GCLOUD\PTM_Results_v2\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];

dirlist = dir(main_dir);

%bound = shaperead('MatGrids/Lowerlakes_Area.shp');


base = tfv_readnetcdf([base_dir,'run.nc'],'names',{'D';'WQ_PHS_FRP';'WQ_OGM_DOP';'cell_A';'cell_X';'cell_Y';'idx2'});clear functions
base.DP = base.WQ_PHS_FRP + base.WQ_OGM_DOP;
base.DP = base.DP * 31/1000;
%base.WQ_OXY_OXY = base.WQ_OXY_OXY * 32/1000;
ucells = unique(base.idx2);
for jj = 1:length(ucells)
    sss = find(base.idx2 == ucells(jj));
    for ii = 1:size(base.DP,2)
        base.DPM(jj,ii) = mean(base.DP(sss,ii));
        base.DP_BOT(jj,ii) = base.DP(sss(end),ii);
        base.DP_SUF(jj,ii) = base.DP(sss(1),ii);
    end
end
    


for i = 3:length(dirlist)
    
    str = strsplit(dirlist(i).name,'_');
    
    if strcmpi(str{1},'Output') == 1
        if exist([main_dir,dirlist(i).name,'/run.nc'],'file')
            if ~exist([main_dir,dirlist(i).name,'/proc_DP.mat'],'file')
            disp([main_dir,dirlist(i).name,'/run.nc']);
            
            data = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'D';'WQ_PHS_FRP';'WQ_OGM_DOP';'cell_A';'cell_X';'cell_Y';'idx2'});
            clear functions
            
            data.DP = data.WQ_PHS_FRP + data.WQ_OGM_DOP;
            data.DP = data.DP * 31/1000;
            dat = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'time',1);
            data.tdate = dat.Time;
            
            %data.WQ_OXY_OXY = data.WQ_OXY_OXY * 32/1000;
            
            ucells = unique(data.idx2);
            for jj = 1:length(ucells)
                sss = find(data.idx2 == ucells(jj));
                %for ii = 1:size(data.DP,2)
                    %data.DPM(jj,ii) = mean(data.DP(sss,ii));
                    data.DP_BOT(jj,1:size(data.DP,2)) = base.DP_BOT(jj,1:size(data.DP,2)) - data.DP(sss(end),1:size(data.DP,2));
                    data.DP_SUF(jj,1:size(data.DP,2)) = base.DP_SUF(jj,1:size(data.DP,2)) - data.DP(sss(1),1:size(data.DP,2));
                    %data.DP_DIFF(jj,ii) = base.DPM(jj,ii) - data.DPM(jj,ii);
                    data.DP_Bot_1(jj,:) = data.DP(sss(end),:);
               % end
            end
            
            
            save([main_dir,dirlist(i).name,'/proc_DP.mat'],'data','-mat');
            end
            
        end
    end
end
end