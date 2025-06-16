clear all;
clc;

% litery F oraz T

F = load('StudentData/FeaturesF');
T = load('StudentData/FeaturesT');

figure('Name','Litery F')
for i=1:80
    subplot(10,8,i)
    imshow(F.Data(i).Normal.Image)
end

figure('Name','Litery T')
for i=1:80
    subplot(10,8,i)
    imshow(T.Data(i).Normal.Image)
end