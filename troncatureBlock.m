function [compressedBlock] = troncatureBlock(sourceImage, posX, posY, blockWidth, coeffCompression, isFFT)
    % Block position
    x_start = posX;
    x_end = posX+blockWidth-1;
    y_start = posY;
    y_end = posY+blockWidth-1;
    %fprintf('TRONCATURE DU BLOCK - pos (X=%d-%d, Y=%d-%d, largeur=%d)\n', x_start,x_end,y_start,y_end, blockWidth);
    if(isFFT == 1)
        imagette = fft2(sourceImage(x_start:x_end,y_start:y_end));
    else
        imagette = dct2(sourceImage(x_start:x_end,y_start:y_end));
    end
    vec_imagette = imagette(:);
    % Trie des valeurs absolues du block
    [~, vect_pos] = sort(log(abs(imagette(:))));
    % On créé le vecteur (1...1) de taille 8x8 et
    % on annulera ensuite tous les termes situés aux positions 64-Q
    vect_dim = ones(1,blockWidth*blockWidth);
    for p=1:1: length( vec_imagette(vect_pos) )-coeffCompression
        index = vect_pos(p,1);
        vect_dim(:, index) = 0;
    end
    %fprintf('coef gardés = %d / %d\n', i, length( imagette(:) ));
    % Transformation matricles lignes en matrice 8x8
    mat_origin = col2im(imagette(:), [1 1], [blockWidth blockWidth]);
    mat_dim = col2im(vect_dim, [1 1], [blockWidth blockWidth]);
    % update final Image
    if(isFFT == 1)
        compressedBlock = ifft2(mat_origin.*mat_dim);
    else
        compressedBlock = idct2(mat_origin.*mat_dim);
    end
    %output = sourceImage(1:8,1:8);
    %output = block;
end

