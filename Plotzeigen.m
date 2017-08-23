function[]= Plotzeigen(Rohsignal,Idealsignal,Gefiltsignal,K)
 figure,
    plot(Rohsignal(1:150,K),'b'); hold on,
    plot(Idealsignal(1:150,K),'r');hold on,
    plot(Gefiltsignal(1:150,K),'g');
    legend('Rohsignal','Idealsignal','Gefiltsignal');
end
 