cd /home/agustin/Code/Matlab/ClasesDoc/R-CNN-Tutorial;

%cargar los pesos y bias del entrenamiento
% automatizar el entrnamiento
% cargar las imagenes por funcion
% 
load('WyB.mat');

%cargar las imagenes para hacer el test
baseFolder = '/home/agustin/Code/Python/Model_LP2021/dataset_completo/Classify';
meta = getImagesFromFolder(strcat(baseFolder, '/Meta'), 1, 40,1);
latasN = getImagesFromFolder(strcat(baseFolder, '/LatasNegras'), 1, 40,1);
latasV = getImagesFromFolder(strcat(baseFolder, '/LatasVerdes'), 1, 40,1);
banista = getImagesFromFolder(strcat(baseFolder, '/Banistas'), 1, 40,1);

trainigImagesLP = uint8(zeros(96,128,3,160));
trainigImagesLP(:,:,:,1:40) = meta;
trainigImagesLP(:,:,:,41:80) = latasN;
trainigImagesLP(:,:,:,81:120) = latasV;
trainigImagesLP(:,:,:,121:160) = banista;
% patron de entrada
p = [latasV latasN arena];
%normalizacion
%p = double(p);
p = p/255.0;

%target
nPatrones = size(p,2);
t = zeros(41,1);
t(1:20,1) = 1;
t(21:40,1) = 2;
t(41:41,1) = 3;

%testing
salida = feedForward_2(nPatrones,W1,W2,W3,b1,b2,b3,p);
disp(salida)
disp(t-salida)
disp(dot(t-salida,t-salida))