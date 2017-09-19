function [filtersig] = UWBWienerfilter( Rohsignal,KanalNr)

%%Step 1:
k=size(Rohsignal,1);
l=size(KanalNr,2);
ID=KanalNr;

n0=1;n1=100;J0=2;
c=(2*J0+1)*(l-1);

for i=1:1:l  %
    
    b=Rohsignal(:,KanalNr(i));
    KanalNr(i)=[];
    
    R(1:c,1:c)=0;P(1:c,1)=0;
    
    
    for n=J0+n0:1:n1-J0
        
        b2n=0; %%%%%%-----
        
        for j=1:1:l-1
            b2n(1:2*J0+1,j)=Rohsignal(n-J0:n+J0,KanalNr(j)); %b2n
        end
        b2n=b2n(:);
        
        Ri=b2n*b2n';                              %R
        R=R+Ri;
        Pi=b2n*b(n);
        P=P+Pi;                                    %P
    end
    
    m=n1-n0-2*J0+1;
    R=R/m;
    P=P/m;
    R=inv(R);
    q=R*P;                                          %q=R*P
    
    for n=J0+1:1:k-J0
        b2n=0;
        for j=1:1:l-1
            b2n(1:2*J0+1,j)=Rohsignal(n-J0:n+J0,KanalNr(j));
        end
        
        b2n=b2n(:);
        s(n,i)=q'*b2n;
        a(n,i)=b(n)-s(n,i);
    end
    KanalNr=ID;
end

for i=1:1:l
    PP=zeros(k,l);
    PP(J0+1:k-J0,i)=a(J0+1:k-J0,i);
    gefiltsignal(:,KanalNr(i))=PP(:,i);
end

%%Step 2:

for i=1:1:l  %
    x=gefiltsignal(:,KanalNr(i));
    KanalNr(i)=[];
    
    for n=J0+1:1:k-J0
        x2n=0;
        for j=1:1:l-1
            x2n(1:2*J0+1,j)=gefiltsignal(n-J0:n+J0,KanalNr(j));
        end
        
        x2n=x2n(:);
        s1(n,i)=q'*x2n;
        a1(n,i)=x(n)-s1(n,i);
    end
    KanalNr=ID;
end
%

PP1=zeros(k,l);
PP1(J0+1:k-J0,1:l)=a1(J0+1:k-J0,1:l);

for i=1:1:l
    filtersig(:,KanalNr(i))=PP1(:,i);
end
end


