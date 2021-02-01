function data_out = cleanse_sites(data_in)

disp('Cleansing the data');

sites = fieldnames(data_in);

for i = 1:length(sites)
    vars = fieldnames(data_in.(sites{i}));
    for j = 1:length(vars)
        X = data_in.(sites{i}).(vars{j}).X;
        Y = data_in.(sites{i}).(vars{j}).Y;
        
        for k = 1:length(sites)
            var_chx = fieldnames(data_in.(sites{k}));
            for l = 1:length(var_chx)
                if strcmpi(vars{j},var_chx{l}) == 1 & ...
                    strcmpi(sites{i},sites{k}) == 0
                %disp([vars{j},' ',var_chx{l}])
                    if X == data_in.(sites{k}).(var_chx{l}).X & ...
                            Y == data_in.(sites{k}).(var_chx{l}).Y
                         disp([vars{j},' ',var_chx{l}])
                         disp([num2str(X),' ',num2str(data_in.(sites{k}).(var_chx{l}).X)]);
    
                        data_in.(sites{i}).(vars{j}).Date = [data_in.(sites{i}).(vars{j}).Date;data_in.(sites{k}).(var_chx{l}).Date];
                        data_in.(sites{i}).(vars{j}).Data = [data_in.(sites{i}).(vars{j}).Data;data_in.(sites{k}).(var_chx{l}).Data];
                        data_in.(sites{i}).(vars{j}).Depth = [data_in.(sites{i}).(vars{j}).Data;data_in.(sites{k}).(var_chx{l}).Depth];
                        
                        data_in.(sites{k}) = rmfield(data_in.(sites{k}),var_chx{l});
                        
                    end
                end
            end
        end
    end
end

sites = fieldnames(data_in);

for i = 1:length(sites)
    if ~isempty(fieldnames(data_in.(sites{i})))
        data_out_t.(sites{i}) = data_in.(sites{i});
    end
end

sites = fieldnames(data_out_t);
for i = 1:length(sites)
    vars = fieldnames(data_out_t.(sites{i}));
    for j = 1:length(vars)
        
        data_out.(sites{i}).(vars{j}) = data_out_t.(sites{i}).(vars{j});
        data_out.(sites{i}).(vars{j}).Date = [];
        data_out.(sites{i}).(vars{j}).Data = [];
        data_out.(sites{i}).(vars{j}).Depth = [];
        [data_out.(sites{i}).(vars{j}).Date,ind] = unique(data_out_t.(sites{i}).(vars{j}).Date);
        data_out.(sites{i}).(vars{j}).Data = data_out_t.(sites{i}).(vars{j}).Data(ind);
%         if isfield(data_out_t.(sites{i}).(vars{j}),'Depth')
%             data_out.(sites{i}).(vars{j}).Depth = data_out_t.(sites{i}).(vars{j}).Depth(ind);
%         else
            data_out.(sites{i}).(vars{j}).Depth(1:length(ind),1) = 0;
%        end
    end
end