function chgbal = calc_chgbal(tfv_data)

% A simple function to calculate uchgbal



%9-NH4,22-Na,24-K,23-Mg,26-Ca,29-Al(3x)
% sumPostives = (ELCOM_BC(:,22) /23.0)*1/1000 ...
%              + (ELCOM_BC(:,24) /39.0)*1/1000 ...
%              + (ELCOM_BC(:,23) /24.3)*2/1000 ...
%              + (ELCOM_BC(:,26) /40.1)*2/1000; ...
   
%13-PO4,10-NO3,25-Cl,27-SO4,5-DIC
% sumNegtives = (ELCOM_BC(:,25) /35.5)*1/1000 ...
%              + (ELCOM_BC(:,5)  /12.0)*1/1000 ...
%              + (ELCOM_BC(:,27) /96.0)*2/1000;


% Positives


        % AED Units .* (back to ELCD Units) ..Rest from ELCD 
AL  = ((tfv_data.nWQ_GEO_AL .* (26.98/1000)) / 26.9).*(3/1000);      
        
FE  = ((tfv_data.nWQ_GEO_FEII .* (55.845/1000)) / 55.8).*(2/1000);

NA = ((tfv_data.nWQ_GEO_NA .* (22.989/1000)) / 23).*(1/1000);

K = ((tfv_data.nWQ_GEO_K .* (39.1/1000)) / 39).*(1/1000);

MG = ((tfv_data.nWQ_GEO_MG .* (24.305/1000)) / 24.3).*(2/1000);

CA = ((tfv_data.nWQ_GEO_CA .* (40.078/1000)) / 40.1).*(2/1000);

pos = NA + K + MG + CA + FE + AL;

% Neg


CL = ((tfv_data.nWQ_GEO_CL .* (35.453/1000)) / 35.5).*(1/1000);

DIC = ((tfv_data.nWQ_CAR_DIC .* (12/1000)) / 12).*(1/1000);

SO4 = ((tfv_data.nWQ_GEO_SO4 .* (96/1000)) / 96).*(2/1000);

AMM = ((tfv_data.nWQ_NIT_AMM .* (14/1000)) / 14).*(1/1000);

NIT  = ((tfv_data.nWQ_NIT_NIT .* (14/1000)) / 14).*(1/1000);

FRP  = ((tfv_data.nWQ_PHS_FRP .* (31/1000)) / 31).*(3/1000);

neg = CL + DIC + SO4 + AMM + NIT + FRP;


% p1 = pos - neg;
% p2 = pos + neg;
% 
% chgbal = (p1./p2).*100;
% 
% chgbal(isnan(chgbal)) = 0;


chgbal = pos - neg;