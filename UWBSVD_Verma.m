

function [filtersig]=UWBSVD_Verma(Rohsignal,KanalNr)

l=size(KanalNr,2);

for i=1:1:l
    Signal1(:,i)=Rohsignal(:,KanalNr(i));
end
[U,S,V]=svd(Signal1,0);

a=S(2,2);
S(:,:)=0;
S(2,2)=a;

X=U*S*V';

for i=1:1:l
    filtersig(:,KanalNr(i))=X(:,i);
end
end

