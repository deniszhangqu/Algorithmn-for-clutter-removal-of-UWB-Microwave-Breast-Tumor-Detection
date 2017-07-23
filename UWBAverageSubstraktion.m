
function [filtersig]=UWBAverageSubstraktion(Rohsignal,KanalNr)


l=size(KanalNr,2);

Summe=0;
for i=1:1:l
    Summe=Summe+Rohsignal(:,KanalNr(i));
end

Average=Summe/l;

for i=1:1:l;
    E(:,KanalNr(i))=Rohsignal(:,KanalNr(i))-Average;
end

filtersig(:,KanalNr)=E(:,KanalNr);
end

