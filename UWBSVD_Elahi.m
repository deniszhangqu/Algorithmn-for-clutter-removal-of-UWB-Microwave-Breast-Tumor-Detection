

function [filtersig]=UWBSVD_Elahi(Rohsignal,KanalNr)

l=size(KanalNr,2);

for i=1:1:l
    Signal1(:,i)=Rohsignal(:,KanalNr(i));
end
[U,S,V]=svd(Signal1,0);
if l==2;
    N=1;
else
    for i=1:1:l-1;
        d(i)=S(i,i)-S(i+1,i+1);
    end
    maximum=max(d);
    N=find(d==maximum);
end
for i=1:1:N
    S(i,i)=0;
end

X=U*S*V';

for i=1:1:l
    filtersig(:,KanalNr(i))=X(:,i);
end
end

