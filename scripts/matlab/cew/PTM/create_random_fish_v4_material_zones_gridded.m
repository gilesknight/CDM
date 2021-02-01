function create_random_fish_v4_material_zones_gridded(Domain,startdate,enddate,cell_size,biomass_factor,scalar_weight,kg_at_timestep)

addpath(genpath('functions'));

% Domain = 'Murray';
%
% startdate = datenum(2015,07,01);
% enddate = datenum(2015,07,15);
%
% cell_size = 100;

Ha_Conv= 1/10000;

total_cells_A = 1000; %Total Number of wet cells to contain fish (total number of BC files)

% scalar_weight = 50;
% 
% kg_at_timestep = 50;

[snum,~] = xlsread('Biomass Density.xlsx','B3:C17');
mZone = snum(:,1);
mBiomass = snum(:,2) * biomass_factor;

%________________________________________

outdir = ['MatOutput/',Domain,'/',num2str(biomass_factor),'/'];



if ~exist(outdir,'dir')
    mkdir(outdir);
end

time_array = startdate:1/24:enddate;
time_index = 1:1:length(time_array);


[XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT,A] = tfv_get_node_from_2dm(['MatGrids/',Domain,'.2dm']);

grid = create_grid_from_2dm(['MatGrids/',Domain,'.2dm'],cell_size);

grid.xx = grid.xx(:);
grid.yy = grid.yy(:);
grid.zz = grid.zz(:);
grid.mat = grid.mat(:);
grid.ID = 1:1:length(grid.xx);

u_mats = unique(MAT);


file_num = 1;


fid_g = fopen([outdir,'Info.csv'],'wt');

%_______________________

fid_u = fopen([outdir,'PTM_',num2str(biomass_factor),'.fvptm'],'wt');


fprintf(fid_u,'!TIME COMMANDS\n');
fprintf(fid_u,'!_________________________________________________________________\n');

fprintf(fid_u,'lagrangian timestep == 60.0   ! seconds\n');
fprintf(fid_u,'eulerian timestep == 60.0     ! seconds\n');

fprintf(fid_u,'!PARTICLE GROUP COMMANDS\n');
fprintf(fid_u,'!_________________________________________________________________\n');

fprintf(fid_u,'Nscalar == 1\n');

fprintf(fid_u,'group == fb\n');
fprintf(fid_u,'!initial scalar mass == 1.0\n');
fprintf(fid_u,'initial scalar mass == %d\n',scalar_weight);
fprintf(fid_u,'settling model == constant \n');
fprintf(fid_u,'settling parameters == 0.00\n');
fprintf(fid_u,'horizontal dispersion model == constant\n');
fprintf(fid_u,'horizontal dispersion parameters == 1.0\n');
fprintf(fid_u,'vertical dispersion model == none!HD model \n');
fprintf(fid_u,'vertical dispersion parameters == 1.0\n');
fprintf(fid_u,'erosion model == mehta \n');
fprintf(fid_u,'erosion parameters == 0.05, 0.1, 1.0\n');
fprintf(fid_u,'deposition model == krone \n');
fprintf(fid_u,'deposition parameters == 0.2\n');
fprintf(fid_u,'end group\n');


fprintf(fid_u,'!MATERIAL SPECS COMMANDS\n');
fprintf(fid_u,'!_________________________________________________________________\n');

fprintf(fid_u,'material == 1\n');
fprintf(fid_u,'ks == 0.001\n');
fprintf(fid_u,'Nlayer == 1\n');
fprintf(fid_u,'layer == 1\n');
fprintf(fid_u,'rhodry == 800.\n');
fprintf(fid_u,'end layer\n');
fprintf(fid_u,'end material\n');

fprintf(fid_u,'!INITIAL CONDITION COMMANDS\n');
fprintf(fid_u,'!_________________________________________________________________\n');
fprintf(fid_u,'!restart file == ../input/log/corner_ptm_005_ptm.rst\n');

fprintf(fid_u,'!BOUNDARY CONDITION COMMANDS\n');
fprintf(fid_u,'!_________________________________________________________________\n');


for i = 1:length(u_mats)
    
    
    
    
    sss = find(grid.mat == u_mats(i));
    ttt = find(MAT == u_mats(i));
    
    
    ggg = find(mZone == u_mats(i));
    
    disp(num2str(mBiomass(ggg)));
    
    
    total_area_m2 = cell_size * cell_size * length(sss);
    total_area_m2_chx = sum(A(ttt));
    total_area_ha = total_area_m2 * Ha_Conv;
    total_biomass = total_area_ha * mBiomass(ggg);
    total_biomass_chx = total_biomass;
    fish_at_timestep = kg_at_timestep / scalar_weight;
    
    
    if (total_biomass - (length(time_array) * 50 * total_cells_A)) > 0
        total_cells = 3000;
        if (total_biomass - (length(time_array) * 50 * total_cells)) > 0
            total_cells = 7000;
        end
        
    else
        total_cells = total_cells_A;
    end
    
    
    fprintf(fid_g,'Total Area (gridded) %10.6f\n',total_area_m2);
    fprintf(fid_g,'Total Area (TFV) %10.6f\n',total_area_m2_chx);
    fprintf(fid_g,'Biomass kg/ha %10.6f\n',mBiomass(ggg));
    fprintf(fid_g,'Total Biomass kg %10.6f\n',total_biomass);
    
    
    
    if length(sss) > total_cells
        all_times_matrix(1:total_cells,1:length(time_array)) = 0;
        
        for ii = 1:total_cells
            tCells_Num(ii,1) = ii;
            tCells_cellID(ii,1) = datasample(grid.ID(sss),1);
        end
    else
        total_cells = length(sss);
        all_times_matrix(1:total_cells,1:length(time_array)) = 0;
        
        for ii = 1:total_cells
            tCells_Num(ii,1) = ii;
            tCells_cellID(ii,1) = datasample(grid.ID(sss),1);
        end
    end
    
    if total_biomass > 0
    
    while total_biomass > 0
        
        this_cell = datasample(tCells_Num,1);
        this_timestep = datasample(time_index,1);
        if all_times_matrix(this_cell,this_timestep) == 0
            all_times_matrix(this_cell,this_timestep) = kg_at_timestep + all_times_matrix(this_cell,this_timestep);
            
            total_biomass = total_biomass - kg_at_timestep;
            
            
        end
    end
    
    for ii = 1:length(tCells_Num)
        
        dirname = [outdir,'PTM/'];
        
        if ~exist(dirname,'dir')
            mkdir(dirname);
        end
        
        
        if sum(all_times_matrix(ii,:)) > 0
            
            filename = [dirname,'f',num2str(file_num),'.csv'];
            
            fprintf(fid_g,'%s has %10.4f kg of biomass\n',filename,sum(all_times_matrix(ii,:)));
            
            fid = fopen(filename,'wt');
            
            fprintf(fid,'ISOTime,fb\n');
            fprintf(fid,'%s,%i\n',datestr(time_array(1) - (1/(24*60)),'dd/mm/yyyy HH:MM:SS'),0);
            for j = 1:length(time_index)
                fprintf(fid,'%s,%i\n',datestr(time_array(j),'dd/mm/yyyy HH:MM:SS'),all_times_matrix(ii,j));
            end
            fprintf(fid,'%s,%i\n',datestr(time_array(j) + (1/(24*60)),'dd/mm/yyyy HH:MM:SS'),0);
            fclose(fid);
            
            S(file_num).X = grid.xx(tCells_cellID(ii));
            S(file_num).Y = grid.yy(tCells_cellID(ii));
            S(file_num).Name = ['f',num2str(file_num)];
            S(file_num).Geometry = 'Point';
            
            
            file_num = file_num + 1;
            
            fprintf(fid_u,'\n');
            fprintf(fid_u,'bc == ptm_source, %8.4f,%8.4f,0. , %s\n',grid.xx(tCells_cellID(ii)),grid.yy(tCells_cellID(ii)),regexprep(filename,outdir,''));
            fprintf(fid_u,'bc groups == fb\n');
            fprintf(fid_u,'bc header == ISOTime,fb\n');
            fprintf(fid_u,'bc scale == 0.2777\n');
            fprintf(fid_u,'end bc\n');
            fprintf(fid_u,'\n');
            
            
            
            
            
            
        end
    end
    
    clear all_times_matrix total_biomass tCells_Num tCells_cellID
    
    end
end

fprintf(fid_u,'output dir == ../../../Output/ \n');

fprintf(fid_u,'output == ptm_netcdf \n');
fprintf(fid_u,'output groups == fb \n');
fprintf(fid_u,'output interval == 7200 \n');
fprintf(fid_u,'output compression == 1 \n');
fprintf(fid_u,'end output \n');

fclose(fid_g);
fclose(fid_u);

shapewrite(S,[outdir,'points.shp']);