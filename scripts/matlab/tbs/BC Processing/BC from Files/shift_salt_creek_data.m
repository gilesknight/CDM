clear all; close all;

addpath(genpath('tuflowfv'));

dirlist = dir(['Salt_Creek_old/','*.csv']);

for i = 1:length(dirlist)
    filename = ['Salt_Creek_old/',dirlist(i).name];
    disp(['Reading ',dirlist(i).name]);
    data = tfv_readBCfile(filename);
    
    [yyyy,mmmm,dddd,HHHH,MMMM,SSSS] = datevec(data.Date);
    
    rrr = find(yyyy == 2014);
    sss = find(yyyy == 2015);
    ttt = find(yyyy == 2016);
    
    dates_2016 = datenum(yyyy(ttt),mmmm(ttt),dddd(ttt),HHHH(ttt),MMMM(ttt),SSSS(ttt));
    curdate_shifted = datenum(yyyy(sss)+1,mmmm(sss),dddd(sss),HHHH(sss),MMMM(sss),SSSS(sss));
    curdate_shifted_2014 = datenum(yyyy(rrr)+2,mmmm(rrr),dddd(rrr),HHHH(rrr),MMMM(rrr),SSSS(rrr));

    figure;
    
    plot(data.Date,data.FLOW,'r');hold on
    
    for j = 1:length(sss)

        [~,ind] = min(abs(dates_2016 - curdate_shifted(j)));
        
        data.FLOW(sss(j)) = data.FLOW(ttt(ind));
        
    end
    
    for j = 1:length(rrr)

        [~,ind] = min(abs(dates_2016 - curdate_shifted_2014(j)));
        
        data.FLOW(rrr(j)) = data.FLOW(ttt(ind));
        
    end
    
    
    
    plot(data.Date,data.FLOW,'k');hold on
    
    datetick('x','dd-mm-yyyy');
    
    legend({'Old';'New'});
    
    saveas(gcf,regexprep(dirlist(i).name,'.csv','.png'));
    
    close;
        
   
    disp(['Writing ',dirlist(i).name]);
    write_tfv_file(['Salt_Creek_new/',regexprep(dirlist(i).name,'-','_')],data);
    
    clear data dates_2016 curdate_shifted sss ttt yyyy mmmm dddd HHHH MMMM SSSS
    
end
        
