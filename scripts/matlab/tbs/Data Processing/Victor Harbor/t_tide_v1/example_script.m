clear;
close;

% roms=load('roms_zeta.mat');
% 
% tideHeight = roms.aa;
% tideHeight(tideHeight>2)=NaN;
% tideHeight(tideHeight<-2)=NaN;
% tideTime = roms.t;

% 
load('../VH.mat');
tideHeight(1,:) = VH(:,2);
tideTime(1,:) = VH(:,1);




ind1=find(tideTime==datenum('20140101','yyyymmdd'));
ind2=find(tideTime==datenum('20150101','yyyymmdd'));
%ind1=1;ind2=length(tideTime);
t2  = tideTime(ind1:ind2);
th2 = tideHeight(ind1:ind2);

   
[tidestruc,pout]=t_tide(th2,...
       'interval',60/60, ...                     % hourly data
       'start',tideTime(1),...               % start time is datestr(tuk_time(1))
       'latitude',-30,...               % Latitude of obs
       'error','linear',...                   % coloured boostrap CI
       'synthesis',1);                       % Use SNR=1 for synthesis. 
   
t3=datenum('20130101','yyyymmdd');
t4=datenum('20260101','yyyymmdd');

t5=t3:1/24:t4;
timetide=t5;

%tideHeight_pred=t_predic(t5,NAMES,FREQ,TIDECON,'latitude',-30,'synthesis',2);
%tideHeight_pred=t_predic(t5,NAMES,FREQ,TIDECON);
tideHeight_pred=t_predic(t5,tidestruc,...
     'latitude',-35,...
     'synthesis',1);
 
 VH_pred(:,1) = t5;
 VH_pred(:,2) = tideHeight_pred;
 
 save ../VH_pred.mat VH_pred -mat
 
 
 
 
