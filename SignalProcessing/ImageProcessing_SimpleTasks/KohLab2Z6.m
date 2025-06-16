clear all; close all; clc; 
A=imread('ObrazZ1.png');
B=rgb2gray(A);
oryginal = B; 
translacja = imtranslate(oryginal,[15, 25],'OutputView','full');
odbicie = flip(oryginal ,2);
rozmiar = imresize(oryginal,2);
rotacja45 = imrotate(oryginal, 45);
rotacja90 = imrotate(oryginal, 90);
figure(1); 
subplot(2,3,1); 
imshow(oryginal); 
title('Obraz oryginalny'); 
subplot(2,3,2); 
imshow(translacja); 
title('Obraz przesuniety'); 
subplot(2,3,3); 
imshow(odbicie); 
title('Odbicie lustrzane'); 
subplot(2,3,4); 
imshow(rozmiar); 
title('Obraz zmniejszony'); 
subplot(2,3,5); 
imshow(rotacja45); 
title('Obraz po rotacji o 45deg'); 
subplot(2,3,6); 
imshow(rotacja90); 
title('Obraz po rotacji o 90deg'); 
phiorgyginal = abs(log(invmom(oryginal))); 
phiobrot = abs(log(invmom(translacja)));
phiodbicie = abs(log(invmom(odbicie))); 
phirozmiar = abs(log(invmom(rozmiar)));
phirotacja45 = abs(log(invmom(rotacja45))); 
phirotacja90 = abs(log(invmom(rotacja90))); 
E = medfilt2(A, [8 8]);

T = 0.5;
C = im2bw(E,T);

D = not(C);
figure(2)
imshow(D)
[L,n]=bwlabel(D,4);
feats=regionprops(L,'all');
% Współczynnik Malinowskiej
for i=1:n
 Ob=feats(i).Perimeter;
 S=feats(i).Area;
 WM(1,i)=(Ob/(2*((pi*S)^(0.5))))-1;
end
WM
% Współczynnik cyrkularności 1 - WC1
for i=1:n
 Pole = feats(i).Area;
 WC1(1,i) = 2*(sqrt(Pole/pi));
end
WC1
% Współczynnik cyrkularności 2 - WC2
for i=1:n
 Ob = feats(i).Perimeter;
 WC2(1,i) = Ob/pi;
end
WC2
% Współczynnik Fereta
for i=1:n
 Dh = feats(i).BoundingBox(3);
 Dv = feats(i).BoundingBox(4);
 WF(1,i) = Dh/Dv;
end
WF