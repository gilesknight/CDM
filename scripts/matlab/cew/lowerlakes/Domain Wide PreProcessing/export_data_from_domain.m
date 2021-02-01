%clear all; close all;

addpath(genpath('Functions'));

ncdir = 'H:\Lowerlakes-CEW-Results/';
savedir = 'G:\Lowerlakes-CEW-Results\Processed/';

dirlist = dir([ncdir,'*.nc']);

vars = {...
    'cell_A',...
    'H',...
    'D',...
    'SAL',...
    'TEMP',...
    'WQ_NCS_SS1',...
    'WQ_OXY_OXY',...
    'WQ_SIL_RSI',...
    'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_PHS_FRP',...
    'WQ_PHS_FRP_ADS',...
    'WQ_OGM_DON',...
    'WQ_OGM_PON',...
    'WQ_OGM_DOP',...
    'WQ_OGM_POP',...
    'WQ_PHY_GRN',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TOC',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_TURBIDITY',...
    'WQ_DIAG_PHY_TPHYS',...
    'ON',...
    'OP',...
    };



for bdb = 1:length(dirlist)
    
    ncfile = [ncdir,dirlist(bdb).name];
    %ncfile = 'Z:\Busch\Studysites\Peel\2018_Modelling\Peel_WQ_Model_v5_2016_2017_3D_Murray\Output\sim_2016_2017_Open.nc';
    outdir = [savedir,regexprep(dirlist(bdb).name,'.nc',''),'/'];
    %     if exist(outdir,'dir')
    %
    %     else
    
    the_vars = tfv_infonetcdf(ncfile);
    
    disp(ncfile);
    
    if ~exist(outdir,'dir')
        
        mkdir(outdir);
        %outdir = 'I:\Peel\Matfiles/Peel_WQ_Model_v5_2016_2017_3D_Murray/';
        
        %load Export_Locations.mat;
        %shp = S;
        
        data = tfv_readnetcdf(ncfile,'names',{'idx2';'idx3';'cell_X';'cell_Y';'cell_A'});
        
        mdata = tfv_readnetcdf(ncfile,'time',1);
        Time = mdata.Time;
        %sites = {'Currency Creek';'Lake Albert WLR';'Lake Alex Middle'};
        
        %______________________________________________________________
        
        
        surf_ind = data.idx3;
        
%         bottom_ind(1:length(data.idx3)-1) = data.idx3(2:end) - 1;
%         bottom_ind(length(data.idx3)) = length(data.idx3);
        
        
        for i = 1:length(vars)
            disp(['Importing ',vars{i}]);
            
            
            if sum(strcmpi(the_vars,vars{i})) == 1 | ...
                    strcmpi(vars{i},'WQ_DIAG_PHY_TCHLA') == 1
                
                if strcmpi(vars{i},'WQ_DIAG_PHY_TCHLA') == 0
                    mod = tfv_readnetcdf(ncfile,'names',vars(i));
                    
                    
                    savedata.X = data.cell_X;
                    savedata.Y = data.cell_Y;
                    savedata.Area = data.cell_A;
                    savedata.Time = Time;
                end
                
                switch vars{i}
                    
                    case 'H'
                        savedata.(vars{i}) = mod.(vars{i});
                    case 'D'
                        savedata.(vars{i}) = mod.(vars{i});
                    case 'cell_A'
                        savedata.(vars{i}) = mod.(vars{i});
                    case  'WQ_DIAG_PHY_TCHLA'
                        savedata = run_tchla_cal(outdir,'WQ_DIAG_PHY_TCHLA');
                    case  'ON'
                        savedata = run_tchla_cal(outdir,'ON');
                    case  'OP'
                        savedata = run_tchla_cal(outdir,'OP');
                    otherwise
                        savedata.(vars{i}).Top = mod.(vars{i})(surf_ind,:);
                        %savedata.(vars{i}).Bot = mod.(vars{i})(bottom_ind,:);
                        
                end
                
                
                
                save([outdir,vars{i},'.mat'],'savedata','-mat','-v7.3');
                clear savedata mod;
            end
            
        end
    end
end


