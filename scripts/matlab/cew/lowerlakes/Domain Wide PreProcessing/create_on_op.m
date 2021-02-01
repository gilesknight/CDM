clear all; close all;

outdir = 'G:\Lowerlakes-CEW-Results\Processed_v2/';

dirlist = dir(outdir);

for mod = 3:length(dirlist)
    
    
    sitelist = dir([outdir,dirlist(mod).name,'/']);
    
    for si = 3:length(sitelist)
        
        don = load([outdir,dirlist(mod).name,'/',sitelist(si).name,'/WQ_OGM_DON.mat']);
        pon = load([outdir,dirlist(mod).name,'/',sitelist(si).name,'/WQ_OGM_PON.mat']);
        
        savedata.X = don.savedata.X;
        savedata.Y = don.savedata.Y;
        savedata.Time = don.savedata.Time;
        savedata.ON.Top = don.savedata.WQ_OGM_DON.Top + pon.savedata.WQ_OGM_PON.Top;
        
        save([outdir,dirlist(mod).name,'/',sitelist(si).name,'/ON.mat'],'savedata','-mat','-v7.3');
        
        clear savedata don pon;
        
        dop = load([outdir,dirlist(mod).name,'/',sitelist(si).name,'/WQ_OGM_DOP.mat']);
        pop = load([outdir,dirlist(mod).name,'/',sitelist(si).name,'/WQ_OGM_POP.mat']);
        
        savedata.X = dop.savedata.X;
        savedata.Y = dop.savedata.Y;
        savedata.Time = dop.savedata.Time;
        savedata.OP.Top = dop.savedata.WQ_OGM_DOP.Top + pop.savedata.WQ_OGM_POP.Top;
        
        save([outdir,dirlist(mod).name,'/',sitelist(si).name,'/OP.mat'],'savedata','-mat','-v7.3');
        
        clear savedata dop pop;
    end
end
