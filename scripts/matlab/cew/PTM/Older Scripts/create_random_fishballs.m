clear all; close all;

addpath(genpath('functions'));

[~,~,~,~,~,X,Y,Z,ID,MAT,A] = tfv_get_node_from_2dm('RM_Wetlands_v1_MZ_Wetland.2dm');

% One month run @ 1 hourly intervals

datearray = datenum(2009,01,01):5/(60*24):datenum(2009,02,01);

rand_array(1:length(datearray),1) = NaN;

for i = 1:length(datearray)
    [s,ind] = datasample(ID,1);
    
    if Z(ind) > 1
        islow = 0;
        while ~islow
            [s,ind] = datasample(ID,1);
            if Z(ind) < 1
                islow = 1;
            end
        end
    end
    
    rand_array(i,1) = s;
    
end 

outdir = 'PTM/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end




% BC file creation
for i = 1:length(rand_array)
    disp(num2str(i));
    
    fileID = [outdir,'f',num2str(i),'.csv'];
    
    xarray(1,1) = datearray(i) - 1000;
    xarray(2,1) = datearray(i) - (10/(60*24));
    xarray(3,1) = datearray(i);%
    xarray(4,1) = datearray(i) + (10/(60*24));
    xarray(5,1) = datearray(i) + 1000;
    
    yarray = [0 0 1 0 0];
    
    fid = fopen(fileID,'wt');
    
    fprintf(fid,'ISOTime,fb\n');

    for j = 1:length(xarray)
        fprintf(fid,'%s,%i\n',datestr(xarray(j),'dd/mm/yyyy HH:MM:SS'),yarray(j));
    end
    fclose(fid);
end

% Include file creation.

fid = fopen('PTMinclude_RM.fvptm','wt');


fprintf(fid,'!TIME COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'lagrangian timestep == 60.0   ! seconds\n');
fprintf(fid,'eulerian timestep == 60.0     ! seconds\n');

fprintf(fid,'!PARTICLE GROUP COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'Nscalar == 1\n');

fprintf(fid,'group == fb\n');
fprintf(fid,'!initial scalar mass == 1.0\n');
  fprintf(fid,'initial scalar mass == 0.2\n');
  fprintf(fid,'settling model == none \n');
  fprintf(fid,'settling parameters == 0.00\n');
  fprintf(fid,'horizontal dispersion model == constant\n');
  fprintf(fid,'horizontal dispersion parameters == 1.0\n');
  fprintf(fid,'vertical dispersion model == none!HD model \n');
  fprintf(fid,'vertical dispersion parameters == 1.0\n');
  fprintf(fid,'erosion model == none \n');
  fprintf(fid,'erosion parameters == 0.02, 0.2, 1.0\n');
  fprintf(fid,'deposition model == none \n');
  fprintf(fid,'deposition parameters == 0.2\n');
fprintf(fid,'end group\n');


fprintf(fid,'!MATERIAL SPECS COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'material == 1\n');
  fprintf(fid,'ks == 0.001\n');
  fprintf(fid,'Nlayer == 1\n');
  fprintf(fid,'layer == 1\n');
    fprintf(fid,'rhodry == 800.\n');
  fprintf(fid,'end layer\n');
fprintf(fid,'end material\n');

fprintf(fid,'!INITIAL CONDITION COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');
fprintf(fid,'!restart file == ../input/log/corner_ptm_005_ptm.rst\n');

fprintf(fid,'!BOUNDARY CONDITION COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');




% fprintf(fid,'! Lock 1 Carp Inputs\n');
% fprintf(fid,'bc == ptm_source, 372911.7,6197840.8, 0. , ../BC/PTM/fish_mass_flux_inputs_test.csv\n');
%   fprintf(fid,'bc groups == fb,minfish\n');
%   fprintf(fid,'bc header == ISOTime,fb\n');
% fprintf(fid,'end bc\n');







% Actual code...............




for i = 1:length(rand_array)
    filename = ['PTM\f',num2str(i),'.csv'];
    fprintf(fid,'\n');
    fprintf(fid,'bc == ptm_source, %8.4f,%8.4f,0. , %s\n',X(rand_array(i)),Y(rand_array(i)),filename);
    fprintf(fid,'bc groups == fb\n');
    fprintf(fid,'bc header == ISOTime,fb\n');
    fprintf(fid,'end bc\n');
    fprintf(fid,'\n');
end

fprintf(fid,'output dir == ../Output_PTM/ \n');

fprintf(fid,'output == ptm_netcdf \n');
  fprintf(fid,'output groups == fb \n');
  fprintf(fid,'output interval == 300 \n');
  fprintf(fid,'output compression == 1 \n');
fprintf(fid,'end output \n');











fclose(fid);
% 
% hvid = VideoWriter('Fish Deaths.mp4','MPEG-4');
% set(hvid,'Quality',100);
% set(hvid,'FrameRate',6);
% framepar.resolution = [1024,768];
% open(hvid);
% 
% 
% hfig = figure('position',[1000.33333333333          262.333333333333          1015.33333333333          1075.33333333333]);
% 
% for i = 1:length(rand_array)
%     axis off
%     if i == 1
%         sc = scatter(X(rand_array(i)),Y(rand_array(i)),'.r');hold on
%         
%         txt = text(0.7,0.01,datestr(datearray(i),'dd HH:MM'),'units','normalized');
%     else
%         sc = scatter(X(rand_array(i)),Y(rand_array(i)),'.r');hold on
%         set(txt,'String',datestr(datearray(i),'dd HH:MM'));
%     end
%     xlim([340000      380000]);
%     ylim([6080000     6200000]);
%     
%     axis off
%     writeVideo(hvid,getframe(hfig));
% end
% close(hvid);
        