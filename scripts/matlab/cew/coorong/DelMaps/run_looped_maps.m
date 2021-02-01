


the_vars = {...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_OXY_OXY',...
    'SAL',...
    'WQ_TRC_AGE',...
    };

the_conv = [14/1000,31/1000,1,32/1000,1,1/86400];

the_caxis(1).val = [0 2];
the_caxis(2).val = [0 0.5];
the_caxis(3).val = [0 60];
the_caxis(4).val = [2 12];
the_caxis(5).val = [10 50];
the_caxis(6).val = [0 100];

for i = 1:length(the_vars)
    
    disp(the_vars{i});
    
    seasonal_averages_v2(the_vars{i},the_caxis(i).val,the_conv(i));
    
   
end