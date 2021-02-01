
function cal_stack_carbon_function(infolder,site,t1,t2,datess,flux,nsnames,nssigns,outputfolder)
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

% model output names
vars3D ={'WQ_OGM_DOC',...
    'WQ_OGM_POC',...
    'WQ_OGM_DOCR',...
    'WQ_OGM_CPOM',...
    'WQ_DIAG_PHY_TPHYS',...
    'WQ_DIAG_BIV_TBIV',...
    'WQ_DIAG_MAC_MAC'...
    'WQ_DIAG_PHY_MPB',...
    'WQ_DIAG_MAG_TMALG'};

% names to display in the plot
hlnames3D={'DOC',...
    'POC',...
    'DOCR',...
    'CPOM',...
    'PHYTOPLANKTON',...
    'BIVALVES',...
    'MACROPHYTE',...
    'MICROPHYTO BENTHOS',...
    'MACROALGAE'};

% color scheme for each variables
colors=[215,48,31;...
    252,141,89;...
    253,204,138;...
    254,240,217;...
    241,238,246;...
    208,209,230;...
    166,189,219;...
    116,169,207;...
    43,140,190;...
    4,90,141];

% define data folder and time
infolder=[infolder,site,'\'];
disp(infolder);
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
    elseif ii<=8        % read in the 2D data in bottom layer and cell areas
        tmp2=tmp.savedata.(vars3D{ii}).Bot;
        area=tmp.savedata.(vars3D{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(vars3D{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    else % converting TMALG from gDW/m2 to mmol C/m2
        tmp2=tmp.savedata.(vars3D{ii}).Bot*0.5/12*1000;
        area=tmp.savedata.(vars3D{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(vars3D{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    end
end


%% loading the internal flux data; note only PHY_GPP is 3D,others are 2D;
%  production unit is mmol C/day;
%  all the Fsed and Psed fluxes are in mmol C/m2/s
varsFlux ={'WQ_DIAG_PHY_GPP',...
    'WQ_DIAG_MAG_GPP',...
    'WQ_DIAG_BIV_NMP',...
    'WQ_DIAG_PHY_BPP',...
    'WQ_DIAG_SDF_FSED_DOC',...
    'WQ_DIAG_OGM_PSED_POC',...
    'WQ_DIAG_OGM_PSED_CPOM',...
    'WQ_DIAG_PHY_PSED_PHY',...
    %'WQ_DIAG_OGM_POC_MINER',...
    %'WQ_DIAG_OGM_DOC_MINER',...
    };

hlnamesFlux={'PHYTO PRODUCTION',...
    'MACROALGAL PRODUCTION',...
    'BIVALVE PRODUCTION',...
    'BENTHIC PHYTO PRODUCTION',...
    'SEDIMENT DOC EFFLUX',...
    'POC SEDIMENTATION RATE',...
    'CPOM SEDIMENTATION RATE',...
    'PHYTO SEDIMENTATION RATE',...
    };

colorsF=[215,48,31;...
    252,141,89;...
    253,204,138;...
    254,240,217;...
    43,140,190;...
    49,163,84;...
    161,217,155;...
    229,245,224
    ];

tmp=load([infolder,varsFlux{1}]);
timeFlux=tmp.savedata.Time;

for ii=1:length(varsFlux)
    tmp=load([infolder,varsFlux{ii}]);
    if ii<=1   % 3D column data
        tmp2=tmp.savedata.(varsFlux{ii}).Column;
        
        for tt=t1:t2
            inds=find(timeFlux>=tt & timeFlux <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(sum(tmp2(:,inds),1));
        end
        clear tmp2;
    elseif ii<=4  % 2D daily data
        tmp2=tmp.savedata.(varsFlux{ii}).Bot;
        area=tmp.savedata.(varsFlux{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    elseif ii<=6  % 2D second data, converted to daily
        tmp2=tmp.savedata.(varsFlux{ii}).Bot*86400;
        area=tmp.savedata.(varsFlux{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    else
        tmp2=tmp.savedata.(varsFlux{ii}).Bot*86400;
        area=tmp.savedata.(varsFlux{ii}).Area;
        tmp3=tmp2'*area';
        for tt=t1:t2
            inds=find(time3D>=tt & time3D <tt+1);
            data.(varsFlux{ii})(tt-t1+1)=mean(tmp3(inds));
        end
    end
    
end


%% loading nodestring data

varsnsFlux ={'OGM_doc',...
    'OGM_poc',...
    'OGM_docr',...
    'OGM_cpom',...
    'MAG_chaetomorpha',...
    'TPHYS'};

hlnamesnsFlux={'DOC',...
    'POC',...
    'DOCR',...
    'CPOM',...
    'MACROALGAE',...
    'PHYTOPLANKTON'};

colorsNS=[215,48,31;...
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


for ii=1:6
    data.nsnetflux.(varsnsFlux{ii})=zeros(1,length(t1:t2));
    for tt=t1:t2
        inds=find(timens>=tt & timens <tt+1);
        for jj=1:length(nsnames)
     %   data.nsinflux.(varsnsFlux{ii})(tt-t1+1)=sum(flux.flux_all.Peel_Int_2.(varsnsFlux{ii})(inds));
     %   data.nsoutflux.(varsnsFlux{ii})(tt-t1+1)=sum(flux.flux_all.Peel_int_3.(varsnsFlux{ii})(inds));
        data.nsnetflux.(varsnsFlux{ii})(tt-t1+1)=data.nsnetflux.(varsnsFlux{ii})(tt-t1+1)+...
            sum(flux.flux_all.(nsnames{jj}).(varsnsFlux{ii})(inds))*nssigns(jj);
        end
    end
end

save([outputfolder,site,'_data.mat'],'data','-mat','-v7.3');
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

hh = bar(t1:t2,cc'*12/1e9,0.9,'stacked');
for jj=1:length(vars3D)
    hh(jj).FaceColor = colors(jj,:)/255;
end

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

hh1 = bar(t1:t2,cc31'*12/1e6,0.9,'stacked');hold on;
hh2 = bar(t1:t2,cc32'*12/1e6,0.9,'stacked');hold on;

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

hh1 = bar(t1:t2,cc31'*12/1e6,0.9,'stacked');hold on;
hh2 = bar(t1:t2,cc32'*12/1e6,0.9,'stacked');hold on;

for jj=1:length(varsnsFlux)
    hh1(jj).FaceColor = colorsNS(jj,:)/255;
    hh2(jj).FaceColor = colorsNS(jj,:)/255;
end

t1=datenum(2008,1,1);t2=datenum(2009,1,1);
set(gca,'xlim',[t1 t2]);

datesv=datenum(datess,'yyyymmdd');
set(gca,'XTick',datesv,'XTickLabel',datestr(datesv,'mmm/yy'));
xlabel('');ylabel('kg/day');
%text(1971,2000,'(a) nitrogen loading and export','FontWeight','Bold');
set(gca,'FontSize',9);
box on;grid on;

hl=legend(hlnamesnsFlux);
set(hl,'Fontsize',6,'Position',pos31);

outputName=[outputfolder,'nutrient_budget_carbon.png'];
print(gcf,'-dpng',outputName);