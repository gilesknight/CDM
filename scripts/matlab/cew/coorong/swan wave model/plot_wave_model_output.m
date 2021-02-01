clear all; close all;

data = load('../Peel/out\h13.mat');

vars = fieldnames(data);

first_plot = 1;

title_text = 'h13';


for i = 1:length(vars)
    mval(i) = max(max(data.(vars{i})));
end



for i = 1:length(vars)
    
    str_name = strsplit(vars{i},'_');
    
    mDate = datenum(str_name{2},'yyyymmdd');
    
    tt = str_name{3};
    temp = str2num(tt(1:2));
    
    if temp > 0
        mDate = mDate + (temp/24);
    end
    
    if first_plot
        
        pC = pcolor(data.(vars{i}));shading flat
        axis xy
        axis ij
        
        caxis([0 max(mval)]);
        
        colorbar
        title(title_text,'fontsize',12,'fontweight','bold');
        
        
        txt = text(0.7,0.1,datestr(mDate,'dd/mm/yyyy HH:MM'),'units','normalized','fontsize',8);
        
        axis off;
    else
        set(pC,'cdata',data.(vars{i}));
        set(txt,'string',datestr(mDate,'dd/mm/yyyy HH:MM'));
        drawnow
        axis off;
    end
    
    saveas(gcf,['h13_',str_name{1},'_',datestr(mDate,'yyyymmddHHMMSS'),'.png']);
    
end
    
    