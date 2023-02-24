clear;
close all;

%% input

% input = imread("Images/C.jpg"); % normal picture
% input = imread("Images/1.png"); % medium brightness picture
% input = imread("Images/Qcc9j.jpeg"); % medium brightness picture
% input = imread("Images/3.png"); % low brightness picture
% input = imread("Images/low-light-photography-1-of-1-2.jpeg"); % very low brightness picture
input = imread("Images/n19qZ.jpeg"); % very low brightness picture

% after reading image, we make sure that it is well lit first
enhanced_input = BIMEF(input);

[M, N, C] = size(enhanced_input);

%% variables
gamma = 0.5;
wc = 1;
ws = 1;
we = 1;

doubleUnderExposureK = 0.5;
underExposureK = 0.7;
overExposureK = 1.3;
doubleOverExposureK = 1.5;

%% change exposure
doubleUnderExposureImage = changeExposure(enhanced_input, doubleUnderExposureK, gamma);
underExposureImage = changeExposure(enhanced_input, underExposureK, gamma);
overExposureImage = changeExposure(enhanced_input, overExposureK, gamma);
doubleOverExposureImage = changeExposure(enhanced_input, doubleOverExposureK, gamma);
% figure("name", "exposure");
% subplot(2,2,1);imshow(doubleUnderExposureImage);title("double under exposure image");
% subplot(2,2,2);imshow(underExposureImage);title("under exposure image");
% subplot(2,2,3);imshow(enhanced_input);title("enhanced image");
% subplot(2,2,4);imshow(overExposureImage);title("over exposure image");

%% exposure fusion

enhanced_input = im2double(enhanced_input);
doubleUnderExposureImage = im2double(doubleUnderExposureImage);
underExposureImage = im2double(underExposureImage);
overExposureImage = im2double(overExposureImage);
doubleOverExposureImage = im2double(doubleOverExposureImage);

C_double_under = obtain_Constrast(doubleUnderExposureImage);
C_under = obtain_Constrast(underExposureImage);
C = obtain_Constrast(enhanced_input);
C_over = obtain_Constrast(overExposureImage);
C_double_over = obtain_Constrast(doubleOverExposureImage);

S_double_under = obtain_Saturation(doubleUnderExposureImage);
S_under = obtain_Saturation(underExposureImage);
S = obtain_Saturation(enhanced_input);
S_over = obtain_Saturation(overExposureImage);
S_double_over = obtain_Saturation(doubleOverExposureImage);

E_double_under = obtain_Exposedness(doubleUnderExposureImage);
E_under = obtain_Exposedness(underExposureImage);
E = obtain_Exposedness(enhanced_input);
E_over = obtain_Exposedness(overExposureImage);
E_double_over = obtain_Exposedness(doubleOverExposureImage);

W_double_under = compute_Weight(C_double_under, S_double_under, E_double_under, wc, ws, we);
W_under = compute_Weight(C_under, S_under, E_under, wc, ws, we);
W = compute_Weight(C, S, E, wc, ws, we);
W_over = compute_Weight(C_over, S_over, E_over, wc, ws, we);
W_double_over = compute_Weight(C_double_over, S_double_over, E_double_over, wc, ws, we);

[W_double_under, W_under, W, W_over, W_double_over] = weight_Blending(W_double_under, W_under, W, W_over, W_double_over);

%% smoothing
Wf(:,:,1) = W_double_under;
Wf(:,:,2) = W_under;
Wf(:,:,3) = W;
Wf(:,:,4) = W_over;
Wf(:,:,5) = W_double_over;

I(:,:,:,1) = doubleUnderExposureImage;
I(:,:,:,2) = underExposureImage;
I(:,:,:,3) = enhanced_input;
I(:,:,:,4) = overExposureImage;
I(:,:,:,5) = doubleOverExposureImage;

% create empty pyramid
pyr = gaussian_pyramid(zeros(M,N,3));
nlev = length(pyr);

% multiresolution blending
for i = 1:5
    % construct pyramid from each input image
	pyrW = gaussian_pyramid(Wf(:,:,i));
	pyrI = laplacian_pyramid(I(:,:,:,i));
    
    % blend
    for l = 1:nlev
        w = repmat(pyrW{l},[1 1 3]);
        pyr{l} = pyr{l} + w.*pyrI{l};
    end
end

% reconstruct
R = reconstruct_laplacian_pyramid(pyr);
% sharpenR = imsharpen(R);

%% show results
% figure("name", "contrast");
% subplot(1,3,1);imshow(C_under);title("contrast of under exposure image");
% subplot(1,3,2);imshow(C);title("contrast of input image");
% subplot(1,3,3);imshow(C_over);title("contrast of over exposure image");
% 
% figure("name", "saturation");
% subplot(1,3,1);imshow(S_under);title("well-exposedness of under exposure image");
% subplot(1,3,2);imshow(S);title("well-exposedness of input image");
% subplot(1,3,3);imshow(S_over);title("well-exposedness of over exposure image");
%  
% figure("name", "well-exposedness");
% subplot(1,3,1);imshow(E_under);title("well-exposedness of under exposure image");
% subplot(1,3,2);imshow(E);title("well-exposedness of input image");
% subplot(1,3,3);imshow(E_over);title("well-exposedness of over exposure image");

figure("name", "input vs results");
subplot(2,3,1);imshow(underExposureImage);title("under exposure");
subplot(2,3,2);imshow(enhanced_input);title("enhanced input");
subplot(2,3,3);imshow(overExposureImage);title("over exposure");
subplot(2,3,4);imshow(R);title("Result");
% subplot(2,3,5);imshow(sharpenR);title("Sharpen result");

Filename = sprintf('Results/exposureFusion_%s.jpg', datetime('now','Format','yyyy-MM-dd''_T''HHmmss'));
% FilenameSharpen = sprintf('Results/sharpenExposureFusion_%s.jpg', datetime('now','Format','yyyy-MM-dd''_T''HHmmss'));
imwrite(R, Filename);
% imwrite(sharpenR, FilenameSharpen);