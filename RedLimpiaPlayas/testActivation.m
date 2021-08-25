clear all
close all
clc
format long

load('jun03.mat');


%baseFolder = '/home/agustin/Code/Python/Model_LP2021/dataset_completo/Classify';
%[metaTrain, metaTest, metaCTrain, metaCTest] = getImagesFromFolder(strcat(baseFolder, '/Meta'), 1, 0.8);

Y = activations(cifar10Net, trainingImages, 'fc_1');

z = 4;

p = trainingImages;
t = squeeze(Y);
t = t';
pSize = size(p);
patron = double(zeros( pSize(1,1) * pSize(1,2) * pSize(1,3), pSize(1,4) ));
for i = 1: pSize(1,4)
    m = p(:,:,:,i);
    n = m(:);
    patron(:, i) = n;
end
p = patron';

nCapas = 2;
alpha = 0.1;

aux  = size(p);
R = aux(1,2);
nIteraciones = 750;
tau = 0.04;

%p = (-2 : 0.1 : 2)';
%t = 1+cos(3*p);

% plot(p,t)

nPatrones = aux(1,1);
nn1 =  10;
nn2 = 64;

%Los pesos y biases iniciales son pequeños valores aleatorios
W1 = -1 + 2*rand(nn1,R);
W2 = -1 + 2*rand(nn2,nn1);

b1 = -1 + 2*rand(nn1,1);
b2 = -1 + 2*rand(nn2,1);

%feedforward
a = zeros(nPatrones, nn2);
for i = 1:size(p,1)
    n1 = W1*p(i,:)'+b1;
    a1 = (1.0)./((1.0)+exp(-n1));   %salida capa 1 (logsig)
    n2 = W2*a1+b2;
    a2 = n2;
    a(i, :) = a2;
end

%graficando la salida inicial de la red
figure(1)
plot(p,a, 'r'), hold on;
plot(p,t, 'b'), hold on;
error = (t-a);
error = dot(error,error); 
title(['error actual: ' num2str(error)])

%Algoritmo de Retropropagación
aSum = zeros(nPatrones, 1);
for k=1:nIteraciones
    for i=1:nPatrones
        caca = p(i,1)
        [a,n1,a1,n2,a2] = feedForward_pattern2(W1,W2,W3,b1,b2,b3,p(i,1));
        sM = -2.0*(t(i,1)- a);      %sensibilidad de la ultima capa
        aux = 1.0 + exp(-n2);
        aux = aux.*aux;
        part1 = exp(-n2)./aux;
        s2 = (part1 .* W3') * sM;  %sensibilidad de capa 2
        
        aux2 = 1.0 + exp(-n1);
        aux2 = aux2.*aux2;
        part1 = exp(-n1)./aux2;
        s1 = part1 .* (W2' * s2);   %sensibilidad de capa 1
        
        %actualizacion de pesos y biases
        W3 = W3 - alpha * sM * a2';
        W2 = W2 - alpha * s2 * a1';
        W1 = W1 - alpha * s1 * p(i,1)';
        
        b3 = b3 - alpha * sM;
        b2 = b2 - alpha * s2;
        b1 = b1 - alpha * s1;
    end
    a = feedForward_2(nPatrones,W1,W2,W3,b1,b2,b3,p);
    
    % indice de desempeno y grafica de cada iteracion
    error = (t-a);
    error = dot(error,error);   %error cuadratico medio
    if mod(k, 100) == 0
         figure(k+1)
         plot(p,a,'r'), hold on;
         plot(p,t,'b'), hold on;
         title(['error actual: ' num2str(error)])
    end
   
    if error < tau                   %meta final
        disp('meta alcanzada')
        break;
    end
end