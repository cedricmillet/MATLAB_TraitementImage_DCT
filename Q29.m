% Config
precision = 32;          % Largeur des sous images
coeffCompression = 15;    % Coef
useFFT2 = 1;

img = imread('milo.tif');
compressedImg = img;

% TRAITEMENT
[hauteur, largeur, canaux] = size(img);
for y=1:precision:largeur
    for x=1:precision:hauteur
        for c=1:1:canaux
            % block position
            x_start = x;
            x_end = x+precision-1;
            y_start = y;
            y_end = y+precision-1;
            % get troncatured block && update compressedImg(512,512)
            compressedImg(x_start:x_end, y_start:y_end, c) = troncatureBlock(img(:,:,c), x, y, precision, coeffCompression, useFFT2);
        end
    end
end

% AFFICHAGE
subplot(1,3,1);
imshow(img);
title(["Q 2.9", "Image originale"], 'FontSize', 10);

subplot(1,3,2);
imshow(compressedImg);
title(["Q 2.9", "Image compresée"], 'FontSize', 10);

subplot(1,3,3);
diff = imageDiff(img, compressedImg);
imshow(diff);
title(["Q 2.9", "Erreur"], 'FontSize', 10);

