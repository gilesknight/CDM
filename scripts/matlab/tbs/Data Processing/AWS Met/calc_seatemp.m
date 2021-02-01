function seatemp = cal_seatemp(dwlbc,site,startdate,enddate)

mDate = dwlbc.(site).TEMP.Date;
mData = dwlbc.(site).TEMP.Data;

newarray = startdate:1/24:enddate;

seatemp(:,1) = interp1(mDate,mData,newarray);