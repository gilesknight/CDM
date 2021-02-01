function create_scenarios_flows(outdir,main_dir,headers)

load([outdir,main_dir,'/data.mat']);


load lowerlakes.mat;
load flow_2018.mat;

facvars = {...
    'WQ_PHS_FRP';...
    'WQ_NIT_AMM';...
    'WQ_NIT_NIT';...
    'WQ_PHY_GRN';...
    };
facvals = [
    8e-07,
    6e-07,
    1e-06,
    0.0007,
    ];


mFlow = tfv_data.FLOW;

tfv_data

%_ no CEW simulation

filename = [outdir,'Lock1_noCEW.csv'];

sFlow = mFlow;

tt = find(ISOTime >= flow.Lock1.Flow_noCEW.Date(1) & ISOTime <= flow.Lock1.Flow_noCEW.Date(end));



sFlow(tt) = interp1(flow.Lock1.Flow_noCEW.Date,flow.Lock1.Flow_noCEW.Data,ISOTime(tt));

flow_diff = mFlow - sFlow;

for i = 1:length(facvars)
    i
    for j = 1:length(ISOTime)
        if flow_diff(j) ~= 0
            tfv_data.(facvars{i})(j) = tfv_data.(facvars{i})(j) - (facvals(i) * flow_diff(j));
            
        end
    end
    sss = find(isnan(tfv_data.(facvars{i})) == 1);

    if ~isempty(sss)
    tfv_data.(facvars{i})(sss) = tfv_data.(facvars{i})(sss(1)-1);
    end
end

tfv_data.FLOW = sFlow;

write_tfvfile(tfv_data,headers,ISOTime,filename);

%_ no ALL simulation
load([outdir,main_dir,'/data.mat']);

filename = [outdir,'Lock1_noALL.csv'];

sFlow = mFlow;

tt = find(ISOTime >= flow.Lock1.Flow_noAll.Date(1) & ISOTime <= flow.Lock1.Flow_noAll.Date(end));

sFlow(tt)  = interp1(flow.Lock1.Flow_noCEW.Date,flow.Lock1.Flow_noCEW.Data,ISOTime(tt));
flow_diff = mFlow - sFlow;

for i = 1:length(facvars)
    for j = 1:length(ISOTime)
        if flow_diff(j) ~= 0
            tfv_data.(facvars{i})(j) = tfv_data.(facvars{i})(j) - (facvals(i) * flow_diff(j));
        end
    end
    sss = find(isnan(tfv_data.(facvars{i})) == 1);
    if ~isempty(sss)
  
    tfv_data.(facvars{i})(sss) = tfv_data.(facvars{i})(sss(1)-1);
    end
end

tfv_data.FLOW = sFlow;

write_tfvfile(tfv_data,headers,ISOTime,filename);


%_ no ALL simulation
load([outdir,main_dir,'/data.mat']);

filename = [outdir,'Lock1_ALL.csv'];

oFlow = mFlow;

tt = find(ISOTime >= flow.Lock1.Flow.Date(1) & ISOTime <= flow.Lock1.Flow_noAll.Date(end));

oFlow(tt) = interp1(flow.Lock1.Flow_noCEW.Date,flow.Lock1.Flow_noCEW.Data,ISOTime(tt));
%flow_diff = mFlow - sFlow;

% for i = 1:length(facvars)
%     for j = 1:length(ISOTime)
%         if flow_diff(j) ~= 0
%             tfv_data.(facvars{i})(j) = tfv_data.(facvars{i})(j) - (facvals(i) * flow_diff(j));
%         end
%     end
%     sss = find(isnan(tfv_data.(facvars{i})) == 1);
%     tfv_data.(facvars{i})(sss) = tfv_data.(facvars{i})(sss(1)-1);
% end

tfv_data.FLOW = oFlow;

write_tfvfile(tfv_data,headers,ISOTime,filename);

