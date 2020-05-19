% Passage de l'image en niveaux de gris
img = imread('milo.tif');
imgNB = rgb2gray(img);

subplot(2,1,1);
imshow(img);
title("Q2.2 | image originale", 'FontSize', 10);
colormap('gray');


subplot(2,1,2);
imshow(imgNB);
title("Q2.2 | Image en noir et blanc", 'FontSize', 10);
colormap('gray');
