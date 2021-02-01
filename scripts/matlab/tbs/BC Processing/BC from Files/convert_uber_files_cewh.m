clear all; close all;

addpath(genpath('tuflowfv'));

dirlist = dir(['Old_Uber/','*.csv']);


vars = {'ISOTime','FLOW','SAL','TEMP','TRACE_1','SS1','RET','OXY',...
    'DIC','PH','CH4','RSI','AMM','NIT','FRP','FRP_ADS','DOC','POC','DON','PON','DOP','POP','GRN',...
    'FEII','FEIII','AL','CL','SO4','NA','K','MG','CA','PE','UBALCHG'};

newvars = {'ISOTime','FLOW','SAL','TEMP','TRACE_1','AGE','SS1','OXY',...
    'RSI','AMM','NIT','FRP','FRP_ADS','DOC','POC','DON','PON','DOP','POP','GRN'};

for i = 1:length(dirlist)
    
    data = tfv_readBCfile(['Old_Uber/',dirlist(i).name]);
    
    for j = 1:length(newvars)
        if strcmpi(newvars{j},'AGE') == 0
            wdata.(newvars{j}) = data.(newvars{j});
        else
            wdata.(newvars{j}) = data.RET;
        end
    end
    
    write_tfv_file(['New_Uber/',dirlist(i).name],wdata);
    
    clear wdata data;
end
    
    