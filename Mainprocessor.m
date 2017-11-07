function [Rohsignal,Idealsignal,Gefiltsignal,PPRR,CM,MSE]=Mainprocessor(Messungname,RemovelAnsatz,Path_Meas,Path_Gold)


%%#1 Daten Einladen
[Rohsignal,Idealsignal]=DatenRead(Messungname,Path_Meas,Path_Gold);

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

if strcmp(RemovelAnsatz,'UWBSVD_Elahi')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBSVD_Elahi(Rohsignal,KanalNr);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end

if strcmp(RemovelAnsatz,'UWBSVD_Verma')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBSVD_Verma(Rohsignal,KanalNr);
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

if strcmp(RemovelAnsatz,'UWBWienerfilter')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBWienerfilter(Rohsignal,KanalNr);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end

if strcmp(RemovelAnsatz,'UWBRLS')
    for i=0:1:26;
        KanalNr=IDChannel(i);
        if isempty(KanalNr);
            continue;
        end
        if length(KanalNr)==1;
            Gefiltsignal(:,KanalNr)=Rohsignal(:,KanalNr);
        end
        if length(KanalNr)>=2;
            filtersig=UWBRLS(Rohsignal,KanalNr);
            Gefiltsignal(:,KanalNr)=filtersig(:,KanalNr);
        end
    end
end
%%#3 Bewertung
[PPRR,CM,MSE]=Bewertung(Rohsignal,Idealsignal,Gefiltsignal);
end
