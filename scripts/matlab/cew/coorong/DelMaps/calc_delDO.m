function dataout = calc_delDO(data_in,conv,time_in)

data_in = data_in * conv;

uTime = unique(floor(time_in));

for i = 1:length(uTime)
    sss = find(floor(time_in) == uTime(i));
    for j = 1:size(data_in,1)
        delDO(j,i) = max(data_in(j,sss)) - min(data_in(j,sss));
    end
end
dataout  = mean(delDO,2);   
        
        
        

% 
% data_calc(1:size(data_in,1),1:size(data_in,2)) = 0;
% 
% for i = 1:size(data_in,2)
%     
%     sss = find(data_in(:,i) < 4);
%     
%     data_calc(sss,i) = 1/size(data_in,2);
%     
% end

%dataout = sum(data_calc,2);