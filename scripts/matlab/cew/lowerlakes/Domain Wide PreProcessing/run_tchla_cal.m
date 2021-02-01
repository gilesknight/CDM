function savedata = run_tchla_cal(outdir,var)

% 'WQ_PHY_GRN',...
%     'WQ_PHY_CRYPT',...
%     'WQ_PHY_DIATOM',...
%     'WQ_PHY_DINO',...
%     'WQ_PHY_BGA',...
    
switch var
    case 'WQ_DIAG_PHY_TCHLA'

            grn = load([outdir,'WQ_PHY_GRN.mat']);
            % cyp = load([outdir,'WQ_PHY_CRYPT.mat']);
            % dia = load([outdir,'WQ_PHY_DIATOM.mat']);
            % dino = load([outdir,'WQ_PHY_DINO.mat']);
            % bga = load([outdir,'WQ_PHY_BGA.mat']);

            savedata.Time = grn.savedata.Time;
            savedata.X = grn.savedata.X;
            savedata.Y = grn.savedata.Y;
            savedata.Area = grn.savedata.Area;


            %          raw(mod).data.WQ_DIAG_PHY_TCHLA = (((tchl.WQ_PHY_GRN / 50)*12) + ...
            %                         ((tchl.WQ_PHY_CRYPT / 50)*12) + ...
            %                         ((tchl.WQ_PHY_DIATOM / 26)*12) + ...
            %                         ((tchl.WQ_PHY_DINO / 40)*12) + ...
            %                         ((tchl.WQ_PHY_BGA / 40)*12));


            savedata.WQ_DIAG_PHY_TCHLA.Top = (((grn.savedata.WQ_PHY_GRN.Top / 50)*12));

            %savedata.WQ_DIAG_PHY_TCHLA.Bot = (((grn.savedata.WQ_PHY_GRN.Bot / 50)*12));
            
    case 'ON'
            don = load([outdir,'WQ_OGM_DON.mat']);
            pon = load([outdir,'WQ_OGM_PON.mat']);
            
            
            savedata.Time = don.savedata.Time;
            savedata.X = don.savedata.X;
            savedata.Y = don.savedata.Y;
            savedata.Area = don.savedata.Area;
            
            savedata.ON.Top = don.savedata.WQ_OGM_DON.Top + pon.savedata.WQ_OGM_PON.Top;

            %savedata.ON.Bot = don.savedata.WQ_OGM_DON.Bot + pon.savedata.WQ_OGM_PON.Bot;
       case 'OP'
            don = load([outdir,'WQ_OGM_DOP.mat']);
            pon = load([outdir,'WQ_OGM_POP.mat']);
            
            
            savedata.Time = don.savedata.Time;
            savedata.X = don.savedata.X;
            savedata.Y = don.savedata.Y;
            savedata.Area = don.savedata.Area;
            
            savedata.OP.Top = don.savedata.WQ_OGM_DOP.Top + pon.savedata.WQ_OGM_POP.Top;
    otherwise
end
            %savedata.OP.Bot = don.savedata.WQ_OGM_DOP.Bot + pon.savedata.WQ_OGM_POP.Bot;     
            