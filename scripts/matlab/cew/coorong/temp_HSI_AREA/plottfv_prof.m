function plottfv_prof(conf)
% The main runtime function to compare the field data with the model data.
addpath(genpath('tuflowfv'));

% Load configuration information
switch conf
    case 'prof'
        config_prof;
    case 'sal'
        config_sal;
    case '11'
        config_prof_11;
    case 'lower'
        config_prof_lower;
    case 'swan_sp'
        config_prof_SP;
        
    case 'swan_1'
        config_prof_1;
    case '2014VH'
        config_prof_2014VH;
        
    case '2014_2016'
        config_prof_2014_2016;
    case '2014_2016_sal'
        config_prof_2014_2016_sal;
    case '2015VH'
        config_prof_2015VH;
    case '2015VH_Culvert'
        config_prof_2015VH_culvert;
    case '2015VH_Culvert_sal'
        config_prof_2015VH_culvert_sal;
        
    case 'noweir'
        config_prof_noweir;
    case 'noweir_sal'
        config_prof_noweir_sal;
    case 'weir1'
        config_prof_weir1;
    case 'weir1_sal'
        config_prof_weir1_sal;
    case 'weirpos'
        config_prof_weirpos;
    case 'weirpos_sal'
        config_prof_weirpos_sal;
    case 'parnkasal'
        config_prof_parnkasal;
    case 'parnkasal_sal'
        config_prof_parnkasal_sal;
    case 'Needles'
        config_prof_Needles_culvert;
    case 'Needles_sal'
        config_prof_Needles_culvert_sal;
    case '2016BK'
        config_prof_2016BK;
        
    case '2014VH_Sal'
        config_prof_2014VH_Sal;
        
    case '2015VH_Sal'
        config_prof_2015VH_Sal;
    case '2016BK_Sal'
        config_prof_2016BK_Sal;
        
        
    case 'GP1'
        config_prof_scenarioGp1;
    case 'GP2'
        config_prof_scenarioGp2;
    case 'GP3'
        config_prof_scenarioGp3;
    case 'GP1_Sal'
        config_prof_scenarioGp1_Sal;
    case 'GP2_Sal'
        config_prof_scenarioGp2_Sal;
    case 'GP3_Sal'
        config_prof_scenarioGp3_Sal;
        
        
        
        
    case 'swan_v2'
        config_prof_v2;
        
    case 'swan_single'
        config_prof_Single;
        
        
    case '2008'
        config_prof_2008;
        
    case '2008_Single'
        config_prof_2008_Single;
        
    case 'swan_2'
        config_prof_2;
        
    case 'swan_3'
        config_prof_3;
    case 'swan_small'
        config_prof_small;
        
    case 'canning'
        config_canning;
    case 'canning3'
        config_canning_3scenarios;
    case 'yarra'
        config_yarra;
    case 'caboolture'
        config_caboolture;
    case 'gippsland'
        config_gippsland;
    case 'testcase'
        config_testcase
    case 'lowerlakes'
        config_lowerlakes;
    case 'lowerlakes_2'
        config_lowerlakes_2;
    case 'lowerlakes_3'
        config_lowerlakes_3;
    case 'main'
        config_lowerlakes_4;
    case 'river'
        config_lowerlakes_river;
    case 'river2'
        config_lowerlakes_river_2;
    case 'coorong'
        config_lowerlakes_coorong;
    otherwise
        disp('Configuration not found');
        stop;
end

allvars = tfv_infonetcdf(ncfile(1).name);

% Loop through variables
for var = 1:length(varname)
    
    savedir = [outputdirectory,varname{var},'/'];
    mkdir(savedir);
    
    disp(varname{var});
    
    % Load Field Data and Get site names
    field = load(['matfiles/',fielddata,'.mat']);
    fdata = field.(fielddata);
    sitenames = fieldnames(fdata);
    clear raw
    for mod = 1:length(ncfile)
        disp(['Loading Model ',num2str(mod)]);
        
        if isfield(ncfile(mod),'translate')
            if ncfile(mod).translate
                switch varname{var}
                    
                    case 'WQ_AED_OXYGEN_OXY'
                        loadname = 'WQ_OXY_OXY';
                    case 'WQ_AED_NITROGEN_AMM'
                        loadname = 'WQ_NIT_AMM';
                    case 'WQ_AED_NITROGEN_NIT'
                        loadname = 'WQ_NIT_NIT';
                    case 'WQ_AED_PHOSPHORUS_FRP'
                        loadname = 'WQ_PHS_FRP';
                    case 'WQ_AED_PHYTOPLANKTON_CHLA'
                        loadname = 'WQ_CHLA';
                    case 'WQ_AED_ORGANIC_MATTER_DON'
                        loadname = 'WQ_OGM_DON';
                    case 'WQ_AED_ORGANIC_MATTER_PON'
                        loadname = 'WQ_OGM_PON';
                    case 'WQ_AED_ORGANIC_MATTER_DOP'
                        loadname = 'WQ_OGM_DOP';
                    case 'WQ_AED_ORGANIC_MATTER_POP'
                        loadname = 'WQ_OGM_POP';
                    case 'WQ_AED_ORGANIC_MATTER_DOC'
                        loadname = 'WQ_OGM_DOC';
                    case 'WQ_AED_ORGANIC_MATTER_POC'
                        loadname = 'WQ_OGM_POC';
                    otherwise
                        loadname = varname{var};
                end
            else
                loadname = varname{var};
            end
        end
        
        switch varname{var}
            
            case 'OXYPC'
                oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_AED_OXYGEN_OXY'});
                tra = tfv_readnetcdf(ncfile(mod).name,'names',{'TRACE_1'});
                
                raw(mod).data.OXYPC = tra.TRACE_1 ./ oxy.WQ_AED_OXYGEN_OXY;
                clear tra oxy
                
                
            case 'WQ_DIAG_TOT_EXTC'
                oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_EXTC'});
                
                dd = oxy.WQ_DIAG_TOT_EXTC;
                
                sss = find(dd > 50);
                dd(sss) = NaN;
                
                
                raw(mod).data.WQ_DIAG_TOT_EXTC = dd;
                clear  oxy dd sss
                
                
            case 'ON'
                TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
                AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
                NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
                
                raw(mod).data.ON = TN.WQ_DIAG_TOT_TN - AMM.WQ_NIT_AMM - NIT.WQ_NIT_NIT;
                
                clear TN AMM NIT
                
            case 'TP'
                
                tp_var = {...
                    'WQ_PHS_FRP',...
                    'WQ_PHS_FRP_ADS',...
                    'WQ_OGM_DOP',...
                    'WQ_OGM_DOPR',...
                    'WQ_OGM_POP',...
                    };
                
                
                TP =  tfv_readnetcdf(ncfile(mod).name,'names',tp_var');
                
                raw(mod).data.TP = TP.WQ_PHS_FRP +...
                    TP.WQ_PHS_FRP_ADS +...
                    TP.WQ_OGM_DOP +...
                    TP.WQ_OGM_DOPR + ...
                    TP.WQ_OGM_POP;
                
                
                
                clear TP tp_var
                
            case 'TN'
                
                tp_var = {...
                    'WQ_NIT_nit',...
                    'WQ_NIT_amm',...
                    'WQ_OGM_don',...
                    'WQ_OGM_pon',...
                    'WQ_OGM_donr',...
                    };
                
                tp_var = upper(tp_var);
                TP =  tfv_readnetcdf(ncfile(mod).name,'names',tp_var');
                
                raw(mod).data.TN = TP.WQ_NIT_NIT +...
                    TP.WQ_NIT_AMM +...
                    TP.WQ_OGM_DON +...
                    TP.WQ_OGM_PON + ...
                    TP.WQ_OGM_DONR;
                
                
                
                clear TP tp_var
                
            case 'Turbidity'
                
                tp_var = {...
                    'WQ_TRC_ss1',...
                    'WQ_TRC_ss2',...
                    'WQ_OGM_poc',...
                    'WQ_PHY_grn',...
                    'WQ_PHY_bga',...
                    'WQ_PHY_dino',...
                    'WQ_PHY_diatom',...
                    'WQ_PHY_crypt',...
                    };
                
                tp_var = upper(tp_var);
                TP =  tfv_readnetcdf(ncfile(mod).name,'names',tp_var');
                
                raw(mod).data.Turbidity = (TP.WQ_TRC_SS1 .* 0.33) +...
                    (TP.WQ_TRC_SS2 .* 0.3) +...
                    (TP.WQ_OGM_POC .* 0.001)+...
                    (TP.WQ_PHY_GRN .* 0.001)+...
                    (TP.WQ_PHY_BGA .* 0.001)+...
                    (TP.WQ_PHY_DINO .* 0.001)+...
                    (TP.WQ_PHY_DIATOM .* 0.001)+...
                    (TP.WQ_PHY_CRYPT .* 0.001);
                
                
                
                
                clear TP tp_var
                
                
                
                
            case 'WQ_OGM_DON'
                data1 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});
                data2 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DONR'});
                
                raw(mod).data.WQ_OGM_DON = data1.WQ_OGM_DON + data2.WQ_OGM_DONR;
                
            case 'WQ_OGM_DOC'
                data1 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOC'});
                data2 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOCR'});
                
                raw(mod).data.WQ_OGM_DOC = data1.WQ_OGM_DOC + data2.WQ_OGM_DOCR;
                
                clear TP FRP
                
            case 'WQ_TRC_RET'
                
                data1 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_RET'});
                
                raw(mod).data.WQ_TRC_RET = data1.WQ_TRC_RET / 86400;
                
                clear data1
                
            case 'WQ_OXY_OXY'
                
                data1 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OXY_OXY'});
                
                raw(mod).data.WQ_OXY_OXY = data1.WQ_OXY_OXY * 32 /1000;
                
                clear data1
                
                
            otherwise
                
                raw(mod).data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});
                
        end
        
        
        
    end
    
    % Loop through sites
    for site = 1:length(sitenames)
        
        %if strcmp(fdata.(sitenames{site}).(varname{var}).Title,'Armstrong Spit')==1
        %    break;
        %end
        %         if plotvalidation  ||  strcmp(varname{var},'H') < 1 || sum(strcmp(varname{var},allvars)) > 0
        valid_vars = fieldnames(fdata.(sitenames{site}));
        %
        %             if sum(strcmp(varname{var},valid_vars)) > 0
        %
        %                 X = fdata.(sitenames{site}).(varname{var}).X;
        %                 Y = fdata.(sitenames{site}).(varname{var}).Y;
        %             end
        %         else
        X = fdata.(sitenames{site}).(valid_vars{1}).X;
        Y = fdata.(sitenames{site}).(valid_vars{1}).Y;
        %         end
        % Load Model Data
        for mod = 1:length(ncfile)
            if isfield(ncfile(mod),'translate')
                if ncfile(mod).translate
                    switch varname{var}
                        
                        case 'WQ_AED_OXYGEN_OXY'
                            loadname = 'WQ_OXY_OXY';
                        case 'WQ_AED_NITROGEN_AMM'
                            loadname = 'WQ_NIT_AMM';
                        case 'WQ_AED_NITROGEN_NIT'
                            loadname = 'WQ_NIT_NIT';
                        case 'WQ_AED_PHOSPHORUS_FRP'
                            loadname = 'WQ_PHS_FRP';
                        case 'WQ_AED_PHYTOPLANKTON_CHLA'
                            loadname = 'WQ_CHLA';
                        case 'WQ_AED_ORGANIC_MATTER_DON'
                            loadname = 'WQ_OGM_DON';
                        case 'WQ_AED_ORGANIC_MATTER_PON'
                            loadname = 'WQ_OGM_PON';
                        case 'WQ_AED_ORGANIC_MATTER_DOP'
                            loadname = 'WQ_OGM_DOP';
                        case 'WQ_AED_ORGANIC_MATTER_POP'
                            loadname = 'WQ_OGM_POP';
                        case 'WQ_AED_ORGANIC_MATTER_DOC'
                            loadname = 'WQ_OGM_DOC';
                        case 'WQ_AED_ORGANIC_MATTER_POC'
                            loadname = 'WQ_OGM_POC';
                        otherwise
                            loadname = varname{var};
                    end
                else
                    loadname = varname{var};
                end
            end
            data(mod) = tfv_getmodeldatalocation(...
                ncfile(mod).name,raw(mod).data,X,Y,{loadname});
        end
        
        % Now for the plotting - timeseries or profile
        if strcmp(plottype,'timeseries')
            
            s.f = figure('visible',def.visible);
            set(gca,'FontName',def.font,'FontSize',8)
            
            
            
            for mod = 1:length(ncfile)
                for lev = 1:length(plotdepth)
                    %                     if strcmp(varname{var},'WQ_OXY_OXY') == 1
                    %                         data(mod).(plotdepth{lev}) = data(mod).(plotdepth{lev}) * 32 /1000;
                    %                     end
                    
                    % Hack for solid lines on H plot
                    if strcmp(varname{var},'H') == 1
                        %pcol = 'k';
                        pcol = ncfile(mod).colour{lev};
                    else
                        pcol = ncfile(mod).colour{lev};
                    end
                    if strcmp(varname{var},'H') & lev == 2
                        %                     plot(data(mod).date,smooth(data(mod).(plotdepth{lev}),...
                        %                         def.smoothfactor),'color',pcol,...
                        %                         'linestyle',ncfile(mod).symbol{lev},...
                        %                         'linewidth',1.5,...
                        %                         'DisplayName',[upper(plotdepth{lev}),...
                        %                         ': ',ncfile(mod).legend]);hold on
                        
                    else
                        
                        xdata = data(mod).date;
                        ydata = data(mod).(plotdepth{lev});
                        
                        if convert_units
                            [ydata,units] = tfv_Unit_Conversion(ydata,varname{var});
                        else
                            units = [];
                        end
                        
                        %                         plot(xdata,smooth(ydata,...
                        %                             def.smoothfactor),'color',pcol,...
                        %                             'linestyle',ncfile(mod).symbol{lev},...
                        %                             'linewidth',1.5,...
                        %                             'DisplayName',[upper(plotdepth{lev}),...
                        %                             ': ',ncfile(mod).legend]);hold on
                        
                        if strcmp(varname{var},'WQ_DIAG_PHY_TCHLA') == 1
                            disp(['Applying factor to WQ_DIAG_PHY_TCHLA']);
                            ydata = ydata .* 3;
                        end
                        
                        
                        hh = plot(xdata,smooth(ydata,...
                            def.smoothfactor),'color',pcol,...
                            'linestyle',ncfile(mod).symbol{lev},...
                            'linewidth',1,...
                            'DisplayName',[upper(plotdepth{lev}),...
                            ': ',ncfile(mod).legend]);hold on
                        clear xdata ydata;
                        
                        %                         hh = plot(xdata,ydata,'color',pcol,...
                        %                             'linestyle',ncfile(mod).symbol{lev},...
                        %                             'linewidth',1,...
                        %                             'DisplayName',[upper(plotdepth{lev}),...
                        %                             ': ',ncfile(mod).legend]);hold on
                        %                         clear xdata ydata;
                        
                        
                        
                        
                        if isfield(ncfile(mod),'restart')
                            if ncfile(mod).restart == 1
                                set(get(get(hh,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
                            end
                        end
                        
                    end
                    %'DisplayName',[ncfile(mod).legend]);hold on
                    
                    
                end
            end
            
            if plotvalidation  ||  strcmp(varname{var},'H') < 1
                % Load field data
                if sum(strcmp(valid_vars,varname{var})) > 0
                    depth = tfv_processfielddata(fdata,...
                        plotdepth,sitenames{site},varname{var});
                    for lev = 1:length(plotdepth)
                        if plotvalidation
                            
                            if strcmp(varname{var},'WQ_OXY_OXY') == 1
                                depth.(plotdepth{lev}) = depth.(plotdepth{lev}) * 32 / 1000;
                            end
                            
                            last_check = find(depth.date >= def.datearray(1) & depth.date<= def.datearray(end));
                            
                            if ~isempty(last_check)
                                
                                xdata = depth.date;
                                ydata = depth.(plotdepth{lev});
                                if convert_units
                                    [ydata,units] = tfv_Unit_Conversion(ydata,varname{var});
                                else
                                    units = [];
                                end
                                
                                % Hack for legend stuff
                                
                                
                                aa = plot(xdata,ydata,'color',def.fieldcolour{lev},...
                                    'linestyle',':','marker',def.fieldsymbol{lev},...
                                    'markersize',6,...
                                    'DisplayName',...
                                    [upper(plotdepth{lev}),': Field']);hold on
                                
                                clear xdata ydata;
                                
                                
                                
                                
                            end
                            %                              plot(depth.date,depth.(plotdepth{lev}),'color',def.fieldcolour{lev},...
                            %                                 'DisplayName',...
                            %                                 ['Field']);hold on
                            %[upper(plotdepth{lev}),': Field']);hold on
                        end
                    end
                end
            end
            
            
            if isfield(def,'add_weirdate')
                if def.add_weirdate
                    
                    yrange = def.cAxis(var).value(2) - def.cAxis(var).value(1);
                    y10 = yrange* 0.1;
                    y20 = y10*2;
                    y30 = y10 * 3;
                    
                    % Add life stage information
                    [yyyy,~,~] = datevec(def.datearray);
                    
                    years = unique(yyyy);
                    for st = 1:length(years)
                        
                        pt = plot([datenum(years(st),01,01) datenum(years(st),01,01)],[def.cAxis(var).value(1) def.cAxis(var).value(end)],'--k');
                        set(pt,'HandleVisibility','off');
                        pt = plot([datenum(years(st),09,01) datenum(years(st),09,01)],[def.cAxis(var).value(1) def.cAxis(var).value(end)],'--k');
                        set(pt,'HandleVisibility','off');
                        
                        st1 = plot([datenum(years(st),04,01) (datenum(years(st),04,01)+120)],...
                            [(def.cAxis(var).value(2)-y10) (def.cAxis(var).value(2)-y10)],'k');
                        set(st1,'HandleVisibility','off');
                        
                        st1 = plot([datenum(years(st),06,01) (datenum(years(st),06,01)+120)],...
                            [(def.cAxis(var).value(2)-y20) (def.cAxis(var).value(2)-y20)],'k');
                        set(st1,'HandleVisibility','off');
                        
                        st1 = plot([datenum(years(st),08,01) (datenum(years(st),08,01)+150)],...
                            [(def.cAxis(var).value(2)-y30) (def.cAxis(var).value(2)-y30)],'k');
                        set(st1,'HandleVisibility','off');
                        
                    end
                end
            end
            
            
            %-------- Now format the Plot ---------%
            
            xlim([def.datearray(1) def.datearray(end)]);
            ylim([def.cAxis(var).value]);
            
            set(gca,'Xtick',def.datearray,...
                'XTickLabel',datestr(def.datearray,def.dateformat),...
                'FontSize',def.xlabelsize);
            %             set(gca,'Xtick',def.datearray,...
            %                 'XTickLabel',[],...
            %                 'FontSize',def.xlabelsize);
            
            
            if sum(strcmp(valid_vars,varname{var})) > 0
                if isylabel
                    
                    if isempty(units)
                        units = fdata.(sitenames{site}).(varname{var}).Units;
                    end
                    
                    ylabel([regexprep(fdata.(sitenames{site}).(varname{var}).Variable_Name,'_',' '),' ','(',...
                        units,')'],...
                        'FontSize',def.ylabelsize);
                    clear units
                end
            end
            if istitled
                title(regexprep(sitenames{site},'_',' '),...
                    'FontSize',def.titlesize,...
                    'FontWeight','bold');
                
                %                 if sum(strcmp(valid_vars,varname{var})) > 0
                %                     title(regexprep(fdata.(sitenames{site}).(varname{var}).Title,'_',' '),...
                %                         'FontSize',def.titlesize,...
                %                         'FontWeight','bold');
                %                 else
                %                     %if isfield(fdata.(sitenames{site}),'SAL')
                %                     title(regexprep(sitenames{site},'_',' '),...
                %                         'FontSize',def.titlesize,...
                %                         'FontWeight','bold');
                %                     %end
                %                 end
            end
%             if exist('islegend','var')
%                 if islegend
%                     leg = legend('location',def.legendlocation);
%                     set(leg,'fontsize',def.legendsize);
%                 end
%             else
%                 leg = legend('location',def.legendlocation);
%                 set(leg,'fontsize',def.legendsize);
%             end
            
            if strcmp(varname{var},'WQ_AED_OXYGEN_OXY') == 1
                
                plot([def.datearray(1) def.datearray(end)],[2 2],...
                    'color',[0.4 0.4 0.4],'linestyle','--');
                
                plot([def.datearray(1) def.datearray(end)],[4 4],...
                    'color',[0.4 0.4 0.4],'linestyle','--');
                
            end
            
            %--% Paper Size
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            xSize = def.dimensions(1);
            ySize = def.dimensions(2);
            xLeft = (21-xSize)/2;
            yTop = (30-ySize)/2;
            set(gcf,'paperposition',[0 0 xSize ySize])
            
            %             if isfield(fdata.(sitenames{site}).SAL,'Order')
            %                 final_sitename = [sprintf('%04d',fdata.(sitenames{site}).SAL.Order),'_',sitenames{site},'.png'];
            %             else
            %                 final_sitename = [sitenames{site},'.png'];
            %             end
            
            tVar = fieldnames(fdata.(sitenames{site}));
            
            if isfield(fdata.(sitenames{site}).(tVar{1}),'Order')
                final_sitename = [sprintf('%04d',fdata.(sitenames{site}).SAL.Order),'_',sitenames{site},'.eps'];
            else
                final_sitename = [sitenames{site},'.eps'];
            end
            finalname = [savedir,final_sitename];
            if exist('filetype','var')
                if strcmpi(filetype,'png');
                    print(gcf,'-depsc2',finalname,'-painters');
                    print(gcf,'-dpng',regexprep(finalname,'.eps','.png'),'-opengl');
                else
                    print(gcf,'-depsc2',finalname,'-painters');
                    print(gcf,'-dpng',regexprep(finalname,'.eps','.png'),'-opengl');
                end
            else
                print(gcf,'-depsc2',finalname,'-painters');
                print(gcf,'-dpng',regexprep(finalname,'.eps','.png'),'-opengl');
            end
            close all force
            %fclose('all');
            %---------------------------------
        elseif strcmp(plottype,'profile')
            
            if strcmp(varname{1},'H') == 0
                
                field = tfv_processfielddata(fdata,...
                    plotdepth,sitenames{site},varname{var});
                
                profileDate = field.date;
                ddd = find(profileDate > def.datearray(1));
                dddd = find(profileDate(ddd) < def.datearray(end));
                profileDate = profileDate(ddd(dddd));
                nprofs = length(profileDate);
                
                disp(nprofs)
                
                
                for profs = 1:nprofs
                    
                    figure('visible',def.visible);
                    set(gca,'FontName',def.font,'FontSize',6)
                    
                    theprof = find(abs( field.date-profileDate(profs) ) <0.05 );
                    
                    
                    
                    for mod = 1:length(ncfile)
                        colp(1).name = ['.-','b'];
                        colp(2).name = ['.-','g'];
                        colp(3).name = ['.-','y'];
                        col2 = ['.-','r'];
                        gap = abs(data(mod).date - (profileDate(profs)+0.5)) ;
                        
                        %theday = find(abs(data(mod).date - profileDate(profs)) <0.02 )
                        theday = find( gap == min(gap) );
                        
                        if ~isempty(theday)
                            if(min(gap) <0.5)
                                modprof = squeeze( data(mod).profile(:,theday) );
                                for fix = 1:size(modprof,2)
                                    plot(modprof(:,fix),-(data(mod).depths(:)-data(mod).depths(1)),colp(fix).name,...
                                        'DisplayName',...
                                        [ncfile(mod).legend,' ',datestr(min(data(mod).date(theday)),'HH:MM')]); hold on
                                end
                                %'DisplayName',[ncfile(mod).legend,' ',datestr(min(data(mod).date(theday)),'dd/mm/yy')]); hold on
                            end
                        end
                        
                        clear modprof moddepths theday
                    end
                    col = [def.fieldsymbol{1},':',def.fieldcolour{1}];
                    plot( field.profiles(theprof).data,-(field.profiles(theprof).depth  ),...
                        col2,'DisplayName',...
                        ['Sonde',' ',datestr(field.date(theprof),'dd/mm/yy')]), hold on
                    
                    xlim([def.cAxis(var).value]);
                    ylim([-0.5,4.5]);
                    
                    set(gca,'Ydir','reverse');
                    set(gca,'FontSize',def.xlabelsize);
                    
                    % ylabel([fdata.(sitenames{site}).(varname{var}).Variable_Name,' (',...
                    %     fdata.(sitenames{site}).(varname{var}).Units,')'],...
                    %     'FontSize',def.ylabelsize);
                    %        title(fdata.(sitenames{site}).(varname{var}).Title,...
                    title([fdata.(sitenames{site}).(varname{var}).Title,' ',datestr(field.date(theprof))],...
                        'FontSize',def.titlesize,...
                        'FontWeight','bold');
                    
                    leg = legend('location','NorthEastOutside');
                    set(leg,'fontsize',def.legendsize);
                    
                    %--% Paper Size
                    set(gcf, 'PaperPositionMode', 'manual');
                    set(gcf, 'PaperUnits', 'centimeters');
                    xSize = def.dimensions(1);
                    ySize = def.dimensions(2);
                    xLeft = (21-xSize)/2;
                    yTop = (30-ySize)/2;
                    set(gcf,'paperposition',[0 0 xSize ySize])
                    
                    if ~exist([savedir,sitenames{site}],'dir')
                        mkdir([savedir,sitenames{site}]);
                    end
                    
                    
                    finalname = [savedir,sitenames{site},'/Profile_',num2str(profs),'.png'];
                    print(gcf,'-dpng',finalname,'-opengl');
                    
                    close all force
                    
                    %fclose('all');
                    
                end
            end
            
            
        end
        
        
    end
    
    
end
end