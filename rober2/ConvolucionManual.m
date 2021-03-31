cd C:\Users\zaval\Desktop\ClasesDoc\rober2;

%cargar y mostrar imagen rgb
imagenRGB = imread('C:\Users\zaval\Desktop\ClasesDoc\rober\Pruebas\gatito.jpg');

figure(1)
imshow(imagenRGB)

%modificar a escala de grises
imagenGrises = 0.33*imagenRGB(:,:,1) + 0.33*imagenRGB(:,:,2) + 0.33*imagenRGB(:,:,3);

figure(2)
imshow(imagenGrises)

I = double(imagenGrises);
J = I;
J2 = I;

%filtro pasa bajos
mask = [1, 1, 1, 1, 1;
        1, 3, 3, 3, 1;
        1, 3, 7, 3, 1;
        1, 3, 3, 3, 1;
        1, 1, 1, 1, 1];
mask = mask(:)';
mask = double(mask);
total = sum(mask);

%ciclos para recorrer la imagen
for m = 3:size(I, 1) -3
    for n = 3:size(I, 2) -3
        %ciclos para recorrer el filtro
        v = 0;
        index = 1;
        for s = -2:2
            for t = -2:2
                v = v + (I(m+s, n+t) * mask(1, index));
                index = index+1;
            end
        end
        v = v/total;
        J(m,n) = v; 
    end
end

K = I - J;
J = uint8(J);
K = uint8(K);

figure(3)
imshow(J)

figure(4)
imshow(K)

Amplitud = 4.0;
K = K*Amplitud;

figure(5)
imshow(K)


% Otra mascara (filtro pasa altos)
mask = [-1, -1, -1, -1, -1;
        -1, -2, -2, -2, -1;
        -1, -2, 32, -2, -1;
        -1, -2, -2, -2, -1;
        -1, -1, -1, -1, -1];
mask = mask(:)';
mask = double(mask);
total = 1.0;

%ciclos para recorrer la imagen
for m = 3:size(I, 1) -3
    for n = 3:size(I, 2) -3
        %ciclos para recorrer el filtro
        v = 0;
        index = 1;
        for s = -2:2
            for t = -2:2
                v = v + (I(m+s, n+t) * mask(1, index));
                index = index+1;
            end
        end
        if v < 0
            v = 0;
        end
        J2(m,n) = v; 
    end
end

I2 = I - J2;
J2 = uint8(J2);
I2 = uint8(I2);

figure(6)
imshow(J2)

figure(7)
imshow(I2)


