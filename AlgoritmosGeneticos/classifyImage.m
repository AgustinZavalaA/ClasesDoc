function a = classifyImage(myNetwork, myImage)
    x = double(myImage);
    x = x / 255.0;
    x = x - 0.5;

    nPatterns = 1;

    %variables
    R = 16;

    nn1 = 10;
    nn3 = 1;

    maskH = 3;
    maskW = 3;
    strideMaskH = 2;
    strideMaskW = 2;
    sizeMask = maskH * maskW;

    col = myNetwork;
    stride1 = 1;
    stride2 = nn1 * R;
    partial = col(stride1:stride2);
    W1 = reshape(partial, nn1, R);
    stride1 = stride2 + 1;
    stride2 = stride2 + (nn3 * nn1);
    partial = col(stride1:stride2);
    W3 = reshape(partial, nn3, nn1);

    stride1 = stride2 + 1;
    stride2 = stride2 + nn1;
    partial = col(stride1:stride2);
    b1 = reshape(partial, nn1, 1);

    stride1 = stride2 + 1;
    stride2 = stride2 + nn3;
    partial = col(stride1:stride2);
    b3 = reshape(partial, nn3, 1);

    stride1 = stride2 + 1;
    stride2 = stride2 + sizeMask;
    partial = col(stride1:stride2);
    mask = partial;

    a = zeros(1, nPatterns);
    %init stage 1
    auxPattern = x;

    for v1 = 3:strideMaskH:size(auxPattern, 1) - 3

        for v2 = 3:strideMaskW:size(auxPattern, 2) -3
            v5 = 0;
            v6 = 0;
            v7 = 0;
            v8 = 1;
            %for v3 = 1:maskH
            %for v4 = 1:maskW
            for v3 = -1:1

                for v4 = -1:1
                    v5 = v5 + (auxPattern(v1 + v3, v2 + v4, 1) * mask(v8));
                    v6 = v6 + (auxPattern(v1 + v3, v2 + v4, 2) * mask(v8));
                    v7 = v7 + (auxPattern(v1 + v3, v2 + v4, 3) * mask(v8));
                    v8 = v8 + 1;
                end

            end

            auxPattern(v1, v2, 1) = v5;
            auxPattern(v1, v2, 2) = v6;
            auxPattern(v1, v2, 3) = v7;
        end

    end

    %tabla de 4 x 4
    strideSubH = floor(size(x, 1) / 4);
    strideSubW = floor(size(x, 2) / 4);
    pp = zeros(16, 1);
    step = 1;

    for v1 = 1:strideSubH:size(auxPattern, 1) - strideSubH + 2

        for v2 = 1:strideSubW:size(auxPattern, 2) - strideSubW + 2
            v9 = auxPattern(v1:v1 + strideSubH - 1, v2:v2 + strideSubW - 1, :);
            pp(step) = sum(v9(:));
            step = step + 1;
        end

    end

    % end stage 1
    pp = pp * 0.01;
    n1 = W1 * pp + b1;
    a1 = 1.0 ./ (1.0 + exp(-n1));

    n3 = W3 * a1 + b3;
    a = n3;
end
