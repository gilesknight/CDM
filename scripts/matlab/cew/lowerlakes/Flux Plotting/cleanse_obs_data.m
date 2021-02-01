function flux_out = cleanse_obs_data(flux,xarray)

sites = fieldnames(flux);
for i = 1:length(sites)
    vars = fieldnames(flux.(sites{i}));
    
    ss = find(flux.(sites{i}).mDate >= xarray(1));
    flux_out.(sites{i}).mDate = flux.(sites{i}).mDate(ss);
    for j = 1:length(vars)
        if strcmpi(vars{j},'mDate') == 0
            flux_out.(sites{i}).(vars{j}) = flux.(sites{i}).(vars{j})(ss);
        end
    end
end