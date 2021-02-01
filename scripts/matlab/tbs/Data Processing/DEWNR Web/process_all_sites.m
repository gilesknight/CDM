clear all; close all;

addpath(genpath('Functions'))

download_data;

download_Site_Info;

process_DWLBC_data;

load dwlbc.mat;

save dwlbc.mat dwlbc -mat

summerise_data('dwlbc.mat','DWLBC/');