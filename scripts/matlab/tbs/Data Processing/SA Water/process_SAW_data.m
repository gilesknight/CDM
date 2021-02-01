addpath(genpath('Functions'));

filename = 'Uni WQ River Murray Data Request 1-1-17 -- 1-6-18.xlsx';

% Raw Data import
sheet = 'DATA';

[~,sstr] = xlsread(filename,sheet,'A3:C100000');

sites = sstr(:,3);




[snum,sstr] = xlsread(filename,sheet,'A3:H100000');

sites = sstr(:,3);

u_sites = unique(sites);

mdate = x2mdate(snum(:,3));

vars = sstr(:,5);

u_vars = unique(vars);

rdata = snum(:,5);


[snum,sstr] = xlsread(filename,'sheet1','A2:E10000');

old_sites = sstr(:,1);
new_sites = sstr(:,2);
do_conv = snum(:,3);




for i = 1:length(snum)
    if do_conv(i)
        [X(i),Y(i)] = ll2utm(snum(i,1),snum(i,2));
    else
        X(i) = snum(i,1);
        Y(i) = snum(i,2);
    end
end

[snum,sstr] = xlsread('SAW Conversions.xlsx','A4:C10000');

old_name = sstr(:,1);
aed_name = sstr(:,2);
conv = snum(:,1);

for i = 1:length(u_sites)
    
    s_name = u_sites{i};
    
    if ~isempty(s_name)
        
        ss = find(strcmpi(sites,u_sites{i}) == 1);
        
        tt = find(strcmpi(old_sites,u_sites{i}) == 1);
        
        nSite = new_sites{tt};
        nX = X(tt);
        nY = Y(tt);
        
        for j = 1:length(u_vars)
            
            s_var = u_vars{j};
            
            if ~isempty(s_var)
                
                tt = find(strcmpi(old_name,u_vars{j}) == 1);
                
                nVar = aed_name{tt};
                
                nConv = conv(tt);
                
                %nUnits = units{tt};
                
                if strcmpi(nVar,'Ignore') == 0
                    
                    sss = find(strcmpi(vars(ss),u_vars{j}) == 1);
                    
                    if ~isempty(sss)
                        if nConv > 0
                            saw_2018.(nSite).(nVar).Data = rdata(ss(sss)) .* nConv;
                        else
                            saw_2018.(nSite).(nVar).Data = conductivity2salinity(rdata(ss(sss)));
                        end
                        saw_2018.(nSite).(nVar).Date = mdate(ss(sss));
                        saw_2018.(nSite).(nVar).Depth(1:length(sss),1) = 0;
                        saw_2018.(nSite).(nVar).X = nX;
                        saw_2018.(nSite).(nVar).Y = nY;
                        %saw_2016.(nSite).(nVar).Units = nUnits;
                    end
                end
            end
        end
    end
end




saw_2018 = merge_sites(saw_2018);




save saw_2018.mat saw_2018 -mat


summerise_data('saw_2018.mat','saw_2018/');

load saw.mat;

saw = rmfield(saw,'Lock5');

save saw_r.mat saw -mat;
