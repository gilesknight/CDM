clear all; close all;
load VH.mat;
load VH_DEWNR.mat;

VH(:,2) = VH(:,2) - 0.4;
VH(:,2) = VH(:,2) .* 0.5;
VH(:,2) = VH(:,2) + 0.1;

plot(VH(:,1),VH(:,2),'r');hold on
plot(ISOTime,tfv_data.H,'k');

datearray = [datenum(2012,01,01):1/24:datenum(2016,07,01)];

VH_Tide = interp1(VH(:,1),VH(:,2),datearray);

fid = fopen('Converted_Tide.csv','wt');
for i = 1:length(VH_Tide)
    fprintf(fid,'%4.4f\n',VH_Tide(i));
end
fclose(fid);