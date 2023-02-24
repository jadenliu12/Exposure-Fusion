function output = spatialFiltering(input, mask)
    [M, N, C] = size(input);
    output = zeros(M, N, C, "single");
%     edit_image = padarray(input,[1 1]);
    edit_image = padarray(input,[1 1],"replicate");
%     edit_image = input;
    
    if(size(edit_image)==size(input))
        for x = 2 : M-1
            for y = 2 : N-1
                for i = 1:3
                    for j = 1:3
                         
                         output(x-1,y-1) = output(x-1,y-1) + mask(i,j) * edit_image(x-i+2,y-j+2);                 
                    end
                end
    
            end
        end
    
    else
        for x = 2 : M+1
            for y = 2 : N+1       
                for i = 1:3
                    for j = 1:3    
                         output(x-1,y-1) = output(x-1,y-1) + mask(i,j) * edit_image(x-i+2,y-j+2);                
                    end
                end
    
            end
        end
    end
end