cd C:\Users\zaval\Desktop\ClasesDoc\rober2;

%cargar los pesos y bias del entrenamiento
% automatizar el entrnamiento
% cargar las imagenes por funcion
% 
load('WyB.mat');

%cargar las imagenes para hacer el test
baseFolder = 'C:\Users\zaval\Desktop\ClasesDoc\rober\pruebas';
latasV = getImagesFromFolder(strcat(baseFolder, '\LatasVerdes'), 21, 40,0.5);
latasN = getImagesFromFolder(strcat(baseFolder, '\LatasNegras'), 21, 40,0.5);
arena = getImagesFromFolder(strcat(baseFolder, '\Arena'), 5, 5,0.5);
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