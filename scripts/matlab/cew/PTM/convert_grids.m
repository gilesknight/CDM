clear all; close all;

addpath(genpath('functions'));

dirlist = dir(['MatGrids/','*.2dm']);

for i = 1:length(dirlist)
    convert_2dm_to_shp(['MatGrids/',dirlist(i).name]);
end