clear all; close all;

basedir = 'Y:\Coorong Report\Budget\ORH_Base_20140101_20170101\';
joindir = 'Y:\Coorong Report\Budget\ORH_Base_20140101_20170101_rst\';
findir = 'Y:\Coorong Report\Budget_Joined\ORH_Base_20140101_20170101\';

sitelist = dir(basedir);

for i = 3:length(sitelist)
    vars = dir([basedir,sitelist(i).name,'/','*mat']);
    for j = 1:length(vars)
        
        disp([sitelist(i).name,',',vars(j).name]);
        
        bs = load([basedir,sitelist(i).name,'/',vars(j).name]);
        jd = load([joindir,sitelist(i).name,'/',vars(j).name]);
        
        vname = regexprep(vars(j).name,'.mat','');
        
        savedata.X = bs.savedata.X;
        savedata.Y = bs.savedata.Y;
        savedata.Time = [bs.savedata.Time;jd.savedata.Time];
        %savedata.(vname).Top = [bs.savedata.(vname).Top jd.savedata.(vname).Top];
        savedata.(vname).Bot = [bs.savedata.(vname).Bot jd.savedata.(vname).Bot];
        savedata.(vname).Column = [bs.savedata.(vname).Column jd.savedata.(vname).Column];
        savedata.(vname).Area = [bs.savedata.(vname).Area];
        
        clear bs jd;
        
        if ~exist([findir,sitelist(i).name],'dir')
            mkdir([findir,sitelist(i).name]);
        end
        
        save([findir,sitelist(i).name,'/',vars(j).name],'savedata','-mat','-v7.3');
        
        clear savedata;
        
    end
    
end


