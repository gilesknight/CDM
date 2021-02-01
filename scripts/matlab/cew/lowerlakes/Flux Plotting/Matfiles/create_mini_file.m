%clear all; close all;

%clear all; close all;

load lowerlakes.mat;

% X = lowerlakes.Lake_Alexandrina_Middle.SAL.X;
% Y = lowerlakes.Lake_Alexandrina_Middle.SAL.Y;
% 
% clear lowerlakes;
% 
% load lowerlakes_2016.mat;
% 
% 
% vars = fieldnames(lowerlakes.Alex_Middle);
% for i = 1:length(vars)
%     lowerlakes.Alex_Middle.(vars{i}).X = X;
%     lowerlakes.Alex_Middle.(vars{i}).Y = Y;
% end
% 
% % downsample H
% 
% sites = fieldnames(lowerlakes);
% 
% 
% vars = fieldnames(lowerlakes.Tauwitcherie);
% % 
% % for i = 1:length(vars)
% %     lowerlakes.Tauwitcherie.(vars{i}).X = lowerlakes.Tauwitchere_US.SAL.X;
% %     lowerlakes.Tauwitcherie.(vars{i}).Y = lowerlakes.Tauwitchere_US.SAL.Y;
% % end
% 
% for i= 1:length(sites)
%     if isfield(lowerlakes.(sites{i}),'H')
%         disp(sites{i});
%         xdata = lowerlakes.(sites{i}).H.Date;
%         ydata = lowerlakes.(sites{i}).H.Data;
%         
%         if length(xdata > 300)
%             mdate = unique(floor(xdata));
%             for k = 1:length(mdate)
%                 ss = find(floor(xdata) == mdate(k));
%                 
%                 newx(k) = mdate(k);
%                 newy(k) = mean(ydata(ss));
%             end
%         end
%         
%         lowerlakes.(sites{i}).H.Date = [];
%         lowerlakes.(sites{i}).H.Data = [];
%         lowerlakes.(sites{i}).H.Depth = [];
%         
%         lowerlakes.(sites{i}).H.Date(:,1) = newx;
%         lowerlakes.(sites{i}).H.Data(:,1) = newy;
%         lowerlakes.(sites{i}).H.Depth(1:length(newx),1) = 0;
%         
%     end
% end
% 
% 
% 







sites = {...
%     'Monument',...
%     'Mouth',...
%     'Tauwitcherie',...
%     'Mundoo',...
%     'Ewe',...
%     'Mark',...
%     'Long',...
%     'Bonneys',...
%     'Yumpa',...
%     'Salt',...
%     'North_Jack',...
%     'Parnka',...
'EPA2014_Lake_Alexandrina_Middle',...
    };

all_sites = fieldnames(lowerlakes);

lowerlakes_river = [];
lowerlakes_coorong = [];

for i = 1:length(all_sites)
    
    ss = find(strcmp(sites,all_sites{i}) == 1);
    
    if ~isempty(ss)
        
        if strcmp(all_sites{i},'Tauwitcherie') == 1
            lowerlakes_coorong.Tauwitchere = lowerlakes.Tauwitcherie;
        else
            disp(['Coorong: ',all_sites{i}]);
            
            lowerlakes_coorong.(all_sites{i}) = lowerlakes.(all_sites{i});
            
        end
        
        %     else
        %         disp(['River: ',all_sites{i}]);
        %         lowerlakes_river.(all_sites{i}) = lowerlakes.(all_sites{i});
    end

    
end

%save lowerlakes_river.mat lowerlakes_river -mat;
save lowerlakes_coorong.mat lowerlakes_coorong -mat;


sites = {...
%     'Tailem_Bend',...
%     'Swan_Reach_SP',...
%     'Murray_Bridge_SP',...
%     'Morgan',...
%     'Blanchetown',...
'EPA2014_Lake_Alexandrina_Middle',...
    };

all_sites = fieldnames(lowerlakes);

lowerlakes_river = [];
lowerlakes_coorong = [];

for i = 1:length(all_sites)
    
    ss = find(strcmp(sites,all_sites{i}) == 1);
    
    if ~isempty(ss)
        disp(['River: ',all_sites{i}]);
        
        lowerlakes_river.(all_sites{i}) = lowerlakes.(all_sites{i});
    end
    
end

save lowerlakes_river.mat lowerlakes_river -mat;



%load lowerlakes.mat;

% sites = {'Wellington','Alex_Middle','Mouth'};
% 
% for i = 1:length(sites)
%     lowerlakes_mini.(sites{i}) = lowerlakes.(sites{i});
% end
% 
% save lowerlakes_mini.mat lowerlakes_mini -mat;

lowerlakes_main = [];

sites = {...
%     'Salt',...
%     'Bonneys',...
%     'Ewe',...
%     'Jockwar',...
%     'Long',...
%     'Mark',...
%     'Monument',...
%     'Mundoo',...
%     'Mouth',...
%     'Tauwitcherie',...
%     'Tauwitchere_US',...
%     'Narrung',...
%     'Albert_Opening',...
%     'Albert_Middle',...
%     'Goolwa',...
%     'Alex_Middle',...
%     'Mcleay',...
%     'Wellington',...
%     'Loveday',...
%     'Poltalloch',...
%     'Tailem_Bend',...
%     'Swan_Reach_SP',...
%     'Murray_Bridge_SP',...
%     'Morgan',...
%     'Blanchetown',...
%     'Parnka',...
'EPA2014_Lake_Alexandrina_Middle',...
    };

for i = 1:length(sites)
    if isfield(lowerlakes,sites{i})
        lowerlakes_main.(sites{i}) = lowerlakes.(sites{i});
    end
end

save lowerlakes_main.mat lowerlakes_main -mat;




lowerlakes_main_1 = [];

sites = {...
%     'Mouth',...
%     'Tauwitcherie',...
%     'Alex_Middle',...
%     'Wellington',...
%     'Albert_Middle',...
'EPA2014_Lake_Alexandrina_Middle',...
    };

for i = 1:length(sites)
    lowerlakes_main_1.(sites{i}) = lowerlakes.(sites{i});
end

save lowerlakes_main_1.mat lowerlakes_main_1 -mat;




%save ../../Initial' Conditions'/Matfiles/lowerlakes_main.mat lowerlakes_main -mat;
%clear all; close all;

% load lowerlakes_coorong.mat;
% 
% sites = {'Mouth'};
% 
% for i = 1:length(sites)
%     lowerlakes_coorong_mini.(sites{i}) = lowerlakes_coorong.(sites{i});
% end
% 
% save lowerlakes_coorong_mini.mat lowerlakes_coorong_mini -mat;

%clear all; close all;

% load lowerlakes_river.mat;
%
% sites = {'Wellington','Alex_Middle'};
% for i = 1:length(sites)
%     lowerlakes_river_mini.(sites{i}) = lowerlakes_river.(sites{i});
% end
%
% save lowerlakes_river_mini.mat lowerlakes_river_mini -mat;

% sites = {'Tauwitchere_US'};
% for i = 1:length(sites)
%     lowerlakes_tau_mini.(sites{i}) = lowerlakes_river.(sites{i});
% end
%
% save lowerlakes_tau_mini.mat lowerlakes_tau_mini -mat;