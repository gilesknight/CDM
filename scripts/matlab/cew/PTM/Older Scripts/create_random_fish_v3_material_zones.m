clear all; close all;

addpath(genpath('functions'));

Domain = 'Murray';

startdate = datenum(2015,07,01);
enddate = datenum(2015,07,15);

biomass = 500; %kg/Ha

Ha_Conv= 1/10000;

total_cells = 5000; %Total Number of wet cells to contain fish (total number of BC files);

initial_height = -0.2; % Finds all cells under this Z level;

scalar_weight = 50; 

kg_at_timestep = 50;

[snum,~] = xlsread('Biomass Density.xlsx','B3:C17');
mZone = snum(:,1);
mBiomass = snum(:,2);

%________________________________________

outdir = ['MatOutput/',Domain,'_',num2str(biomass),'/'];



if ~exist(outdir,'dir')
    mkdir(outdir);
end

time_array = startdate:1/24:enddate;
time_index = 1:1:length(time_array);


[~,~,~,~,~,X,Y,Z,ID,MAT,A] = tfv_get_node_from_2dm(['MatGrids/',Domain,'.2dm']);

stop

sss = find(Z <= initial_height);






total_area_m2 = sum(A(sss));
total_area_ha = total_area_m2 * Ha_Conv;
total_biomass = total_area_ha * biomass;
total_biomass_chx = total_biomass;
fish_at_timestep = kg_at_timestep / scalar_weight;

% Set all time steps for all files to 0
% Matrix hold all the values
all_times_matrix(1:total_cells,1:length(time_array)) = 0;


while total_biomass > 0
    
    this_cell = datasample(tCells_Num,1);
    this_timestep = datasample(time_index,1);
    if all_times_matrix(this_cell,this_timestep) == 0
        all_times_matrix(this_cell,this_timestep) = kg_at_timestep + all_times_matrix(this_cell,this_timestep);

        total_biomass = total_biomass - kg_at_timestep;
        
%         sss = find(all_times_matrix==0);
%         if isempty(sss)
%             stop;
%         end
        
    end
end

for ii = 1:length(time_array)
    if ii == 1
        cum_balls(ii) = sum(all_times_matrix(:,ii));
    else
        cum_balls(ii) = sum(all_times_matrix(:,ii));
    end
end

xa = min(time_array):(max(time_array) - min(time_array))/5:max(time_array);

figure('position',[1000.33333333333          917.666666666667          1305.33333333333                       420]);
subplot(2,1,1)
plot(time_array,cumsum(cum_balls));
set(gca,'xtick',xa,'xticklabel',datestr(xa,'dd/mm/yyyy'));

text(0.1,0.9,['Total Biomass ',num2str(sum(cum_balls))],'units','normalized');
text(0.1,0.8,['Total Calculated Biomass ',num2str(total_biomass_chx)],'units','normalized');

ylabel('Cumulative Biomass (kg)')
xlim([min(floor(time_array)) max(floor(time_array))]); 
grid on
subplot(2,1,2)
plot(time_array,cum_balls);
set(gca,'xtick',xa,'xticklabel',datestr(xa,'dd/mm/yyyy'));
ylabel('Biomass (kg)');
xlim([min(floor(time_array)) max(floor(time_array))]); 
grid on

saveas(gcf,[outdir,'Biomass.png']);

close



chx = sum(sum(all_times_matrix));

% File writing

for i = 1:length(tCells_Num)
    
    dirname = [outdir,'PTM/'];
    
    if ~exist(dirname,'dir')
        mkdir(dirname);
    end
    
    filename = [dirname,'f',num2str(i),'.csv'];
    fid = fopen(filename,'wt');
    
    fprintf(fid,'ISOTime,fb\n');

    for j = 1:length(time_index)
        fprintf(fid,'%s,%i\n',datestr(time_array(j),'dd/mm/yyyy HH:MM:SS'),all_times_matrix(i,j));
    end
    fprintf(fid,'%s,%i\n',datestr(time_array(j) + (1/24),'dd/mm/yyyy HH:MM:SS'),0);
    fclose(fid);
end

% Include file creation.

fid = fopen([outdir,'PTMinclude_RM.fvptm'],'wt');


fprintf(fid,'!TIME COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'lagrangian timestep == 60.0   ! seconds\n');
fprintf(fid,'eulerian timestep == 60.0     ! seconds\n');

fprintf(fid,'!PARTICLE GROUP COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'Nscalar == 1\n');

fprintf(fid,'group == fb\n');
fprintf(fid,'!initial scalar mass == 1.0\n');
  fprintf(fid,'initial scalar mass == %d\n',scalar_weight);
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



for i = 1:length(tCells_Num)
    filename = [dirname,'f',num2str(i),'.csv'];;
    fprintf(fid,'\n');
    fprintf(fid,'bc == ptm_source, %8.4f,%8.4f,0. , %s\n',X(tCells_cellID(i)),Y(tCells_cellID(i)),regexprep(filename,outdir,''));
    fprintf(fid,'bc groups == fb\n');
    fprintf(fid,'bc header == ISOTime,fb\n');
    fprintf(fid,'bc scale == 0.2777\n');
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