function out_data = convert_data_hourly(data,startdate,enddate)

mdate = data.Date;

% startdate = min(mdate);
% enddate = max(mdate);

vars = fieldnames(data);
 
newarray = startdate:1/24:enddate;


for i = 1:length(vars)
    if length(data.(vars{i})) == length(mdate)
        if strcmpi(vars{i},'Date') == 0
            out_data.(vars{i})(:,1) = interp1(mdate,data.(vars{i}),newarray);
        else
            out_data.Date(:,1) = newarray;
        end
    else
        out_data.(vars{i}) = data.(vars{i});
    end
end