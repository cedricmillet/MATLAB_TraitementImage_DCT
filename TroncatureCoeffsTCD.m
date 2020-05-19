clear all;

% config
precision = 8;              % Largeur des sous images
coeffCompression = 8;       % Coef
img = imread('mandril_color.tif');
% save current block
imagette = dct2(img(1:8,1:8));
% matrice -> colonne
vect = imagette(:);
% Trie des valeurs absolues
[elems, vect_pos] = sort(abs(vect));
% On créé le vecteur (1...1) de taille 8x8 et
% on annulera ensuite tous les termes situés aux positions 64-Q
vect_dim = ones(1,precision*precision);
for p=1:1:length(vect)-coeffCompression
    vect_dim(:, vect_pos(p,1)) = 0;
end
% Transformation matrices lignes en matrice 8x8
mat_origin = col2im(vect, [1 1], [precision precision]);
mat_dim = col2im(vect_dim, [1 1], [precision precision]);
% update final Image
compressedBlock(1:8, 1:8) = idct2(mat_origin.*mat_dim);

        
        
        
% AFFICHAGE
subplot(1,4,1);
imshow(img(1:8,1:8));
title(["", "Bloc original"], 'FontSize', 10);

subplot(1,4,2);
imshow(imagette);
title(["", "DCT avant compression"], 'FontSize', 10);

subplot(1,4,3);
imshow(mat_origin.*mat_dim);
title(["", "DCT apres compression"], 'FontSize', 10);

subplot(1,4,4);
imshow(uint8(compressedBlock));
title(["", "Image compressée "], 'FontSize', 10);


