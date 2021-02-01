clear all; close all;

addpath(genpath('Functions'));




ncfile = 'R:\Coorong-Output\ORH_Base_20140101_20170101_rst.nc';
%ncfile = 'Z:\Busch\Studysites\Peel\2018_Modelling\Peel_WQ_Model_v5_2016_2017_3D_Murray\Output\sim_2016_2017_Open.nc';
outdir = 'Y:\Coorong Report\Budget\ORH_Base_20140101_20170101_rst\';
if exist(outdir,'dir')
    mkdir(outdir);
end
disp(ncfile);

vars = {...
'SAL',...
'TEMP',...
'WQ_OXY_OXY',...
'WQ_TRC_AGE',...
'WQ_OGM_DOC',...
'WQ_OGM_POC',...
'WQ_DIAG_PHY_TPHYS',...
'WQ_DIAG_PHY_GPP',...
'WQ_DIAG_PHY_NCP',...
'WQ_DIAG_MAG_GPP',...
'WQ_DIAG_MAG_NMP'
'WQ_DIAG_MAC_MAC'...
'WQ_DIAG_MAC_GPP',...
'WQ_DIAG_MAC_P_R',...
'WQ_DIAG_PHY_MPB',...
'WQ_DIAG_PHY_BPP',...
'WQ_DIAG_PHY_BCP',...
'WQ_DIAG_MAG_GPP_BEN',...
'WQ_DIAG_MAG_NMP_BEN',...
'WQ_DIAG_MAG_MAG_BEN'
'WQ_OGM_DON',...
'WQ_OGM_PON',...
'WQ_NIT_NIT',...
'WQ_NIT_AMM',...
'WQ_DIAG_NIT_NITRIF',...
'WQ_DIAG_NIT_DENIT'
'WQ_DIAG_NIT_SED_NIT',...
'WQ_DIAG_NIT_SED_AMM'
'WQ_DIAG_OGM_PSED_PON'
'WQ_OGM_DOP',...
'WQ_OGM_POP',...
'WQ_PHS_FRP',...
'WQ_PHS_FRP_ADS',...
'WQ_DIAG_PHS_SED_FRP',...
'WQ_DIAG_OGM_PSED_POP',...
};

%v_all = tfv_infonetcdf(ncfile);
%%vars = v_all(23:end);
%vars = v_all([20 21 23:end]);
%outdir = 'I:\Peel\Matfiles/Peel_WQ_Model_v5_2016_2017_3D_Murray/';

%load Export_Locations.mat;
shp = shaperead('GIS/Coorong_Regions.shp');
%shp = shp_A(4);

data = tfv_readnetcdf(ncfile,'names',{'idx2';'idx3';'cell_X';'cell_Y';'cell_A';'D';'NL';'layerface_Z';'cell_Zb'});clear functions;
names = tfv_infonetcdf(ncfile);
mdata = tfv_readnetcdf(ncfile,'time',1);clear functions;
Time = mdata.Time;
%sites = {'Currency Creek';'Lake Albert WLR';'Lake Alex Middle'};

%______________________________________________________________




for i = 1:length(shp)
    
    
    %     for j = 1:length(data.cell_X)
    %
    %         dist(j) = sqrt(power(abs(data.cell_X(j)-shp(i).X),2) + power(abs(data.cell_Y(j)-shp(i).Y),2));
    %
    %     end
    inpol = inpolygon(data.cell_X,data.cell_Y,shp(i).X,shp(i).Y);
    %    inpol = find(dist <= shp(i).Radius);
    
    ttt = find(inpol == 1);
    fsite(i).theID = ttt;
    fsite(i).Name = shp(i).Name;
    
    
end


for i = 1:length(vars)
    
    if sum(strcmpi(names,vars{i})) == 1
        
        disp(['Importing ',vars{i}]);
        
        
        mod = tfv_readnetcdf(ncfile,'names',vars(i));clear functions;
        tic
        for j = 1:length(shp)
            savedata = [];
            
            findir = [outdir,shp(j).Name,'/'];
            if ~exist(findir,'dir')
                mkdir(findir);
            end
            %if ~exists([findir,vars{i},'.mat'],'file')
            
            savedata.X = data.cell_X(fsite(j).theID);
            savedata.Y = data.cell_Y(fsite(j).theID);
            
            
            
            
            if strcmpi(vars{i},'H') == 1 | strcmpi(vars{i},'D') == 1 | strcmpi(vars{i},'cell_A') == 1
                savedata.(vars{i}) = mod.(vars{i})(fsite(j).theID,:);
            else
                
               savedata.(vars{i}).Bot(:,:) = mod.(vars{i})(fsite(j).theID,:); 
               DD = data.D(fsite(j).theID,:); 
               savedata.(vars{i}).Area(:) = data.cell_A(fsite(j).theID); 
             
               savedata.(vars{i}).Column(:,:) = mod.(vars{i})(fsite(j).theID,:) .* DD .* savedata.(vars{i}).Area(:);
                
               
               
            end
            
            savedata.Time = Time;
            
            save([findir,vars{i},'.mat'],'savedata','-mat','-v7.3');
            clear savedata;
            % end
        end
        toc
    end
end

% end



