% permet de troncaturer un bloc dans une image pour une matrice de
% quantification donnée
function [compressedBlock] = troncatureBlockMat(sourceImage, posX, posY, blockWidth, matriceQuantification)
    % Block position
    x_start = posX;
    x_end = posX+blockWidth-1;
    y_start = posY;
    y_end = posY+blockWidth-1;
    
    
    [l,h] = size(matriceQuantification);
    if(blockWidth ~= l)
        error('!!!!!!!!!!!!!!!!! [ERREUR] - La matrice de quantification fournit ne dispose pas de la meme largeur que les sous-images.');
    end  
 
    %fprintf('TRONCATURE AVEC MATRICE DU BLOCK - pos (X=%d-%d, Y=%d-%d, largeur=%d)\n', x_start,x_end,y_start,y_end, blockWidth);
    imagette = dct2(sourceImage(x_start:x_end,y_start:y_end));
    % Transformation en matrice 8x8
    mat_origin = col2im(imagette(:), [1 1], [blockWidth blockWidth]);
    % update final Image
    compressedBlock = idct2(floor(mat_origin.*matriceQuantification));
end

