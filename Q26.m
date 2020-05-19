% Config
precision = 16;          % Largeur des sous images
coeffCompression = 3;    % Coef
useFFT2 = 0;             % On utilisera dct2() et idct2()

img = imread('mandril_gray.tif');
compressedImg = img;

% TRAITEMENT
[hauteur, largeur, nCanaux] = size(img);
for y=1:precision:largeur
    for x=1:precision:hauteur
        for canal=1:1:nCanaux % inutile si gray image => 1 seul canal
            % block position (x_start:x_end, y_start:y_end)
            x_start = x;
            x_end = x+precision-1;
            y_start = y;
            y_end = y+precision-1;
            % get troncatured block && update compressedImg(512,512)
            compressedImg(x_start:x_end, y_start:y_end,canal) = troncatureBlock(img(:,:,canal), x, y, precision, coeffCompression, useFFT2);
        end
    end
end

% AFFICHAGE
subplot(1,3,1);
imshow(img);
title(["", "Image originale"], 'FontSize', 10);

subplot(1,3,2);
imshow(uint8(compressedImg));
title(["", "Image compresée"], 'FontSize', 10);

subplot(1,3,3);
colormap gray;
imagesc(abs(double(img)) - abs(double(compressedImg)));
title(["", "Erreur"], 'FontSize', 10);

% Enregistrement fichier local pour la question suivante
imwrite(compressedImg,'q26_mandril_compressed.tif');
