clc;
clear all;
close all;

info = imfinfo('ObrazZ1.png');

A = imread('ObrazZ1.png');
im_size = size(A);
A=rgb2gray(A);

hist = imhist(A);

E = imnoise(A, 'salt & pepper');

B = medfilt2(E, [8 8]);

hist2 = imhist(B);

T = 0.79;
C = im2bw(B,T);

D = not(C);

[num, L] = bwlabel(D);
feats = regionprops(D, 'all');

for i=1:num
    centroids = cat(1, feats.Centroid);
    figure(1)
    imshow(D)
    hold on
    plot(centroids(:,1), centroids(:,2), 'b*')
    hold off
end

hold on
for k = 1:length(feats)
    x=feats(k).Centroid(1,1);
    y=feats(k).Centroid(1,2);
    figure(1)
    imshow(D)
    plot(x,y,'*')
    a1 = tan((feats(k).Orientation)*pi/180);
    b1 = y-a1*x;
    x1 = x-30;
    x2 = x+30;
    y1 = a1*x1+b1;
    y2 = a1*x2+b1;
    plot([x1 x2], [y1 y2], '-.b')
end
hold off

 figure(2)
subplot(121)
 imhist(A)
 subplot(122)
 imhist(B)

 figure(3)
 imshow(E)