%Entrenamiento de una red neuronal perceptron de tres capas mediante
%backpropagation
%las funciones de activacion para las dos primeras capas son logsig y, 
%purelin para la ultima capa

%todo es un ajuste entre el numero de patrones, tasa de aprendizaje, numero de iteraciones, numero
%de neuronas de capa oculta e indice de desempeño solicitado o error total (tau)

%Aqui se presenta una red neuronal artificial que aprende una función
%cosenoidal en el intervalo de -2 a 2
% ver capitulo 11 del libro Neural Network de Hagan. En la fig. 11.10 se
% presenta un red de 2 capas. Se extiende ese ejemplo a tres capas.

%poner 10 imagenes de la ver, negra, arena
% probar con 3 imagenes no utilizadas en el entrenamiento
% t = 10 * 1 (ver) 10* 2 (negro)

clc
clear all
close all
format long
cd C:\Users\zaval\Desktop\ClasesDoc\rober2;

baseFolder = 'C:\Users\zaval\Desktop\ClasesDoc\rober\pruebas';
latasV = getImagesFromFolder(strcat(baseFolder, '\LatasVerdes'), 1, 20,0.5);
latasN = getImagesFromFolder(strcat(baseFolder, '\LatasNegras'), 1, 20,0.5);
arena = getImagesFromFolder(strcat(baseFolder, '\Arena'), 1, 4,0.5);

nCapas = 3;
alpha = 0.002; %tasa de aprendizaje
%p = [a(:) a1(:) a2(:) a3(:) b(:) b1(:) b2(:) b3(:) c(:) c1(:) c2(:) c3(:)];
%p = double(p);
p = [latasV latasN arena];
p = p/255.0;

%t = [1,1,1,1,2,2,2,2,3,3,3,3]'; %objetivo
t = zeros(44,1);
t(1:size(latasV, 2),1) = 1;  
t(size(latasV, 2)+1:size(latasV, 2)+size(latasN, 2),1) = 2;
t(size(latasV, 2)+size(latasN, 2)+1:size(latasV, 2)+size(latasN, 2)+size(arena, 2),1) = 3;
R = size(p,1);
nIteraciones = 10000;
tau = 0.004; 

%p = (-2 : 0.1 : 2)'; %patron


% plot(p,t)

nPatrones = size(p,2);
%nn1 = floor( 0.003*R );
%nn2 = floor( 0.003*R );
nn1 = 16;
nn2 = 16;
% nn1 = nPatrones;
% nn2 = nPatrones;
nn3 = 1;

%Los pesos y biases iniciales son pequeños valores aleatorios
W1 = -1 + 2*rand(nn1,R);
W2 = -1 + 2*rand(nn2,nn1);
W3 = -1 + 2*rand(nn3,nn2);

b1 = -1 + 2*rand(nn1,1);
b2 = -1 + 2*rand(nn2,1);
b3 = -1 + 2*rand(nn3,1);

%feedforward
a = zeros(nPatrones, nn3);
for i = 1:size(p,2)
    n1 = W1*p(:,i)+b1;
    a1 = (1.0)./((1.0)+exp(-n1));   %salida capa 1 (logsig)
    n2 = W2*a1+b2;
    a2 = (1.0)./((1.0)+exp(-n2));   %salida capa 2 (logsig)
    n3 = W3*a2+b3;                     %salida capa 3 (purelin)
    a(i,:) = n3;
end

%graficando la salida inicial de la red
%figure(1)
%plot(p,a, 'r'), hold on;
%plot(p,t, 'b'), hold on;
error = (t-a);
error = dot(error,error); 
%title(['error actual: ' num2str(error)])

%Algoritmo de Retropropagación
aSum = zeros(nPatrones, 1);
for k=1:nIteraciones
    for i=1:nPatrones
        [a,n1,a1,n2,a2] = feedForward_pattern2(W1,W2,W3,b1,b2,b3,p(:,i));
        sM = -2.0*(t(i,1)- a);      %sensibilidad de la ultima capa
        aux = 1.0 + exp(-n2);
        aux = aux.*aux;
        part1 = exp(-n2)./aux;
        s2 = (part1 .* W3') * sM';  %sensibilidad de capa 2
        
        aux2 = 1.0 + exp(-n1);
        aux2 = aux2.*aux2;
        part1 = exp(-n1)./aux2;
        s1 = part1 .* (W2' * s2);   %sensibilidad de capa 1
        
        %actualizacion de pesos y biases
        W3 = W3 - alpha * sM * a2';
        W2 = W2 - alpha * s2' * a1;
        W1 = W1 - alpha * s1 * p(:,i)';
        
        b3 = b3 - alpha * sM;
        b2 = b2 - alpha * s2;
        b1 = b1 - alpha * s1;
    end
    a = feedForward_2(nPatrones,W1,W2,W3,b1,b2,b3,p);
    
    % indice de desempeno y grafica de cada iteracion
    error = (t-a);
    error = dot(error,error);   %error cuadratico medio
    fprintf(1,"Epoch: %4d Error: %.5f\n",k,error)
    %if mod(k, 90) == 0
    %     figure(k+1)
%          plot(p,a,'r'), hold on;
%          plot(p,t,'b'), hold on;
%          title(['error actual: ' num2str(error)])
%     end
   
    if error < tau                   %meta final
        disp(k)
        disp(error)
        disp('meta alcanzada')
        break;
    end
end

%filename = 'WyB.mat';
%save(filename, 'W1','W2','W3','b1','b2','b3');












