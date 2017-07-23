function [Rohsignal,Idealsignal,Gefiltsignal,gefiltPPRR,idealPPRR,gefiltCM,CMdiff,MSE]=Mainprocessor(datenname,RemovelMethode)


%%#1 Daten Einladen
[Rohsignal,Idealsignal]=DatenRead(datenname);

%%#2 Clutter Remove
if strcmp(RemovelMethode,'UWBAverageSubstraktion')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBAverageSubstraktion(Rohsignal,KanalNr);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end

if strcmp(RemovelMethode,'UWBSVD_optimal')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBSVD_optimal(Rohsignal,KanalNr);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end

if strcmp(RemovelMethode,'UWBSVD_2')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBSVD_2(Rohsignal,KanalNr);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end

if strcmp(RemovelMethode,'UWBEntropie_1')
    alpha=3; window=50;
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            %filtersig=UWBEntropie(Rohsignal,KanalNr,alpha,window);
            filtersig=UWBEntropie_1(Rohsignal,KanalNr,alpha);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end
%%#3 Bewertung
[gefiltPPRR,idealPPRR,gefiltCM,CMdiff,MSE]=Bewertung(Rohsignal,Idealsignal,Gefiltsignal);
end
