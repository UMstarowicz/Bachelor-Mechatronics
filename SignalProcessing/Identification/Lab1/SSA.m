function [Sh,Y,RC]=SSA(x,L)

% wejścia
% x przebieg czasowy
% L liczba opóżnionych wektorów (dobór użytkownika)

% wyjścia
% Sh - zdekomponowany szeregów czasowych analizowanego szeregu czasowego
% Y - Macierz Trajectorii
% RC - Macierzy Elementarny

% Przykład wykorzystania:

% N = 1000;
%t=linspace(0,200,N);
%trend= 0.0025*(t-100).^2;
%p1=20; 
%p2=5;
%periodic1=2*sin(2*pi*t/p1);
%periodic2=0.75*sin(2*pi*t/p2);
%noise= 0.75*(rand(1,N)-0.5);
%x = trend + periodic1 + periodic2 + noise;
%[Sh,Y,RC]=SSA(x,70)
%plot(t,F,LineWidth=1.5)
%hold on
%for i=1:4
%plot(t,Sh(:,i))
%end
%hold off
%xlabel('Time [s]',Interpreter='latex', FontSize=14)
%ylabel('Signal Amplitude',Interpreter='latex', FontSize=14)
%grid on
%legend('Signal','Trend','Periodicity 1','Periodicity 2','Noise',Interpreter='latex', FontSize=14)

N=length(x);
Y=zeros(L,N-L+1);

for l=1:L
  Y(l,:) = x((1:N-L+1)+l-1);
end

[U,S,V]=svd(Y);
LAMBDA=diag(S);   
V=V';

for i=1:length(LAMBDA)
    PC(:,:,i)=LAMBDA(i)*U(:,i)*V(i,:);
end

RC(:,:,1)=PC(:,:,1);
RC(:,:,2)=PC(:,:,2)+PC(:,:,3);
RC(:,:,3)=PC(:,:,4)+PC(:,:,5);
RC(:,:,4)=0;

for i=6:size(PC,3)
    RC(:,:,4)=RC(:,:,4)+PC(:,:,i);
end

for j=1:4
    H(:,:,j)=flip(RC(:,:,j));
end

ip=-L+1:N-L;

for l=1:4
    for i=1:length(ip)
        Sh(i,l)=mean(diag(H(:,:,l),ip(i)));
    end
end

end