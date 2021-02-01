function tidal=tidalfit(data,varargin)
%% TIDALFIT: Fits a tidal model to data
% Modified: Yanti 09/08/2014
% tidalfit uses the HAMELS (ordinary least squares)
% technique to fit tidal components to the detrended data. Additionally it
% can also do robust fitting.
%
% Please include an acknowledgement to Aslak Grinsted if you use this code.
%
% USAGE: tidal=tidalfit(data[,parameter,value])
%
% INPUT:
% ------
% data:  A two column vector.
% \       - first column should be a serial date number (See help datenum)
% \       - second column should be the y-values (i.e. sea level)
% \       (missing values and nans are OK.)
%
% OPTIONAL PARAMETERS:
% --------------------
% Components: cell-array of strings with names of the which
% \           components should be included in the fit? (ALL is default)
% \           Note: The routine will only attempt to fit components
% \           that have period<data_timespan/4 and period>dt*2.
% FittingMethod: 'OLS' for ordinary least squares or 'ROBUST' for robustfitting.
% \           (default=OLS)
% RobustFitOptions: cell of options for robustfit. (See help robustfit.)
% \           only used if FittingMethod='ROBUST'. (default={})
% DetrendData: should the data be detrended prior to fitting? (default=true)
%
% Note: optional parameters can be specified using abbreviations. e.g. RFO for RobustFitOptions.
%
% OUTPUT:
% -------
% If no output arguments are specified the routine will display the results
% visually.
%
% tidal: A struct-array containing the fitted model parameters.
% \     .name:  name of tidal component (see e.g. http://www.mhl.nsw.gov.au/www/tide_glossary.htmlx)
% \     .period:period of tidal component in days
% \     .speed: frequency of tidal component in degrees per solar hour
% \     .amp:   amplitude of fitted component
% \     .phase: phase of fitted component
%
% Components that are not included in the fit will have NaN in .amp and .phase.
%
%
% Note: In addition to the tradtional tidal components some components that
% accounts for the annual cycle are included. Called S3A, S4A, S5A, with
% periods of a year/3, year/4, year/5, ...
%
% EXAMPLE:
%  data=datenum(1971,1,1):datenum(2008,1,1);
%  data=[data;randn(size(data))]';
%  tidal=tidalfit(data,'fm','robust');
%  future=[datenum(2008,1,1):datenum(2009,1,1)'];
%  plot(future,tidalval(tidal,future));
%
%


%%  Copyright (C) 2008, Aslak Grinsted
%   This software may be used, copied, or redistributed as long as it is not
%   sold and this copyright notice is reproduced on each copy made.  This
%   routine is provided as is without any express or implied warranties
%   whatsoever.

if nargin<1
    error('no input data specified!')
end

if size(data,2)~=2
    warning('TIDALFIT:DATASHAPE','tidalfit needs a two column data matrix.')
end

Args=struct('Components',[],'FittingMethod','OLS','RobustFitOptions',[],'DetrendData',true,'NumericArguments',[]);
Args=parseArgs(varargin,Args);

if (Args.DetrendData)
    p=polyfit(data(~isnan(data(:,2)),1),data(~isnan(data(:,2)),2),1);
    data(:,2)=data(:,2)-polyval(p,data(:,1));
else
    data(:,2)=data(:,2)-nanmean(data(:,2)); %center
end

tminmax=[min(data(:,1)) max(data(:,1))];
dt=min(diff(sortrows(data(:,1)))); %SLOW but robust. dt needed for nyquist
if dt==0
    error('dt==0!')
end

isOLS=false;
switch upper(Args.FittingMethod)
    case {'OLS','ORDINARY LEAST SQUARES'}
        isOLS=true;
    case {'ROBUST','ROBUSTFIT'}
        if isempty(Args.RobustFitOptions)
            Args.RobustFitOptions={};
        end
    otherwise
        error('Unknown FittingMethod specified')
end


T=15;
s=0.54901653;
h=0.04106864;
p=0.00464183;
p1=0.00000196;


%good high precision table:
%http://www.mhl.nsw.gov.au/www/tide_glossary.htmlx

%key west:
%http://tidesandcurrents.noaa.gov/cgi-bin/co-ops_qry.cgi?stn=8724580 Key West, FL&dcp=1&ssid=WL&pc=P2&datum=NULL&unit=0&bdate=20080306&edate=20080307&date=1&shift=0&level=-4&form=0&data_type=har&format=View+Data

%initialize struct to avoid dynamic re-allocation.
tidal=struct('name','xxxx','speed',num2cell(nan(44,1)),'period',nan,'amp',nan,'phase',nan);


ix= 1; tidal(ix).name='M2'; 	tidal(ix).speed	=	2*T - 2*s + 2*h ;
ix= 2; tidal(ix).name='S2'; 	tidal(ix).speed	=	2*T;
ix= 3; tidal(ix).name='N2'; 	tidal(ix).speed	=	2*T - 3*s + 2*h + p;
ix= 4; tidal(ix).name='K1'; 	tidal(ix).speed	=	15.0410686;
ix= 5; tidal(ix).name='M4'; 	tidal(ix).speed	=	4*(T - s + h) ;
ix= 6; tidal(ix).name='O1'; 	tidal(ix).speed	=	T - 2*s + h;
ix= 7; tidal(ix).name='M6'; 	tidal(ix).speed	=	6*(T - s + h);
ix= 8; tidal(ix).name='MK3'; 	tidal(ix).speed	=	44.0251729;
ix= 9; tidal(ix).name='S4'; 	tidal(ix).speed	=	4*T;
ix=10; tidal(ix).name='MN4'; 	tidal(ix).speed	=	57.4238337;
ix=11; tidal(ix).name='NU2'; 	tidal(ix).speed	=	28.5125831;
ix=12; tidal(ix).name='S6'; 	tidal(ix).speed	=	6*T;
ix=13; tidal(ix).name='MU2'; 	tidal(ix).speed	=	27.9682084;
ix=14; tidal(ix).name='2N2'; 	tidal(ix).speed	=	2*T - 4*s + 2*h + 2*p;
ix=15; tidal(ix).name='OO1'; 	tidal(ix).speed	=	T + 2*s + h;
ix=16; tidal(ix).name='LAM2'; 	tidal(ix).speed	=	29.4556253;
ix=17; tidal(ix).name='S1'; 	tidal(ix).speed	=	T;
ix=18; tidal(ix).name='M1'; 	tidal(ix).speed	=	T - s + h + p ;
ix=19; tidal(ix).name='J1'; 	tidal(ix).speed	=	15.5854433;
ix=20; tidal(ix).name='MM'; 	tidal(ix).speed	=	s-p;
ix=21; tidal(ix).name='SSA'; 	tidal(ix).speed	=	2*h;
ix=22; tidal(ix).name='SA'; 	tidal(ix).speed	=	h;
ix=23; tidal(ix).name='MSF'; 	tidal(ix).speed	=	2*s-2*h;
ix=24; tidal(ix).name='MF'; 	tidal(ix).speed	=	2*s;
ix=25; tidal(ix).name='RHO'; 	tidal(ix).speed	=	T - 3*s + 3*h - p;
ix=26; tidal(ix).name='Q1'; 	tidal(ix).speed	=	T - 3*s + h + p;
ix=27; tidal(ix).name='T2'; 	tidal(ix).speed	=	2*T - h + p1 ;
ix=28; tidal(ix).name='R2'; 	tidal(ix).speed	=	2*T + h - p1;
ix=29; tidal(ix).name='2Q1'; 	tidal(ix).speed	=	T - 4*s + h + 2*p ;
ix=30; tidal(ix).name='P1'; 	tidal(ix).speed	=	T-h;
ix=31; tidal(ix).name='2SM2'; 	tidal(ix).speed	=	31.0158958;
ix=32; tidal(ix).name='M3'; 	tidal(ix).speed	=	3*T - 3*s + 3*h ;
ix=33; tidal(ix).name='L2'; 	tidal(ix).speed	=	29.5284789;
ix=34; tidal(ix).name='2MK3'; 	tidal(ix).speed	=	42.9271398;
ix=35; tidal(ix).name='K2'; 	tidal(ix).speed	=	30.0821373;
ix=36; tidal(ix).name='M8'; 	tidal(ix).speed	=	8*(T - s + h);
ix=37; tidal(ix).name='MS4'; 	tidal(ix).speed	=	58.9841042;
%------------------------------
ix=38; tidal(ix).name='N';  	tidal(ix).speed	=	0.00220641;




for sn=3:8 %y1&y2 are the same as sa & ssa
    ix=39-3+sn;
    tidal(ix).name=['S' num2str(sn) 'A']; tidal(ix).speed=360*sn/(365.24237*24);
end



%DO NOT ADD ANY MORE COMPONENTS AFTER HERE:
%-------------------------------------------
for ii=1:length(tidal)
    tidal(ii).period=(360/tidal(ii).speed)/24;
end

if isempty(Args.Components)
    keep=(1:length(tidal))';
else
    components={tidal.name};
    keep=nan(length(Args.Components),1);
    for ii=1:length(Args.Components)
        ix=strmatch(upper(Args.Components{ii}),components,'exact');
        if isempty(ix)
            error(['Unknown component: ' upper(Args.Components{ii})]);
        end
        keep(ii)=strmatch(upper(Args.Components{ii}),components,'exact');
    end
    keep=unique(keep);
end


%Check nyquist and long period:
ix=([tidal(keep).period]'>=2*dt)&([tidal(keep).period]'<=diff(tminmax)/4);
keep=keep(ix);



%--------------------------------
data(any(isnan(data),2),:)=[];

N=size(data,1);
Np=length(keep);

if Np==0
    error('No predictors kept.')
end


predictors=ones(N,Np*2+isOLS);
for ii=1:Np
    period=tidal(keep(ii)).period;
    predictors(:,ii)=cos(data(:,1)*2*pi/period);
    predictors(:,ii+Np)=sin(data(:,1)*2*pi/period);
end

if isOLS
    reg=predictors\data(:,2);
else
    reg=robustfit(predictors,data(:,2),Args.RobustFitOptions{:});
    reg=reg([2:end 1]);
end


for ii=1:Np
    q=reg([ii ii+Np]);
    if all(isnan(q))
        tidal(keep(ii)).amp=nan;
        tidal(keep(ii)).phase=nan;
    else
        tidal(keep(ii)).amp=sqrt(nansum(q.^2));
        q(isnan(q))=0;
        tidal(keep(ii)).phase=atan2(q(2),q(1));
    end
end


% Visualize the output if the user doesn't want it as an output.
if nargout==0
    
    %yp=predictors*reg;
    yp=tidalval(tidal,data(:,1));
    
    plot(data(:,1),data(:,2),data(:,1),data(:,2)-yp,data(:,1),yp);
    legend('data','residuals','model','location','best')
    
    fprintf('\n\n')
    v=[tidal.amp;tidal.phase;tidal.speed;tidal.period]';
    v=v(keep,:);
    v(:,2)=mod(v(:,2)*180/pi,360);
    
    dispmtx(v,'%7.3f',{'amp' 'phase' 'speed' 'period'},{tidal(keep).name})
    
    xlabel('serial date')
    
    fprintf('\ntidalmodel accounts for %.1f%% of the variance.\n',var(yp)*100/var(data(:,2)))
    clear tidal
end

end
function ArgStruct=parseArgs(args,ArgStruct,varargin)
% Helper function for parsing varargin.
%
%
% ArgStruct=parseArgs(varargin,ArgStruct[,FlagtypeParams[,Aliases]])
%
% * ArgStruct is the structure full of named arguments with default values.
% * Flagtype params is params that don't require a value. (the value will be set to 1 if it is present)
% * Aliases can be used to map one argument-name to several argstruct fields
%
%
% example usage:
% --------------
% function parseargtest(varargin)
%
% %define the acceptable named arguments and assign default values
% Args=struct('Holdaxis',0, ...
%        'SpacingVertical',0.05,'SpacingHorizontal',0.05, ...
%        'PaddingLeft',0,'PaddingRight',0,'PaddingTop',0,'PaddingBottom',0, ...
%        'MarginLeft',.1,'MarginRight',.1,'MarginTop',.1,'MarginBottom',.1, ...
%        'rows',[],'cols',[]);
%
% %The capital letters define abrreviations.
% %  Eg. parseargtest('spacingvertical',0) is equivalent to  parseargtest('sv',0)
%
% Args=parseArgs(varargin,Args, ... % fill the arg-struct with values entered by the user
%           {'Holdaxis'}, ... %this argument has no value (flag-type)
%           {'Spacing' {'sh','sv'}; 'Padding' {'pl','pr','pt','pb'}; 'Margin' {'ml','mr','mt','mb'}});
%
% disp(Args)
%
%
%
%
% Aslak Grinsted 2004

% -------------------------------------------------------------------------
%   Copyright (C) 2002-2004, Aslak Grinsted
%   This software may be used, copied, or redistributed as long as it is not
%   sold and this copyright notice is reproduced on each copy made.  This
%   routine is provided as is without any express or implied warranties
%   whatsoever.

persistent matlabver

if isempty(matlabver)
    matlabver=ver('MATLAB');
    matlabver=str2double(matlabver.Version);
end

Aliases={};
FlagTypeParams='';

if (length(varargin)>0)
    FlagTypeParams=lower(strvcat(varargin{1}));  %#ok
    if length(varargin)>1
        Aliases=varargin{2};
    end
end


%---------------Get "numeric" arguments
NumArgCount=1;
while (NumArgCount<=size(args,2))&&(~ischar(args{NumArgCount}))
    NumArgCount=NumArgCount+1;
end
NumArgCount=NumArgCount-1;
if (NumArgCount>0)
    ArgStruct.NumericArguments={args{1:NumArgCount}};
else
    ArgStruct.NumericArguments={};
end


%--------------Make an accepted fieldname matrix (case insensitive)
Fnames=fieldnames(ArgStruct);
for i=1:length(Fnames)
    name=lower(Fnames{i,1});
    Fnames{i,2}=name; %col2=lower
    Fnames{i,3}=[name(Fnames{i,1}~=name) ' ']; %col3=abreviation letters (those that are uppercase in the ArgStruct) e.g. SpacingHoriz->sh
    %the space prevents strvcat from removing empty lines
    Fnames{i,4}=isempty(strmatch(Fnames{i,2},FlagTypeParams)); %Does this parameter have a value?
end
FnamesFull=strvcat(Fnames{:,2}); %#ok
FnamesAbbr=strvcat(Fnames{:,3}); %#ok

if length(Aliases)>0
    for i=1:length(Aliases)
        name=lower(Aliases{i,1});
        FieldIdx=strmatch(name,FnamesAbbr,'exact'); %try abbreviations (must be exact)
        if isempty(FieldIdx)
            FieldIdx=strmatch(name,FnamesFull); %&??????? exact or not?
        end
        Aliases{i,2}=FieldIdx;
        Aliases{i,3}=[name(Aliases{i,1}~=name) ' ']; %the space prevents strvcat from removing empty lines
        Aliases{i,1}=name; %dont need the name in uppercase anymore for aliases
    end
    %Append aliases to the end of FnamesFull and FnamesAbbr
    FnamesFull=strvcat(FnamesFull,strvcat(Aliases{:,1})); %#ok
    FnamesAbbr=strvcat(FnamesAbbr,strvcat(Aliases{:,3})); %#ok
end

%--------------get parameters--------------------
l=NumArgCount+1;
while (l<=length(args))
    a=args{l};
    if ischar(a)
        paramHasValue=1; % assume that the parameter has is of type 'param',value
        a=lower(a);
        FieldIdx=strmatch(a,FnamesAbbr,'exact'); %try abbreviations (must be exact)
        if isempty(FieldIdx)
            FieldIdx=strmatch(a,FnamesFull);
        end
        if (length(FieldIdx)>1) %shortest fieldname should win
            [mx,mxi]=max(sum(FnamesFull(FieldIdx,:)==' ',2));%#ok
            FieldIdx=FieldIdx(mxi);
        end
        if FieldIdx>length(Fnames) %then it's an alias type.
            FieldIdx=Aliases{FieldIdx-length(Fnames),2};
        end
        
        if isempty(FieldIdx)
            error(['Unknown named parameter: ' a])
        end
        for curField=FieldIdx' %if it is an alias it could be more than one.
            if (Fnames{curField,4})
                if (l+1>length(args))
                    error(['Expected a value for parameter: ' Fnames{curField,1}])
                end
                val=args{l+1};
            else %FLAG PARAMETER
                if (l<length(args)) %there might be a explicitly specified value for the flag
                    val=args{l+1};
                    if isnumeric(val)
                        if (numel(val)==1)
                            val=logical(val);
                        else
                            error(['Invalid value for flag-parameter: ' Fnames{curField,1}])
                        end
                    else
                        val=true;
                        paramHasValue=0;
                    end
                else
                    val=true;
                    paramHasValue=0;
                end
            end
            if matlabver>=6
                ArgStruct.(Fnames{curField,1})=val; %try the line below if you get an error here
            else
                ArgStruct=setfield(ArgStruct,Fnames{curField,1},val); %#ok <-works in old matlab versions
            end
        end
        l=l+1+paramHasValue; %if a wildcard matches more than one
    else
        error(['Expected a named parameter: ' num2str(a)])
    end
end
end