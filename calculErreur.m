img = imread('mandril_gray.tif');
compressedImg = imread('q26_mandril_compressed.tif');       % image générée lors de l'execution de Q26.m
% calcul de l'erreur (difference source-compressedImg )
imErreur = abs(double(img)) - abs(double(compressedImg));


subplot(3,1,1);
colormap gray;
imagesc(img);
title(["Image originale"], 'FontSize', 10);

subplot(3,1,2);
colormap gray;
imagesc(compressedImg);
title(["Image compressée"], 'FontSize', 10);

subplot(3,1,3);
colormap gray;
imagesc(imErreur);
title(["Erreur"], 'FontSize', 10);