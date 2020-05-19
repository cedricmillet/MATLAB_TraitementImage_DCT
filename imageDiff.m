function [diff] = imageDiff(image1,image2)
    diff = imsubtract(abs(double(image1)), abs(double(image2)));
end

