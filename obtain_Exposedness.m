function E = obtain_Exposedness(input)
% 
    R = input(:,:,1); 
    G = input(:,:,2); 
    B = input(:,:,3);

    sigma = 0.2;

%     R_E = exp(-1 * (R-0.5).^2 / (2 * sigma^2));
%     G_E = exp(-1 * (G-0.5).^2 / (2 * sigma^2));
%     B_E = exp(-1 * (B-0.5).^2 / (2 * sigma^2));
    R_E = exp(-.5*(R - .5).^2/sigma^2);
    G_E = exp(-.5*(G - .5).^2/sigma^2);
    B_E = exp(-.5*(B - .5).^2/sigma^2);

    E = R_E .* G_E .* B_E;
end