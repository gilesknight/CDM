function write_tfv_file(filename,data)

vars = fieldnames(data);

disp(['Writing ',filename]);

fid = fopen(filename,'wt');

fprintf(fid,'ISOTime,');


for ii = 2:length(vars)
    if ii == length(vars)
        fprintf(fid,'%s\n',vars{ii});
    else
        fprintf(fid,'%s,',vars{ii});
    end
end

for j = 1:length(data.Date)
    fprintf(fid,'%s,',datestr(data.Date(j),'dd/mm/yyyy HH:MM:SS'));
    for ii = 2:length(vars)
        if ii == length(vars)
            fprintf(fid,'%6.6f\n',data.(vars{ii})(j));
        else
            fprintf(fid,'%6.6f,',data.(vars{ii})(j));
        end
    end
end
fclose(fid);

end