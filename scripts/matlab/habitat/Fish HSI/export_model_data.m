
vars={'D'}%'SAL','TEMP',};

infile='E:\Lowerlakes\Busch_Ruppia_modeloutput\MER_Scen2_20170701_20200701.nc';

outdir='E:\Lowerlakes\fishHSI\MER_Coorong_eWater_2020_v1\mat\Scen2\';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

for i=1:length(vars)
    tmp=ncread(infile,vars{i});

    dat = tfv_readnetcdf(infile,'time',1);
    savedata.Time = dat.Time;
    
    ts=datenum(2017,7,1);tf=datenum(2020,7,1);  %only export this time period
        tsind=find(abs(dat.Time-ts)==min(abs(dat.Time-ts)));
        tfind=find(abs(dat.Time-tf)==min(abs(dat.Time-tf)));
        
    savedata.(vars{i})=tmp(:,tsind:tfind);
    
    save([outdir,'\',vars{i},'.mat'],'savedata','-mat','-v7.3'); %-v7.3 is for large files over 2G
end