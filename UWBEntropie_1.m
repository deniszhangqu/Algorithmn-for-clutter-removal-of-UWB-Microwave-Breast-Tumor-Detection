

function [filtersig]=UWBEntropie_1(Rohsignal,KanalNr,alpha)


l=size(KanalNr,2);

for i=1:1:l
    Signal1(:,i)=Rohsignal(:,KanalNr(i));
end

Sig=Signal1;
[t,q]=size(Sig); %t is rows and q is columns

for i=1:1:t;
    SumE(i)=sum(Sig(i,:).^2); 
    for j=1:1:q;
        p(i,j)=(Sig(i,j)^2)./SumE(i);  
    end
end
%
for i=1:1:t;
    SumQ(i)=sum(p(i,:).^alpha);
    H(i)=1/(1-alpha).*log(SumQ(i));
end

%

N=log(l);
for i=1:1:t
    if H(i)>N;
        W(i)=0;
    else
        W(i)=1;
    end
end

%w(n)*b(n)
for i=1:1:l
    S(:,i)=W.*(Sig(:,i)');
end


for i=1:1:l
    filtersig(:,KanalNr(i))=S(:,i);
end
end
