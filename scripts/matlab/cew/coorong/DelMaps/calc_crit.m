function dataout = calc_crit(data_in,conv)

data_in = data_in * conv;

data_calc(1:size(data_in,1),1:size(data_in,2)) = 0;

for i = 1:size(data_in,2)
    
    sss = find(data_in(:,i) < 4);
    
    data_calc(sss,i) = 1/size(data_in,2);
    
end

dataout = sum(data_calc,2);
    
    
    