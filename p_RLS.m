close all;
clear all;


Path_Meas = 'C:\Users\zhang\Desktop\Signalverarbeitung\Hauptseminar\Daten\Messdaten - NSI\Testmessungen\';
Path_Gold = 'C:\Users\zhang\Desktop\Signalverarbeitung\Hauptseminar\Daten\Messdaten - NSI\Goldstandards\';
datenlist={'Aquadest K9','BodyMilk K9','CremeFresh K9','Glyzerin K9','Glyzerin-Wasser 1-1 K9','Joghurt K9','Kaffeesahne K9','Leitungswasser K9','Luft K9','Oel K9','Propylenglykol K9','Quark K9','Rama K9','Sahne 0 K9','Sahne +1 K9','Sahne +2 K9','Sahne alt 0 K9','Sahne alt +1 K9','Sahne alt +2 K9','Sahne alt -1 K9','Vernel K9'};
%datenlist={'Aquadest K9','BodyMilk K9','CremeFresh K9','Kaffeesahne K9','Leitungswasser K9','Quark K9','Rama K9','Sahne 0 K9','Sahne +1 K9','Sahne +2 K9','Sahne alt 0 K9','Sahne alt +1 K9','Sahne alt +2 K9','Sahne alt -1 K9','Vernel K9'};
Messung=datenlist{1};
[Rohsignal,Idealsignal]=DatenRead(Messung,Path_Meas,Path_Gold);

KanalNr=[1 3 15 34 56 61 90 107 119];
lamda=0.5;
l=size(KanalNr,2);
k=size(Rohsignal,1);
%%
KanalNr1=KanalNr;
for i=1:1:l
    d(:,1)=Rohsignal(:,KanalNr(i));
    d=d';
    KanalNr1(i)=[];
    
    for j=1:1:k
        u(j,:)=Rohsignal(1,KanalNr1);
    end
    u=u';
    for n=1:1:k
        F(l-1,l-1)=0;z(l-1,1)=0;
        for m=1:1:n
            F(:,:)=(lamda.^(n-m))*u(:,m)*u(:,m)'+F;
            z(:,1)=(lamda.^(n-m))*u(:,m)*d(m)+z;
        end
        w(:,1)=inv(F)*z;
        d_g(n)=w'*u(:,n);
    end
    filtersig(:,KanalNr(i))=d_g(:)';
    KanalNr1=KanalNr;
end

