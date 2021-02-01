function jd=date2jul(dd,mm,yyyy)
%DATE2JUL  Calculates Julian date from an input calendar date.
%
%	date2jul(dd,mm,yyyy)
%
%	Calculates Julian date (number of days since 31 December, 1900)
%	from a date input as day (dd), month (mm) and year (yyyy).
%	31 December 1900 is Julian day number zero.  Dates preceding
%	this have negative Julian day.
%	The algorithm uses the full 400-year Gregorian calendar cycle,
%	and is therefore valid for any Gregorian date.  However, it is 
%	recommended that dates earlier than 01/01/0001 not be used.

%	Neil Viney --- 21 June 1999

nm=[0,31,59,90,120,151,181,212,243,273,304,334];
ny=yyyy-1900;
jd=(ny-1)*365+nm(mm)+dd+floor(ny/4)-floor(ny/100)+floor((yyyy-1600)/400);
jd=jd-(rem(ny,4)==0 & (rem(ny,100)~=0 | rem(yyyy,400)==0) & mm<=2);
