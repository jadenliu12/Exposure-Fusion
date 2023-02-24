function C = obtain_Constrast(input)
    % obtain the gray image of the rgb image and get the Laplacian filter response
    
    gray = rgb2gray(input);
    
    scale = 1;
    laplacianMask = [0,1,0;1,-4,1;0,1,0];

%     C = abs(imfilter(input,laplacianMask,'replicate'));
    
    [~, scaledLaplacian] = laplacianFiltering(gray, laplacianMask, scale);
    C = scaledLaplacian;
end