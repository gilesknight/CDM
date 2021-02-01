addpath(genpath('Functions'));

clear all; close all;

epa_2016 = [];

filename = 'Merged.xlsx';

[~,sites] = xlsread(filename,'H2:H210000');

sites = regexprep(sites,'EPA -  ','');
sites = regexprep(sites,'EPA - ','');
sites = regexprep(sites,'EPA- ','');

u_sites = unique(sites);


[xdate,sstr] = xlsread(filename,'M2:M20000');

mdate = x2mdate(xdate);

[~,vars] = xlsread(filename,'K2:K20000');

u_vars = unique(vars);
%
% fid = fopen('epa_vars.csv','wt');
% for i = 1:length(u_vars)
%     fprintf(fid,'%s\n',u_vars{i});
% end
% fclose(fid);
%
% fid = fopen('epa_sites.csv','wt');
% for i = 1:length(u_sites)
%     fprintf(fid,'%s\n',u_sites{i});
% end
% fclose(fid);




[rdata,~] = xlsread(filename,'P2:P20000');


[snum,sstr] = xlsread('2016_vars.xlsx','A2:D100');

old_var = sstr(:,1);
AED_var = sstr(:,2);
units = sstr(:,3);
conv = snum(:,1);

[snum,sstr] = xlsread('2016_sites.xlsx','A2:D100');

old_site = sstr(:,1);
new_site = sstr(:,2);
X = snum(:,1);
Y = snum(:,2);

for i = 1:length(u_sites)
    
    ss = find(strcmpi(sites,u_sites{i}) == 1);
    
    tt = find(strcmpi(old_site,u_sites{i}) == 1);
    
    nSite = new_site{tt};
    nX = X(tt);
    nY = Y(tt);
    
    for j = 1:length(u_vars)
        
        
        tt = find(strcmpi(old_var,u_vars{j}) == 1);
        
        nVar = AED_var{tt};
        
        nConv = conv(tt);
        
        nUnits = units{tt};
        
        if strcmpi(nVar,'Ignore') == 0
            
            sss = find(strcmpi(vars(ss),u_vars{j}) == 1);
            
            if ~isempty(sss)
                
                if isfield(epa_2016,nSite)
                    
                    if ~isfield(epa_2016.(nSite),nVar)
                        
                        epa_2016.(nSite).(nVar).Data = rdata(ss(sss)) .* nConv(1);
                        epa_2016.(nSite).(nVar).Date = mdate(ss(sss));
                        epa_2016.(nSite).(nVar).Depth(1:length(sss),1) = 0;
                        epa_2016.(nSite).(nVar).X = nX;
                        epa_2016.(nSite).(nVar).Y = nY;
                        epa_2016.(nSite).(nVar).Units = nUnits;
                        
                    else
                        
                        epa_2016.(nSite).(nVar).Data = [epa_2016.(nSite).(nVar).Data;rdata(ss(sss)) .* nConv(1)];
                        epa_2016.(nSite).(nVar).Date = [epa_2016.(nSite).(nVar).Date;mdate(ss(sss))];
                        
                    end
                else
                    epa_2016.(nSite).(nVar).Data = rdata(ss(sss)) .* nConv(1);
                    epa_2016.(nSite).(nVar).Date = mdate(ss(sss));
                    epa_2016.(nSite).(nVar).Depth(1:length(sss),1) = 0;
                    epa_2016.(nSite).(nVar).X = nX;
                    epa_2016.(nSite).(nVar).Y = nY;
                    epa_2016.(nSite).(nVar).Units = nUnits;
                end
                
                
            end
        end
    end
end

sites = fieldnames(epa_2016);
for i = 1:length(sites)
    if isfield(epa_2016.(sites{i}),'WQ_PHY_GRN')
        epa_2016.(sites{i}).WQ_DIAG_PHY_TCHLA = epa_2016.(sites{i}).WQ_PHY_GRN;
        
        epa_2016.(sites{i}).WQ_DIAG_PHY_TCHLA.Data = epa_2016.(sites{i}).WQ_DIAG_PHY_TCHLA.Data * (12 / 50);
    end
end


save Matfiles/epa_2016.mat epa_2016 -mat

merge_old_epa
