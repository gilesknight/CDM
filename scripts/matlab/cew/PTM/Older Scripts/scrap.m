for i = 1:length(X)
    s(i).X = [X(faces(:,i));X(faces(1,i))];
    s(i).Y = [Y(faces(:,i));Y(faces(1,i))];
    s(i).Name = 'BOB';
end

out_file = 'test.shp';

merge_field = 'Name';

all_field_vals = {s(:).(merge_field)};
unique_field_vals = unique(all_field_vals);

w = waitbar(0,'Processing');
c=1;
for k=1:numel(unique_field_vals)
   idx = find(ismember(all_field_vals, unique_field_vals{k}));
   x = s(idx(1)).X;
   y = s(idx(1)).Y;
   for i=2:numel(idx)
       [x,y] = polybool('union',x,y,s(idx(i)).X,s(idx(i)).Y);
   end
   
   s2(c).X = x;
   s2(c).Y = y;
   s2(c).Geometry = s(idx(1)).Geometry;
   s2(c).(merge_field) = s(idx(1)).(merge_field);
   c=c+1;
   waitbar(k/numel(unique_field_vals),w);
   drawnow
end
