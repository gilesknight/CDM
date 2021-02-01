function create_wave_model_from_tfv
% This fundtion is designed to take a tuflowfv 2dm file and tuflowfv met
% file and create a fully functioning SWAN Wave model.

% In order to prevent incorrect files being read, this script will Auto
% delete any directory named Wind and out found in the current directory.

% Locations of 2dm file and met file
tfv_bathy = 'TFV/014_Coorong_Salt_Crk_Mouth_Channel_MZ3_Culverts.2dm';
tfv_met = 'TFV/TFV_Wind_2016.csv';

% Cell size for the SWAN bathymetry (X and Y will be the same)
cell_size = 50;
wind_cell_size = 1000;

% Start & End date of SWAN model - dd/mm/yyyy
model_start_date = '01/01/2014';
model_end_date = '31/12/2014';

model_wind_increment = 3; %in hours
% Any factoring of the wind data
model_wind_factor = 1;

model_output_increment = 1; %in hours

model_project_name = 'Coorong 2014 2016';
model_project_version = 'v1';

run_model_in_matlab = 1; %1 to run in matlab, 0 to not run 



% Start the Processing_____________________________________________________

% Do not change anything here........


if ~exist('out','dir')
    mkdir('out');
else
    rmdir('out','s');
    mkdir('out');
end

% Create the Bathy File
disp('Making bathy file');
[xStart,yStart,xLength,yLength,xNum,yNum] = create_swan_bathy_from_2dm(tfv_bathy,cell_size);
disp('Making Wind domain');
[xStart,yStart,xLength,yLength,xNum,yNum] = create_wind_bathy_from_2dm(tfv_bathy,wind_cell_size);

xNum = xNum -1;
yNum = yNum - 1;

xLength = xLength + cell_size;
yLength = yLength + cell_size;

% Create the wind field files
disp('Writing wind files');

swn_create_wind_from_TFV_met(tfv_met,...
    datenum(model_start_date,'dd/mm/yyyy'),...
    datenum(model_end_date,'dd/mm/yyyy'),...
    model_wind_increment,model_wind_factor);

create_swan_init;

create_swan_input(model_start_date,model_end_date,xStart,yStart,...
    xLength,yLength,xNum,yNum,...
    model_output_increment,model_wind_increment,...
    model_project_name,...
    model_project_version,cell_size);

if run_model_in_matlab
    !swan.exe
end


clear all; close all; fclose all;

end

function create_swan_input(sdate,edate,xStart,yStart,xLength,yLength,xNum,yNum,model_output_increment,model_wind_increment,model_project_name,model_project_version,cell_size)

fid = fopen('INPUT','wt');

sdate_c = datestr(datenum(sdate,'dd/mm/yyyy'),'yyyymmdd');
edate_c = datestr(datenum(edate,'dd/mm/yyyy'),'yyyymmdd');

fprintf(fid,'PROJ ''%s'' ''%s''\n',model_project_name,model_project_version);

fprintf(fid,'\n');

fprintf(fid,'SET   0.5  90   0.05   200     2    9.81  1012   99999   0     0.1    NAUTical  4       0.8     4      4\n');
fprintf(fid,'$    level  nor depmin maxmes maxerr grav  rho      cdcap inrhog hsrerr           pwtail froudmax printf prtest\n');

fprintf(fid,'\n');

fprintf(fid,'MODE NONSTATIONARY\n');
fprintf(fid,'COORD CARTESIAN\n');

fprintf(fid,'\n');
fprintf(fid,'CGRID REGular  %8.3f  %8.3f   .0   %d  %d  %d  %d  CIRCLE  36  0.2  2.  27\n',...
    xStart,...
    yStart,...
    xLength,...
    yLength,...
    xNum,...
    yNum);
fprintf(fid,'\n');
fprintf(fid,'INPgrid BOTTOM   %8.3f  %8.3f  .0    %d  %d   %d   %d   EXC -999.9\n',...  
        xStart,...
    yStart,...
    xNum,...
    yNum,...
    cell_size,...
    cell_size);
fprintf(fid,'\n');


fprintf(fid,'READINP BOTTOM -1.0 ''Bathymetry/Bathymetry.dat''  1   0   FREE\n');

fprintf(fid,'\n');

fprintf(fid,'INPGRID Wind REG %8.3f  %8.3f  0    %d  %d   %d   %d NONSTATIONARY %s %s HR %s\n',...
            xStart,...
    yStart,...
    xNum,...
    yNum,...
    cell_size,...
    cell_size,...
    sdate_c,...
    num2str(model_wind_increment),...
    edate_c);
 fprintf(fid,'\n');   

fprintf(fid,'READINP Wind 1  SERIES ''Wind_Map_Series.txt'' 1 0 FREE\n');
 fprintf(fid,'\n');   
 fprintf(fid,'\n');   

fprintf(fid,'GEN3 KOMEN\n');  
fprintf(fid,'BREAKING CON alpha=1.0 gamma=0.73\n'); 
fprintf(fid,'FRICTION MADSEN 0.05\n'); 
fprintf(fid,'TRIAD\n');  
fprintf(fid,'WCAPping KOMen\n'); 
fprintf(fid,'PROP BSBT\n'); 
 
fprintf(fid,'FRAME ''SWAN'' %d %d  16.0 %d %d  %d  %d\n',xStart,yStart,xLength,yLength,xNum,yNum);

fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/depth.mat'' LAY 1 DEPTH OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/tm01.mat''  LAY 1 TM01  OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/h13.mat''   LAY 1 HSIGN OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/ubot.mat''  LAY 1 UBOT  OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/tmbot.mat'' LAY 1 TMBOT OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/wind.mat''  LAY 1 WIND  OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/tra.mat''   LAY 1 TRA   OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/tps.mat''   LAY 1 TPS   OUTPUT %s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/dir.mat''   LAY 1 DIR   OUTPUT 2%s %d HR\n',sdate_c,model_output_increment);
fprintf(fid,'BLOCK ''COMPGRID'' NOHEAD ''./out/bathy.mat'' LAY 1 BOTL\n');
fprintf(fid,'!BLOCK ''COMPGRID'' NOHEAD ''./out/WAVE.nc''   LAY 3 HSIGN TPS PDIR UBOT DEPTH OUTPUT %s %d Hr\n',sdate_c,model_output_increment);


fprintf(fid,'TEST 1 0 \n');
fprintf(fid,'COMPUTE NONSTAT %s  10 MIN %s\n',sdate_c,edate_c);

fprintf(fid,'STOP\n');

fclose(fid);

end

function create_swan_init

fid = fopen('swaninit','wt');

fprintf(fid,'    4                                   version of initialisation file\n');
fprintf(fid,'Delft University of Technology          name of institute\n');
fprintf(fid,'    3                                   command file ref. number\n');
fprintf(fid,'INPUT                                   command file name\n');
fprintf(fid,'    4                                   print file ref. number\n');
fprintf(fid,'PRINT                                   print file name\n');
fprintf(fid,'    4                                   test file ref. number\n');
fprintf(fid,'                                        test file name\n');
fprintf(fid,'    6                                   screen ref. number\n');
fprintf(fid,'   99                                   highest file ref. number\n');
fprintf(fid,'$                                       comment identifier\n');
fprintf(fid,'	                                       TAB character\n');
fprintf(fid,'/                                       dir sep char in input file\n');
fprintf(fid,'\\                                       dir sep char replacing previous one\n');
fprintf(fid,'    1                                   default time coding option\n');
fclose(fid);

end

function swn_create_wind_from_TFV_met(filename,sdate,edate,int,factor)

data = tfv_readBCfile(filename);



%int = 3/24;

%factor = 1;

bat = load('Bathymetry/Wind_Bathy.dat');

[y,x] = size(bat);

newdate = sdate:int/24:edate;

Wx = interp1(data.Date,data.Wx,newdate,'linear','extrap');
Wy = interp1(data.Date,data.Wy,newdate,'linear','extrap');

Wx = Wx .* factor;
Wy = Wy .* factor;


fid4 = fopen('Wind_Map_Series.txt','wt');

if ~exist('Wind/','dir')
    mkdir('Wind/');
else
    rmdir('Wind','s');
    mkdir('Wind/');
end


for i = 1:length(Wx)

        
        fprintf(fid4,'%s\n',['Wind\Wind',num2str(i),'.dat']);

       fid = fopen(['Wind\Wind',num2str(i),'.dat'],'wt');
       
       for jj = 1:y
       for ii = 1:x
           fprintf(fid,'%4.4f ',Wx(i));
       end
       fprintf(fid,'\n');
       end
       fprintf(fid,'\n');
       for jj = 1:y
       for ii = 1:x
           fprintf(fid,'%4.4f ',Wy(i));
       end
       fprintf(fid,'\n');
       end
       
       fclose(fid);



end

fclose(fid4);
end
function data = tfv_readBCfile(filename)
%--% a simple function to read in a TuflowFV BC file and return a
%structured type 'data', justing the headers as variable names.
%
% Created by Brendan Busch

if ~exist(filename,'file')
    disp('File Not Found');
    return
end

data = [];

fid = fopen(filename,'rt');

sLine = fgetl(fid);

headers = regexp(sLine,',','split');
headers = regexprep(headers,'\s','');
EOF = 0;
inc = 1;
while ~EOF
    
    sLine = fgetl(fid);
    
    if sLine == -1
        EOF = 1;
    else
        dataline = regexp(sLine,',','split');
        
        for ii = 1:length(headers);
            
            if strcmpi(headers{ii},'ISOTime')
                data.Date(inc,1) = datenum(dataline{ii},...
                                        'dd/mm/yyyy HH:MM');
            else
                data.(headers{ii})(inc,1) = str2double(dataline{ii});
            end
        end
        inc = inc + 1;
    end
end

    
end
function [xStart,yStart,xLength,yLength,xNum,yNum] = create_swan_bathy_from_2dm(filename,cell_size)

if ~exist('Bathymetry/','dir')
    mkdir('Bathymetry/');
end

%[XX,YY,ZZ,nodeID,faces,X,Y,ID] = tfv_get_node_from_2dm(filename);
[XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT] = tfv_get_node_from_2dm(filename);


max_depth = max(ZZ);
min_depth = min(ZZ);

%cell_size = 200;

cell_clip_distance = cell_size;

ZZ = ZZ - max_depth;

%initial_depth = 1022 - max_depth;

xarray = [(min(XX)-1000):cell_size:max(XX)+1000];
yarray = [(min(YY)-1000):cell_size:max(YY)+1000];
[xx,yy] = meshgrid(xarray',yarray');

Fx = scatteredInterpolant(XX,YY,ZZ,'linear','none');

zz = Fx(xx,yy);


%_ Clip the exterior

pnt(:,1) = xx(:);
pnt(:,2) = yy(:);


dtri = DelaunayTri(XX,YY);

pt_id = nearestNeighbor(dtri,pnt);

for i = 1:length(pt_id)
    
    dist = sqrt((XX(pt_id(i))-pnt(i,1)) .^2 + (YY(pt_id(i)) - pnt(i,2)).^2);
    
    %dist = sqrt((XX(i)-X(pt_id(i))) .^2 + (YY(i) - Y(pt_id(i))).^2);
    
    if abs(dist) > cell_clip_distance
        zz(i) = NaN;
    end
end







xxx = flipud(xx);
yyy = flipud(yy);
zzz = flipud(zz);

pcolor(xxx,yyy,zzz);shading flat;axis xy;hold on
colorbar
scatter(xxx(1,1),yyy(1,1),'*k');

axis equal

saveas(gcf,'Bathymetry/Bathymetry.png')

zzz(isnan(zzz)) = 999;


save Bathymetry/Bathymetry.mat xxx yyy zzz -mat;

fid = fopen('Bathymetry/Bathymetry.dat','wt');

for i = 1:size(zzz,1)
    for j = 1:size(zzz,2)
        fprintf(fid,'%4.3f ',zzz(i,j));
    end
    fprintf(fid,'\n');
end

fclose(fid);


xStart = xxx(1,1);
yStart = min(min(yyy));
xLength = xarray(end) - xarray(1);
yLength = yarray(end) - yarray(1);
xNum = length(xarray);
yNum = length(yarray);

fid = fopen('Bathymetry/Bathymetry_Info.txt','wt');

fprintf(fid,'Start X Co-Ord %8.4f\n',xxx(1,1));
fprintf(fid,'Start Y Co-Ord %8.4f\n',min(min(yyy)));
fprintf(fid,'Cell Size == %4.2fm\n',cell_size);
fprintf(fid,'Max Depth == %4.4f\n',max_depth);
fprintf(fid,'x length == %4.4f\n',xarray(end) - xarray(1));
fprintf(fid,'y length == %4.4f\n',yarray(end) - yarray(1));
fprintf(fid,'x num == %4.4f\n',length(xarray));
fprintf(fid,'y num == %4.4f\n',length(yarray));
fclose(fid);

end

function [xStart,yStart,xLength,yLength,xNum,yNum] = create_wind_bathy_from_2dm(filename,cell_size)

if ~exist('Bathymetry/','dir')
    mkdir('Bathymetry/');
end

%[XX,YY,ZZ,nodeID,faces,X,Y,ID] = tfv_get_node_from_2dm(filename);
[XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT] = tfv_get_node_from_2dm(filename);


max_depth = max(ZZ);
min_depth = min(ZZ);

%cell_size = 200;

cell_clip_distance = cell_size;

ZZ = ZZ - max_depth;

%initial_depth = 1022 - max_depth;

xarray = [(min(XX)-1000):cell_size:max(XX)+1000];
yarray = [(min(YY)-1000):cell_size:max(YY)+1000];
[xx,yy] = meshgrid(xarray',yarray');

Fx = scatteredInterpolant(XX,YY,ZZ,'linear','none');

zz = Fx(xx,yy);


%_ Clip the exterior

pnt(:,1) = xx(:);
pnt(:,2) = yy(:);


dtri = DelaunayTri(XX,YY);

pt_id = nearestNeighbor(dtri,pnt);

for i = 1:length(pt_id)
    
    dist = sqrt((XX(pt_id(i))-pnt(i,1)) .^2 + (YY(pt_id(i)) - pnt(i,2)).^2);
    
    %dist = sqrt((XX(i)-X(pt_id(i))) .^2 + (YY(i) - Y(pt_id(i))).^2);
    
    if abs(dist) > cell_clip_distance
        zz(i) = NaN;
    end
end







xxx = flipud(xx);
yyy = flipud(yy);
zzz = flipud(zz);

pcolor(xxx,yyy,zzz);shading flat;axis xy;hold on
colorbar
scatter(xxx(1,1),yyy(1,1),'*k');

axis equal

saveas(gcf,'Bathymetry/Wind_Bathy.png')

zzz(isnan(zzz)) = 999;


save Bathymetry/Wind_Bathy.mat xxx yyy zzz -mat;

fid = fopen('Bathymetry/Wind_Bathy.dat','wt');

for i = 1:size(zzz,1)
    for j = 1:size(zzz,2)
        fprintf(fid,'%4.3f ',zzz(i,j));
    end
    fprintf(fid,'\n');
end

fclose(fid);


xStart = xxx(1,1);
yStart = min(min(yyy));
xLength = xarray(end) - xarray(1);
yLength = yarray(end) - yarray(1);
xNum = length(xarray);
yNum = length(yarray);

% fid = fopen('Bathymetry/Bathymetry_Info.txt','wt');
% 
% fprintf(fid,'Start X Co-Ord %8.4f\n',xxx(1,1));
% fprintf(fid,'Start Y Co-Ord %8.4f\n',min(min(yyy)));
% fprintf(fid,'Cell Size == %4.2fm\n',cell_size);
% fprintf(fid,'Max Depth == %4.4f\n',max_depth);
% fprintf(fid,'x length == %4.4f\n',xarray(end) - xarray(1));
% fprintf(fid,'y length == %4.4f\n',yarray(end) - yarray(1));
% fprintf(fid,'x num == %4.4f\n',length(xarray));
% fprintf(fid,'y num == %4.4f\n',length(yarray));
% fclose(fid);

end
function [XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT] = tfv_get_node_from_2dm(filename)


fid = fopen(filename,'rt');

fline = fgetl(fid);
fline = fgetl(fid);
fline = fgetl(fid);
fline = fgetl(fid);


str = strsplit(fline);

inc = 1;

switch str{1}
    case 'E4Q'
        for ii = 1:4
            faces(ii,inc) = str2double(str{ii + 2});
        end
    case 'E3T'
        for ii = 1:3
            faces(ii,inc) = str2double(str{ii + 2});
        end
        faces(4,inc) = str2double(str{3});
    otherwise
end

MAT(inc) = str2double(str{end});

inc = inc + 1;
fline = fgetl(fid);
str = strsplit(fline);
while strcmpi(str{1},'ND') == 0
    switch str{1}
        case 'E4Q'
            for ii = 1:4
                faces(ii,inc) = str2double(str{ii + 2});
            end
        case 'E3T'
            for ii = 1:3
                faces(ii,inc) = str2double(str{ii + 2});
            end
            faces(4,inc) = str2double(str{3});
        otherwise
    end
    MAT(inc) = str2double(str{end});
    
    inc = inc + 1;
    fline = fgetl(fid);
    str = strsplit(fline);
    
end

inc = 1;

nodeID(inc,1) = str2double(str{2});
XX(inc,1) = str2double(str{3});
YY(inc,1) = str2double(str{4});
ZZ(inc,1) = str2double(str{5});
inc = 2;
fline = fgetl(fid);
str = strsplit(fline);

while strcmpi(str{1},'ND') == 1
    nodeID(inc,1) = str2double(str{2});
    XX(inc,1) = str2double(str{3});
    YY(inc,1) = str2double(str{4});
    ZZ(inc,1) = str2double(str{5});

    inc = inc + 1;
    fline = fgetl(fid);
    str = strsplit(fline);
    
end

fclose(fid);

X(1:length(faces),1) = NaN;
Y(1:length(faces),1) = NaN;
ID(1:length(faces),1) = NaN;
Z(1:length(faces),1) = NaN;

% for ii = 1:length(faces)
%     gg = polygeom(XX(faces(:,ii)),YY(faces(:,ii)));
%     
%     X(ii) = gg(2);
%     Y(ii) = gg(3);
%     Z(ii) = mean(ZZ(faces(:,ii)));
%     ID(ii) = ii;
% end



end

function [ geom, iner, cpmo ] = polygeom( x, y )
%POLYGEOM Geometry of a planar polygon
%
%   POLYGEOM( X, Y ) returns area, X centroid,
%   Y centroid and perimeter for the planar polygon
%   specified by vertices in vectors X and Y.
%
%   [ GEOM, INER, CPMO ] = POLYGEOM( X, Y ) returns
%   area, centroid, perimeter and area moments of
%   inertia for the polygon.
%   GEOM = [ area   X_cen  Y_cen  perimeter ]
%   INER = [ Ixx    Iyy    Ixy    Iuu    Ivv    Iuv ]
%     u,v are centroidal axes parallel to x,y axes.
%   CPMO = [ I1     ang1   I2     ang2   J ]
%     I1,I2 are centroidal principal moments about axes
%         at angles ang1,ang2.
%     ang1 and ang2 are in radians.
%     J is centroidal polar moment.  J = I1 + I2 = Iuu + Ivv

% H.J. Sommer III - 02.05.14 - tested under MATLAB v5.2
%
% sample data
% x = [ 2.000  0.500  4.830  6.330 ]';
% y = [ 4.000  6.598  9.098  6.500 ]';
% 3x5 test rectangle with long axis at 30 degrees
% area=15, x_cen=3.415, y_cen=6.549, perimeter=16
% Ixx=659.561, Iyy=201.173, Ixy=344.117
% Iuu=16.249, Ivv=26.247, Iuv=8.660
% I1=11.249, ang1=30deg, I2=31.247, ang2=120deg, J=42.496
%
% H.J. Sommer III, Ph.D., Professor of Mechanical Engineering, 337 Leonhard Bldg
% The Pennsylvania State University, University Park, PA  16802
% (814)863-8997  FAX (814)865-9693  hjs1@psu.edu  www.me.psu.edu/sommer/

% begin function POLYGEOM

% check if inputs are same size
if ~isequal( size(x), size(y) ),
    error( 'X and Y must be the same size');
end

% number of vertices
[ x, ns ] = shiftdim( x );
[ y, ns ] = shiftdim( y );
[ n, c ] = size( x );

% temporarily shift data to mean of vertices for improved accuracy
xm = mean(x);
ym = mean(y);
x = x - xm*ones(n,1);
y = y - ym*ones(n,1);

% delta x and delta y
dx = x( [ 2:n 1 ] ) - x;
dy = y( [ 2:n 1 ] ) - y;

% summations for CW boundary integrals
A = sum( y.*dx - x.*dy )/2;
Axc = sum( 6*x.*y.*dx -3*x.*x.*dy +3*y.*dx.*dx +dx.*dx.*dy )/12;
Ayc = sum( 3*y.*y.*dx -6*x.*y.*dy -3*x.*dy.*dy -dx.*dy.*dy )/12;
Ixx = sum( 2*y.*y.*y.*dx -6*x.*y.*y.*dy -6*x.*y.*dy.*dy ...
    -2*x.*dy.*dy.*dy -2*y.*dx.*dy.*dy -dx.*dy.*dy.*dy )/12;
Iyy = sum( 6*x.*x.*y.*dx -2*x.*x.*x.*dy +6*x.*y.*dx.*dx ...
    +2*y.*dx.*dx.*dx +2*x.*dx.*dx.*dy +dx.*dx.*dx.*dy )/12;
Ixy = sum( 6*x.*y.*y.*dx -6*x.*x.*y.*dy +3*y.*y.*dx.*dx ...
    -3*x.*x.*dy.*dy +2*y.*dx.*dx.*dy -2*x.*dx.*dy.*dy )/24;
P = sum( sqrt( dx.*dx +dy.*dy ) );

% check for CCW versus CW boundary
if A < 0,
    A = -A;
    Axc = -Axc;
    Ayc = -Ayc;
    Ixx = -Ixx;
    Iyy = -Iyy;
    Ixy = -Ixy;
end

% centroidal moments
xc = Axc / A;
yc = Ayc / A;
Iuu = Ixx - A*yc*yc;
Ivv = Iyy - A*xc*xc;
Iuv = Ixy - A*xc*yc;
J = Iuu + Ivv;

% replace mean of vertices
x_cen = xc + xm;
y_cen = yc + ym;
Ixx = Iuu + A*y_cen*y_cen;
Iyy = Ivv + A*x_cen*x_cen;
Ixy = Iuv + A*x_cen*y_cen;

% principal moments and orientation
I = [ Iuu  -Iuv ;
    -Iuv   Ivv ];
[ eig_vec, eig_val ] = eig(I);
I1 = eig_val(1,1);
I2 = eig_val(2,2);
ang1 = atan2( eig_vec(2,1), eig_vec(1,1) );
ang2 = atan2( eig_vec(2,2), eig_vec(1,2) );

% return values
geom = [ A  x_cen  y_cen  P ];
iner = [ Ixx  Iyy  Ixy  Iuu  Ivv  Iuv ];
cpmo = [ I1  ang1  I2  ang2  J ];

% end of function POLYGEOM
end
