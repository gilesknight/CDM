clear all; close all;

%[snum,sstr] = xlsread('Barrage_flows_20121212_20160914_no_backflow.csv','A2:G31932');

filename = 'Barrage_flows_20121212_20160914_no_backflow.csv';

fid = fopen(filename,'rt');

textformat = [repmat('%s ',1,7)];

datacell = textscan(fid,textformat,'Headerlines',1,'Delimiter',',');

%Time,Q_Goolwa,Q_Mundoo,Q_EweIs,Q_Tauwitchere,Q_BoundaryCk,Sal

mDate(:,1) = datenum(datacell{1},'dd/mm/yyyy HH:MM');

% Flow is hourly so we can calculate the ML for each timestep first
% From m3/s to ML/hour

Goolwa(:,1) = str2double(datacell{2}) .* (60*60/1000);
Mundoo(:,1) = str2double(datacell{3}) .* (60*60/1000);
Ewe(:,1) = str2double(datacell{4}) .* (60*60/1000);
Tau(:,1) = str2double(datacell{5}) .* (60*60/1000);
Boundary(:,1) = str2double(datacell{6}) .* (60*60/1000);
%________________________________________________________________
SAL(:,1) = str2double(datacell{7});

[a_year,a_month,a_day] = datevec(mDate);

u_years = unique(a_year);
u_months = unique(a_month);

fid = fopen('WBM_Monthly_Barrage_Flows.csv','wt');
fprintf(fid,'Year,Month,Goolwa (GL),Mundoo (GL),Ewe (GL),Tau (GL),Boundary (GL),All (GL)\n');

for i = 1:length(u_years)
    for j = 1:length(u_months)
        
        ss = find(a_year == u_years(i) & a_month == u_months(j));
        
        if ~isempty(ss)
            % Convert from ML to GL
            Goolwa_sum = sum(Goolwa(ss)) / 1000;
            Mundoo_sum = sum(Mundoo(ss)) / 1000;
            Ewe_sum = sum(Ewe(ss)) / 1000;
            Tau_sum = sum(Tau(ss)) / 1000;
            Boundary_sum = sum(Boundary(ss)) / 1000;
            
            M_Total = Goolwa_sum + Mundoo_sum + Ewe_sum + Tau_sum + Boundary_sum;
            
            fprintf(fid,'%d,%d,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f\n',u_years(i),u_months(j),...
               Goolwa_sum,Mundoo_sum,Ewe_sum,Tau_sum,Boundary_sum,M_Total);
           
           clear Goolwa_sum Mundoo_sum Ewe_sum Tau_sum Boundary_sum M_Total;
           
        end
    end
end
fclose(fid);
            
            


