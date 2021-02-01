function [dd,mm,yyyy]=jul2date(jd)
%JUL2DATE  Calculates calendar date from an input value of Julian date.
%
%	jul2date(jd)
%
%	Calculates calendar date [dd,mm,yyyy] from an input value of
%	Julian date (days since 31 December 1900).
%	31 December 1900 is Julian day number zero.  Dates preceding
%	this have negative Julian day.
%	The algorithm uses the full 400-year Gregorian calendar cycle,
%	and is therefore valid for any Gregorian date.  However, it is 
%	recommended that Julian days smaller than -693959 (=01/01/0001)
%	not be used.

%	Neil Viney --- 21 June 1999

nm=[31,59,90,120,151,181,212,243,273,304,334,365];
kd=mod(jd+109571,146097)+1;
quad=5+floor((jd+109571)/146097);
iy=floor((kd+365.1+floor(kd/36524.26))/365.25);
yyyy=400*(quad-1)+iy;
id=kd-floor(365.25*iy-365.1)+floor(kd/36524.26);
leap=(rem(iy,4)==0 & (rem(iy,100)~=0 | rem(iy,400)==0));
dd=id;							% DEFAULT FOR JANUARY
mm=ones(size(jd));					% DEFAULT FOR JANUARY
for j=1:length(jd);
  if id(j)>nm(1);
    k=1+find(nm(2:12)+leap(j)>=id(j));
    mm(j)=k(1);
    dd(j)=id(j)-nm(k(1)-1)+leap(j)*(max(0,3-mm(j))-1);
  end;
end;
