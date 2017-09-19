
%% [PPRR,CM,MSE]=Bewertung(Rohsignal,Idealsignal,Gefiltsignal)
%% Rohsignal:the original signal,the row is observed value, column is the varirance;
%% Idealsignal is the gold standard response of tumor,the size muss be  the
%% same with sig
%% Gefiltsignal is the signal later artifactremove

function [PPRR,CM,MSE]=Bewertung(Rohsignal,Idealsignal,Gefiltsignal)

[a,b]=size(Rohsignal);
for i=1:1:b;
    Maxsig(i)=max(Rohsignal(:,i));
    Maxfiltersig(i)=max(Gefiltsignal(:,i));
    Maxstandard(i)=max(Idealsignal(:,i));
end
for i=1:1:b;
    PPRR(i)=Maxsig(i)/Maxfiltersig(i);
    
    v1=Gefiltsignal(:,i);
    v2=Idealsignal(:,i);
    v3=Rohsignal(:,i);
    CMmatrix1=corrcoef(v1,v2);
    CM(i)=CMmatrix1(2,1); 
      
end
for i=1:1:b;
    MSE1(i)=sum((Idealsignal(:,i)-Gefiltsignal(:,i)).^2);
    MSE2(i)=sum(Idealsignal(:,i).^2);
    MSE(i)=MSE1(i)./MSE2(i);
end

end
