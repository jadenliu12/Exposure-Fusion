function [output, scaledLaplacian] = laplacianFiltering(input, laplacianMask, scale)

    scaledLaplacian = scale * spatialFiltering(input, laplacianMask);

    output = input + scaledLaplacian;
end