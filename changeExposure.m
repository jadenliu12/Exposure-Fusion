function [outputImage] = changeExposure(inputImage, k, g)
    A = im2double(inputImage);
    tmp = A * (k ^ (1 / g));
    outputImage = im2uint8(tmp);
end