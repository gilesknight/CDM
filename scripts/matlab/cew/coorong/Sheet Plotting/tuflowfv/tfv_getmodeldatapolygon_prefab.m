function [data,c_units,isConv] = tfv_getmodeldatapolygon_prefab(filename,Name,varname,depth_range)
%--% Function to load the tuflowFV model output at a specified location
% (X,Y).
% Usage: H = H = getmodeldatalocation(filename,X,Y,varname)
load([filename,'/',Name,'/D.mat']);

D = savedata.D;

load([filename,'/',Name,'/',varname{1},'.mat']);

data1.surface = savedata.(varname{1}).Top;
data1.bottom = savedata.(varname{1}).Bot;

% rawGeo = tfv_readnetcdf(filename,'timestep',1);
% clear functions
% inpol = inpolygon(X,Y,sX,sY);
% sss = find(inpol == 1);
pred_lims = [0.05,0.25,0.5,0.75,0.95];
num_lims = length(pred_lims);
nn = (num_lims+1)/2;

[data.surface,c_units,isConv] = tfv_Unit_Conversion(data1.surface,varname{1});
[data.bottom,c_units,isConv]  = tfv_Unit_Conversion(data1.bottom,varname{1});

%
%         point_D = D(pt_id,:);
%         %Get curtain series of predictive limits for variable varname
%
%         %ddd = find(point_D <= 0.042);
ddd = find(D <= depth_range(1) | D >= depth_range(2));
%
%
data.surface(ddd) = NaN;
data.bottom(ddd) = NaN;
%
%
% end







[~,iy] = size(data.surface);

%dat = tfv_readnetcdf(filename,'time',1);
tdate = savedata.Time;

%if strcmp(varname{1},'H') == 0

inc = 1;
for i = 1:iy
    xd = data.surface(:,i);
    if sum(isnan(xd)) < length(xd)
        xd(isnan(xd)) = mean(xd(~isnan(xd)));
        data.pred_lim_ts(:,inc) = plims(xd,pred_lims);
        data.date(inc,1) = tdate(i);
        inc = inc + 1;
    end
end

inc = 1;
for i = 1:iy
    xd = data.bottom(:,i);
    if sum(isnan(xd)) < length(xd)
        xd(isnan(xd)) = mean(xd(~isnan(xd)));
        data.pred_lim_ts_b(:,inc) = plims(xd,pred_lims);
        data.date_b(inc,1) = tdate(i);
        inc = inc + 1;
    end
end



% else
%     data.date = tdate;
% end




%Set limits for predictive plot as 2.5%, 50.0% and 97.5%
%pred_lims = [0.025,0.5,0.975];

