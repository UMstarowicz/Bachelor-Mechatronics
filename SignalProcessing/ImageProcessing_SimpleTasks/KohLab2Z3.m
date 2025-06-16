clc;
clear all;
close all;

info = imfinfo('ObrazZ3pop.png');

A = imread('ObrazZ3pop.png');
im_size = size(A);
A=rgb2gray(A);

hist = imhist(A);

E = imnoise(A, 'salt & pepper');

B = medfilt2(E, [8 8]);

figure(1)
imhist(B);

fil=(A>=40) & (A<=45);

T = 0.79;
C = im2bw(fil,T);

D = not(C);

figure(2)
imshow(D)

[num, L] = bwlabel(D);
feats = regionprops(D, 'all');