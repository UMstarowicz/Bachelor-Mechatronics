close all;
clear all;
clc;

imfinfo('ObrazZ4.png')
A=imread('ObrazZ4.png');
B=rgb2gray(A);

figure(1)
imhist(B)
T = 0.79;
C = im2bw(B,T);
im_bw = not(C);
figure(2)
imshow(im_bw)
hold on

[L,num]=bwlabel(im_bw,4);
feats=regionprops(L,'all');

for i=1:num
    centroids = cat(1, feats.Centroid);
    form_factor(i)=cat(1,(4*pi*feats(i).Area)/(feats(i).Perimeter*feats(i).Perimeter));
    roundness(i)=cat(1,(4*feats(i).Area)/(pi*feats(i).MajorAxisLength*feats(i).MajorAxisLength));
    aspect_ratio(i)=cat(1,feats(i).MajorAxisLength/feats(i).MinorAxisLength);
    solidity(i)=cat(1,feats(i).Area/feats(i).ConvexArea);
    compactness(i)=cat(1,(sqrt(4*(feats(i).Area/pi))/feats(i).MajorAxisLength));
    plot(centroids(:,1), centroids(:,2), 'b*')
 
end
for k=1:length(feats)
 x=feats(k).Centroid(1,1);
 y=feats(k).Centroid(1,2);
 plot(x,y,'*')
end
hold off

E = bwconncomp(im_bw);
L = labelmatrix(E);

figure(3)
F=find([roundness] <= 0.3);
G = ismember(L, F);
imshow(G)
hold on

for k=1:length(feats)
 if roundness(k) <= 0.3
 rectangle('Position', feats(k).BoundingBox, 'EdgeColor','red');
 x=feats(k).Centroid(1,1);
 y=feats(k).Centroid(1,2);
 plot(x,y,'*')
 end
end
hold off