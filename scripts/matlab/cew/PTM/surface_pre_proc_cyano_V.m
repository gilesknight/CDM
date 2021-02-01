clear all; close all;

addpath(genpath('functions'));
sitelist = dir('I:\GCLOUD\PTM_Results_v3\');

for kk = 3:length(sitelist)
    
    main_dir = ['I:\GCLOUD\PTM_Results_v3\',sitelist(kk).name,'\'];
    base_dir = ['I:\GCLOUD\PTM_Results\',sitelist(kk).name,'\Output_1_0\'];
    dirlist = dir(main_dir);
    
%    bound = shaperead('MatGrids/Lowerlakes_Area.shp');
    
%     
%     base = tfv_readnetcdf([base_dir,'run.nc'],'names',{'D';'TEMP';'WQ_NIT_NIT';'WQ_NIT_AMM';'WQ_PHS_FRP';'cell_A';'cell_X';'cell_Y';'idx2'});
%     clear functions
%     
%     %base.WQ_OXY_OXY = base.WQ_OXY_OXY * 32/1000;
%     ucells = unique(base.idx2);
%     for jj = 1:length(ucells)
%         sss = find(base.idx2 == ucells(jj));
%         for ii = 1:size(base.TEMP,2)
%             
%             %------ stratification
%             strat = base.TEMP(sss(1),ii) - base.TEMP(sss(end),ii);
%             
%             if(strat<0.1)
%                 fS = 0;
%             else
%                 fS = 0 + max((4-strat)/4,1);
%             end
%             
%             %------ temperature
%             %The numbers I've used for Darwin Reservoir cyanobacteria are:
%             %Theta_growth (v) = 1.08;
%             %T_std = 28; %T_opt = 34; %T_max = 40;
%             k = 4.1102;
%             a = 35.0623;
%             b = 0.1071;
%             
%             T = base.TEMP(sss(1),ii);
%             
%             fT = v^(T-20)-v^(k(T-a))+b;
%             
%             %------ nitrogen
%             N = max(base.WQ_NIT_NIT(sss,ii)) + max(base.WQ_NIT_AMM(sss,ii));   % max in column
%             KN = 4;                   in mmol/m3
%             fN = N/(KN+N);
%             
%             %------ phosphorus
%             P = max(base.WQ_PHS_FRP(sss,ii));   max in column
%             KP = 0.15;     in mmol/m3
%             fP = P/(KP+P);
%             
%             
%             %------ TOTAL RISK
%             
%             data.CYANO_base(jj,ii) = fS * fT * min(fN , fP);
%             
%             
%             
%         end
%     end
    
    
    
    for i = 3:length(dirlist)
        
        str = strsplit(dirlist(i).name,'_');
        
        if strcmpi(str{1},'Output') == 1
            if exist([main_dir,dirlist(i).name,'/run.nc'],'file')
                if ~exist([main_dir,dirlist(i).name,'/proc_cyano_V.mat'],'file')
                disp([main_dir,dirlist(i).name,'/run.nc']);
                
                
                %stop
                
                data = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'names',{'V_x';'V_y';'D';'TEMP';'WQ_NIT_NIT';'WQ_NIT_AMM';'WQ_PHS_FRP';'cell_A';'cell_X';'cell_Y';'idx2'});
                
                data.V = sqrt(power(data.V_x,2) + power(data.V_y,2));
                
                clear functions

                dat = tfv_readnetcdf([main_dir,dirlist(i).name,'/run.nc'],'time',1);
                data.tdate = dat.Time;
                
                %data.WQ_OXY_OXY = data.WQ_OXY_OXY * 32/1000;
                
                ucells = unique(data.idx2);
                for jj = 1:length(ucells)
                    sss = find(data.idx2 == ucells(jj));
                    for ii = 1:size(data.TEMP,2)
                        %------ stratification
                        strat = data.TEMP(sss(1),ii) - data.TEMP(sss(end),ii);
                        
                        mV = mean(data.V(sss,ii));
                        
%                         k = (0.1 - 0.001) / ( 0 - 1);
% 
%                         n = 0.0099;

                        
                        
                        if mV < 0.01
                            fS = 1;
                        else
                            %fS = k*mV + n;
                            fS = 1 - (mV*(1/0.1));
                            fS(fS<0) = 0;
                        end
%                         if(strat<0.1)
%                             fS = 0;
%                         else
%                             fS = 0 + max((4-strat)/4,1);
%                         end
                        
                        %------ temperature
                        %The numbers I've used for Darwin Reservoir cyanobacteria are:
                        %Theta_growth (v) = 1.08;
                        %T_std = 28; %T_opt = 34; %T_max = 40;
                        k = 4.1102;
                        a = 35.0623;
                        b = 0.1071;
                        v = 1.08;
                        
                        T = double(data.TEMP(sss(1),ii));
                        
                        fT = v^(T-20)-v^(k*(T-a))+b;
                        
                        %------ nitrogen
                        N = max(data.WQ_NIT_NIT(sss,ii)) + max(data.WQ_NIT_AMM(sss,ii));   % max in column
                        KN = 4;                %   in mmol/m3
                        fN = N/(KN+N);
                        
                        %------ phosphorus
                        P = max(data.WQ_PHS_FRP(sss,ii));%   max in column
                        KP = 0.15;    % in mmol/m3
                        fP = P/(KP+P);
                        
                        
                        %------ TOTAL RISK
                        
                        data.CYANO_data(jj,ii) = fS * fT * min(fN , fP);
                        
                        
                    end
                end
                
                
                save([main_dir,dirlist(i).name,'/proc_cyano_V.mat'],'data','-mat');
                end
                
            end
        end
    end
end