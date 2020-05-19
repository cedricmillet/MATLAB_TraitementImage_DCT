% ============ Q2.4 ============ 
% Calcul de la TCD sur chacune des sous-images



fprintf('Decomposition en sous-images...\n');

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
        %fprintf('IMG=%d - pos (X=%d, Y=%d, largeur=%d)\n',i, x+1, y+1, subImageWidth);
        % Extraction du bloc à la liste
        imagettes(:,:,i) = imcrop(img,[x+1 y+1 (subImageWidth-1) (subImageHeight-1)]);
        % Increment for debug
        i = i + 1;
    end
end

fprintf('Reconstruction des sous-images && dct2...\n');
[hauteur, largeur, nbCanaux] = size(img);
finalImg = uint8( zeros(largeur,hauteur) );
finalTcd2 = uint8( zeros(largeur,hauteur) );
index = 1;
for y=0: subImageHeight :hauteur-1
    for x=0 : subImageWidth : largeur-1
        % Position (X;Y) du premier(start) et du dernier(end) pixel de ce bloc 8x8
        x_start = x+1;
        x_end = x+8;
        y_start = y+1;
        y_end = y+8;
        %fprintf('Reconstruction image...%d [X=%d,%d|Y=%d,%d]\n', i, x_start, x_end, y_start, y_end);        
        finalImg(y_start:y_end, x_start:x_end) = imagettes(:,:,index);
        finalTcd2(y_start:y_end, x_start:x_end) = dct2(imagettes(:,:,index));
        % Incrementer l'indexImagette (bloc 8x8)
        index = index+1;
    end
end

subplot(2,2,1);
imshow(img);
title({'Q 2.4','Image originale'}, 'FontSize', 8);

subplot(2,2,2);
imshow(finalImg);
title({'Q 2.4','Image découpée puis reconstitiée'}, 'FontSize', 8);

subplot(2,2,3);
imshow(dct2(finalTcd2));
title({'Q 2.4','DCT image reconstituée'}, 'FontSize', 8);
drawnow;

subplot(2,2,4);
imshow(finalTcd2);
title("DCT bloc par bloc", 'FontSize', 10);
drawnow;