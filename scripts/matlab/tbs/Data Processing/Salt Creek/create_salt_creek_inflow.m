clear all; close all;

addpath(genpath('tuflowfv'));

filename = 'ModelledSEFlows_Salinity_1889-2016.xlsx';

% Sheet names....
% "Existing_1889-2016';
% 'Current_SEFRP_1889-2016';
% 'Extended_SEFRP_1889-2016';

sheets = {...
    'Existing_1889-2016',...
    'Current_SEFRP_1889-2016',...
    'Extended_SEFRP_1889-2016',...
    };



conv = 1000 / 86400;


data = tfv_readBCfile('Salt_2017.csv');
fn = fieldnames(data);

%_____________________________________________________________--
% Don't need to change code below here;

for i = 1:length(sheets)
    
    sheet_name = sheets{i};
    
    
    [snum,sstr] = xlsread(filename,sheet_name,'A2:E50000');
    
    mdate = datenum(sstr(:,1),'dd/mm/yyyy');
    
    flow = snum(:,3) * conv;
    
    sal = conductivity2salinity(snum(:,4));
    
    
    tdata = data;
    tdata.FLOW = [];
    tdata.SAL = [];
    
    tdata.FLOW = interp1(mdate,flow,data.Date,'linear','extrap');
    tdata.SAL = interp1(mdate,sal,data.Date,'linear','extrap');
    
    figure
    
    plot(data.Date,data.FLOW,'k');hold on;
    plot(tdata.Date,tdata.FLOW,'r');hold on;
    
    title('Flow');
    legend({'Existing','New'});
    datetick('x','mm-yy');
    saveas(gcf,[sheet_name,'_Flow.png']);
    close(gcf);
    
    
    
    figure
    
    plot(data.Date,data.SAL,'k');hold on;
    plot(tdata.Date,tdata.SAL,'r');hold on;
    
    title('SAL');
    legend({'Existing','New'});
    
    datetick('x','mm-yy');
    saveas(gcf,[sheet_name,'_SAL.png']);
    close(gcf);
    
    disp('Writing file');
    
    fid = fopen(['Salt_Creek_',sheet_name,'.csv'],'wt');
    
    fprintf(fid,'ISOTime,');
    
    for j = 2:length(fn)
        if j == length(fn)
            fprintf(fid,'%s\n',fn{j});
        else
            fprintf(fid,'%s,',fn{j});
        end
    end
    
    for k = 1:length(tdata.Date)
        fprintf(fid,'%s,',datestr(tdata.Date(k),'dd/mm/yyyy HH:MM'));
        
        for j = 2:length(fn)
            if j == length(fn)
                fprintf(fid,'%6.6f\n',tdata.(fn{j})(k));
            else
                fprintf(fid,'%6.6f,',tdata.(fn{j})(k));
            end
        end
    end
    fclose(fid);
end
    