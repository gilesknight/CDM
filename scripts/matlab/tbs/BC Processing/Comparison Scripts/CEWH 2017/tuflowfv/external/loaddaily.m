function loaddaily(incatch,subno,flux)
%LOADDAILY  Load LASCAM daily output data.
%
%	loaddaily(incatch,subno,flux)
%
%	Loads LASCAM daily output data.  All three arguments are optional, but
%	must appear in the correct order.  LOADDAILY may be launched from any
%	directory on the file system.
%
%	With no argument, LOADDAILY looks for the default streamflow file, 
%	'sc001_daily.wat', in the current working directory.
%
%	The first argument (incatch), if present, is a string and specifies the 
%	name of a catchment directory containing the input data file.  Usually,
%	this directory name will be the same as  the name of the catchment.
%
%	The second argument (subno), if present, is an integer, and specifies 
%	the subcatchment number of the input file.  The default value is
%	subcatchment number 1 (provided there is not a single argument giving
%	the file name --- see below).
%
%	The third argument (flux), if present, is a string, and specifies 
%	the flux type of the input file.  LOADDAILY recognises the following
%	values for the flux string:
%	  'wat'						Water (the default)
%	  'sal'  'salt'					Salt
%	  'sed'  'seds'					Sediment
%	  'phos'  'solp'  'psol'  'pps'			Soluble phosphorus
%	  'phot'  'totp'  'ptot'  'ppt'  'tp'		Total phosphorus
%	  'nito'  'no3'  'nno'				Nitrate nitrogen
%	  'nith'  'nh4'  'nnh'				Ammonium nitrogen
%	  'nitt'  'totn'  'ntot'  'nnt'  'tn'		Total nitrogen
%
%	Alternatively, LOADDAILY will accept a single argument that specifies
%	either:  A) the name of a data file in the current working directory;
%	or B) the directory path of an input file relative to Matlab's current 
%	working directory; or C) the absolute path of an input file.  
%
%	Note that where only one argument is given, and it is a string, it can 
%	refer to either a catchment directory, a flux type, or a file name.  In
%	such cases, LOADDAILY first checks whether a file exists with that name.
%	If no such file exists, then it checks to see whether there is a 
%	catchment directory of that name (in /LASCAM/catchments/).  If no such 
%	directory exists, it assumes that the argument refers to a flux type, 
%	and attempts to open the file sc001_daily.*** for the relevant flux in 
%	the current working directory.  
%
%	The input file may be in either ASCII or binary formats.  In the ASCII
%	format, data is assumed to be arranged in four columns:
%		line number; julian day; observed; predicted.
%       or in three columns (where there is no observed data):
%		line number; julian day; predicted.
%
%	Users may access the data by declaring the following as global 
%	variables:
%	  jdd		Julian day
%	  obsd		Observed daily flux (if available)
%	  predd		Predicted daily flux
%
%	EXAMPLES:
%	  loaddaily		         Loads:	sc001_daily.wat from CWD
%	  loaddaily(3)				sc003_daily.wat from CWD
%	  loaddaily('nito')			sc001_daily.nno from CWD
%	  loaddaily(5,'nh4')			sc005_daily.nnh from CWD
%	  loaddaily('ellen')			catchments/ellen/sc001_daily.wat
%	  loaddaily('ellen',7)			catchments/ellen/sc007_daily.wat
%	  loaddaily('ellen','sed')		catchments/ellen/sc001_daily.sed
%	  loaddaily('ellen',4,'sed')		catchments/ellen/sc004_daily.sed
%	  loaddaily('sc019_daily.sal3')		sc019_daily.sal3 from CWD
%	  loaddaily('../avon/sc022_daily.ppt')	../avon/sc022_daily.ppt 
%						    (relative to CWD)
%
%	Neil Viney --- 9 June 1994


global jdd obsd predd hyear hinfiled hsalt subcatd

%
%
%  FIND AND OPEN INPUT DATA FILE
%
hinfiled=[];
hsalt=[];
if nargin>3;
  error('ERROR:  This function may have no more than three arguments')
end;
if nargin<3;flux=[];end;
if nargin<2;subno=[];end;
if nargin<1;incatch=[];end;
[hinfiled,subcatd,err]=findfile('daily',incatch,subno,flux);
if exist(hinfiled)==0 | err>0;
  disp('ERROR:  Unable to load data...')
  disp('  USAGE:  loaddaily([CatchmentName],[SubcatchmentNumber],[FluxType])')
  disp('         ...where each argument is optional but must be in this order;')
  disp('     OR:  loaddaily([InputFileName])')
  disp(char(7))                                              % BEEP
  return
end;
tmp=fopen(hinfiled,'r','b');			% ASSUME BIG ENDIAN
%
%
%  IS THIS A BINARY OR ASCII FILE?
%    [ BEWARE OF str2num BUG IN THE OFFICIAL DISTRIBUTION OF MATLAB V4.2c ---
%      MY MATLAB PATH USES THE CORRECTED str2num FROM /usr/nefertiti/matlab_ms ]
%
inline=fgetl(tmp);
if inline<0;
  disp('ERROR:  Unable to load data...')
  disp('          The data file:')
  disp(['            ',hinfiled])
  disp('          is empty.')
  disp(char(7))                                              % BEEP
  return
end;
ncol=length(str2num(inline));		% FIND OUT HOW MANY COLUMNS
frewind(tmp);
if ncol==0;	% ==> BINARY FILE
  jd1=fread(tmp,4,'long');
  jd2=jd1(4);
  jd1=jd1(3);
  ncol=1;
  if jd2==0;
    jd2=fread(tmp,4,'long');
    jd1=jd2(1);
    jd2=jd2(3);
    ncol=2;
  end;
  d=fread(tmp,[ncol,Inf],'float');
  if jd2-jd1+1~=max(size(d));
    disp(['DATA WARNING:  File ',hinfiled,' begins on day ',int2str(jd1),...
        ' and ends on day ',int2str(jd2),','])
    disp(['               but has ',int2str(max(size(d))),' data points.'])
    disp(['               I will assume these are the first ',...
        int2str(max(size(d))), ' data points after day ',int2str(jd1)])
    jd2=jd1-1+max(size(d));
  end;
  jdd=(jd1:jd2);
  d=d';
else;					% ASCII FILE
  d=fscanf(tmp,'%f',[ncol,Inf]);
  d=d';
  jdd=d(:,2);
end;
[d1,m,yr1]=jul2date(jdd(1));
[d1,m,yr2]=jul2date(jdd(length(jdd)));
disp(['File contains predictions from ',num2str(yr1),' to ',num2str(yr2),' for subcat ',num2str(subcatd)])
fclose(tmp);
%
%
%  RESHAPE DATA STREAM TO GIVE PREDICTED [AND OBSERVED] VECTORS
%
if ncol==2 | ncol==4;		% ==> THERE EXISTS A COLUMN OF OBSERVED DATA
  obsd=d(:,ncol-1);
  predd=d(:,ncol);
  i=find(obsd<0);
  j=find(obsd>=0);
  obsd(i)=NaN*ones(size(i));
  if length(j)>0;
    [d1,m,yr1]=jul2date(jdd(j(1)));
    [d1,m,yr2]=jul2date(jdd(max(j)));
    disp(['         and observations from ',num2str(yr1),' to '...
        ,num2str(yr2),' for subcatc ',num2str(subcatd),'.'])
  else;
    disp('  and no observations.')
  end;
else;				% ==> THERE EXISTS NO COLUMN OF OBSERVED DATA
  predd=d(:,ncol);
  obsd=NaN*ones(size(predd));
  disp('  and no observations.')
end;
%hinfiled=[hinfiled,hsalt];
hyear=yr1-1;
