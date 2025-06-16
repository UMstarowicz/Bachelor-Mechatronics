clear all;
clc;

load Odksztalcenia1.mat;
load Odksztalcenie2.mat;

g=9.81;
ma=0.418;
mb=0.497;
mc=0.6;
md=0.64;
me=0.916;
mf=1.08;
mg=1.109;
mh=1.578;
mi=2.102;
mj=2.595;
ml=3.014;
mk=3.542;
mm=3.96;
mn=4.161;
mo=4.2;
mp=4.895;
mr=5.313;
mt=5.504;
mw=6.076;
mq=6.689;

M =[ma mb mc md me mf mg mh mi mj ml mk mm mn mo mp mr mt mw mq];

%% Ciężar
for i=1:1:20
    F(i)=M(1,i)*g;
    na(i) = F(i)/0.0016;
    nb(i) = F(i)/0.0016;
    nc(i) = F(i)/0.0016;
    nd(i) = F(i)/0.0016;
end

for j=1:1:17
    F(j)=M(1,j)*g;
    ne(j) = F(j)/0.0049;
    nf(j) = F(j)/0.0049;
    ng(j) = F(j)/0.0049;
end
%% 

Zmiana1 = Odksztalcenia1(1,:)/38.42;
Zmiana2 = Odksztalcenia1(2,:)/38.25;
Zmiana3 = Odksztalcenia1(3,:)/38.95;
Zmiana4 = Odksztalcenia1(4,:)/38.55;
Zmiana5 = Odksztalcenia2(1,:)/30.29;
Zmiana6 = Odksztalcenia2(2,:)/30.25;
Zmiana7 = Odksztalcenia2(3,:)/28.45;

Young1 = na(1,:)./Zmiana1(1,:);
Young2 = nb(1,:)./Zmiana2(1,:);
Young3 = nc(1,:)./Zmiana3(1,:);
Young4 = nd(1,:)./Zmiana4(1,:);
Young5 = ne(1,:)./Zmiana5(1,:);
Young6 = nf(1,:)./Zmiana6(1,:);
Young7 = ng(1,:)./Zmiana7(1,:);

Y = [91581.1875000000	103208.397554348	116493.750000000	116671.603053435	148810.859693878	166398.169354839	163483.157986111	225656.066991018	288496.102370690	340504.190418956	378831.543750000	436016.890786082	484972.442307692	501867.430397727];
K = [299388.937500000	326307.679687500	132538.142523364	128195.084745763	178930.143595041	197882.529069767	194165.106250000	272244.953923358	360020.335597826	444458.977581522	456659.037259615	529864.565268987	553836.900887574	506954.979220361];
a=mean(Young1)
b=mean(Young2)
c=mean(Y)
d=mean(K)
e=mean(Young5)
f=mean(Young6)
g=mean(Young7)

subplot(4,2,1)
plot(na, Odksztalcenia1(1,:))
subplot(4,2,2)
plot(nb, Odksztalcenia1(2,:))
subplot(4,2,3)
plot(nc, Odksztalcenia1(3,:))
subplot(4,2,4)
plot(nd, Odksztalcenia1(4,:))
subplot(4,2,5)
plot(ne, Odksztalcenia2(1,:))
subplot(4,2,6)
plot(nf, Odksztalcenia2(2,:))
subplot(4,2,7)
plot(ng, Odksztalcenia2(3,:))