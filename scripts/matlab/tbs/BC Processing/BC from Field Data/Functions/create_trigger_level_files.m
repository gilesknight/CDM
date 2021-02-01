clear all; close all;

load lowerlakes.mat;

datecheck = datenum(2009,04,01);

% %_______________________
% 
 datearray = datenum(2008,01,01):01:datenum(2015,01,01);
% height(1:length(datearray)) = 0.8;
% 
% % Clayton weir..................................
% fid = fopen('BCs/Weir_TS_08.csv','wt');
% fprintf(fid,'time,weir_crest\n');
% 
% clay_height = height;
% 
% % sss = find(datearray < datenum(2009,07,01));
% % 
% % clay_height(sss) = 1;
% % sss = find(datearray > datenum(2010,09,01));
% % clay_height(sss) = 1;
% 
% mHours = [0:1:length(datearray)];
% mHours = mHours * 24;
% 
% for i = 1:length(datearray)
%     fprintf(fid,'%s,%4.2f\n',datestr(datearray(i),'dd/mm/yyyy'),clay_height(i));
% end
% fclose(fid);
% 
% % Narrung weir..................................
% fid = fopen('BCs/Narrung_Weir_TS.csv','wt');
% fprintf(fid,'time,weir_crest\n');
% 
% clay_height = height;
% 
% sss = find(datearray > datenum(2010,09,01));
% clay_height(sss) = 0;
% 
% for i = 1:length(datearray)
%     fprintf(fid,'%s,%4.2f\n',datestr(datearray(i),'dd/mm/yyyy'),clay_height(i));
% end
% fclose(fid);
% 


% Barrage trigger heights..................................

col = {'r';'k'};

filename = {'BCs/goolwa_target.csv','BCs/tauwitchere_target.csv'};

siteID = {'A4261123','A4261156'};

xdata = datearray;

for i = 1:length(filename)
    
    for k = 1:length(xdata)
        sss = find(floor(lowerlakes.(siteID{i}).H.Date) == xdata(k));
        
        if ~isempty(sss)
        
            tdata = lowerlakes.(siteID{i}).H.Data(sss);
            ydata(k) = mean(tdata(~isnan(tdata)));
            
        else
            ydata(k) = 0.5;
            
        end
    end
    sss = find(isnan(ydata) ==1);
    if ~isempty(sss)
        for k = 1:length(sss)
            ydata(sss(k)) = ydata(sss(k)+4);
        end
    end
    
    fid = fopen(filename{i},'wt');
    
    fprintf(fid,'time,target_value\n');
    
    
    ydata = smooth(ydata,95);
    
    sss = find(xdata == datecheck);
    ydata(sss)
    ydata(sss:sss+10)
    
    for j = 1:length(xdata)
        fprintf(fid,'%s,%4.4f\n',datestr(xdata(j),'dd/mm/yyyy'),ydata(j));
    end
    fclose(fid);
    
    outX(:,i) = xdata; 
    outY(:,i) = ydata;
end


save out.mat outX outY -mat
