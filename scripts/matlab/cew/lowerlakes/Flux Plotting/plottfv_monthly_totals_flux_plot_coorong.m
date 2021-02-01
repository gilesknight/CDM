clear all; close all;

mod(1).mat = 'D:\Studysites\Lowerlakes\CEWH_2016\CEW_2015_2016_Obs_v1_rerun\Output\Flux.mat';
mod(1).name = 'With all Water';
mod(1).color = 'b';

mod(2).mat = 'D:\Studysites\Lowerlakes\CEWH_2016\CEW_2015_2016_noCEW_v1\Output\Flux.mat';
mod(2).name = 'No CEW';
mod(2).color = 'r';

mod(3).mat = 'D:\Studysites\Lowerlakes\CEWH_2016\CEW_2015_2016_noALL_v1\Output\Flux.mat';
mod(3).name = 'No eWater';
mod(3).color = 'g';

for i = 1:length(mod)
    load(mod(i).mat);
    
    % MH Murray/Coorong Flux Adjustment
    flux.MouthNoCoorong.mDate   = flux.Murray.mDate ;
    flux.MouthNoCoorong.Flow    = flux.Murray.Flow - flux.Coorong_1.Flow;
    flux.MouthNoCoorong.Salt    = flux.Murray.Salt - flux.Coorong_1.Salt;
    flux.MouthNoCoorong.Temp    = flux.Murray.Temp - flux.Coorong_1.Temp;
    flux.MouthNoCoorong.Trace_1 = flux.Murray.Trace_1 - flux.Coorong_1.Trace_1;
    flux.MouthNoCoorong.OXY_oxy = flux.Murray.OXY_oxy - flux.Coorong_1.OXY_oxy;
    flux.MouthNoCoorong.SIL_rsi = flux.Murray.SIL_rsi - flux.Coorong_1.SIL_rsi;
    flux.MouthNoCoorong.NIT_amm = flux.Murray.NIT_amm - flux.Coorong_1.NIT_amm ;
    flux.MouthNoCoorong.NIT_nit = flux.Murray.NIT_nit - flux.Coorong_1.NIT_nit ;
    flux.MouthNoCoorong.PHS_frp = flux.Murray.PHS_frp - flux.Coorong_1.PHS_frp ;
    flux.MouthNoCoorong.OGM_don = flux.Murray.OGM_don - flux.Coorong_1.OGM_don ;
    flux.MouthNoCoorong.OGM_pon = flux.Murray.OGM_pon - flux.Coorong_1.OGM_pon ;
    flux.MouthNoCoorong.OGM_dop = flux.Murray.OGM_dop - flux.Coorong_1.OGM_dop ;
    flux.MouthNoCoorong.OGM_pop = flux.Murray.OGM_pop - flux.Coorong_1.OGM_pop ;
    flux.MouthNoCoorong.OGM_doc = flux.Murray.OGM_doc - flux.Coorong_1.OGM_doc ;
    flux.MouthNoCoorong.OGM_poc = flux.Murray.OGM_poc - flux.Coorong_1.OGM_poc ;
    flux.MouthNoCoorong.PHY_grn = flux.Murray.PHY_grn - flux.Coorong_1.PHY_grn ;
    flux.MouthNoCoorong.TRC_ss1 = flux.Murray.TRC_ss1 - flux.Coorong_1.TRC_ss1 ;
    %flux.MouthNoCoorong.TRC_ss2 = flux.Murray.TRC_ss2 - flux.Coorong_1.TRC_ss2 ;
    flux.MouthNoCoorong.TRC_ret = flux.Murray.TRC_ret - flux.Coorong_1.TRC_ret ;
    %/## MH Murray/Coorong Flux Adjustment

    % MH Barrages Flux Adjustment   
    flux.Barrages.mDate   = flux.Murray.mDate ;
    flux.Barrages.Flow    = flux.Goolwa.Flow + flux.Mundoo.Flow + flux.Ewe.Flow + flux.Tauwitchere.Flow + flux.Boundary.Flow;
    flux.Barrages.Salt    = flux.Goolwa.Salt + flux.Mundoo.Salt + flux.Ewe.Salt + flux.Tauwitchere.Salt + flux.Boundary.Salt;
    flux.Barrages.Temp    = flux.Goolwa.Temp + flux.Mundoo.Temp + flux.Ewe.Temp + flux.Tauwitchere.Temp + flux.Boundary.Temp;
    flux.Barrages.Trace_1 = flux.Goolwa.Trace_1 + flux.Mundoo.Trace_1 + flux.Ewe.Trace_1 + flux.Tauwitchere.Trace_1 + flux.Boundary.Trace_1;
    flux.Barrages.OXY_oxy = flux.Goolwa.OXY_oxy + flux.Mundoo.OXY_oxy + flux.Ewe.OXY_oxy + flux.Tauwitchere.OXY_oxy + flux.Boundary.OXY_oxy;
    flux.Barrages.SIL_rsi = flux.Goolwa.SIL_rsi + flux.Mundoo.SIL_rsi + flux.Ewe.SIL_rsi + flux.Tauwitchere.SIL_rsi + flux.Boundary.SIL_rsi;
    flux.Barrages.NIT_amm = flux.Goolwa.NIT_amm + flux.Mundoo.NIT_amm + flux.Ewe.NIT_amm + flux.Tauwitchere.NIT_amm + flux.Boundary.NIT_amm;
    flux.Barrages.NIT_nit = flux.Goolwa.NIT_nit + flux.Mundoo.NIT_nit + flux.Ewe.NIT_nit + flux.Tauwitchere.NIT_nit + flux.Boundary.NIT_nit;
    flux.Barrages.PHS_frp = flux.Goolwa.PHS_frp + flux.Mundoo.PHS_frp + flux.Ewe.PHS_frp + flux.Tauwitchere.PHS_frp + flux.Boundary.PHS_frp;
    flux.Barrages.OGM_don = flux.Goolwa.OGM_don + flux.Mundoo.OGM_don + flux.Ewe.OGM_don + flux.Tauwitchere.OGM_don + flux.Boundary.OGM_don;
    flux.Barrages.OGM_pon = flux.Goolwa.OGM_pon + flux.Mundoo.OGM_pon + flux.Ewe.OGM_pon + flux.Tauwitchere.OGM_pon + flux.Boundary.OGM_pon;
    flux.Barrages.OGM_dop = flux.Goolwa.OGM_dop + flux.Mundoo.OGM_dop + flux.Ewe.OGM_dop + flux.Tauwitchere.OGM_dop + flux.Boundary.OGM_dop;
    flux.Barrages.OGM_pop = flux.Goolwa.OGM_pop + flux.Mundoo.OGM_pop + flux.Ewe.OGM_pop + flux.Tauwitchere.OGM_pop + flux.Boundary.OGM_pop;
    flux.Barrages.OGM_doc = flux.Goolwa.OGM_doc + flux.Mundoo.OGM_doc + flux.Ewe.OGM_doc + flux.Tauwitchere.OGM_doc + flux.Boundary.OGM_doc;
    flux.Barrages.OGM_poc = flux.Goolwa.OGM_poc + flux.Mundoo.OGM_poc + flux.Ewe.OGM_poc + flux.Tauwitchere.OGM_poc + flux.Boundary.OGM_poc;
    flux.Barrages.PHY_grn = flux.Goolwa.PHY_grn + flux.Mundoo.PHY_grn + flux.Ewe.PHY_grn + flux.Tauwitchere.PHY_grn + flux.Boundary.PHY_grn;
    flux.Barrages.TRC_ss1 = flux.Goolwa.TRC_ss1 + flux.Mundoo.TRC_ss1 + flux.Ewe.TRC_ss1 + flux.Tauwitchere.TRC_ss1 + flux.Boundary.TRC_ss1;
    %flux.Barrages.TRC_ss2 = flux.Goolwa.TRC_ss2 + flux.Mundoo.TRC_ss2 + flux.Ewe.TRC_ss2 + flux.Tauwitchere.TRC_ss2 + flux.Boundary.TRC_ss2;
    flux.Barrages.TRC_ret = flux.Goolwa.TRC_ret + flux.Mundoo.TRC_ret + flux.Ewe.TRC_ret + flux.Tauwitchere.TRC_ret + flux.Boundary.TRC_ret;
    
    data(i).flux = flux;
    clear flux;
end


outputdirectory = 'E:\Dropbox\CEW_2016\Results\CEW_2015_2016_Obs_v1\Flux Totals\';

timeperiod = 2*60*60;

[snum,str] = xlsread('matfiles/Flux Order WQ.xlsx','A2:H50');

varnames = str(:,1);
conv = snum(:,1);
units = str(:,3);
cax_min = snum(:,4);
cax_max = snum(:,5);

labels = str(:,6);
%__________________________________________________________________________

%sites = fieldnames(data(1).flux);
sites = {'Murray','MouthNoCoorong','Lock1','Wellington','Barrages','Tauwitchere','Ewe','Boundary','Mundoo','Goolwa','Coorong_1','Coorong_BC','Ocean'};

fluxplot = 1; %1 for Flux, 0 for net export


for i = 1:length(sites)
    
    vars = fieldnames(data(1).flux.(sites{i}));
    
    % Create the secondary variables
    % Values from the AED2.mnl file: Totals
    
    % TN
    
    vars(end+1) = {'TN'};
    
    for jjj = 1:length(data)
        
        data(jjj).flux.(sites{i}).TN = (data(jjj).flux.(sites{i}).NIT_nit .* (14/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).NIT_amm .* (14/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).OGM_don .* (14/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).OGM_pon .* (14/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).PHY_grn  .* (12/(1000*1000*1000)) .* 0.15);
    end
    % TP
    
    vars(end+1) = {'TP'};
    for jjj = 1:length(data)
        data(jjj).flux.(sites{i}).TP = (data(jjj).flux.(sites{i}).PHS_frp .* (31/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).OGM_dop .* (31/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).OGM_pop .* (31/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).PHY_grn .* (12/(1000*1000*1000)) .* 0.01);
    end
    % TSS
    
     vars(end+1) = {'TSS'};
    for jjj = 1:length(data)
        data(jjj).flux.(sites{i}).TSS = (data(jjj).flux.(sites{i}).TRC_ss1 .* (1/(1000*1000))) ...
           %+ (data(jjj).flux.(sites{i}).TRC_ss2 .* (1/(1000*1000)))...
            + (data(jjj).flux.(sites{i}).OGM_poc .* (12/(1000*1000*1000)))...
            + (data(jjj).flux.(sites{i}).PHY_grn .*(12/(1000*1000*1000)) .* 1);
    end
    % Turbidity
    
    vars(end+1) = {'Turbidity'};
    for jjj = 1:length(data)
        data(jjj).flux.(sites{i}).Turbidity = ((data(jjj).flux.(sites{i}).TRC_ss1 .* (1/(1000*1000))) .* 0.71) ...
            %+ ((data(jjj).flux.(sites{i}).TRC_ss2 .* (1/(1000*1000))) .* 0.71) ...
            + ((data(jjj).flux.(sites{i}).OGM_poc .* (12/(1000*1000*1000))) .* 0.1) ...
            + (data(jjj).flux.(sites{i}).PHY_grn .* (12/(1000*1000*1000)) .* 0.1);
    end
    % TCHLOR
    
    vars(end+1) = {'TCHLOR'};
    for jjj = 1:length(data)
        data(jjj).flux.(sites{i}).TCHLOR = (data(jjj).flux.(sites{i}).PHY_grn .* (12/(1000*1000*1000)) ./ 4.166667);
    end
    
    % ON
    
    vars(end+1) = {'ON'};
    for jjj = 1:length(data)
        data(jjj).flux.(sites{i}).ON = data(jjj).flux.(sites{i}).TN - (data(jjj).flux.(sites{i}).NIT_nit .* (14/(1000*1000*1000)))...
            - (data(jjj).flux.(sites{i}).NIT_amm .* (14/(1000*1000*1000)));
    end
    
    % OP
    
    vars(end+1) = {'OP'};
    for jjj = 1:length(data)
        data(jjj).flux.(sites{i}).OP = data(jjj).flux.(sites{i}).TP - (data(jjj).flux.(sites{i}).PHS_frp .* (31/(1000*1000*1000)));
    end
    
    
    
    
    
    
    
    for j = 1:length(vars)
        
        if strcmp(vars{j},'mDate') == 0
            
            for jjj = 1:length(data)
                
                sss = find(strcmp(varnames,vars{j}) == 1);
                
                xdata = data(jjj).flux.(sites{i}).mDate;
                %BB Checking for scale
                %ydata = abs(flux.(sites{i}).(vars{j}) * conv(sss));
                ydata = data(jjj).flux.(sites{i}).(vars{j}) * conv(sss);
                
                all_months = str2num(datestr(xdata,'mm'));
                all_years = str2num(datestr(xdata,'yyyy'));
                
                u_months = unique(all_months);
                u_years = unique(all_years);
                
                inc = 1;
                for jj = 1:length(u_years)
                    for ii = 1:length(u_months)
                        
                        
                        ss = find(all_months == u_months(ii) & all_years == u_years(jj));
                        
                        if ~isempty(ss)
                            
                            plotdate(inc,jjj) = datenum(u_years(jj),u_months(ii),01);
                            
                           if fluxplot == 1
                                % Include negitives in Calc
                                tt = find(isnan(ydata(ss)) == 0);
                            else
                                % Exclude Negitives in Calc
                                tt = find(ydata(ss) > 0);
                            end
                            
                            
                             if inc == 1 % Cumulative Monthly Total
                                
                                plotdata(1,jjj) = sum(ydata(ss(tt)) .* timeperiod);
                                
                                
                            else
                                
                                plotdata(inc,jjj) = plotdata(inc-1,jjj) + (sum(ydata(ss(tt)) .* timeperiod));
                                
                             end
                            clear xmonth ymonth;
                            
                            inc = inc + 1;
                            
                        end
                        
                        
                    end
                end
                
            end
            %plot(xdata,ydata,'k','displayname','Timeseries'); hold on
            s.f = figure('visible','off');
            set(gca,'FontName','Arial','FontSize',7);
            
            nBar = bar(plotdate(:,1),plotdata);hold on;
            for jjj = 1:length(data)
                set(nBar(jjj),'FaceColor',mod(jjj).color,'EdgeColor',mod(jjj).color);
                leg(jjj) = {mod(jjj).name};
            end
            ylim([cax_min(sss) cax_max(sss)]);
            xlim([(plotdate(1,1) - 20) (plotdate(end,1) + 20)]);
            set(gca,'XTick',plotdate(1:3:end,1),'XTickLabel',datestr(plotdate(1:3:end,1),'mm-yyyy'),'FontSize',7,'FontName','Arial');
            ylabel(['Cumulative ',labels{sss},' Load ',' (',units{sss},')'],'FontSize',7,'FontName','Arial');
            
            %title([regexprep(vars{j},'_','-')],'FontSize',7);
            
            
            legend(leg,'location','NW','fontsize',6,'FontName','Arial');
            
            savedir = [outputdirectory,vars{j},'/'];
            
            if ~exist(savedir,'dir');
                mkdir(savedir);
            end
            
            savename = [savedir,sites{i},'.png'];
            
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            xSize = 10;
            ySize = 6.1;
            set(gcf,'paperposition',[0 0 xSize ySize])
            
            
            print(gcf,savename,'-dpng');
            print(gcf,regexprep(savename,'.png','.eps'),'-depsc2','-painters');
            
            tfv_export_load(regexprep(savename,'.png','.csv'),plotdate,plotdata);
            
            close all;
            
            clear plotdata
            
        end
    end
end
