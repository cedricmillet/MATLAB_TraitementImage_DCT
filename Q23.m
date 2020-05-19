% ============ Q2.3 ============ 

%On fixe nSub à 8
subImageWidth = 8;
subImageHeight = 8;

img = rgb2gray(imread('mandril_color.tif'));
%imwrite(uint8(imcrop(img,[1 1 8 8])), 'bloc_1.tif')
[hauteur, largeur, nbCanaux] = size(img);
imagettes = uint8( zeros(subImageWidth,subImageHeight,4096) );

% Decomposition en sous images
i = 1;
for y=0: subImageHeight :hauteur-1
    for x=0 : subImageWidth : largeur-1
        fprintf('IMG=%d - pos (X=%d, Y=%d, largeur=%d)\n',i, x+1, y+1, subImageWidth);
        % Extraction du bloc à la liste
        imagettes(:,:,i) = imcrop(img,[x+1 y+1 (subImageWidth-1) (subImageHeight-1)]);
        % Increment for debug
        i = i + 1;
    end
end

fprintf('Decoupage terminé, nbre imagettes = %d\n',i-1);
