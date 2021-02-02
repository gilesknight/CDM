%clear;close;

function [HSI,fS,fT,fO,fA]=cal_HSI_goby(sal_bot,monthTEMP, Depth)%,do_bot,amm_bot,)
%load swan_WQ.mat;

% do_bot=do_bot*32/1000;
% amm_bot=amm_bot*14/1000;

fS=zeros(size(sal_bot)); %create an empty matrix the same size as sal_bot
fT=fS;
fO=fS;
fA=fS;

%s10=60;s50=64;%s3=20;s4=39;s5=50;
t1=14;t2=23;%t3=26;t4=28;
% o1=2;o2=4;
% a1=0.3;a2=1.1;

for ii=1:size(sal_bot,1) %cell
    
    if mod(ii,1000)==0
        disp(ii);
    end
    
    for jj=1:size(sal_bot,2) %time step
        
        if Depth(ii,jj)<0.1
            fS(ii,jj)=0;
        else
            
            if monthTEMP(ii,jj)<t1
                s10=68;
                s50=73;
            elseif monthTEMP(ii,jj)<t2
                s10=((66-68)/(23-14))*(monthTEMP(ii,jj)-14)+68;
                s50=((71-73)/(23-14))*(monthTEMP(ii,jj)-14)+73;
            elseif monthTEMP(ii,jj)>=t2
                s10=66;
                s50=71;
            end
            
            
            if sal_bot(ii,jj)<s10
                fS(ii,jj)=1;
            elseif sal_bot(ii,jj)<s50
                fS(ii,jj)=(s50-sal_bot(ii,jj))/(s50-s10);
                %         elseif sal_bot(ii,jj)<=s3
                %             fS(ii,jj)=0.08*sal_bot(ii,jj)-0.7;
                %         elseif sal_bot(ii,jj)<=s4+1
                %             fS(ii,jj)=1;
                %         elseif sal_bot(ii,jj)<=s5
                %             fS(ii,jj)=-0.1*sal_bot(ii,jj)+5;
            else
                fS(ii,jj)=0;
            end
            
            %         if temp_bot(ii,jj)<t1
            %             fT(ii,jj)=0.0012*exp(0.675*temp_bot(ii,jj));
            %         elseif temp_bot(ii,jj)<t2
            %             fT(ii,jj)=1;
            %         elseif temp_bot(ii,jj)<t3
            %             fT(ii,jj)=-(temp_bot(ii,jj)*0.0667)+2.33;
            %         elseif temp_bot(ii,jj)<t4
            %             fT(ii,jj)=-(temp_bot(ii,jj)*0.3)+8.4;
            %         else
            %             fT(ii,jj)=0;
            %         end
            %
            %         if do_bot(ii,jj)<o1
            %             fO(ii,jj)=0;
            %         elseif do_bot(ii,jj)<o2
            %             fO(ii,jj)=0.5*do_bot(ii,jj)-1;
            %         else
            %             fO(ii,jj)=1;
            %         end
            %
            %         if amm_bot(ii,jj)<a1
            %             fA(ii,jj)=1;
            %         elseif amm_bot(ii,jj)<a2
            %             fA(ii,jj)=-1.25*amm_bot(ii,jj)+1.375;
            %         else
            %             fA(ii,jj)=0;
        end
    end
end
HSI=fS; %(.*fT.*fO.*fA); %remove ; will print results
end





%save('swan_musselHSI_new.mat','fS','fT','fO','fA','HSI','time','geo','-mat','-v7.3');
%end