clc;
close all;
clear all;

x1= 9.488;
n1 = 1;
x2= 9.5;
n2 = 4;
x3= 9.503;
n3 = 9;
x4 = 9.505;
n4 = 21;
x5= 9.507;
n5 = 26;
x6 = 9.51;
n6 = 54;
x7 = 9.12;
n7 = 85;
x8= 9.515;
n8 = 81;
x9= 9.517;
n9 = 137;
x10 = 9.519;
n10 = 141;
x11 = 9.522;
n11 = 147;
x12 = 9.524;
n12 = 134;
x13 = 9.527;
n13 = 90;
x14 = 9.529;
n14 = 57;
x15 = 9.531;
n15 = 56;
x16 = 9.534;
n16 = 33;
x17 = 9.536;
n17 = 20;
x18 = 9.538;
n18 = 9;
x19 = 9.541;
n19 = 3;
x20 = 9.543;
n20 = 1;

X = [x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18];
N = [n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 n17 n18];

for i=1:1:16
   s(i)=X(1,i)*N(1,i);
end

N_sum = sum(N);
S_sum = sum(s);
srednia = S_sum/N_sum;

for j=1:1:16
    t(j) = X(1,j)-srednia;
    T(j) = t(j)*N(1,j);
end
P=T.^2;
P_sum = sum(P);
odch_std = sqrt(P_sum/(N_sum-1))
