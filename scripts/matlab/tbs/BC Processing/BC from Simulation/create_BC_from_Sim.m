clear all; close all;

addpath(genpath('tuflowfv'));
addpath(genpath('Functions'));


ncfile = 'I:\Lowerlakes\004_Simulations\004_Coorong_2013_2016_AED_wSalt_Ck\Output\lower_lakes.nc';
fluxfile = 'I:\Lowerlakes\004_Simulations\004_Coorong_2013_2016_AED_wSalt_Ck\Output\lower_lakes_FLUX.csv';


% nodestring = 5;
%
% node_conversion = 1;
%
% % Tauwitchere
% % pnt(1,1) = 319928.0;
% % pnt(1,2) = 6060308.0;
%
% % Ewe
%  pnt(1,1) = 316253.0;
%  pnt(1,2) = 6062708.0;
%
%
% outfile = 'Ewe.csv';

ns.nodestring = [11 4 3];
ns.conversion = [1 1 1];

ns.outfile = {'Boundary.csv';'Mundoo.csv';'Goolwa.csv';};

pnt(1,1) = 314279.0;
pnt(1,2) = 6063808.0;

pnt(2,1) = 310144.0;
pnt(2,2) = 6063808.0;

pnt(3,1) = 300360.0;
pnt(3,2) = 6066992.0;

for bb = 1:length(ns.outfile)
    
    node_conversion = ns.conversion(bb);
    nodestring = ns.nodestring(bb);
    
    
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
    
    
    flux = tfv_process_fluxfile(fluxfile,headers);
    
    flux.(['NS',num2str(nodestring)]).Flow = flux.(['NS',num2str(nodestring)]).Flow .* node_conversion;
    
    
    
    dat = tfv_readnetcdf(ncfile,'time',1);
    timesteps = dat.Time;
    
    rawGeo = tfv_readnetcdf(ncfile,'timestep',1);
    
    geo_x = double(rawGeo.cell_X);
    geo_y = double(rawGeo.cell_Y);
    dtri = DelaunayTri(geo_x,geo_y);
    
    
    
    temp = nearestNeighbor(dtri,pnt(bb,:));
    
    temp2 = find(rawGeo.idx2==temp);
    pnt_id = max(temp2);
    
    
    
    for i = 1:length(timesteps)
        data = tfv_readnetcdf(ncfile,'timestep',i);
        clear function
        
        disp(datestr(timesteps(i),'dd/mm/yyyy HH:MM:SS'));
        
        for k = 2:length(headers)
            if isfield(data,headers{k})
                inf.(headers{k})(i) = data.(headers{k})(pnt_id);
            else
                inf.(headers{k})(i) = 0;
            end
            
        end
        
        clear data;
        close all force;
        fclose all;
        clear functions
    end
    
    
    inf.Flow = interp1(flux.(['NS',num2str(nodestring)]).mDate,flux.(['NS',num2str(nodestring)]).Flow,timesteps);
    
    
    inf.Date = timesteps(1:length(inf.SAL));
    save inf.mat inf -mat;
    
    fid = fopen(ns.outfile{bb},'wt');
    
    fprintf(fid,'ISOTime,');
    
    vars = fieldnames(inf);
    
    for i = 1:length(vars)
        if strcmpi(vars{i},'Date') == 0
            if i == length(write_headers)
                fprintf(fid,'%s\n',write_headers{i});
            else
                fprintf(fid,'%s,',write_headers{i});
            end
        end
    end
    
    for j = 1:length(timesteps)
        fprintf(fid,'%s,',datestr(inf.Date(j),'dd/mm/yyyy HH:MM:SS'));
        for i = 1:length(write_headers)
            if strcmpi(vars{i},'Date') == 0
                if i == length(write_headers)
                    fprintf(fid,'%6.6f\n',inf.(headers{i})(j));
                else
                    fprintf(fid,'%6.6f,',inf.(headers{i})(j));
                end
            end
        end
    end
    fclose(fid);
    
end

