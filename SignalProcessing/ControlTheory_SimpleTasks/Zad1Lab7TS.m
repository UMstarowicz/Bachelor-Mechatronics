clear all;
close all;
clc;
addpath Plants\

T = [0:0.1:100]; 
goalResult = ObjectForIdentification_4P_01(T,1);

figure; 
plot(T, goalResult)

figure;
for i= 1:1:25
RandomObject = tf(1,[randn(),randn()]); 
subplot(5,5,i)
step(RandomObject,T)
end

%od ilości minimów; 