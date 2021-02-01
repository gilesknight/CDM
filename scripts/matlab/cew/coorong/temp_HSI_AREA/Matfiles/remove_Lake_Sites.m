clear all; close all;

load lowerlakes.mat;

shp = shaperead('Coorong_Boundary1.shp');

sites = fieldnames(lowerlakes);
for i = 1:length(sites)
    vars = fieldnames(lowerlakes.(sites{i}));
    if inpolygon(lowerlakes.(sites{i}).(vars{1}).X,lowerlakes.(sites{i}).(vars{1}).Y,shp.X,shp.Y)
        coorong.(sites{i}) = lowerlakes.(sites{i});
    end
end

save coorong.mat coorong -mat;

sites = {...
    'A4260633',...
    'A4261036',...
    'A4261039',...
    'A4261043',...
    'A4261128',...
    'A4261134',...
    'A4261135',...
    'A4261165',...
    'A4261209',...
    };

for i = 1:length(sites)
    coorong_mini.(sites{i}) = coorong.(sites{i});
    
end
save coorong_mini.mat coorong_mini -mat;



sites = {...
    'A4260633',...
    'A4261165',...
    'A4261209',...
    };

for i = 1:length(sites)
    coorong_sal.(sites{i}) = coorong.(sites{i});
    
end
save coorong_sal.mat coorong_sal -mat;