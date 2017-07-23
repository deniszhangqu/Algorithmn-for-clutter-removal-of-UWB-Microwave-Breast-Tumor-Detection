

function [filtersig]=UWBEntropie(Rohsignal,KanalNr,alpha,window)


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
H(t+1:t+window)=0;

H=H';
HS0=0;
for i=1:1:t
    for j=i:1:i+window;
        HS0=HS0+H(j);
    end
    HS(i)=HS0;
    HS0=0;  
end
HS=HS./window;
%
for i=1:1:t;
    D(i)=exp(HS(i));
end
N=l/2;
for i=1:1:t
    if D(i)>N;
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
