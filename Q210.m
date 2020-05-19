% Config
precision = 32;          % Largeur des sous images
coeffCompression = 3;    % Coef
useFFT2 = 1;

imgRGB = imread('mandril_color.tif');
img = rgb2ycbcr( imgRGB ); % https://fr.mathworks.com/help/images/ref/rgb2ycbcr.html
compressedImg = img;

% TRAITEMENT
[hauteur, largeur, canaux] = size(img);
i = 0;
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
            % debug
            if(mod(idebug,3) == 0)
                fprintf('Traitement : %f / 100 \n', i/((largeur/precision*hauteur/precision)*3)*100 );
            end
            i = i + 1;
        end
    end
end

% AFFICHAGE
subplot(2,2,1);
imshow(imgRGB);
title(["Q 2.10", "Image originale (RGB)"], 'FontSize', 10);

subplot(2,2,2);
imshow(img);
title(["Q 2.10", "Image originale (YCbCr)"], 'FontSize', 10);

subplot(2,2,3);
imshow(compressedImg);
title(["Q 2.10", "Image compressée"], 'FontSize', 10);

subplot(2,2,4);
imagesc(imageDiff(img, compressedImg));
title(["Q 2.10", "Erreur"], 'FontSize', 10);

