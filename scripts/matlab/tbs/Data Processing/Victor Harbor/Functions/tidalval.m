function v=tidalval(tidal,t)
%% Predicts tide from a tidal model.
%
% USAGE: v=tidalval(tidal,t)
%
%
% INPUT:
% tidal: tidal model from fittidal
% t: time instants to evaluate at (serial date numbers, see help datenum)
%
% OUTPUT:
% v: tidal prediction
%
% See example from help tidalfit.m
%
%
% -Please include an acknowledgement to Aslak Grinsted if you use this
% code.
%

%%   Copyright (C) 2008, Aslak Grinsted
%   This software may be used, copied, or redistributed as long as it is not
%   sold and this copyright notice is reproduced on each copy made.  This
%   routine is provided as is without any express or implied warranties
%   whatsoever.

keep=~isnan([tidal.amp])';
period=[tidal(keep).period]';
amp=[tidal(keep).amp]';
phase=[tidal(keep).phase]';

Np=length(period);

v=zeros(size(t));
for ii=1:Np
    qt=t*2*pi/period(ii);
    v=v+(amp(ii)*cos(phase(ii))).*cos(qt)+(amp(ii)*sin(phase(ii))).*sin(qt);
end

