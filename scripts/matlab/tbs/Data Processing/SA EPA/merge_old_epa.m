clear all; close all;

load Matfiles/epa_2016.mat;
load Matfiles/lowerlakes.mat;

epa_new = epa_2016;

epa_sites = fieldnames(epa_new);

vars = fieldnames(lowerlakes.Coorong_sub_lagoon_7_Parnka_Point);
for i = 1:length(vars)
    lowerlakes.Coorong_sub_lagoon_7_Parnka_Point.(vars{i}).X = epa_2016.Parnka_Point.WQ_DIAG_TOT_TN.X;
    lowerlakes.Coorong_sub_lagoon_7_Parnka_Point.(vars{i}).Y = epa_2016.Parnka_Point.WQ_DIAG_TOT_TN.Y;
end

vars = fieldnames(lowerlakes.Coorong_sub_lagoon_9_Stoney_Well);
for i = 1:length(vars)
    lowerlakes.Coorong_sub_lagoon_9_Stoney_Well.(vars{i}).X = epa_2016.Stoney_Well.WQ_DIAG_TOT_TKN.X;
    lowerlakes.Coorong_sub_lagoon_9_Stoney_Well.(vars{i}).Y = epa_2016.Stoney_Well.WQ_DIAG_TOT_TKN.Y;
end

vars = fieldnames(lowerlakes.Coorong_sub_lagoon_3_Long_Point);
for i = 1:length(vars)
    lowerlakes.Coorong_sub_lagoon_3_Long_Point.(vars{i}).X = epa_2016.Long.WQ_DIAG_TOT_TKN.X;
    lowerlakes.Coorong_sub_lagoon_3_Long_Point.(vars{i}).Y = epa_2016.Long.WQ_DIAG_TOT_TKN.Y;
end


for i = 1:length(epa_sites)
    
    vars = fieldnames(epa_new.(epa_sites{i}));
    X(i,1) = epa_new.(epa_sites{i}).(vars{1}).X(1);
    Y(i,1) = epa_new.(epa_sites{i}).(vars{1}).Y(1);
    
end

ll_sites = fieldnames(lowerlakes);



for i = 1:length(ll_sites)
    
    vars = fieldnames(lowerlakes.(ll_sites{i}));
    
    found_site = 0;
    sname = [];
    
    llX = lowerlakes.(ll_sites{i}).(vars{1}).X(1);
    llY = lowerlakes.(ll_sites{i}).(vars{1}).Y(1);
    
    % See if the current lower lakes site matches our epa site.
    for j = 1:length(X)
        
        if X(j) == llX & Y(j) == llY
            found_site = 1;
            sname = ll_sites{i};
            epa_site = epa_sites{j};
            
            
         if strcmpi(epa_site,'Salt') == 0 & strcmpi(epa_site,'Salt_Creek_South_12') == 0
                  disp([sname,' == ',epa_site]);

            for j = 1:length(vars)
                if ~isfield(epa_new.(epa_site),vars{j})
                    epa_new.(epa_site).(vars{j}) = lowerlakes.(sname).(vars{j});
                else
                    
                    date1(:,1) = epa_new.(epa_site).(vars{j}).Date;
                    date2(:,1) = lowerlakes.(sname).(vars{j}).Date;
                    data1(:,1) = epa_new.(epa_site).(vars{j}).Data;
                    data2(:,1) = lowerlakes.(sname).(vars{j}).Data;
                    
                    
                    epa_new.(epa_site).(vars{j}).Date = [];
                    epa_new.(epa_site).(vars{j}).Data = [];
                    epa_new.(epa_site).(vars{j}).Depth = [];
                    
                    epa_new.(epa_site).(vars{j}).Date = [date1;date2];
                    epa_new.(epa_site).(vars{j}).Data = [data1;data2];
                    
                    [epa_new.(epa_site).(vars{j}).Date,ind] = sort(epa_new.(epa_site).(vars{j}).Date);
                    epa_new.(epa_site).(vars{j}).Data = epa_new.(epa_site).(vars{j}).Data(ind);
                    epa_new.(epa_site).(vars{j}).Depth(1:length(ind),1) = 0;
                    
                    clear date1 date2 data1 data2;
                    
                end
            end
            
         end  
            
        end
    end
 
end

ll_sites_1
for i = 1:length(ll_sites)
    epa_new.(['ll_',ll_sites{i}]) = lowerlakes.(ll_sites{i});
end


save epa_new.mat epa_new -mat;

%summerise_data('epa_new.mat','epa_new/');





















