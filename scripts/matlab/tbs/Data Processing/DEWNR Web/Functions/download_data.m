clear all; close all;

site_txt = 'http://apps.waterconnect.sa.gov.au/SiteInfo/Data/Site_Data/';

outdir = 'Data/';
zipdir = 'Raw/';
if ~exist(outdir,'dir');
    mkdir(outdir);
end
if ~exist(zipdir,'dir');
    mkdir(zipdir);
end

types = {'windvelrec.zip',...
    'winddirrec.zip',...
    'lakerec.zip',...
    'flowrec.zip',...
    'flowcday.zip',...
    'flowmrec.zip',...
    'wlrec.zip',...
    'tiderec.zip',...
    'ecrec.zip',...
    'temprec.zip',...
    'phrec.zip'};

all_sites

for i = 1:length(sites)
    disp(sites{i});
    for j = 1:length(types)
        
        address = [site_txt,sites{i},'/',lower(sites{i}),'_',types{j}];
        
        savename = [zipdir,lower(sites{i}),'_',types{j}];
        
        try
            websave(savename,address);
            unzip(savename,outdir);
        end
    end
end

