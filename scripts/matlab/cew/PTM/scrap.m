clear all; close all;

mV = [0:0.005:0.15];

k = (-0.00001) / (1 - 0);

n = 0.009;

fS = (k*mV);% + n;

fS(fS < 0) = 0;
fS(mV <= 0.01) = 1;

plot(mV,fS);