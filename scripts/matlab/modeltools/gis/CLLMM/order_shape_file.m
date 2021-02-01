clear all;close all;

shp = shaperead('report_sites.shp');

% Wellington;
X = 353467.27;
Y = 6088753.24;

dist = [];

for i = 1:length(shp)
    
    XX = shp(i).X;
    YY = shp(i).Y;
    
    gg = polygeom(XX(~isnan(XX)),YY(~isnan(XX)));
  
    mid_X = gg(2);
    mid_Y = gg(3);
    
    
        dist(i) = sqrt((mid_X - X) .^2 + (mid_Y - Y).^2);
    
    
    
end

[sdist,ind] = sort(dist);

for i = 1:length(ind)
    shp(ind(i)).Order = i;
end

shapewrite(shp,'report_sites_v2.shp');
