clear all; close all;

addpath(genpath('functions'));

folder = 'E:\Github 2018\Carp_PTM\Chowilla\Input\PTM\1\PTM\';
part_ncfile = 'I:\GCLOUD\PTM_Results\Chowilla\Output_1_1\run_ptm.nc';
mod_ncfile = 'I:\GCLOUD\PTM_Results\Chowilla\Output_1_1\run.nc';



mdata = tfv_readnetcdf(mod_ncfile);

[pData,x,y,z] = tfv_readPTM(part_ncfile);


dat = tfv_readnetcdf(mod_ncfile,'time',1);
tdate = dat.Time;


balls_as_reported = 100198;

ptm = import_PTM_BC_Files(folder);

%load ptm.mat;

sss = find(ptm.Balls > 0);

num_balls = length(sss);


for i = 1:size(ptm.Date,2)
    sss = find(ptm.Balls(:,i) > 0);
    if i >1
        pBalls(i,1) = length(sss) + pBalls(i-1,1);
    else
        pBalls(i,1) = length(sss);
    end
    pDate(i,1) = ptm.Date(1,i);
end



for i = 1:size(pData.stat,2)
        sss = find(pData.stat(:,i) > 0);
        ttt = find(pData.stat(:,i) <= 0);
        mBalls(i,1) = length(sss);
        inaBalls(i,1) = length(ttt);
        
        
        
        
end


for i = 1:length(tdate)
    
    mPart(i) = sum(mdata.WQ_DIAG_PTM_TOTAL_COUNT(:,i));
end

tarea = 0;

    sss = find(mdata.stat(:,100) == 0);
(sum(mdata.cell_A(sss)) / sum(mdata.cell_A)) * 100

plot(pDate,pBalls,'b');hold on

plot(pData.mdate,mBalls,'k');
plot(pData.mdate,inaBalls,'r');

plot(tdate,mPart,'g');

plot([datenum(2015,10,01) datenum(2017,11,01)],[balls_as_reported balls_as_reported],'--k');
plot([datenum(2015,10,01) datenum(2017,11,01)],[num_balls num_balls],'--b');

xlim([min(pDate) max(pDate)]);


legend({'PTM BC Files';'PTM Active';'PTM Inactive';'AED Count';'Balls reported in log';'Total Balls from BC files'},'location','SE');

datetick('x','dd/mm/yyyy')

xlim([datenum(2015,10,01) datenum(2015,11,01)]);


