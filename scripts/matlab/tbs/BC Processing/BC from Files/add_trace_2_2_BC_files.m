clear all; close all;

addpath(genpath('tuflowfv'));

dirlist = dir(['Old Files/','*.csv']);

mkdir('New Files/');

for i = 2:length(dirlist)
    
    dd = strsplit(dirlist(i).name,'_');
    
    site_ID = dd{1};
    
    disp(['Importing ',dirlist(i).name]);
    
    data = tfv_readBCfile(['Old Files/',dirlist(i).name]);
    
    
    vars = fieldnames(data);
    
    
    switch site_ID
        case 'Salt'
            data.TRACE_1(1:length(data.Date)) = 0;
            data.TRACE_2(1:length(data.Date),1) = 1;
    
         case 'BK'
            data.TRACE_1(1:length(data.Date)) = 0;
            data.TRACE_2(1:length(data.Date),1) = 0;  
            
        otherwise
            data.TRACE_1(1:length(data.Date)) = 1;
            data.TRACE_2(1:length(data.Date),1) = 0;
    end
    
  data.MAG_ulva(1:length(data.Date)) = 0;
  data.MAG_ulva_IN(1:length(data.Date)) = 0;
  data.MAG_ulva_IP(1:length(data.Date)) = 0;
  
  
  % reorder
  
  for j = 1:length(vars)
      if strcmpi(vars{j},'TRACE_1') == 1
          wdata.TRACE_1 = data.TRACE_1;
          wdata.TRACE_2 = data.TRACE_2;
      else
          wdata.(vars{j}) = data.(vars{j});
      end
  end
  
   wdata.MAG_ulva = data.MAG_ulva;
   wdata.MAG_ulva_IN = data.MAG_ulva_IN;
   wdata.MAG_ulva_IP = data.MAG_ulva_IP;
   
   
   wdata
   
   write_tfv_file(['New Files/',dirlist(i).name],wdata);
   
   
   clear data wdata;
   
end
    
    
    
    
    