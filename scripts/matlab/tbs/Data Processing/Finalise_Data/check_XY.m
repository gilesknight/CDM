function data = check_XY(data)

sites = fieldnames(data);
for i = 1:length(sites)
    vars = fieldnames(data.(sites{i}));
    for j = 1:length(vars)
        X = data.(sites{i}).(vars{j}).X;
        Y = data.(sites{i}).(vars{j}).Y;
        data.(sites{i}).(vars{j}).X = [];
        data.(sites{i}).(vars{j}).Y = [];
        data.(sites{i}).(vars{j}).X = X(1);
        data.(sites{i}).(vars{j}).Y = Y(1);  
        
        if length(X) > 1
            disp([sites{i},' had dodgy Co-Ords']);
        end
        
    end
end