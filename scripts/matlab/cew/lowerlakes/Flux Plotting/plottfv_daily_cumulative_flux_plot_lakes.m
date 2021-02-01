clear all; close all;


mod(1).mat = 'H:\Lowerlakes-CEW-Results\Obs\Flux.mat';
mod(1).name = 'With all Water';
mod(1).color = 'b';

mod(2).mat = 'H:\Lowerlakes-CEW-Results\NoCEW\Flux.mat';
mod(2).name = 'No CEW';
mod(2).color = 'r';
% % % 
mod(3).mat = 'H:\Lowerlakes-CEW-Results\NoEWater\Flux.mat';
mod(3).name = 'No eWater';
mod(3).color = 'g';
%


% mod(1).mat = 'D:\Studysites\Lowerlakes\034_obs_AED2_LCFlow_IC2_NIT\Output\Flux.mat';
% mod(1).name = 'v34';
% mod(1).color = 'b';
%
% mod(2).mat = 'D:\Studysites\Lowerlakes\035_obs_LL_Only_TFV_AED2_Inf\Output\Flux.mat';
% mod(2).name = 'v35 LL';
% mod(2).color = 'r';
%
% mod(3).mat = 'D:\Studysites\Lowerlakes\025_obs_AED2_WS20_SC_Flow_off_IC2_NIT\Output\Flux.mat';
% mod(3).name = 'v25';
% mod(3).color = 'g';

xarray = datenum(2017,07:03:20,01);


for i = 1:length(mod)
    load(mod(i).mat);
%         if i == 1
%         flux = cleanse_obs_data(flux,xarray);
%     end
    data(i).flux = flux;
    clear flux;
end


outputdirectory = 'H:\Lowerlakes-CEW-Results\Flux Dailys Totals\';

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
sites = {'Wellington','Murray','Tauwitchere','Ewe','Boundary','Mundoo','Goolwa','Ocean','Coorong_1','Coorong_BC'};

sumdata = [];

fluxplot = 1; %1 for Flux, 0 for net export


for i = 1:length(sites)
    
    vars = fieldnames(data(1).flux.(sites{i}));
    
    % Create the secondary variables
    % Values from the AED2.mnl file: Totals
    
    % TN
    
    if sum(strcmpi(vars,'NIT_nit')) == 1
        
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
            %+ ((data(jjj).flux.(sites{i}).OGM_poc .* (12/(1000*1000*1000))) .* 0.1) ...
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
                inc = 1;
                for jj = 1:length(u_years)
                    for ii = 1:length(u_months)
                        
                        eday = eomday(u_years(jj),u_months(ii));
                        
                        for iii = 1:eday
                            
                            %ss = find(all_months == u_months(ii) & all_years == u_years(jj));
                            
                            ss = find(floor(xdata) == datenum(u_years(jj),u_months(ii),iii));
                            
                            if ~isempty(ss)
                                
                                plotdate(inc,jjj) = datenum(u_years(jj),u_months(ii),iii);
                                
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
                                    
                                    plotdata(inc,jjj) = sum(ydata(ss(tt)) .* timeperiod);%plotdata(inc-1,jjj) + 
                                    
                                end
                                
                                clear xmonth ymonth;
                                
                                inc = inc + 1;
                                
                            end
                            
                        end
                        
                        
                    end
                end
                
            end
            
            sumdata.(sites{i}).(vars{j}).plotdate = plotdate;
            sumdata.(sites{i}).(vars{j}).plotdata = plotdata;
            
            %plot(xdata,ydata,'k','displayname','Timeseries'); hold on
%             s.f = figure('visible','off');
%             set(gca,'FontName','Arial','FontSize',7);
%             
%             nBar = bar(plotdate(:,2),plotdata);hold on;
%             for jjj = 1:length(data)
%                 set(nBar(jjj),'FaceColor',mod(jjj).color,'EdgeColor',mod(jjj).color);
%                 leg(jjj) = {mod(jjj).name};
%             end
%             
%             if strcmpi(sites{i},'Murray') == 1 & strcmpi(vars{j},'Salt') == 1
%                 
%                 ylim([(cax_max(sss) * -2.5) cax_max(sss)]);
%                 
%                 
%             else
%                 if strcmpi(sites{i},'Murray') == 1 & strcmpi(vars{j},'TSS') == 1
%                     
%                     %ylim([(cax_max(sss) * -0.5) cax_max(sss)/2]);
%                     ylim([cax_min(sss) cax_max(sss)]);
%                 else
%                     
%                     
%                     if strcmpi(sites{i},'Murray') == 1 & strcmpi(vars{j},'PHS_frp') == 1
%                         ylim([-2 2]);
%                     else
%                         ylim([cax_min(sss) cax_max(sss)]);
%                     end
%                 end
%                 
%             end
%             
%             xlim([(plotdate(1,2) - 20) (plotdate(end,2) + 20)]);
%             set(gca,'XTick',plotdate(1:3:end,2),'XTickLabel',datestr(plotdate(1:3:end,2),'mm-yyyy'),'FontSize',7,'FontName','Arial');
%             ylabel(['Cumulative ',labels{sss},' Load ',' (',units{sss},')'],'FontSize',7,'FontName','Arial');
%             
%             %title([regexprep(vars{j},'_','-')],'FontSize',7);
%             
%             if strcmpi(sites{i},'Murray') == 1 & strcmpi(vars{j},'Salt') == 1
%                 legend(leg,'location','SW','fontsize',6,'FontName','Arial');
%                 
%             else
%                 if strcmpi(sites{i},'Wellington') == 1 & strcmpi(vars{j},'PHS_frp') == 1
%                     legend(leg,'location','NW','fontsize',6,'FontName','Arial');
%                 else
%                     legend(leg,'location','NE','fontsize',6,'FontName','Arial');
%                 end
%             end
             savedir = [outputdirectory,vars{j},'/'];
            
            if ~exist(savedir,'dir');
                mkdir(savedir);
            end
            
            savename = [savedir,sites{i},'.png'];
            
%             set(gcf, 'PaperPositionMode', 'manual');
%             set(gcf, 'PaperUnits', 'centimeters');
%             xSize = 10;
%             ySize = 6.1;
%             set(gcf,'paperposition',[0 0 xSize ySize])
%             
%             
%             print(gcf,savename,'-dpng');
%             print(gcf,regexprep(savename,'.png','.eps'),'-depsc2','-painters');
            
            tfv_export_load_daily(regexprep(savename,'.png','.csv'),plotdate,plotdata,mod);
            
            
            close all;
            
            clear plotdata
            
        end
    end
end

save([outputdirectory,'sumdata.mat'],'sumdata','-mat');

disp('Plotting the Barrage totals');


for j = 1:length(vars)
    if strcmp(vars{j},'mDate') == 0
        sss = find(strcmp(varnames,vars{j}) == 1);
        bplotdate(:,1) = sumdata.Tauwitchere.(vars{j}).plotdate(:,1);
        
        for jj = 1:length(mod)
            
            bplotdata(:,jj) = sumdata.Tauwitchere.(vars{j}).plotdata(:,jj) + ...
                sumdata.Boundary.(vars{j}).plotdata(:,jj) + ...
                sumdata.Ewe.(vars{j}).plotdata(:,jj) + ...
                sumdata.Mundoo.(vars{j}).plotdata(:,jj)+ ...
                sumdata.Goolwa.(vars{j}).plotdata(:,jj);
        end
        
        %plot(xdata,ydata,'k','displayname','Timeseries'); hold on
%         s.f = figure('visible','off');
%         set(gca,'FontName','Arial','FontSize',7);
%         
%         nBar = bar(bplotdate(:,1),bplotdata);hold on;
%         for jjj = 1:length(data)
%             set(nBar(jjj),'FaceColor',mod(jjj).color,'EdgeColor',mod(jjj).color);
%             leg(jjj) = {mod(jjj).name};
%         end
%         if strcmpi(vars{j},'PHS_frp') == 1
%             ylim([0 2]);
%         else
%             ylim([cax_min(sss) cax_max(sss)]);
%         end
%         xlim([(bplotdate(1,1) - 20) (bplotdate(end,1) + 20)]);
%         set(gca,'XTick',bplotdate(1:3:end,1),'XTickLabel',datestr(bplotdate(1:3:end,1),'mm-yyyy'),'FontSize',7,'FontName','Arial');
%         ylabel(['Cumulative ',labels{sss},' Load ',' (',units{sss},')'],'FontSize',7,'FontName','Arial');
%         
%         %title([regexprep(vars{j},'_','-')],'FontSize',7);
%         
%         
%         legend(leg,'location','NE','fontsize',6,'FontName','Arial');
        
        savedir = [outputdirectory,vars{j},'/'];
        
        if ~exist(savedir,'dir');
            mkdir(savedir);
        end
        
        savename = [savedir,'Barrage.png'];
        
%         set(gcf, 'PaperPositionMode', 'manual');
%         set(gcf, 'PaperUnits', 'centimeters');
%         xSize = 10;
%         ySize = 6.1;
%         set(gcf,'paperposition',[0 0 xSize ySize])
%         
%         
%         print(gcf,savename,'-dpng');
%         print(gcf,regexprep(savename,'.png','.eps'),'-depsc2','-painters');
        
        tfv_export_load_daily(regexprep(savename,'.png','.csv'),bplotdate,bplotdata,mod);
        
        
        close all;
        
        clear bplotdata
    end
end





