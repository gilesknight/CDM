function data1 = merge_sites(data)

sites = fieldnames(data);



for i = 1:length(sites)
    vars = fieldnames(data.(sites{i}));
    CO(i,1) = data.(sites{i}).(vars{1}).X;
    CO(i,2) = data.(sites{i}).(vars{1}).Y;
end

[u_CO,ia,~] = unique(CO,'rows');

u_sites = sites(ia);

for i = 1:length(u_sites)
    for j = 1:length(sites)
            vars = fieldnames(data.(sites{j}));
            X = data.(sites{j}).(vars{1}).X;
            Y = data.(sites{j}).(vars{1}).Y;
            
            if X == u_CO(i,1) & Y == u_CO(i,2) & strcmpi(sites{j},u_sites{i}) == 0
                
                for k = 1:length(vars)
                    
                    if ~isfield(data.(u_sites{i}),vars{k})
                        data.(u_sites{i}).(vars{k}) = data.(sites{j}).(vars{k});
                    else
                        data.(u_sites{i}).(vars{k}).Date = [data.(u_sites{i}).(vars{k}).Date;data.(sites{j}).(vars{k}).Date];
                        data.(u_sites{i}).(vars{k}).Data = [data.(u_sites{i}).(vars{k}).Data;data.(sites{j}).(vars{k}).Data];
                        data.(u_sites{i}).(vars{k}).Depth = [data.(u_sites{i}).(vars{k}).Depth;data.(sites{j}).(vars{k}).Depth];
                        
                        [data.(u_sites{i}).(vars{k}).Date,ind] = sort(data.(u_sites{i}).(vars{k}).Date);
                        data.(u_sites{i}).(vars{k}).Data = data.(u_sites{i}).(vars{k}).Data(ind);
                        data.(u_sites{i}).(vars{k}).Depth = data.(u_sites{i}).(vars{k}).Depth(ind);
                    end
                end
            end
    end
end

for i = 1:length(u_sites)
    data1.(u_sites{i}) = data.(u_sites{i});
end

                        
                    
                
                
                
                
                
                
            
        
        
        