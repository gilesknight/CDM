function create_tfv_inflow_file(data,headers,datearray,filename,X,Y,subdir,sitename)


if ~exist(subdir,'dir');
    mkdir(subdir);
end

[XX,YY,sites,dist] = ranksites(X,Y,data);


ISOTime = datearray;


fid1 = fopen([subdir,sitename,'_summery.csv'],'wt');
fprintf(fid1,'Variable,Site\n');

for i = 1:length(headers)
    
    [site_ID,site_X,site_Y,site_Name] = find_site(data,sites,headers{i},10,XX,YY);
    if site_ID < 900
        disp(['Data found for: ',headers{i},' at ',sites{site_ID}]);
    else
        disp(['No data found for:',headers{i}]);
    end
    
    if site_ID < 900
        tfv_data.(headers{i}) = create_interpolated_dataset(data.(sites{site_ID}),headers{i},'Surface',datearray);
    else
        tfv_data.(headers{i})(1:length(datearray),1) = 0;
    end
    
    tfv_data.(headers{i})(tfv_data.(headers{i}) == 999.9) = 0;
    
    % Last the UBALCHG
    
    if strcmpi(headers{i},'WQ_GEO_UBALCHG') == 1
       save tfv_data.mat tfv_data -mat;
       tfv_data.(headers{i}) = calc_chgbal(tfv_data);
    end
    
    
    plot_variable(tfv_data.(headers{i}),datearray,headers{i},site_X,site_Y,site_Name,subdir,X,Y,sitename);
    
    fprintf(fid1,'%s,%s\n',headers{i},site_Name);
    
end




save([subdir,'data.mat'],'tfv_data','ISOTime','-mat');

write_tfvfile(tfv_data,headers,ISOTime,filename);

end % End Function......




function write_tfvfile(tfv_data,headers,ISOTime,filename)

disp(['Writing: ',filename]);

fid = fopen(filename,'wt');
fprintf(fid,'ISOTime,');
for i = 1:length(headers)
    
    tt = strsplit(headers{i},'_');
    if length(tt) == 3
        header_ID = tt{3};
    else
        if length(tt) == 4
            header_ID = [tt{3},'_',tt{4}];
        else
            header_ID = headers{i};
        end
    end
    
    if strcmpi(header_ID,'H') == 1
        header_ID = 'WL';
    end
    
    if i == length(headers)
        
        fprintf(fid,'%s\n',header_ID);
    else
        fprintf(fid,'%s,',header_ID);
    end
end
for i = 1:length(ISOTime)
    fprintf(fid,'%s,',datestr(ISOTime(i),'dd/mm/yyyy HH:MM:SS'));
    for j = 1:length(headers)
        if j == length(headers)
            fprintf(fid,'%4.4f\n',tfv_data.(headers{j})(i));
        else
            fprintf(fid,'%4.4f,',tfv_data.(headers{j})(i));
        end
    end
end
fclose(fid);




end

function plot_variable(ydata,xdata,varname,site_X,site_Y,site_Name,subdir,X,Y,sitename)
filename = [subdir,varname,'.png'];

figure('position',[555 635 1018 343]);
plot(xdata,ydata,'k');

title(regexprep(varname,'_',' '));

x_array = xdata(1):(xdata(end)-xdata(1))/5:xdata(end);

set(gca,'xtick',x_array,'xticklabel',datestr(x_array,'mm/yyyy'));

xlim([xdata(1) xdata(end)]);

saveas(gcf,filename);

close

S(1).X = X;
S(1).Y = Y;
S(1).Name = sitename;
S(1).Geometry = 'Point';

S(2).X = site_X;
S(2).Y = site_Y;
S(2).Name = site_Name;
S(2).Geometry = 'Point';

shapename = regexprep(filename,'png','shp');

shapewrite(S,shapename);

% fid = fopen(regexprep(filename,'.png','.txt'),'wt');
% 
% fprintf(fid,'Data for %s from %s\n',sitename,site_Name);
% 
% fclose(fid);



end


function [site_id,site_X,site_Y,site_Name] = find_site(data,sites,varname,num_sample,XX,YY)
isfound = 0;
site_id = 999; % Default for no data found...

while num_sample > 0 & isfound == 0
    for j = 1:length(sites)
        if ~isfound
            if isfield(data.(sites{j}),varname)
                % Some data available.
                if length(data.(sites{j}).(varname).Data) > num_sample
                    % a decent amount of data.....
                    site_id = j;
                    isfound = 1;
                end
            end
        end
    end
    
    if isfound == 0
        num_sample = num_sample -1;
    end
end
if site_id < 900
    site_X = XX(site_id);
    site_Y = YY(site_id);
    site_Name = sites{site_id};
else
    site_X = 0;
    site_Y = 0;
    site_Name = 'No Site';
end


end


function var = create_interpolated_dataset(data,varname,depth,mtime)
% A Function to take a AED data structure, site and variable and create an
% interpolated dataset for use in creation of the input files
tt_data = data.(varname).Data;

if isfield(data.(varname),'Depth')
    t_depth = data.(varname).Depth;
else
    t_depth(1:length(tt_data),1) = 0;
end

tt_date = floor(data.(varname).Date);

u_date = unique(tt_date);

t_data(1:length(u_date)) = NaN;
t_date(1:length(u_date)) = NaN;
for iii = 1:length(u_date)
    [min_val,sss] = min(abs(tt_date - u_date(iii)));
    
%     switch depth
%         case 'Bottom'
%             [~,ind] = min(t_depth(sss));
%         case 'Surface'
%             [~,ind] = max(t_depth(sss));
%         otherwise
%             disp('Not a valid depth name');
%     end
    if min_val < 2
        t_data(iii) = tt_data(sss);
        t_date(iii) = data.(varname).Date(sss);
    else
        stop
    end
end

ss = find(~isnan(t_data) == 1);

t_date_NoNaN = t_date(ss);
t_data_NoNaN = t_data(ss);



[t_date_NoNaN_years,t_data_NoNaN_years] = replicate_years(t_date_NoNaN,t_data_NoNaN,mtime);

%disp(['Number of sameples to be interp: ',num2str(size(t_data_NoNaN_years))]);

if length(t_date_NoNaN_years) > 1
    var = interp1(t_date_NoNaN_years,t_data_NoNaN_years,mtime,'linear',mean(t_data_NoNaN_years));
else
    var(1:length(mtime),1) = mean(t_data_NoNaN_years);
end

var(isnan(var)) = 999.9;

end

function [date_year_u,data_year_u] = replicate_years(tdate,tdata,mtime)


tdata_1(:,1) = tdata;
tdate_1(:,1) = tdate;


[yyyy,~,~] = datevec(mtime);

[tyyy,~,~] = datevec(tdate_1);

u_years = unique(yyyy);

date_year = [];
data_year = [];

for i = 1:length(u_years)
    
    ss = find(tyyy == u_years(i));
    
    % is there no data in that year.
    if isempty(ss)
        
        % Find the closest years data
        inc = 1;
% %         %for k = 1:length(u_years)
        [~,tt] = min(abs(tyyy - u_years(i)));
            %[~,ind] = min(abs(tyyy - u_years(i)));
        % Index of that data
          %  tt = find(tyyy == u_years(k));
% % %             if ~isempty(tt)
% % %                 kk(inc) = length(tt);
% % %                 yy(inc) = u_years(k);
% % %                 inc = inc + 1;
% % %             end
% % %         end
        
 %%%           [~,ind1] = max(kk);

%%%            bb = find(tyyy == yy(ind1));
            bb = find(tyyy == tyyy(tt));
 %%%           dateshift = (yy(ind1) - u_years(i)) * 365;
            dateshift = (tyyy(tt) - u_years(i)) * 365;
        %disp(['Data for closest year: ',num2str(tyyy(ind(1)))]);
            new_date(:,1) = tdate_1(bb) - dateshift;
            new_data(:,1) = tdata_1(bb);
            
        
        %disp(['Amount of replicated data: ',num2str(length(new_data))])
        
        date_year = [date_year;new_date];
        data_year = [data_year;new_data];
        
        clear new_date new_data;
        
    else
        date_year = [date_year;tdate_1(ss)];
        data_year = [data_year;tdata_1(ss)];
    end
    
    %disp(['Size of data: ',num2str(length(data_year))])
    
end

%disp(['Size of data: ',num2str(length(data_year))])
[date_year_u,ind2] = unique(date_year,'sorted');
data_year_u = data_year(ind2);

%disp(['Number of sameples to be interp: ',num2str(size(data_year_u))]);



end



function [rXX,rYY,rSites,rDist] = ranksites(X,Y,data)

% Get a list of all sites...

sites = fieldnames(data);

XX(1:length(sites),1) = NaN;
YY(1:length(sites),1) = NaN;

for i = 1:length(sites)
    vars = fieldnames(data.(sites{i}));
    XX(i,1) = data.(sites{i}).(vars{1}).X;
    YY(i,1) = data.(sites{i}).(vars{1}).Y;
end

% Calculate distance from point

dist(1:length(XX)) = 0;
for ii = 1:length(XX)
    dist(ii) = sqrt((XX(ii)-X) .^2 + (YY(ii) - Y).^2);
end

[rDist,ind] = sort(dist);
rSites = sites(ind);
rXX = XX(ind);
rYY = YY(ind);

end

