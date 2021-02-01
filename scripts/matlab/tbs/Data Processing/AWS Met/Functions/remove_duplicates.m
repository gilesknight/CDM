function umet = remove_duplicates(met)


if length(met.Date > 100)
    
    [umet.Date,ind] = unique(met.Date);
    
    vars = fieldnames(met);
    
    for i = 1:length(vars)
        if strcmpi(vars{i},'Date') == 0
            umet.(vars{i}) = met.(vars{i})(ind);
        end
    end
    
else
    umet = met;
end
