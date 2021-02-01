function merged = join_sites_by_variable(varname)

%NewDate
% Wind to do both Wx & Wx
%           Rad_Model: [1×80364 double]
%            TC_interp: [1×80364 double]
%            Wx_interp: [1×80364 double]
%            Wy_interp: [1×80364 double]
%            RH_interp: [1×80364 double]
%          Temp_interp: [1×80364 double]
%       W_Speed_interp: [1×80364 double]
%         W_Dir_interp: [1×80364 double]

%or
%Date_daily
%Rain_interp



load Locations\sites.mat;

dirlist = dir('Raw');

%varname = 'Temp_interp';

for i = 3:length(dirlist)
    load(['Raw/',dirlist(i).name,'/metdata.mat']);
    
    disp(dirlist(i).name)
    
    ss = fieldnames(metdata);
    site = ss{1};
    
    if isfield(metdata.(site),'Processed')
        
        if strcmpi(varname,'Wind') == 1
            merged.(site).Wx = metdata.(site).Processed.Wx_interp;
            merged.(site).Wy = metdata.(site).Processed.Wy_interp;
        else
            
             merged.(site).(varname) = metdata.(site).Processed.(varname);
        end
        if strcmpi(varname,'Rain_interp') == 0
            merged.(site).Date = metdata.(site).Processed.NewDate;
        else
            merged.(site).Date = metdata.(site).Processed.Date_daily;
        end
        merged.(site).Lat = metdata.(site).Lat;
        merged.(site).Lon = metdata.(site).Lon;
    end
    
    clear metdata;
end

%save([varname,'.mat'],'-mat');

