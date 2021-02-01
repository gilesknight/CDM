clear all; close all;

[yDep05_yEro.ptm_data,yDep05_yEro.x,yDep05_yEro.y,yDep05_yEro.z] = tfv_readPTM('I:\GCLOUD\Testsv2\Chowilla_HD_v2\Output\run_ptm.nc');



for i = 1:size(yDep05_yEro.ptm_data.x_raw,1)
    
    dist(i) = 0;
    
    X = yDep05_yEro.ptm_data.x_raw(i,1);
    Y = yDep05_yEro.ptm_data.y_raw(i,1);
    
    for j = 2:length(yDep05_yEro.ptm_data.mdate)
        
        X1 = yDep05_yEro.ptm_data.x_raw(i,j);
        Y1 = yDep05_yEro.ptm_data.y_raw(i,j);
        
        if ~isnan(X1)
            
            if ~isnan(X)
                
                dist(i) = dist(i) + sqrt(power(abs(X1-X),2) + power(abs(Y1-Y),2));
                
            end
            X = X1;
            Y = Y1;
        end
    end
end

% [yDep05_yEro.ptm_data,yDep05_yEro.x,yDep05_yEro.y,yDep05_yEro.z] = tfv_readPTM('I:\GCLOUD\Chowilla Tests\Chow_yDep_02_Ero_nAED\Output\run_ptm_bak.nc');
% 
% 
% 
% for i = 1:size(yDep05_yEro.ptm_data.x_raw,1)
%     
%     dist2(i) = 0;
%     
%     X = yDep05_yEro.ptm_data.x_raw(i,1);
%     Y = yDep05_yEro.ptm_data.y_raw(i,1);
%     
%     for j = 2:length(yDep05_yEro.ptm_data.mdate)
%         
%         X1 = yDep05_yEro.ptm_data.x_raw(i,j);
%         Y1 = yDep05_yEro.ptm_data.y_raw(i,j);
%         
%         if ~isnan(X1)
%             
%             if ~isnan(X)
%                 
%                 dist2(i) = dist2(i) + sqrt(power(abs(X1-X),2) + power(abs(Y1-Y),2));
%                 
%             end
%             X = X1;
%             Y = Y1;
%         end
%     end
% end

[yDep05_yEro.ptm_data,yDep05_yEro.x,yDep05_yEro.y,yDep05_yEro.z] = tfv_readPTM('I:\GCLOUD\Testsv2\Chowilla_HD\Output\run_ptm.nc');



for i = 1:size(yDep05_yEro.ptm_data.x_raw,1)
    
    dist3(i) = 0;
    
    X = yDep05_yEro.ptm_data.x_raw(i,1);
    Y = yDep05_yEro.ptm_data.y_raw(i,1);
    
    for j = 2:length(yDep05_yEro.ptm_data.mdate)
        
        X1 = yDep05_yEro.ptm_data.x_raw(i,j);
        Y1 = yDep05_yEro.ptm_data.y_raw(i,j);
        
        if ~isnan(X1)
            
            if ~isnan(X)
                
                dist3(i) = dist3(i) + sqrt(power(abs(X1-X),2) + power(abs(Y1-Y),2));
                
            end
            X = X1;
            Y = Y1;
        end
    end
end


% plot(dist3/1000);hold on;plot(dist/1000);hold on;plot(dist2/1000);
% legend({'No Deposition';'Deposition 0.05';'Deposition 0.2'});
% xlabel('Ball ID Number')
% ylabel('Distance Travelled (km)');
% 
% sss = find(dist > 0);
% 
% mean(dist(sss)/1000)

% [yDep05_yEro.ptm_data,yDep05_yEro.x,yDep05_yEro.y,yDep05_yEro.z] = tfv_readPTM('I:\GCLOUD\Chowilla Tests\Chow_yDep_05_nEro_nAED\Output\run_ptm.nc');
% 
% 
% 
% for i = 1:size(yDep05_yEro.ptm_data.x_raw,1)
%     
%     dist4(i) = 0;
%     
%     X = yDep05_yEro.ptm_data.x_raw(i,1);
%     Y = yDep05_yEro.ptm_data.y_raw(i,1);
%     
%     for j = 2:length(yDep05_yEro.ptm_data.mdate)
%         
%         X1 = yDep05_yEro.ptm_data.x_raw(i,j);
%         Y1 = yDep05_yEro.ptm_data.y_raw(i,j);
%         
%         if ~isnan(X1)
%             
%             if ~isnan(X)
%                 
%                 dist4(i) = dist4(i) + sqrt(power(abs(X1-X),2) + power(abs(Y1-Y),2));
%                 
%             end
%             X = X1;
%             Y = Y1;
%         end
%     end
% end

