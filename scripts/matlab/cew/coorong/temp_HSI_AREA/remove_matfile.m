dd = genpath('Processing');

path_all = strsplit(dd,';');


for i = 1:length(path_all)-1
    
    dirname = path_all{i};
    
    dirlist = dir([dirname,'\*.mat']);
    
    if length(dirlist) > 0
        for j = 1:length(dirlist)
            
        delete([dirname,'\',dirlist(j).name]);
        end
    end
end
    
