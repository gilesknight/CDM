clear all; close all;

addpath(genpath('tuflowfv'));
addpath(genpath('Functions'));


ncfile = 'K:\Lowerlakes-CEW-Results\lower_lakes.nc';

load barrages.mat;


barrages = barrages;

ns.outfile = {'Tauwitchere_v3.csv';'Ewe_v3.csv';'Boundary_v3.csv';'Mundoo_v3.csv';'Goolwa_v3.csv';};

pnt(1,1) = 319928.0;
pnt(1,2) = 6060308.0;

pnt(2,1) = 316253.0;
pnt(2,2) = 6062708.0;


pnt(3,1) = 314279.0;
pnt(3,2) = 6063808.0;

pnt(4,1) = 310144.0;
pnt(4,2) = 6063808.0;

pnt(5,1) = 300360.0;
pnt(5,2) = 6066992.0;


datearray = [datenum(2013,07,01):1:datenum(2019,07,01)];

for bb = 1:length(ns.outfile)
   
    dd = strsplit(ns.outfile{bb},'_');
    site = dd{1};
    
    headers = {...
        'Flow',...
        'SAL',...
        'TEMP',...
        'TRACE_1',...
        'WQ_TRC_SS1',...
        'WQ_TRC_RET',...
        'WQ_OXY_OXY',...
        'WQ_SIL_RSI',...
        'WQ_NIT_AMM',...
        'WQ_NIT_NIT',...
        'WQ_PHS_FRP',...
        'WQ_PHS_FRP_ADS',...
        'WQ_OGM_DOC',...
        'WQ_OGM_POC',...
        'WQ_OGM_DON',...
        'WQ_OGM_PON',...
        'WQ_OGM_DOP',...
        'WQ_OGM_POP',...
        'WQ_PHY_GRN',...
        };
    
    write_headers = {...
        'Flow',...
        'SAL',...
        'TEMP',...
        'TRACE_1',...
        'SS1',...
        'RET',...
        'OXY',...
        'RSI',...
        'AMM',...
        'NIT',...
        'FRP',...
        'FRP_ADS',...
        'DOC',...
        'POC',...
        'DON',...
        'PON',...
        'DOP',...
        'POP',...
        'GRN',...
        };
    
    
    
    
    
    
    dat = tfv_readnetcdf(ncfile,'time',1);
    timesteps_all = dat.Time;
    
    rawGeo = tfv_readnetcdf(ncfile,'timestep',1);
    
    geo_x = double(rawGeo.cell_X);
    geo_y = double(rawGeo.cell_Y);
    dtri = DelaunayTri(geo_x,geo_y);
    
    
    
    temp = nearestNeighbor(dtri,pnt(bb,:));
    
    temp2 = find(rawGeo.idx2==temp);
    pnt_id = max(temp2);
    
    
%     ggg = find(timesteps_all >= (datearray(1)-10) & timesteps_all <= (datearray(end)+10));
%     
%     timesteps = timesteps_all(ggg);

       for kkk = 1:length(datearray)
           [~,int(kkk)] = min(abs(timesteps_all-datearray(kkk)));
           timesteps(kkk) = timesteps_all(int(kkk));
       end


    
    for i = 1:length(int)
        data = tfv_readnetcdf(ncfile,'timestep',int(i));
        clear function
        
        disp(datestr(timesteps_all(int(i)),'dd/mm/yyyy HH:MM:SS'));
        
        for k = 2:length(headers)
            if isfield(data,headers{k})
                out.(headers{k})(i) = data.(headers{k})(pnt_id);
            else
                out.(headers{k})(i) = 0;
            end
            
        end
        
        clear data;
        close all force;
        fclose all;
        clear functions
    end
    
    [uDate,ind] = unique(barrages.(site).Date);
    uFlow = barrages.(site).Flow(ind);
    
    
    inf.Flow = interp1(uDate,uFlow,datearray);
    
    
    inf.Date = datearray;
    
    for k = 2:length(headers)
        inf.(headers{k}) = interp1(timesteps,out.(headers{k}),datearray);
    end
    
    save inf.mat inf -mat;
    
    fid = fopen(ns.outfile{bb},'wt');
    
    fprintf(fid,'ISOTime,');
    
    vars = fieldnames(inf);
    
    for i = 1:length(write_headers)
            if i == length(write_headers)
                fprintf(fid,'%s\n',write_headers{i});
            else
                fprintf(fid,'%s,',write_headers{i});
            end
    end
    
    for j = 1:length(datearray)
        fprintf(fid,'%s,',datestr(inf.Date(j),'dd/mm/yyyy HH:MM:SS'));
        for i = 1:length(write_headers)
                if i == length(write_headers)
                    fprintf(fid,'%6.6f\n',inf.(headers{i})(j));
                else
                    fprintf(fid,'%6.6f,',inf.(headers{i})(j));
                end
        end
    end
    fclose(fid);
    
end

