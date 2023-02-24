function output = obtain_Saturation(input)

    img = double(input);

    R = img(:, :, 1);
    G = img(:, :, 2);
    B = img(:, :, 3);
    mean = sum(img, 3) ./3;
    output = sqrt(((R - mean).^2 + (G - mean).^2 + (B - mean).^2)/3);
end

