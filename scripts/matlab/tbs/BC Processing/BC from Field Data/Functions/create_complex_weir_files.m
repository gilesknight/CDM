function create_complex_weir_files

datearray = [datenum(2008,01,01):01:datenum(2016,01,01)];

%__________________________________________

filename = 'Targets/Currency_Weir_South.csv';
height = 0.828;
sdate = datenum(2009,07,31);
edate = datenum(2013,08,15);

disp(filename);
create_file(datearray,sdate,edate,height,filename);

%__________________________________________

filename = 'Targets/Currency_Weir_North.csv';
height = 0.828;
sdate = datenum(2009,09,15);
edate = datenum(2010,09,15);

disp(filename);
create_file(datearray,sdate,edate,height,filename);

%__________________________________________

filename = 'Targets/Clayton_Weir_South.csv';
height = 1;
sdate = datenum(2009,07,15);
edate = datenum(2010,09,16);

disp(filename);
create_file(datearray,sdate,edate,height,filename);

%__________________________________________

filename = 'Targets/Clayton_Weir_North.csv';
height = 1;
sdate = datenum(2009,08,31);
edate = datenum(2012,10,16);

disp(filename);
create_file(datearray,sdate,edate,height,filename);


%__________________________________________

filename = 'Targets/Nurrung_Weir_South.csv';
height = 1;
sdate = datenum(2008,03,01);
edate = datenum(2010,09,20);

disp(filename);
create_file(datearray,sdate,edate,height,filename);

%__________________________________________

filename = 'Targets/Nurrung_Weir_North.csv';
height = 1;
sdate = datenum(2008,03,01);
edate = datenum(2010,10,02);

disp(filename);
create_file(datearray,sdate,edate,height,filename);

%__________________________________________

filename = 'Targets/Barrage_Weir.csv';
height = 0.7;
sdate = datenum(2008,03,01);
edate = datenum(2010,09,21);

disp(filename);
create_file(datearray,sdate,edate,height,filename);



end
function create_file(datearray,sdate,edate,height,filename)

height_array(1:length(datearray),1) = 0;

ss = find(datearray >= sdate & datearray <= edate);

height_array(ss) = height;

fid = fopen(filename,'wt');

fprintf(fid,'time,weir_crest\n');

for i = 1:length(datearray)
    fprintf(fid,'%s,%2.4f\n',datestr(datearray(i),'dd/mm/yyyy'),height_array(i));
    
end

fclose(fid);

end
