close all;
clear all;

%%
Path_Meas = 'C:\Users\zhang\Desktop\Signalverarbeitung\Hauptseminar\Daten\Messdaten - NSI\Testmessungen\';
Path_Gold = 'C:\Users\zhang\Desktop\Signalverarbeitung\Hauptseminar\Daten\Messdaten - NSI\Goldstandards\';
datenlist={'Aquadest K9','BodyMilk K9','CremeFresh K9','Glyzerin K9','Glyzerin-Wasser 1-1 K9','Joghurt K9','Kaffeesahne K9','Leitungswasser K9','Luft K9','Oel K9','Propylenglykol K9','Quark K9','Rama K9','Sahne 0 K9','Sahne +1 K9','Sahne +2 K9','Sahne alt 0 K9','Sahne alt +1 K9','Sahne alt +2 K9','Sahne alt -1 K9','Vernel K9'};
methodelist={'UWBAverageSubtraktion', 'UWBSVD_Verma','UWBSVD_Elahi', 'UWBEntropie'};
for i=1:1:21
    datenname=datenlist{i};
    
    RemovelMethode='UWBEntropie';  %'UWBAverageSubtraktion'/'UWBSVD_Verma'/'UWBSVD_Elahi'/'UWBEntropie'%
    
    [Rohsignal,Idealsignal,Gefiltsignal,gefiltPPRR,gefiltCM,MSE1]=Mainprocessor(datenname,RemovelMethode,Path_Meas,Path_Gold);
    %
    a=[1 2 3 15 17 113];
    Mean_PPRR6=mean(gefiltPPRR(a));
    Mean_PPRR128=mean(gefiltPPRR); 
    Mean_CM6=mean(gefiltCM(a));
    Mean_CM128=mean(gefiltCM);
    Mean_MSE6=mean(MSE1(a));
    Mean_MSE128=mean(MSE1);
    
    cm=gefiltCM(a);cm(7:8)=[Mean_CM6,Mean_CM128];
    pprr=gefiltPPRR(a);pprr(7:8)=[Mean_PPRR6,Mean_PPRR128];
    mse=MSE1(a);mse(7:8)=[Mean_MSE6,Mean_MSE128];
    
    CM(i,1:8)=cm;
    PPRR(i,1:8)=pprr;
    MSE(i,1:8)=mse;
end
%% write the daten  in Excel 
datenlist={'Aquadest K9';'BodyMilk K9';'CremeFresh K9';'Glyzerin K9';'Glyzerin-Wasser 1-1 K9';'Joghurt K9';'Kaffeesahne K9';'Leitungswasser K9';'Luft K9';'Oel K9';'Propylenglykol K9';'Quark K9';'Rama K9';'Sahne 0 K9';'Sahne +1 K9';'Sahne +2 K9';'Sahne alt 0 K9';'Sahne alt +1 K9';'Sahne alt +2 K9';'Sahne alt -1 K9';'Vernel K9'};
chlist={'Ch1','Ch2','Ch3','Ch15','Ch17','Ch113','Mittelwert(6)','Mittelwert(128)'};

xlswrite(RemovelMethode,datenlist,'CM','A2');
xlswrite(RemovelMethode,chlist,'CM','B1');
xlswrite(RemovelMethode,CM,'CM','B2');

xlswrite(RemovelMethode,datenlist,'PPRR','A2');
xlswrite(RemovelMethode,chlist,'PPRR','B1');
xlswrite(RemovelMethode,PPRR,'PPRR','B2');

xlswrite(RemovelMethode,datenlist,'MSE','A2');
xlswrite(RemovelMethode,chlist,'MSE','B1');
xlswrite(RemovelMethode,MSE,'MSE','B2');




