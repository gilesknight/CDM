clear all; close all;

addpath(genpath('tuflowfv'));

outdir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\BB\Weir_Final\Parnka_SC55\Sheet\';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

basedir = 'D:\Cloud\Dropbox\Data_Lowerlakes\Illustrator Processing\';

scenarios_A = {'013_Weir_8_SC55_Parnka'};
scenarios_B = {'013_Weir_9_SC55_noWeir'};

scenario_A_nc = {'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_8_SC55_Parnka\Output\coorong.nc'};
scenario_B_nc = {'I:\Lowerlakes\Coorong Weir Simulations\013_Weir_9_SC55_noWeir\Output\coorong.nc'};

for i = 1:length(scenarios_A)
    
    
    
    
    datA = tfv_readnetcdf(scenario_A_nc{i},'timestep',1);
    datB = tfv_readnetcdf(scenario_B_nc{i},'timestep',1);
    
    dirlist = dir([basedir,scenarios_A{i},'/Sheets/']);
    
    
    vertA(:,1) = datA.node_X;
    vertA(:,2) = datA.node_Y;

    facesA = datA.cell_node';

    %--% Fix the triangles
    facesA(facesA(:,4)== 0,4) = facesA(facesA(:,4)== 0,1);
    
    vertB(:,1) = datB.node_X;
    vertB(:,2) = datB.node_Y;

    facesB = datB.cell_node';

    %--% Fix the triangles
    facesB(facesB(:,4)== 0,4) = facesB(facesB(:,4)== 0,1);   
    
    
    for j = 3:length(dirlist)
        
        
        dirname = [basedir,scenarios_A{i},'/Sheets/',dirlist(j).name,'/'];
        dirnameB = [basedir,scenarios_B{i},'/Sheets/',dirlist(j).name,'/'];
        
        mapA.Adult = load([dirname,'1_adult_new/HSI_adult.mat']);
        mapB.Adult = load([dirnameB,'1_adult_new/HSI_adult.mat']);
        
        mapA.Flower = load([dirname,'2_flower_new/HSI_flower.mat']);
        mapB.Flower = load([dirnameB,'2_flower_new/HSI_flower.mat']);
        
        mapA.Seed = load([dirname,'3_seed_new/HSI_seed.mat']);
        mapB.Seed = load([dirnameB,'3_seed_new/HSI_seed.mat']);        
 
        mapA.Turion = load([dirname,'4_turion_new/HSI_turion.mat']);
        mapB.Turion = load([dirnameB,'4_turion_new/HSI_turion.mat']); 
  
        mapA.Sexual = load([dirname,'HSI_sexual.mat']);
        mapB.Sexual = load([dirnameB,'HSI_sexual.mat']);
        
        
        if j== 3
           for jj = 1:length(facesA)
            S(jj).X = double(vertA(facesA(jj,:),1));
            S(jj).Y = double(vertA(facesA(jj,:),2));
            S(jj).Geometry = 'Polygon';
            S(jj).Sexual_2014 = mapA.Sexual.min_cdata(jj);
            S(jj).Adult_2014 = mapA.Adult.min_cdata(jj);
            S(jj).Flower_2014 = mapA.Flower.min_cdata(jj);
            S(jj).Seed_2014 = mapA.Seed.min_cdata(jj);
            S(jj).Turion_2014 = mapA.Turion.min_cdata(jj);
           end
        else
            for jj = 1:length(facesA)
            S(jj).Sexual_2015 = mapA.Sexual.min_cdata(jj);
            S(jj).Adult_2015 = mapA.Adult.min_cdata(jj);
            S(jj).Flower_2015 = mapA.Flower.min_cdata(jj);
            S(jj).Seed_2015 = mapA.Seed.min_cdata(jj);
            S(jj).Turion_2015 = mapA.Turion.min_cdata(jj);
            end
        end
        if j== 3
           for jj = 1:length(facesB)
            SB(jj).X = double(vertB(facesB(jj,:),1));
            SB(jj).Y = double(vertB(facesB(jj,:),2));
            SB(jj).Geometry = 'Polygon';
            SB(jj).Sexual_2014 = mapB.Sexual.min_cdata(jj);
            SB(jj).Adult_2014 = mapB.Adult.min_cdata(jj);
            SB(jj).Flower_2014 = mapB.Flower.min_cdata(jj);
            SB(jj).Seed_2014 = mapB.Seed.min_cdata(jj);
            SB(jj).Turion_2014 = mapB.Turion.min_cdata(jj);
           end
        else
            for jj = 1:length(facesB)
            SB(jj).Sexual_2015 = mapB.Sexual.min_cdata(jj);
            SB(jj).Adult_2015 = mapB.Adult.min_cdata(jj);
            SB(jj).Flower_2015 = mapB.Flower.min_cdata(jj);
            SB(jj).Seed_2015 = mapB.Seed.min_cdata(jj);
            SB(jj).Turion_2015 = mapB.Turion.min_cdata(jj);
            end
        end
        
        
        
    end
    
    
     shapewrite(S,[outdir,'Parnka_SC55.shp']);
     shapewrite(SB,[outdir,'NoWeir_SC55.shp']);

end
