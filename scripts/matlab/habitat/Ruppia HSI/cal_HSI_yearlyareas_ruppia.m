clear; close all;

scenario = {...
    'MER_Base_20170701_20200701',...
    'MER_Scen1_20170701_20200701',...
    'MER_Scen2_20170701_20200701',...
    
    };

year_array = 2017:2019;

% stage = {...
%     'HSI_sexual',...
%     'HSI_adult',...
%     'HSI_flower',...
%     'HSI_seed',...
%     };



shp=shaperead('E:\Lowerlakes\GIS\ocean_north.shp');    %shapefile that contains the north ocean area of coorong



for n = 1:length(scenario)
    
    %load geo.mat;
    ncfile=['E:\Lowerlakes\Busch_Ruppia_modeloutput\',scenario{n},'.nc'];
    dat = tfv_readnetcdf(ncfile,'timestep',1);
    cell_A=dat.cell_A; %cell area
    cellx=dat.cell_X;
    celly=dat.cell_Y;
    inpol=inpolygon(cellx,celly,shp(2).X,shp(2).Y);
    
    for j=1:length(year_array)
%         for m = 1:length(stage)
            
            dataHSI0=load(['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\Sheets\',num2str(year_array(j)),'\HSI_sexual.mat']); 
            dataHSI1=load(['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\Sheets\',num2str(year_array(j)),'\1_adult_new\HSI_adult.mat']);
            dataHSI2=load(['E:\Lowerlakes\RuppiaHSI\',scenario{n},'\Sheets\',num2str(year_array(j)),'\2_flower_new\HSI_flower.mat']);
            dataHSI3=load(['E:\Lowerlakes\RuppiaHSI\',scenario{n},'\Sheets\',num2str(year_array(j)),'\3_seed_new\HSI_seed.mat']);
            
%             disp(stage{m});
            
            outdir0=['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\Sheets\',num2str(year_array(j)),'\'];
            outdir1=['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\Sheets\',num2str(year_array(j)),'\1_adult_new\'];
            outdir2=['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\Sheets\',num2str(year_array(j)),'\2_flower_new\'];
            outdir3=['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\Sheets\',num2str(year_array(j)),'\3_seed_new\'];
            
%             var=fieldnames(dataHSI);
            %             time=dataHSI.(var{1}).(['scen_',scenario{n}]).mdates;
            %
            %
            %             dv=datevec(time);
            %             dm=dv(:,2); %month
            %             dy=dv(:,1);  %year
            %
            %             datearray=datenum(2017,7:42,1);
            %             vecarray=datevec(datearray); %split datetime into 6 columns
            %
            %
            %
            %             vars={'HSI'};
            %             for kk=1:length(vars)
            data0=dataHSI0.min_cdata;
            data1=dataHSI1.min_cdata;
            data2=dataHSI2.min_cdata;
            data3=dataHSI3.min_cdata;
          
            tarea0=0;
            tarea1=0;
            tarea2=0;
            tarea3=0;
            
            for cc=1:size(data0,1) %for all HSI
                if ~inpol(cc) %if it's not in polygon
                    if data0(cc)<0.3
                        tarea0=tarea0+0; %if HSI<0.3, area deemed unsuitable
                    elseif data0(cc)>=0.3
                        tarea0=tarea0+data0(cc).*cell_A(cc); %if HSI>=0.3, suitable area=HSI*area(m2)
                    end
                end
            end
            
            for cc=1:size(data1,1) %for all HSI
                if ~inpol(cc) %if it's not in polygon
                    if data1(cc)<0.3
                        tarea1=tarea1+0; %if HSI<0.3, area deemed unsuitable
                    elseif data1(cc)>=0.3
                        tarea1=tarea1+data1(cc).*cell_A(cc); %if HSI>=0.3, suitable area=HSI*area(m2)
                    end
                end
            end
            
            for cc=1:size(data2,1) %for all HSI
                if ~inpol(cc) %if it's not in polygon
                    if data2(cc)<0.3
                        tarea2=tarea2+0; %if HSI<0.3, area deemed unsuitable
                    elseif data2(cc)>=0.3
                        tarea2=tarea2+data2(cc).*cell_A(cc); %if HSI>=0.3, suitable area=HSI*area(m2)
                    end
                end
            end
            
            for cc=1:size(data3,1) %for all HSI
                if ~inpol(cc) %if it's not in polygon
                    if data3(cc)<0.3
                        tarea3=tarea3+0; %if HSI<0.3, area deemed unsuitable
                    elseif data3(cc)>=0.3
                        tarea3=tarea3+data3(cc).*cell_A(cc); %if HSI>=0.3, suitable area=HSI*area(m2)
                    end
                end
            end
            
            
            yearlyareaRuppia_sexual.(scenario{n}).(['year_',num2str(year_array(j))])=tarea0/1e6; %convert area m2 to km2
            yearlyareaRuppia_adult.(scenario{n}).(['year_',num2str(year_array(j))])=tarea1/1e6;
            yearlyareaRuppia_flower.(scenario{n}).(['year_',num2str(year_array(j))])=tarea2/1e6;
            yearlyareaRuppia_seed.(scenario{n}).(['year_',num2str(year_array(j))])=tarea3/1e6;
            
%             save([outdir0,'\sexual_yearlyarea_nonorth.mat'],'yearlyareaRuppia_sexual','-mat','-v7.3')
%             save([outdir1,'\adult_yearlyarea_nonorth.mat'],'yearlyareaRuppia_adult','-mat','-v7.3')
%             save([outdir2,'\flower_yearlyarea_nonorth.mat'],'yearlyareaRuppia_flower','-mat','-v7.3')
%             save([outdir3,'\seed_yearlyarea_nonorth.mat'],'yearlyareaRuppia_seed','-mat','-v7.3')

            
            
        end
end

%%
for n = 1:length(scenario)

table0=struct2table(yearlyareaRuppia_sexual.(scenario{n}));
table1=struct2table(yearlyareaRuppia_adult.(scenario{n}));
table2=struct2table(yearlyareaRuppia_flower.(scenario{n}));
table3=struct2table(yearlyareaRuppia_seed.(scenario{n}));

writetable(table0,['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\sexual_yearlyarea_nonorth.csv']);
writetable(table1,['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\adult_yearlyarea_nonorth.csv']);
writetable(table2,['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\flower_yearlyarea_nonorth.csv']);
writetable(table3,['E:\Lowerlakes\RuppiaHSI\',scenario{n}, '\seed_yearlyarea_nonorth.csv']);

end
