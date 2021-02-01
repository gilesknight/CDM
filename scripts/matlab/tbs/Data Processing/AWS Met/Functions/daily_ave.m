function [xdata,ydata] = daily_ave(xin,yin);

xdata = unique(floor(xin));

for j = 1:length(xdata)
    ss = find(floor(xin) == xdata(j));
    ydata(j) = mean(yin(ss));
end