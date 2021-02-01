clear; close;

%% set up basic information for budgeting
infolder='run_2016_2017_Tidal_Test\';
sites={'Harvey_North','Harvey_South','Murray_Delta','Peel_Dawesville','Peel_East','Peel_Mid','Peel_West'};
flux=load('F:\The University of Western Australia\AED Aquatic Ecodynamics - Documents\Peel\budget_scripts_figures\flux_all');
t1=datenum(2015,11,1);t2=datenum(2015,11,8);
%datess={'20080101','20080401','20080701','20081001'};
datess={'20151101','20151103','20151105','20151107'};

%% go through all site, defining nodestring names and signs for each site

for ss=1:length(sites)
    
site=sites{ss};    
outputfolder=['./',site,'/'];
if strcmp(sites(ss),'Harvey_North')
    nsnames={'Harvey_Int_1','Harvey_Int_2'};
    nssigns=[1,-1];
elseif strcmp(sites(ss),'Harvey_South')
    nsnames={'Harvey_River_Est','Harvey_Int_2'};
    nssigns=[1,1];
elseif strcmp(sites(ss),'Murray_Delta')
    nsnames={'Serpentine_Est','Murray_Est','Peel_Int_1'};
    nssigns=[1,-1,1];    
elseif strcmp(sites(ss),'Peel_Dawesville')
    nsnames={'Dawes_Est','Peel_Int_2','Harvey_Int_1'};
    nssigns=[-1,-1,-1];  
elseif strcmp(sites(ss),'Peel_East')
    nsnames={'Peel_int_3','Peel_Int_1','Mandurah_Est'};
    nssigns=[-1,-1,-1];  
elseif strcmp(sites(ss),'Peel_Mid')
    nsnames={'Peel_int_3','Peel_int_4'};
    nssigns=[1,1];   
else
nsnames={'Peel_Int_2','Peel_int_4'};
nssigns=[1,-1];
end

cal_stack_carbon_function(infolder,site,t1,t2,datess,flux,nsnames,nssigns,outputfolder);
cal_stack_nitrogen_function(infolder,site,t1,t2,datess,flux,nsnames,nssigns,outputfolder);
cal_stack_phosphorus_function(infolder,site,t1,t2,datess,flux,nsnames,nssigns,outputfolder);

end