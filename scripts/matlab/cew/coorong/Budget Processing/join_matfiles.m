
clear all; close all;

dirlist = dir(['R:\Coorong\Proc_Out/','*.mat']);

flux_all = [];

load(['R:\Coorong\Proc_Out/',dirlist(1).name]);

sites = fieldnames(flux);
vars = fieldnames(flux.(sites{1}));

flux_all = flux;
% 
% for ii = 1:length(dirlist)
%     clear flux;
%     load(['R:\Coorong\014_noWeir_test_for_binary\Flux/',dirlist(ii).name]);
%     
%     for i = 1:length(sites)
%         for j = 1:length(vars)
%             
%             
%             
%             flux_all.(sites{i}).(vars{j}) = [flux_all.(sites{i}).(vars{j});flux.(sites{i}).(vars{j})];
%             
%             
%         end
%         
%         if length(flux_all.(sites{i}).mDate) ~= length(flux_all.(sites{i}).OGM_donr)
%             stop;
%         end
%     end
% end
% 
% sites = fieldnames(flux_all);
% for i = 1:length(sites)
%     
%     mvec = datevec(flux_all.(sites{i}).mDate);
%     flux_all.(sites{i}).mDate = datenum(mvec(:,1),mvec(:,2),mvec(:,3),mvec(:,4),mvec(:,5),00);
%     
%     [flux_all.(sites{i}).mDate,ind] = unique(flux_all.(sites{i}).mDate);
%     vars = fieldnames(flux_all.(sites{i}));
%     for j = 1:length(vars)
%         if strcmpi(vars{j},'mDate') == 0
%             flux_all.(sites{i}).(vars{j}) = flux_all.(sites{i}).(vars{j})(ind);
%         end
%     end
% end




save('R:\Coorong\Proc\flux_all.mat','flux_all','-mat');