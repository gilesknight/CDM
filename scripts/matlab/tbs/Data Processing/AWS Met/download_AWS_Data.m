clear all; close all;

load Locations\sites.mat;

base_id = 'http://aws.naturalresources.sa.gov.au/data_download.php?aws_id=';

%RMPW14

id_1 = '&start=';
id_2 = '-01-01&end=';

end_id = '-12-31&format=15min';


year_array = [2015:1:2018];


output_dir = 'Raw';


options = weboptions('Timeout',Inf);



%______________________________________________________

for j = 1:length(year_array)
    
    for i = 1:length(sites)
        
        fin_dir = [output_dir,'/',sites(i).name,'/'];
        
        if ~exist(fin_dir,'dir')
            mkdir(fin_dir);
        end
        
        
        url = [base_id,sites(i).id,id_1,num2str(year_array(j)),id_2,num2str(year_array(j)),end_id];
        
        filename = [fin_dir,num2str(year_array(j)),' ',sites(i).name,'.csv'];
        
        disp(['Downloading ',filename]);
        try
            
            outfilename = urlwrite(url,filename,'Timeout',Inf);
            
            %         outfilename = websave(filename,url,options);
        catch
            % Continue on error
        end
        
    end
    
end
