function [P,r,Fr,Yr]=DFA(t,x1,n)

% wejścia
% t wektor czasu
% x przebieg czasowy
% n wektor zawierający długości segmentów na które przebieg zostanie
% podzielony (muszą być wspólnymi wielokrotnościami długości szeregu czasowego)

% wyjścia
% P - nachylenie funkcji log(n)-log(Fn)
% r - wektor log(n)  
% Fr - wektor log(Fn) [błąd średniokwadratowego]
% yf - aproximacjia wielomianu pierwszego rzędu log(n)-log(Fn)

% Przykład wykorzystania:

% t=linspace(0,1,10000);
% x=rand(10000,1);
% n=[10,20,40,50,100,200,400,500,1000];
% [P,r,Fr,Yr]=DFA(t,x,n);
%figure(1)
%plot(r,Fr,'.')
%hold on
%plot(r,Yr)
%hold off

L=length(x1);   %długosć szeregu czasowego
x1=x1-mean(x1); %szereg czasowy - średnia
y1=cumsum(x1);  %skumulowany szereg czasowy

for si=1:length(n) %podzielenie szregu czasowego na segmenty o różnych długoścach
k=0;
j=1;

for i=1:L
    k=k+1;

    H(j,k)=y1(i);
    T(j,k)=t(i);

    if k==n(si)
        j=j+1;
        k=0;
    end
end

for i=1:size(H,1)
    P(i,:)=polyfit(T(i,:),H(i,:),1);
end

for i=1:size(H,1)
    HR(i,:)=polyval(P(i,:),T(i,:));
end

Fn(si)=sqrt(sum(sum((H-HR).^2))/L);
clear H
clear HR
clear P
clear T
end

r=log(n);   
Fr=log(Fn); % błąd średniokwadratowy (skala logarytmiczna)

pf=polyfit(r,Fr,1);
Yr=polyval(pf,r); % Aproximacja
P=pf(1); 

end