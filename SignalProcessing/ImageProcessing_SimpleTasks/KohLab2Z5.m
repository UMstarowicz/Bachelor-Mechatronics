clc;

imfinfo('rice.png.jpg')
A=imread('rice.png.jpg');
B=rgb2gray(A);
T = 0.5;
D = medfilt2(B, [8 8]);
C = im2bw(D,T);
figure(1)
imhist(B)
figure(2)
subplot(121)
imshow(A)
subplot(122)
imshow(C)

se = strel('disk',15);
background = imopen(A,se);

figure(4)
imshow(C)
[L,n]=bwlabel(C,4);
feats=regionprops(L,'all');
Array = [feats.Orientation]; 
%Array = find (Array1 > 0.94);
Min = min(Array); 
Max = max(Array); 
Mean = mean(Array); 
Std = std(Array); 
figure('Name', 'histogram for orientation'), hist(Array, 20); 
idx = find(Array< (Mean-Std)); 
L2 = ismember(L, idx); 
L2 = 1.*L2; 
figure('Name', 'Objects below mean-std: orientation'), imshow(L2); 
idx = find(Array > (Mean+Std)); 
L2 = ismember(L, idx); 
L2 = 1.*L2; 
figure('Name', 'Objects above mean+std: orientation'), imshow(L2); 
idx = find((Array < (Mean+Std)) & (Array > (Mean-Std))); 
L2 = ismember(L, idx); 
L2 = 1.*L2; 
figure( 'Name', 'Objects between mean-std and mean+std: orientation'), imshow(L2);