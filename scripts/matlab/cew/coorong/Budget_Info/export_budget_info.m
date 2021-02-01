

maindir = 'Y:\Coorong Report\Budget_Final\';

dirlist = dir(maindir);

fid = fopen('info.txt','wt');

for i = 3:length(dirlist)
    
    slist = dir([maindir,dirlist(i).name,'/']);
    
    disp([maindir,dirlist(i).name,'/',slist(3).name,'/SAL.mat']);
    
    sal = load([maindir,dirlist(i).name,'/',slist(3).name,'/SAL.mat']);
    
    fprintf(fid,'%s,%s\n',dirlist(i).name,datestr(sal.savedata.Time(end),'dd/mm/yyyy HH:MM'));
    
end