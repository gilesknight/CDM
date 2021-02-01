

function cal_stack_nitrogen_function(infolder,site,t1,t2,datess,flux,nsnames,nssigns,outputfolder)
% This function calculated the daily carbon pool changes 
% infolder: where the pre-porssed data is;
% t1: start time; t2: end time;

% flux: nodetring pre-proccesed data
% outputfolder: where tosave the figures and data

%% loading 3D and 2D data, note the 2D data only exist in the bottom layer
%  with unit of mmol C/m2

if ~exist(outputfolder,'dir')
    mkdir(outputfolder);
end

%% loading 3D data
vars3D ={'WQ_OGM_DON',...
'WQ_OGM_PON',...
'WQ_NIT_NIT',...
'WQ_NIT_AMM',...
'WQ_OGM_DONR',...
'WQ_OGM_CPOM',...
'WQ_DIAG_PHY_TPHYS',...
'WQ_DIAG_BIV_TBIV',...
'WQ_DIAG_MAC_MAC'...
'WQ_DIAG_PHY_MPB',...
'WQ_DIAG_MAG_TMALG'};

hlnames3D={'DON',...
'PON',...
'NIT',...
'AMM',...
'DONR',...
'CPOM-NITROGEN',...
'PHYTOPLANKTON-NITROGEN',...
'BIVALVES-NITROGEN',...
'MACROPHYTE-NITROGEN',...
'BENTHIC PHYTO-NITROGEN',...
'MACROALGAE-NITROGEN'};

colors=[254,240,217;...
253,212,158;...
253,187,132;...
252,141,89;...
227,74,51;...
179,0,0;...
208,209,230;...
166,189,219;...
116,169,207;...
43,140,190;...
4,90,141];

infolder=[infolder,site,'\'];
tmp=load([infolder,vars3D{1}]);
time3D=tmp.savedata.Time;

% loop through the variables
for ii=1:length(vars3D)
    tmp=load([infolder,vars3D{ii}]);
    if ii<=5    % read in the 3D data in water column
        tmp2=tmp.savedata.(vars3D{ii}).Column;
        for tt=t1:t2  % calculate the daily-average C pool in the selected polygon
            inds=find(time3D>=tt & time3D <tt+1);
            data.(vars3D{ii})(tt-t1+1)=mean(sum(tmp2(:,inds),1));
        end
        clear tmp2;
    elseif ii<=7
        tmp2=tmp.savedata.(vars3D{ii}).Column*16/106;
        for tt=t1:t2  % calculate the daily-average C pool in the selected polygon
            inds=find(time3D>=tt & time3D <tt+1);
            data.(vars3D{ii})(tt-t1+1)=mean(sum(tmp2(:,inds),1));
        end
        clear tmp2;
        
    elseif ii<=10  % read in the 2D data in bottom layer and cell areas
        tmp2=tmp.savedata.(vars3D{ii}).Bot*16/106;
        area=tmp.savedata.(vars3D{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(vars3D{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    else
                tmp2=tmp.savedata.(vars3D{ii}).Bot*0.5/12*1000*16/106;
        area=tmp.savedata.(vars3D{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(vars3D{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    end
end

%% loading flux data
varsFlux ={'WQ_DIAG_NIT_NITRIF',...
    'WQ_DIAG_NIT_DENIT',...
'WQ_DIAG_NIT_SED_NIT',...
'WQ_DIAG_NIT_SED_AMM',...
'WQ_DIAG_SDF_FSED_DON',...
'WQ_DIAG_SDF_FSED_N2O',...
'WQ_DIAG_OGM_PSED_PON',...
        'WQ_DIAG_PHY_GPP',...
    'WQ_DIAG_MAG_GPP',...
'WQ_DIAG_BIV_NMP',...
'WQ_DIAG_PHY_BPP'
};

hlnamesFlux={'NITRIFICATION',...
    'DENITRIFICATION',...
'SEDIMENT NIT EFFLUX',...
'SEDIMENT AMM EFFLUX',...
'SEDIMENT DON EFFLUX',...
'SEDIMENT N2O EFFLUX',...
'PON SEDIMENTATION RATE',...
'PHYTO PRODUCTION-N',...
'MAG PRODUCTION-N',...
'BIVALVE PRODUCTION-N',...
'BPP-N',...
};

colorsF=[215,48,31;...
253,204,138;...
0,109,44;...
44,162,95;...
102,194,164;...
153,216,201;...
204,236,230;...
218,218,235;...
203,201,226;...
158,154,200;...
106,81,163;...
];

tmp=load([infolder,varsFlux{1}]);
timeFlux=tmp.savedata.Time;

for ii=1:length(varsFlux)
    tmp=load([infolder,varsFlux{ii}]);
    if ii<=2   % 3D column data
        tmp2=tmp.savedata.(varsFlux{ii}).Column;
        
        for tt=t1:t2
            inds=find(timeFlux>=tt & timeFlux <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(sum(tmp2(:,inds),1));
        end
        clear tmp2;
    elseif ii<=4  % 2D second data, converted to daily
        tmp2=tmp.savedata.(varsFlux{ii}).Bot;
        area=tmp.savedata.(varsFlux{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    elseif ii<=7  % 2D second data, converted to daily
        tmp2=tmp.savedata.(varsFlux{ii}).Bot*86400;
        area=tmp.savedata.(varsFlux{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    elseif ii<=8  % 2D daily data
        tmp2=-tmp.savedata.(varsFlux{ii}).Column*16/106;
        
        for tt=t1:t2
            inds=find(timeFlux>=tt & timeFlux <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(sum(tmp2(:,inds),1));
        end
        clear tmp2;
    else
        tmp2=tmp.savedata.(varsFlux{ii}).Bot*16/106;
        area=tmp.savedata.(varsFlux{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    end
    
end



%% loading nodestring data

varsnsFlux ={'NIT_nit',...
    'NIT_amm',...
    'OGM_don',...
'OGM_pon',...
'OGM_donr',...
'OGM_cpom',...
'MAG_chaetomorpha',...
'TPHYS'};

hlnamesnsFlux={'NIT',...
    'AMM',...
    'DON',...
'PON',...
'DONR',...
'CPOM-NITROGEN',...
'MACROALGAE-NITROGEN',...
'PHYTOPLANKTON-NITROGEN'};

colorsNS=[188,189,220;...
117,107,177;...
215,48,31;...
252,141,89;...
253,204,138;...
254,240,217;...
166,189,219;...
43,140,190];

timens=flux.flux_all.(nsnames{1}).mDate;

for ii=1:length(nsnames)
flux.flux_all.(nsnames{ii}).TPHYS=flux.flux_all.(nsnames{ii}).PHY_grn+flux.flux_all.(nsnames{ii}).PHY_crypt+...
    flux.flux_all.(nsnames{ii}).PHY_diatom+...
    flux.flux_all.(nsnames{ii}).PHY_dino+flux.flux_all.(nsnames{ii}).PHY_bga;
end


for ii=1:length(varsnsFlux)
    data.nsnetflux.(varsnsFlux{ii})=zeros(1,length(t1:t2));
    if ii<=4
    for tt=t1:t2
        inds=find(timens>=tt & timens <tt+1);
        for jj=1:length(nsnames)
     %   data.nsinflux.(varsnsFlux{ii})(tt-t1+1)=sum(flux.flux_all.Peel_Int_2.(varsnsFlux{ii})(inds));
     %   data.nsoutflux.(varsnsFlux{ii})(tt-t1+1)=sum(flux.flux_all.Peel_int_3.(varsnsFlux{ii})(inds));
        data.nsnetflux.(varsnsFlux{ii})(tt-t1+1)=data.nsnetflux.(varsnsFlux{ii})(tt-t1+1)+...
            sum(flux.flux_all.(nsnames{jj}).(varsnsFlux{ii})(inds))*nssigns(jj);
        end
    end
    else
        for tt=t1:t2
        inds=find(timens>=tt & timens <tt+1);
        for jj=1:length(nsnames)
     %   data.nsinflux.(varsnsFlux{ii})(tt-t1+1)=sum(flux.flux_all.Peel_Int_2.(varsnsFlux{ii})(inds));
     %   data.nsoutflux.(varsnsFlux{ii})(tt-t1+1)=sum(flux.flux_all.Peel_int_3.(varsnsFlux{ii})(inds));
        data.nsnetflux.(varsnsFlux{ii})(tt-t1+1)=data.nsnetflux.(varsnsFlux{ii})(tt-t1+1)+...
            sum(flux.flux_all.(nsnames{jj}).(varsnsFlux{ii})(inds))*nssigns(jj)*16/106;
        end
        end
    end
end

save([outputfolder,site,'_N_data.mat'],'data','-mat','-v7.3');



%% plotting
figure(1);
def.dimensions = [30 20]; % Width & Height in cm
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters','PaperOrientation', 'Portrait');
xSize = def.dimensions(1);
ySize = def.dimensions(2);
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])  ;
clf;
pos1=[0.1 0.68 0.72 0.25];pos11=[0.85 0.73 0.1 0.15];
pos2=[0.1 0.38 0.72 0.25];pos21=[0.86 0.38 0.1 0.15];
pos3=[0.1 0.08 0.72 0.25];pos31=[0.84 0.08 0.1 0.15];

axes('Position',pos1);

cc=data.(vars3D{1});

for ii=2:length(vars3D)
    cc=[cc;data.(vars3D{ii})];
end

hh = bar(t1:t2,cc'*14/1e9,0.9,'stacked');
for jj=1:length(vars3D)
    hh(jj).FaceColor = colors(jj,:)/255;
end
% t1=datenum(2008,1,1);t2=datenum(2009,1,1);
 set(gca,'xlim',[t1 t2]);

 datesv=datenum(datess,'yyyymmdd');
 set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('');ylabel('Tonnes'); 
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;

hl=legend(hlnames3D);
set(hl,'Fontsize',6,'Position',pos11);

axes('Position',pos2);

cc3=-data.(varsFlux{1});

for ii=2:length(varsFlux)
    cc3=[cc3;data.(varsFlux{ii})];
end

cc31=cc3;
cc32=cc3;

for mm=1:size(cc3,1)
    for nn=1:size(cc3,2)
        if cc3(mm,nn)>0
            cc31(mm,nn)=0;
        else
            cc32(mm,nn)=0;
        end
    end
end

hh1 = bar(t1:t2,cc31'*14/1e6,0.9,'stacked');hold on;
hh2 = bar(t1:t2,cc32'*14/1e6,0.9,'stacked');hold on;

for jj=1:length(varsFlux)
    hh1(jj).FaceColor = colorsF(jj,:)/255;
    hh2(jj).FaceColor = colorsF(jj,:)/255;
end

 set(gca,'xlim',[t1 t2]);

 datesv=datenum(datess,'yyyymmdd');
 set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('');ylabel('kg/day'); 
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;

hl=legend(hlnamesFlux);
set(hl,'Fontsize',6,'Position',pos21);

axes('Position',pos3);


cc3=data.nsnetflux.(varsnsFlux{1});

for ii=2:length(varsnsFlux)
    cc3=[cc3;data.nsnetflux.(varsnsFlux{ii})];
end

cc31=cc3;
cc32=cc3;

for mm=1:size(cc3,1)
    for nn=1:size(cc3,2)
        if cc3(mm,nn)>0
            cc31(mm,nn)=0;
        else
            cc32(mm,nn)=0;
        end
    end
end

hh1 = bar(t1:t2,cc31'*14/1e6,0.9,'stacked');hold on;
hh2 = bar(t1:t2,cc32'*14/1e6,0.9,'stacked');hold on;

for jj=1:length(varsnsFlux)
    hh1(jj).FaceColor = colorsNS(jj,:)/255;
    hh2(jj).FaceColor = colorsNS(jj,:)/255;
end

% for ii=1:length(varsnsFlux)
%     plot(t1:t2,data.nsinflux.(varsnsFlux{ii})*12/1e6); hold on;
% end

 set(gca,'xlim',[t1 t2]);

 datesv=datenum(datess,'yyyymmdd');
 set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('');ylabel('kg/day'); 
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;

hl=legend(hlnamesnsFlux);
set(hl,'Fontsize',6,'Position',pos31);

outputName=[outputfolder,'nutrient_budget_nitrogen.png'];
print(gcf,'-dpng',outputName);


%% regression

%% plotting
figure(2);
def.dimensions = [30 20]; % Width & Height in cm
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters','PaperOrientation', 'Portrait');
xSize = def.dimensions(1);
ySize = def.dimensions(2);
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])  ;
clf;
% pos1=[0.1 0.68 0.72 0.25];pos11=[0.85 0.73 0.1 0.15];
% pos2=[0.1 0.38 0.72 0.25];pos21=[0.86 0.38 0.1 0.15];
% pos3=[0.1 0.08 0.72 0.25];pos31=[0.84 0.08 0.1 0.15];
% 
% axes('Position',pos1);
subplot(2,2,1);
scatter(data.nsnetflux.NIT_nit*12/1e6,-data.WQ_DIAG_PHY_GPP*14/1e6);
%  set(gca,'xlim',[t1 t2]);
%  datess={'20080101','20080401','20080701','20081001'};
%  datesv=datenum(datess,'yyyymmdd');
%  set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('NIT flux (kg/day)');ylabel('PHY-GPP (kg/day)'); 
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;

subplot(2,2,2);

endp=floor(length(data.nsnetflux.NIT_nit)/7);

for mm=1:endp
    tmpr1(mm)=sum(data.nsnetflux.NIT_nit((mm-1)*7+1:(mm-1)*7+7));
    tmpr2(mm)=sum(data.WQ_DIAG_PHY_GPP((mm-1)*7+1:(mm-1)*7+7));
end
scatter(tmpr1*14/1e6,-tmpr2*12/1e6);
%  set(gca,'xlim',[t1 t2]);
%  datess={'20080101','20080401','20080701','20081001'};
%  datesv=datenum(datess,'yyyymmdd');
%  set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('NIT flux (kg/week)');ylabel('PHY-GPP (kg/week)'); 
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;

subplot(2,2,3);

endp=floor(length(data.nsnetflux.NIT_nit)/30);

for mm=1:endp
    tmpm1(mm)=sum(data.nsnetflux.NIT_nit((mm-1)*30+1:(mm-1)*30+30));
    tmpm2(mm)=sum(data.WQ_DIAG_PHY_GPP((mm-1)*30+1:(mm-1)*30+30));
end
scatter(tmpm1*14/1e6,-tmpm2*12/1e6);
%  set(gca,'xlim',[t1 t2]);
%  datess={'20080101','20080401','20080701','20081001'};
%  datesv=datenum(datess,'yyyymmdd');
%  set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('NIT flux (kg/month)');ylabel('PHY-GPP (kg/month)'); 
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;

subplot(2,2,4);

endp=floor(length(data.nsnetflux.NIT_nit)/90);

for mm=1:endp
    tmps1(mm)=sum(data.nsnetflux.NIT_nit((mm-1)*90+1:(mm-1)*90+90));
    tmps2(mm)=sum(data.WQ_DIAG_PHY_GPP((mm-1)*90+1:(mm-1)*90+90));
end
scatter(tmps1*14/1e6,-tmps2*12/1e6);
%  set(gca,'xlim',[t1 t2]);
%  datess={'20080101','20080401','20080701','20081001'};
%  datesv=datenum(datess,'yyyymmdd');
%  set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('NIT flux (kg/season)');ylabel('PHY-GPP (kg/season)'); 
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;



outputName=[outputfolder,'nutrient_budget_nitrogen_regression.png'];
print(gcf,'-dpng',outputName);