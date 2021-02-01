function isize = get_size(remote_size,remote_name)


names = strsplit(remote_name{1},' ');

i_name = [];
isize = [];
for i = 1:length(names)
    if strcmpi(names{i},'coorong.nc')==1
        i_name = names{i};
    end
end

if ~isempty(i_name)
    for i = 1:length(remote_size)
        
        ss = strsplit(remote_size{i},' ');
        
        if length(ss) == 9
            
            if strcmpi(ss{9},i_name) == 1
                
                isize = str2num(ss{5});
            end
        end
    end
end