function write_tfvfile(tfv_data,headers,ISOTime,filename)

disp(['Writing: ',filename]);

fid = fopen(filename,'wt');
fprintf(fid,'ISOTime,');
for i = 1:length(headers)
    
    tt = strsplit(headers{i},'_');
    if length(tt) == 3
        header_ID = tt{3};
    else
        if length(tt) == 4
            header_ID = [tt{3},'_',tt{4}];
        else
            header_ID = headers{i};
        end
    end
    
    if strcmpi(header_ID,'H') == 1
        header_ID = 'WL';
    end
    
    if i == length(headers)
        
        fprintf(fid,'%s\n',header_ID);
    else
        fprintf(fid,'%s,',header_ID);
    end
end
for i = 1:length(ISOTime)
    fprintf(fid,'%s,',datestr(ISOTime(i),'dd/mm/yyyy HH:MM:SS'));
    for j = 1:length(headers)

        
        if j == length(headers)
            fprintf(fid,'%4.4f\n',tfv_data.(headers{j})(i));
        else
            fprintf(fid,'%4.4f,',tfv_data.(headers{j})(i));
        end
    end
end
fclose(fid);




end