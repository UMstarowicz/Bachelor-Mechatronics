clearvars; clc; close all;

a=0.075;
b=0.18;
c=0.315;
r1=0.12;
r2=0.3;
D1 = 2*r1;
D2 = 2*r2;
f1t=-4300;
f1r=-1200;
f2t=-1720;
f2r=-1100;
n = 500;
L10h = 50000;
ft = 1;
fd = 1.4;
E = 210*1e3;
ro = 0.00785;  %g/mm3
Rm = 500;
Re = 280;
Zgo = 220;
Zso = 130;

%Wyliczenie sił reakcji w płaszczyźnie x-z
ha=0;
Vcz=-(c*f2t + a*f1r)/(a+b); %z sumy momentów od punktu a
Vaz =-f1r-f2t-Vcz; % z sumy sil po z

%Wyliczenie sił reakcji w płaszczyźnie x-y
ha=0;
Vcy=-(c*f2r + a*f1t)/(a+b);
Vay= -f1t-f2r-Vcy;

%Wyliczenie wartości całkowitej sił
Va=(Vaz^2+Vay^2)^(1/2);
Vc=(Vcz^2+Vcy^2)^(1/2);

%Wykresy sił tnących
x=0:0.001:c;
%Wykres x-z
for i=1:1:length(x)
    if i<=a*1000
        tz(i)=-Vaz;
    else if i >a*1000
            if i<(a+b)*1000
            tz(i)=-Vaz-f1r;
            else 
            tz(i)=-Vaz-f1r-Vcz;
            end
        end
    end
end
figure(1);plot(x,tz)
title('Sila tnąca w płaszczyźnie x-z')
xlabel('Odległość od początku wału [m]')
ylabel('Siła [N]')
xlim([0 c])

%wykres x-y
for i=1:1:length(x)
    if i<=a*1000
        ty(i)=-Vay;
    else if i >a*1000
            if i<(a+b)*1000
            ty(i)=-Vay-f1t;
            else 
            ty(i)=-Vay-f1t-Vcy;
            end
    end
    end
end
figure(2);plot(x,ty);
title('Sila tnąca w płaszczyźnie x-y')
xlabel('Odległość od początku wału [m]')
ylabel('Siła [N]')
xlim([0 c])

%wykresy momentów zginających
for i=1:1:length(x)
    if i<=a*1000
            mgy(i)=x(i)*-Vay;
        else if i >a*1000
                if i<(a+b)*1000
                mgy(i)=x(i)*-Vay-(x(i)-a)*f1t;
                else 
                mgy(i)=x(i)*-Vay-(x(i)-a)*f1t-(x(i)-(a+b))*Vcy;
                end
        end
    end
end
figure(3)
plot(x,mgy)
title('Moment zginający y')
xlabel('Odległość od początku wału [m]')
ylabel('Moment zginający [Nm]')
xlim([0 c])
for i=1:1:length(x)
    if i<=a*1000
            mgz(i)=x(i)*-Vaz;
        else if i >a*1000
                if i<(a+b)*1000
                mgz(i)=x(i)*-Vaz-(x(i)-a)*f1r;
                else 
                mgz(i)=x(i)*-Vaz-(x(i)-a)*f1r-(x(i)-(a+b))*Vcz;
                end
        end
    end
end
figure(4)
plot(x,mgz)
title('Moment zginający z')
xlabel('Odległość od początku wału [m]')
ylabel('Moment zginający [Nm]')
xlim([0 c])

%Moment zginający połączony
mg=sqrt(mgz.^2+mgy.^2);

figure(5)
plot(x,mg)
title('Moment zginający')
xlabel('Odległość od początku wału [m]')
ylabel('Moment zginający [Nm]')
xlim([0 c])

%moment skręcający
for i=1:1:length(x)
    if i<=a*1000
            ms(i)=0;
        else if i >a*1000
                ms(i)=-f1t*r1;                  

        end
    end
end

figure(6)
plot(x,ms)
title('Moment skręcający')
xlabel('Odległość od początku wału [m]')
ylabel('Moment skręcający [Nm]')
xlim([0 c])

%moment zredukowany z hmh
for i=1:1:length(x)              
     mzr(i)=sqrt(mg(i)^2 + 3/4*(ms(i)^2));            
end
figure(7)
plot(x,mzr)
title('Moment zredukowany')
xlabel('Odległość od początku wału [m]')
ylabel('Moment zredukowany [Nm]')
xlim([0 c])

%średnice wałów
o=55e6;
for i=1:a*1000
mzr11(i)=mzr(i);
end
for i=a*1000+1:(a+b)*1000
mzr12(i)=mzr(i);
end
for i=(a+b)*1000:c*1000+1
mzr13(i)=mzr(i);
end

da1=(32*max(mzr11)/(pi*o))^(1/3); % min d na odcinku A1
d12=(32*max(mzr12)/(pi*o))^(1/3); % min d na odcinku 12
d23=(32*max(mzr13)/(pi*o))^(1/3); % min d na odcinku 23


for i=1:a*1000
    d(i) = da1;
end
for i = a*1000+1:(a+b)*1000
    d(i) = d12;
end
for i = (a+b)*1000+1:c*1000+1
    d(i) = d23;
end

figure(8)
plot(x,d); hold on;
plot(x,-d); hold off;
title('Minimalna Średnica wału teoretyczna')
xlabel('Odległość od początku wału [m]')
ylabel('Średnica wału [m]')
xlim([0 c])
f = 1.5*max(d);
ylim([-f f])


figure(9)
dr = 1.1*d;
plot(x,dr); hold on;
plot(x,-dr); hold off;
title('Minimalna Średnica wału praktyczna')
xlabel('Odległość od początku wału [m]')
ylabel('Średnica wału [m]')
xlim([0 c])
f = 1.5*max(d);
ylim([-f f])

%% Łożyska
L10 = 60*n*L10h/(1e6);
%Podpora A
C_A = nthroot(L10, 3) * Va * ft * fd;
%Podpora B
C_C = nthroot(L10, 3) * Vc * ft * fd;

%% Ugięcie
I0 = pi*35^4/64;
zero = zeros([1 316]);
amm = a*1e3;
bmm = b*1e3;
cmm = c*1e3;
xmm = x*1e3;

Dxy = -(f1t*(-amm^3)/6 + Vcy*(-amm-bmm)^3/6);
Cxy = -(Vay*(amm+bmm)^3/6 + f1t*(bmm^3)/6 + Dxy)/(amm+bmm);
Dxz = -(f2t*(-amm^3)/6 + Vcz*(-amm-bmm)^3/6);
Cxz = -(Vaz*(amm+bmm)^3/6 + f2t*(bmm^3)/6 + Dxz)/(amm+bmm);

s1 = -(1/(E*I0))*((1/6)*Vay*(amm).^3 + (1/6)*f2r*(amm-amm).^3 + (1/6)*Vcy*(amm-amm-bmm).^3 + (1/6)*f1t*(amm-cmm).^3 + Cxy*amm +Dxy);
s2 = -(1/(E*I0))*((1/6)*Vay*(cmm).^3 + (1/6)*f2r*(cmm-amm).^3 + (1/6)*Vcy*(cmm-amm-bmm).^3 + (1/6)*f1t*(cmm-cmm).^3 + Cxy*cmm +Dxy);
s3 = -(1/(E*I0))*((1/6)*Vaz*(cmm).^3 + (1/6)*f2t*(cmm-amm).^3 + (1/6)*Vcz*(cmm-amm-bmm).^3 + (1/6)*f1r*(cmm-cmm).^3 + Cxz*cmm +Dxz);
s4 = -(1/(E*I0))*((1/6)*Vaz*(amm).^3 + (1/6)*f2t*(amm-amm).^3 + (1/6)*Vcz*(amm-amm-bmm).^3 + (1/6)*f1r*(amm-cmm).^3 + Cxz*amm +Dxz);

s12 = sqrt(s1^2 + s2^2);
s34 = sqrt(s3^2 + s4^4);

Uxy = -(Vay*(xmm).^3/6 + f1t*((xmm-amm).^3)/6 + Vcy*(xmm-(amm+bmm)).^3/6 + Cxy*xmm + Dxy)/(E*I0);
Uxz = -(Vaz*(xmm).^3/6 + f1r*((xmm-amm).^3)/6 + Vcz*(xmm-(amm+bmm)).^3/6 + Cxz*xmm + Dxz)/(E*I0);
%% Kąt skręcenia
fi1 = -(1/(E*I0))*((1/2)*Vay*(amm).^2 + (1/2)*f2r*(amm-amm).^2 + (1/2)*Vcy*(amm-amm-bmm).^2 + (1/2)*f1t*(amm-cmm).^2 + Cxy);
fi2 = -(1/(E*I0))*((1/2)*Vay*(cmm).^2 + (1/2)*f2r*(cmm-amm).^2 + (1/2)*Vcy*(cmm-amm-bmm).^2 + (1/2)*f1t*(cmm-cmm).^2 + Cxy);
fi3 = -(1/(E*I0))*((1/2)*Vaz*(cmm).^2 + (1/2)*f2t*(cmm-amm).^2 + (1/2)*Vcz*(cmm-amm-bmm).^2 + (1/2)*f1r*(cmm-cmm).^2 + Cxz);
fi4 = -(1/(E*I0))*((1/2)*Vaz*(amm).^2 + (1/2)*f2t*(amm-amm).^2 + (1/2)*Vcz*(amm-amm-bmm).^2 + (1/2)*f1r*(amm-cmm).^2 + Cxz);
%% Pierwsza prędkość krytyczna
alfa1 = (((pi).^2)/(cmm-(amm+bmm)).^2)*sqrt((E*I0*cmm)/((ro*pi*da1*da1*cmm)*(1/4)));
obr = 30*sqrt(1/(s3*0.001));
obr1 = 30*sqrt(1/(-s4*0.001));
usz = obr/alfa1;
uszk = obr1/alfa1;
%% Wpusty
bw = 14;
lw = 36;
kt = 41;
kd = 97.5;
t2 = 3.8;
% srkęcenie 1 wpust
kts1 = 4*abs(f1t)/(bw*lw*1);
% docisk wał 1 wpust
kd1_1 = abs(f1t)/(t2*lw*1);
% docisk koło 1 wpust
kd1_2 = abs(f1t)/(t2*lw*1);
% srkęcenie 2 wpust
kts2 = 4*abs(f2t)/(bw*lw*1);
% docisk wał 2 wpust
kd2_1 = abs(f2t)/(t2*lw*1);
% docisk koło 2 wpust
kd2_2 = abs(f2t)/(t2*lw*1);
%% Zmęczeniówka
% d = 35 x = 55
Wg1 = pi*35^3/32;
Wo1 = pi*35^3/16;
AmpGna1 = mg(55)*1000/Wg1;
BetaRo1 = 1.85 + 1.1 - 1;
Epsilon1 = 0.85;

AmpSkr1 = ms(55)*1000/Wo1;
BetaTau1 = 1.4 + 1.05 - 1;

WBNapNor1 = Zgo*Epsilon1/(AmpGna1*BetaRo1);
WBNapSkr1 = Zso*Epsilon1/(AmpSkr1*BetaTau1);

% 1 Współczynnik
WB1 = WBNapSkr1*WBNapNor1/sqrt(WBNapNor1^2 + WBNapSkr1^2);

% d = 50 x = 75
b2 = 14;
t2 = t2;

Wg2 = pi*50^3/32 - b2*t2*(b2-t2)^2/(2*50);
Wo2 = pi*50^3/16;
AmpGna2 = mg(75)*1000/Wg2;
BetaRo2 = 1.75 + 1.1 - 1;
Epsilon2 = 0.825;

AmpSkr2 = ms(76)*1000/Wo2;
BetaTau2 = 1.5 + 1.05 - 1;

WBNapNor2 = Zgo*Epsilon2/(AmpGna2*BetaRo2);
WBNapSkr2 = Zso*Epsilon2/(AmpSkr2*BetaTau2);

% 2 Współczynnik
WB2 = WBNapSkr2*WBNapNor2/sqrt(WBNapNor2^2 + WBNapSkr2^2);

% d = 50 x = 241

Wg3 = pi*50^3/32;
Wo3 = pi*50^3/16;
AmpGna3 = mg(241)*1000/Wg3;
BetaRo3 = 1.85 + 1.1 - 1;
Epsilon3 = 0.825;

AmpSkr3 = ms(241)*1000/Wo3;
BetaTau3 = 1.4 + 1.05 - 1;

WBNapNor3 = Zgo*Epsilon3/(AmpGna3*BetaRo3);
WBNapSkr3 = Zso*Epsilon3/(AmpSkr3*BetaTau3);

% 3 Współczynnik
WB3 = WBNapSkr3*WBNapNor3/sqrt(WBNapNor3^2 + WBNapSkr3^2);

% d = 45 x = 279

Wg4 = pi*45^3/32;
Wo4 = pi*45^3/16;
AmpGna4 = mg(279)*1000/Wg4;
BetaRo4 = 1.85 + 1.1 - 1;
Epsilon4 = 0.8;

AmpSkr4 = ms(279)*1000/Wo4;
BetaTau4 = 1.4 + 1.05 - 1;

WBNapNor4 = Zgo*Epsilon4/(AmpGna4*BetaRo4);
WBNapSkr4 = Zso*Epsilon4/(AmpSkr4*BetaTau4);

% 4 Współczynnik
WB4 = WBNapSkr4*WBNapNor4/sqrt(WBNapNor4^2 + WBNapSkr4^2);

% d = 50 x = 75
b5 = 14;
t5 = t2;

Wg5 = pi*50^3/32 - b5*t5*(b5-t5)^2/(2*50);
Wo5 = pi*50^3/16;
AmpGna5 = mg(316)*1000/Wg5;
BetaRo5 = 1.75 + 1.1 - 1;
Epsilon5 = 0.825;

AmpSkr5 = ms(316)*1000/Wo5;
BetaTau5 = 1.5 + 1.05 - 1;

WBNapNor5 = Zgo*Epsilon5/(AmpGna5*BetaRo5);
WBNapSkr5 = Zso*Epsilon5/(AmpSkr5*BetaTau5);

% 5 Współczynnik
WB5 = WBNapSkr5*WBNapNor5/sqrt(WBNapNor5^2 + WBNapSkr5^2);

% close all