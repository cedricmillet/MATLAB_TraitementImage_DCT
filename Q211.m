% Config
precision = 8;          % Largeur des sous images

% contruction de la matrice de quantification
vec_quantification = [16 11 10 16 24 40 51 61 12 12 14 19 26 58 60 55 14 13 16 24 40 57 69 56 14 17 22 29 51 87 80 62 18 22 37 56 68 109 103 77 24 35 55 64 81 104 113 92 49 64 78 87 103 121 120 101 72 92 95 98 112 100 103 99];
mat_quantification = (col2im(vec_quantification, [1 1], [8 8]).'); % transformation en matrice 8x8 puis symétrie par transposée





img = imread('mandril_color.tif');
compressedImg = img;

% TRAITEMENT
[hauteur, largeur, canaux] = size(img);
idebug = 0;
for y=1:precision:largeur
    for x=1:precision:hauteur
        for c=1:1:canaux
            % block position
            x_start = x;
            x_end = x+precision-1;
            y_start = y;
            y_end = y+precision-1;
            % get troncatured block && update compressedImg(512,512)
            compressedImg(x_start:x_end, y_start:y_end, c) = troncatureBlockMat(img(:,:,c), x, y, precision, mat_quantification);
            % debug
            if(mod(idebug,100) == 0)
                fprintf('Traitement %f/100 \n', idebug/((largeur/precision*hauteur/precision)*3)*100 );
            end
            idebug = idebug + 1;
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

