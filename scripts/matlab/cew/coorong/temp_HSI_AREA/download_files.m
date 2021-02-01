%function download_files(min_size)
min_size = 30000000000;

davy_files = {...
    '010_Ruppia_2015_2016_1',...
    '010_Ruppia_2015_2016_2_B0',...
    '010_Ruppia_2015_2016_3_BTau',...
    '010_Ruppia_2015_2016_4_BGoo',...
    '010_Ruppia_2015_2016_5_BL_SC100',...
    '010_Ruppia_2015_2016_11_lgt',...
    };



% Server Information
ssh2_conn = ssh2_config('Davy','hydro','modeller');

for i = 1:length(davy_files)
    
    % File information
    remote_file = 'coorong.nc';
    remote_path = ['/Users/Matt/CLLMMRW/',davy_files{i},'/Output/'];
    outdir = ['I:\Lowerlakes\Coorong Only Simulations\Scenarios\',davy_files{i},'\Output'];
    
    if ~exist(outdir,'dir');
        mkdir(outdir);
    end
    
    disp(remote_path);
    ssh2_conn = ssh2_command(ssh2_conn, ['ls -alt ',remote_path]);
    remote_size = ssh2_command_response(ssh2_conn);
    ssh2_conn = ssh2_command(ssh2_conn, ['dir ',remote_path]);
    remote_name = ssh2_command_response(ssh2_conn);
    
    isize = get_size(remote_size,remote_name);
    local_dir = dir([outdir,'\*.nc']);
    
    if ~isempty(isize) % there is a file
        
        if ~isempty(local_dir) % there is no local file
            
            if isize > local_dir(1).bytes & isize > min_size%  % there is both but the remote file is bigger
                
                % Download Code
                disp(['Downloading ',remote_file]);
                ssh2_conn = scp_simple_get('Davy','hydro','modeller',remote_file,outdir,remote_path);
            else % Final nc file has been downloaded
                disp(['Already downloaded  ',remote_file]);
            end
        else
            % Download Code
            disp(['Downloading ',remote_file]);
            ssh2_conn = scp_simple_get('Davy','hydro','modeller',remote_file,outdir,remote_path);
        end
    else
        disp(['No remote file  ',remote_file]);
    end
    
end

% 
% sci_files = {...
%     '010_Ruppia_2015_2016_6_SC0',...
%     '010_Ruppia_2015_2016_7_SC40',...
%     '010_Ruppia_2015_2016_8_SC100',...
%     '010_Ruppia_2015_2016_9_SC40_2Nut',...
%     '010_Ruppia_2015_2016_10_SC40_0_5Nut',...
%     };
% 
% 
% 
% % Server Information
% ssh2_conn = ssh2_config('130.95.163.130','00065525','BRendan01');
% 
% for i = 1:length(sci_files)
%     
%     % File information
%     remote_file = 'coorong.zip';
%     remote_path = ['/home/Simulations/',sci_files{i},'/Output/'];
%     outdir = ['I:\Lowerlakes\Coorong Only Simulations\Scenarios\',sci_files{i},'\Output'];
%     
%         if ~exist(outdir,'dir');
%         mkdir(outdir);
%     end
%     
%     ssh2_conn = ssh2_command(ssh2_conn, ['ls -l ',remote_path]);
%     remote_size = ssh2_command_response(ssh2_conn);
%     ssh2_conn = ssh2_command(ssh2_conn, ['dir ',remote_path]);
%     remote_name = ssh2_command_response(ssh2_conn);
%     
%     [isize] = get_size_zip(remote_size,remote_name);
%     local_dir = dir([outdir,'\*.zip']);
%     
%     if ~isempty(isize) % there is a file
%         
%         if ~isempty(local_dir) % there is no local file
%             
%             if isize > local_dir(1).bytes % there is both but the remote file is bigger
%                 
%                 % Download Code
%                 disp(['Downloading ',remote_file]);
%                 ssh2_conn = scp_simple_get('130.95.163.130','00065525','BRendan01',remote_file,outdir,remote_path);
%                 %unzip('coorong.nc',outdir);
%             else % Final nc file has been downloaded
%                 disp(['Already downloaded  ',remote_file]);
%             end
%         else
%             % Download Code
%             disp(['Downloading ',remote_file]);
%             ssh2_conn = scp_simple_get('130.95.163.130','00065525','BRendan01',remote_file,outdir,remote_path);
%             %unzip('coorong.nc',outdir);
% 
%         end
%     else
%         disp(['No remote file  ',remote_file]);
%     end
%     
% end