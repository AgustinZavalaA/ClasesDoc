function opencvImg = IMGtoOpenCVFormat(img)
    %img = imresize(img, [50, 50]);
    R = img(:, :, 1);
    G = img(:, :, 1);
    B = img(:, :, 1);

    D = uint8(zeros(1, 50*50 * 3));
    contador = 1;

    for i = 1:size(R, 1)

        for j = 1:size(R, 2)
            %D(i, j) =
            D(1, contador) = B(i, j);
            contador = contador +1;
            D(1, contador) = G(i, j);
            contador = contador +1;
            D(1, contador) = R(i, j);
            contador = contador +1;
        end

    end

    opencvImg = reshape(D, [50, 50, 3]);
end
