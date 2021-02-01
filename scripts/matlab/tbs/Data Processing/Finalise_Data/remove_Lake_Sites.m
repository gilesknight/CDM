function coorong = remove_Lake_Sites(lowerlakes,shapefile)

%
shp = shaperead(shapefile);

sites = fieldnames(lowerlakes);
for i = 1:length(sites)
    vars = fieldnames(lowerlakes.(sites{i}));
    if inpolygon(lowerlakes.(sites{i}).(vars{1}).X,lowerlakes.(sites{i}).(vars{1}).Y,shp.X,shp.Y)
        coorong.(sites{i}) = lowerlakes.(sites{i});
    end
end

save coorong.mat coorong -mat;