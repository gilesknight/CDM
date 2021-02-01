function export_area(filename,cdata,area)

sss = find(cdata > 0);

h_area = cdata(sss) .* area(sss);

fid = fopen(filename,'wt');

fprintf(fid,'Total Area Calc,%10.10f\n',sum(h_area));

fclose(fid);

