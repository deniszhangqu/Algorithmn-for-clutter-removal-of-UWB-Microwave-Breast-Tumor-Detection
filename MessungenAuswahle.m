close all;
clear all;

%%
Path_Meas = 'C:\Users\zhang\Desktop\Signalverarbeitung\Hauptseminar\Daten\Messdaten - NSI\Testmessungen\';
Path_Gold = 'C:\Users\zhang\Desktop\Signalverarbeitung\Hauptseminar\Daten\Messdaten - NSI\Goldstandards\';
datenlist={'Aquadest K9','BodyMilk K9','CremeFresh K9','Glyzerin K9','Glyzerin-Wasser 1-1 K9','Joghurt K9','Kaffeesahne K9','Leitungswasser K9','Luft K9','Oel K9','Propylenglykol K9','Quark K9','Rama K9','Sahne 0 K9','Sahne +1 K9','Sahne +2 K9','Sahne alt 0 K9','Sahne alt +1 K9','Sahne alt +2 K9','Sahne alt -1 K9','Vernel K9'};
%datenlist={'Aquadest K9','BodyMilk K9','CremeFresh K9','Kaffeesahne K9','Leitungswasser K9','Quark K9','Rama K9','Sahne 0 K9','Sahne +1 K9','Sahne +2 K9','Sahne alt 0 K9','Sahne alt +1 K9','Sahne alt +2 K9','Sahne alt -1 K9','Vernel K9'};

Ansatzlist={'UWBAverageSubtraktion', 'UWBSVD_2','UWBSVD_optimal', 'UWBEntropie'};
for i=1:1:21
    datenname=datenlist{i};
    [Rohsignal,Idealsignal]=DatenRead(datenname,Path_Meas,Path_Gold);
    [PPRR,CM,MSE]=Bewertung(Rohsignal,Idealsignal,Rohsignal);
    a=[1 2 3 15 17 113];
    Mean_PPRR6(i)=mean(PPRR(a));
    Mean_PPRR128(i)=mean(PPRR);
    Mean_CM6(i)=mean(CM(a));
    Mean_CM128(i)=mean(CM);
    Mean_MSE6(i)=mean(MSE(a));
    Mean_MSE128(i)=mean(MSE);
end

