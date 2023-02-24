clear;
close all;

% input = imread("Images/C.jpg"); % normal picture
% input = imread("Images/1.png"); % medium brightness picture
% input = imread("Images/Qcc9j.jpeg"); % medium brightness picture
% input = imread("Images/3.png"); % low brightness picture
% input = imread("Images/low-light-photography-1-of-1-2.jpeg"); % very low brightness picture
input = imread("Images/n19qZ.jpeg"); % very low brightness picture

enhanced_image = BIMEF(input);

figure("name", "input vs results");
subplot(2,1,1);imshow(input);title("input");
subplot(2,1,2);imshow(enhanced_image);title("Result");