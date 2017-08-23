function [Rohsignal,Idealsignal,Gefiltsignal,PPRR,CM,MSE]=Mainprocessor(datenname,RemovelAnsatz,Path_Meas,Path_Gold)


%%#1 Daten Einladen
[Rohsignal,Idealsignal]=DatenRead(datenname,Path_Meas,Path_Gold);

%%#2 Clutter Remove
if strcmp(RemovelAnsatz,'UWBAverageSubtraktion')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBAverageSubtraktion(Rohsignal,KanalNr);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end

if strcmp(RemovelAnsatz,'UWBSVD_optimal')
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

if strcmp(RemovelAnsatz,'UWBSVD_2')
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

if strcmp(RemovelAnsatz,'UWBEntropie')
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
            filtersig=UWBEntropie(Rohsignal,KanalNr,alpha,window);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end
%%#3 Bewertung
[PPRR,CM,MSE]=Bewertung(Rohsignal,Idealsignal,Gefiltsignal);
end
