clear all;
clc;

% litery F oraz T

F = load('StudentData/FeaturesF');
T = load('StudentData/FeaturesT');

figure;
for k = 1:300
 plot(F.Data(k).Normal.Moments.N11,F.Data(k).Normal.HuInvariants.I1,('.r')); hold on
 plot(T.Data(k).Normal.Moments.N11,T.Data(k).Normal.HuInvariants.I1,('.b')); hold on 
end

% M11 Area
% I0 M30
% I2 M11
% M11 Eccentricity/Solidity/Cicularity
% N11 I1


xlabel('Area');
ylabel('Orientation');
legend('F','T');
