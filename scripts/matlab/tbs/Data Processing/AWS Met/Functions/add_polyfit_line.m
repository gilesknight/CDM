function [str] = add_polyfit_line(xdata,ydata,fid,col,Site,Var)

% X(1) = 0;
% X(2:length(xdata)+1) = xdata;

X = xdata;

% Y(1) = 0;
% Y(2:length(ydata)+1) = ydata;

Y = ydata;

P = polyfit(X,Y,1);
yfit = P(1)*X+P(2);

plot(X,yfit,col);

fprintf(fid,'%s,%s,%2.4f,%2.4f\n',Site,Var,P(1),P(2));

str = [sprintf('%2.4f',P(1)),'X + ',sprintf('%2.4f',P(2))];

