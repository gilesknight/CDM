clear; close all;


infolder0='E:\Lowerlakes\fishHSI\MER_Coorong_eWater_2020_v1\mat\';
% infolder0='Z:\Sherry\Lowerlakes fish HSI\fishHSI\MER_Coorong_eWater_2020_v1\mat\';

scens={'Scen2'};%'Base','Scen1',,'1b','2a','2b','3a','3b'};

yr_array = 2019;


for ii=1:length(scens)
    
    infolder=[infolder0,scens{ii},'\'];
    disp(infolder);
    
        outdir=['E:\Lowerlakes\fishHSI\MER_Coorong_eWater_2020_v1\mat\',scens{ii},'\'];
%     outdir=['Z:\Sherry\Lowerlakes fish HSI\fishHSI\MER_Coorong_eWater_2020_v1\mat\',scens{ii},'\'];
    
    load([infolder,'TEMP.mat']);
    tmp=savedata.Time; %savedata = what was loaded - TEMP.mat
    
    for y=1:length(yr_array)
        
        ts=datenum(yr_array(y),7,1);tf=datenum(yr_array(y)+1,7,1);
        tsind=find(abs(tmp-ts)==min(abs(tmp-ts))); % time start index
        tfind=find(abs(tmp-tf)==min(abs(tmp-tf)));
        mullowayHSI.(['scen_',scens{ii}]).mdates=savedata.Time(tsind:tfind);
        gobyHSI.(['scen_',scens{ii}]).mdates=savedata.Time(tsind:tfind);
        breamHSI.(['scen_',scens{ii}]).mdates=savedata.Time(tsind:tfind);
        flounderHSI.(['scen_',scens{ii}]).mdates=savedata.Time(tsind:tfind);
        mulletHSI.(['scen_',scens{ii}]).mdates=savedata.Time(tsind:tfind);
        congolliHSI.(['scen_',scens{ii}]).mdates=savedata.Time(tsind:tfind);
        hardyheadHSI.(['scen_',scens{ii}]).mdates=savedata.Time(tsind:tfind);
        
        
        cal_monthlymean=0; %whether to calculate monthly mean temp. somehow it seems to use more memory if set to 0?
        
        if cal_monthlymean
            temp_bot=savedata.TEMP(:,tsind:tfind); %: = all cells
            clear savedata;
            
            newTime=tmp(tsind:tfind);
            tvec=datevec(newTime); %split time into 6 columns: year, month,day, HH, MM, SS
            
            monthTEMP=zeros(size(temp_bot)); % each cell will still have the same number of timesteps but each timestep in a month will have the same value
            
            for i=1:length(newTime)
                inds=find(tvec(:,1)==tvec(i,1) & tvec(:,2)==tvec(i,2)); %find all cells in the same year and month
                
                for j=1:size(temp_bot,1) %cell
                    monthTEMP(j,i)=mean(temp_bot(j,inds));
                end
            end
            
            save([outdir,'TEMP_monthlymean_',num2str(yr_array(y)),'.mat'],'-mat','-v7.3');
            
        else
            load([infolder,'TEMP_monthlymean_',num2str(yr_array(y)),'.mat']);
            
        end
        load([infolder,'SAL.mat']);
        sal_bot=savedata.SAL(:,tsind:tfind);
        clear savedata;
        
        load([infolder,'D.mat']);
        Depth=savedata.D(:,tsind:tfind);
        clear savedata;
        
        %         load([infolder,'WQ_NIT_AMM.mat']);
        %         ammB=savedata.WQ_NIT_AMM.Bot(:,tsind:tfind);
        %         clear savedata;
        %
        %         load([infolder,'D.mat']);
        %         D=savedata.D(:,tsind:tfind);
        %         clear savedata;
        %
        
        %function HSI=cal_HSI_NEW(do_bot,amm_bot,sal_bot,temp_bot)
        
        [HSI,fS,fT,fO,fA]=cal_HSI_mulloway(sal_bot,monthTEMP,Depth);
        mullowayHSI.(['scen_',scens{ii}]).HSI=HSI;
        mullowayHSI.(['scen_',scens{ii}]).fS=fS;
        mullowayHSI.(['scen_',scens{ii}]).fT=fT;
        mullowayHSI.(['scen_',scens{ii}]).fO=fO;
        mullowayHSI.(['scen_',scens{ii}]).fA=fA;
        
        
        [HSI,fS,fT,fO,fA]=cal_HSI_goby(sal_bot,monthTEMP,Depth);
        gobyHSI.(['scen_',scens{ii}]).HSI=HSI;
        gobyHSI.(['scen_',scens{ii}]).fS=fS;
        gobyHSI.(['scen_',scens{ii}]).fT=fT;
        gobyHSI.(['scen_',scens{ii}]).fO=fO;
        gobyHSI.(['scen_',scens{ii}]).fA=fA;
        
        
        [HSI,fS,fT,fO,fA]=cal_HSI_bream(sal_bot,monthTEMP,Depth);
        breamHSI.(['scen_',scens{ii}]).HSI=HSI;
        breamHSI.(['scen_',scens{ii}]).fS=fS;
        breamHSI.(['scen_',scens{ii}]).fT=fT;
        breamHSI.(['scen_',scens{ii}]).fO=fO;
        breamHSI.(['scen_',scens{ii}]).fA=fA;
        
        
        [HSI,fS,fT,fO,fA]=cal_HSI_flounder(sal_bot,monthTEMP,Depth);
        flounderHSI.(['scen_',scens{ii}]).HSI=HSI;
        flounderHSI.(['scen_',scens{ii}]).fS=fS;
        flounderHSI.(['scen_',scens{ii}]).fT=fT;
        flounderHSI.(['scen_',scens{ii}]).fO=fO;
        flounderHSI.(['scen_',scens{ii}]).fA=fA;
        
        
        [HSI,fS,fT,fO,fA]=cal_HSI_mullet(sal_bot,monthTEMP,Depth);
        mulletHSI.(['scen_',scens{ii}]).HSI=HSI;
        mulletHSI.(['scen_',scens{ii}]).fS=fS;
        mulletHSI.(['scen_',scens{ii}]).fT=fT;
        mulletHSI.(['scen_',scens{ii}]).fO=fO;
        mulletHSI.(['scen_',scens{ii}]).fA=fA;
        
        
        [HSI,fS,fT,fO,fA]=cal_HSI_congolli(sal_bot,monthTEMP,Depth);
        congolliHSI.(['scen_',scens{ii}]).HSI=HSI;
        congolliHSI.(['scen_',scens{ii}]).fS=fS;
        congolliHSI.(['scen_',scens{ii}]).fT=fT;
        congolliHSI.(['scen_',scens{ii}]).fO=fO;
        congolliHSI.(['scen_',scens{ii}]).fA=fA;
        
        
        [HSI,fS,fT,fO,fA]=cal_HSI_hardyhead(sal_bot,monthTEMP,Depth);
        hardyheadHSI.(['scen_',scens{ii}]).HSI=HSI;
        hardyheadHSI.(['scen_',scens{ii}]).fS=fS;
        hardyheadHSI.(['scen_',scens{ii}]).fT=fT;
        hardyheadHSI.(['scen_',scens{ii}]).fO=fO;
        hardyheadHSI.(['scen_',scens{ii}]).fA=fA;
        
        %calculate delta HSI
        %         if ii==2 %if scen1
        %
        %             mullowayHSI.('scen_Scen1').del = mullowayHSI.('scen_Base').HSI - mullowayHSI.('scen_Scen1').HSI ;
        %             gobyHSI.('scen_Scen1').del = gobyHSI.('scen_Base').HSI - gobyHSI.('scen_Scen1').HSI ;
        %             breamHSI.('scen_Scen1').del = breamHSI.('scen_Base').HSI - breamHSI.('scen_Scen1').HSI ;
        %             flounderHSI.('scen_Scen1').del = flounderHSI.('scen_Base').HSI - flounderHSI.('scen_Scen1').HSI ;
        %             mulletHSI.('scen_Scen1').del = mulletHSI.('scen_Base').HSI - mulletHSI.('scen_Scen1').HSI ;
        %             congolliHSI.('scen_Scen1').del = congolliHSI.('scen_Base').HSI - congolliHSI.('scen_Scen1').HSI ;
        %             hardyheadHSI.('scen_Scen1').del = hardyheadHSI.('scen_Base').HSI - hardyheadHSI.('scen_Scen1').HSI ;
        
        %     end
        
        
        save([outdir,'\','mullowayHSI_del_',num2str(yr_array(y)),'.mat'],'mullowayHSI','-mat','-v7.3')
        save([outdir,'\','gobyHSI_del_',num2str(yr_array(y)),'.mat'],'gobyHSI','-mat','-v7.3')
        save([outdir,'\','breamHSI_del_',num2str(yr_array(y)),'.mat'],'breamHSI','-mat','-v7.3')
        save([outdir,'\','flounderHSI_del_',num2str(yr_array(y)),'.mat'],'flounderHSI','-mat','-v7.3')
        save([outdir,'\','mulletHSI_del_',num2str(yr_array(y)),'.mat'],'mulletHSI','-mat','-v7.3')
        save([outdir,'\','congolliHSI_del_',num2str(yr_array(y)),'.mat'],'congolliHSI','-mat','-v7.3')
        save([outdir,'\','hardyheadHSI_del_',num2str(yr_array(y)),'.mat'],'hardyheadHSI','-mat','-v7.3')
        
        
        %         save([outdir,'\','mullowayHSI_',num2str(yr_array(y)),'.mat'],'mullowayHSI','-mat','-v7.3')
        %         save([outdir,'\','gobyHSI_',num2str(yr_array(y)),'.mat'],'gobyHSI','-mat','-v7.3')
        %         save([outdir,'\','breamHSI_',num2str(yr_array(y)),'.mat'],'breamHSI','-mat','-v7.3')
        %         save([outdir,'\','flounderHSI_',num2str(yr_array(y)),'.mat'],'flounderHSI','-mat','-v7.3')
        %         save([outdir,'\','mulletHSI_',num2str(yr_array(y)),'.mat'],'mulletHSI','-mat','-v7.3')
        %         save([outdir,'\','congolliHSI_',num2str(yr_array(y)),'.mat'],'congolliHSI','-mat','-v7.3')
        %         save([outdir,'\','hardyheadHSI_',num2str(yr_array(y)),'.mat'],'hardyheadHSI','-mat','-v7.3')
        
        
        %         save([outdir,'\','mullowayHSI_2017','.mat'],'mullowayHSI','-mat','-v7.3')
        %         save([outdir,'\','gobyHSI_2017','.mat'],'gobyHSI','-mat','-v7.3')
        %         save([outdir,'\','breamHSI_2017','.mat'],'breamHSI','-mat','-v7.3')
        %         save([outdir,'\','flounderHSI_2017','.mat'],'flounderHSI','-mat','-v7.3')
        %         save([outdir,'\','mulletHSI_2017','.mat'],'mulletHSI','-mat','-v7.3')
        %         save([outdir,'\','congolliHSI_2017','.mat'],'congolliHSI','-mat','-v7.3')
        %         save([outdir,'\','hardyheadHSI_2017','.mat'],'hardyheadHSI','-mat','-v7.3')
        
        
        
        
    end
end



