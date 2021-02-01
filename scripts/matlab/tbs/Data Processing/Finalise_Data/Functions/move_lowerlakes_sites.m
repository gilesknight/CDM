sites = fieldnames(lowerlakes);

shp = shaperead('GIS/LL_Data_GIS.shp');

for i = 1:length(shp)
    
    disp(['Moving Site: ',shp(i).Name]);
    if isfield(lowerlakes,shp(i).Name)
        vars = fieldnames(lowerlakes.(shp(i).Name));
        
        for j = 1:length(vars)
            
            lowerlakes.(shp(i).Name).(vars{j}).X = shp(i).X;
            lowerlakes.(shp(i).Name).(vars{j}).Y = shp(i).Y;
        end
    end
    
end
