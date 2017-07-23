function[]= Plotzeigen(Rohsignal,Idealsignal,Gefiltsignal,K)
 figure,
    plot(Rohsignal(:,K),'b'); hold on,
    plot(Idealsignal(:,K),'r');hold on,
    plot(Gefiltsignal(:,K),'g');
    legend('Rohsignal','Idealsignal','Gefiltsignal');
end
 