clear all; close all;

[snum,sstr] = xlsread('CEWO 201617 Five Barrages Flow.xlsx','Five Barrages','B4:H10000');

mDate = datenum(sstr,'dd/mm/yyyy');

conv = 1000/86400;

bar.Goolwa.Date = mDate;
bar.Goolwa.Flow = snum(:,1) * conv;
bar.Goolwa.Raw = snum(:,1);

bar.Mundoo.Date = mDate;
bar.Mundoo.Flow = snum(:,2) * conv;
bar.Mundoo.Raw = snum(:,2);


bar.Boundary.Date = mDate;
bar.Boundary.Flow = snum(:,3) * conv;
bar.Boundary.Raw = snum(:,3);

bar.Ewe.Date = mDate;
bar.Ewe.Flow = snum(:,4) * conv;
bar.Ewe.Raw = snum(:,4);

bar.Tauwitchere.Date = mDate;
bar.Tauwitchere.Flow = snum(:,5) * conv;
bar.Tauwitchere.Raw = snum(:,5);


bar.Total.Date = mDate;
bar.Total.Flow = snum(:,6) * conv;
bar.Total.Raw = snum(:,6);

save barrage_2017.mat bar -mat;

