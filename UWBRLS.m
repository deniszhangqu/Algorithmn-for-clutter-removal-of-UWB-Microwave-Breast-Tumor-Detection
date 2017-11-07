function [filtersig]=UWBRLS(Rohsignal,KanalNr)

lamda=0.5;
l=size(KanalNr,2);
k=size(Rohsignal,1);

KanalNr1=KanalNr;
for i=1:1:l
    d(:,1)=Rohsignal(:,KanalNr(i));
    d=d';
    KanalNr1(i)=[];
    
    for j=1:1:k
        u(j,:)=Rohsignal(1,KanalNr1);
    end
    u=u';
    for n=1:1:k
        F(l-1,l-1)=0;z(l-1,1)=0;
        for m=1:1:n
            F(:,:)=(lamda.^(n-m))*u(:,m)*u(:,m)'+F;
            z(:,1)=(lamda.^(n-m))*u(:,m)*d(m)+z;
        end
        w(:,1)=inv(F)*z;
        d_g(n)=w'*u(:,n);
    end
    filtersig(:,KanalNr(i))=d_g(:)';
    KanalNr1=KanalNr;
end

end