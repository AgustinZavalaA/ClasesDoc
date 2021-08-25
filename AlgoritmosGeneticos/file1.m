
cd /home/agustin/Code/Matlab/ClasesDoc/AlgoritmosGeneticos;
clc
clear all
close all
format long 

n1 = dir(['/home/agustin/Code/Matlab/ClasesDoc/AlgoritmosGeneticos/Pictures/c1' '/*.png']);
n2 = dir(['/home/agustin/Code/Matlab/ClasesDoc/AlgoritmosGeneticos/Pictures/c2' '/*.png']);
n3 = dir(['/home/agustin/Code/Matlab/ClasesDoc/AlgoritmosGeneticos/Pictures/c3' '/*.png']);

sizeN1= length(n1);
sizeN2= length(n2);
sizeN3= length(n3);

height = 50;
width  = 50;

R = height * width * 3;
nPatterns = sizeN1 + sizeN2  +  sizeN3;
patterns = double(zeros(R, nPatterns));
for i = 1: sizeN1
    x= imread( [n1(i).folder '/' n1(i).name] );
    x= imresize(x, [height width]);
    patterns(:,i) = x(:);
end

for i = 1: sizeN2
    x= imread( [n2(i).folder '/' n2(i).name] );
    x= imresize(x, [height width]);
    patterns(:,i + sizeN1) = x(:);
end

for i = 1: sizeN3
    x= imread( [n3(i).folder '/' n3(i).name] );
    x= imresize(x, [height width]);
    patterns(:,i + sizeN1 + sizeN2) = x(:);
end

patterns = patterns/255.0;
patterns = patterns - 0.5;
target   = zeros(1, nPatterns);
target(1, 1:sizeN1) = 1;
target(1, sizeN1 + 1 : sizeN1 + sizeN2) = 2;
target(1, sizeN1 + sizeN2 + 1 : nPatterns) = 3;

nn1 = 20;
nn2 = 10;
nn3 = 1;

% W1 = -4.0 + 8.0*rand(nn1, R);
% W2 = -4.0 + 8.0*rand(nn2, nn1);
% W3 = -4.0 + 8.0*rand(nn3, nn2);
% b1 = -4.0 + 8.0*rand(nn1, 1);
% b2 = -4.0 + 8.0*rand(nn2, 1);
% b3 = -4.0 + 8.0*rand(nn3, 1);

% a = zeros(1, nPatterns);
% for i = 1: nPatterns
%    n1 = W1*patterns(:, i) + b1;
%    a1 = logsig(n1);
%    
%    n2 = W2*a1 + b2;
%    a2 = logsig(n2);
%   
%    n3 = W3*a2 + b3;
%    a(1,i) = n3;
% end

L = nn1 * R + nn1*nn2 + nn2 + nn1 + nn2 + nn3;
sizePopulation = 150;
initial_population = -2.0 + 4.0*rand(L, sizePopulation);
nIterations = 500;

%evaluation
population = initial_population;
errors = zeros(sizePopulation, 2);
for k= 1: nIterations
    for i = 1: sizePopulation
        col = population(:, i);
        stride1 = 1;
        stride2 = nn1 * R;
        partial = col(stride1: stride2);
        W1 = reshape(partial, nn1, R); 
        stride1 = stride2 + 1;
        stride2 = stride2 + ( nn2 * nn1 );
        partial = col(stride1: stride2);
        W2 = reshape(partial, nn2 ,nn1); 
        stride1 = stride2 + 1;
        stride2 = stride2 + ( nn3 * nn2 );
        partial = col(stride1: stride2);
        W3 = reshape(partial, nn3, nn2); 

        stride1 = stride2 + 1;
        stride2 = stride2 + nn1;
        partial = col(stride1: stride2);
        b1 = reshape(partial, nn1, 1); 

        stride1 = stride2 + 1;
        stride2 = stride2 + nn2;
        partial = col(stride1: stride2);
        b2 = reshape(partial, nn2, 1);

        stride1 = stride2 + 1;
        stride2 = stride2 + nn3;
        partial = col(stride1: stride2);
        b3 = reshape(partial, nn3, 1);

        a = zeros(1, nPatterns);
        for j = 1: nPatterns
           n1 = W1*patterns(:, j) + b1;
           a1 = logsig(n1);

           n2 = W2*a1 + b2;
           a2 = logsig(n2);

           n3 = W3*a2 + b3;
           a(1,j) = n3;
        end
        error = a - target;
        error = error .* error;
        errors(i, 1) = i;
        errors(i, 2) = sum(error);
    end

    rateSel = 35;  % un tornillo
    D = sortrows(errors, 2);
    newPopulation = population;
    newPopulation(:, 1:rateSel) = population(:, D(1:rateSel, 1));
    myNetwork = newPopulation(:, 1);
    D(1,2)

    for j = rateSel+1: sizePopulation
      parent1 = randi([1 rateSel]);
      parent2 = randi([1 rateSel]);
      aux = randi(2);
      if aux == 1
          mid = floor(L/2);
          newPopulation(1:mid, j)   = newPopulation(1:mid,   parent1);
          newPopulation(mid+1:L, j) = newPopulation(mid+1:L, parent2);
      else
          newPopulation(:, j) = 0.5*( newPopulation(:, parent1) + newPopulation(:,parent2) );
      end
      %mutar
      for m = 1: 35  %tornillo-ajuste
          x1 = randi(L);
          x2 = randi(3);
          if x2 == 1
             newPopulation(x1, j) = 1.2*newPopulation(x1, j);
          elseif x2 == 2
                 newPopulation(x1, j) = 0.8*newPopulation(x1, j);
          else
              newPopulation(x1, j) = -newPopulation(x1, j);
          end
      end
    end

    population = newPopulation;
    
    k
end

% a, tiene que ser del uso de myNetwork
a
a-target
round(a)
% fin del uso de myNetwork

save('miRed.mat', 'myNetwork');

%probando
col = myNetwork;
stride1 = 1;
stride2 = nn1 * R;
partial = col(stride1: stride2);
W1 = reshape(partial, nn1, R); 
stride1 = stride2 + 1;
stride2 = stride2 + ( nn2 * nn1 );
partial = col(stride1: stride2);
W2 = reshape(partial, nn2 ,nn1); 
stride1 = stride2 + 1;
stride2 = stride2 + ( nn3 * nn2 );
partial = col(stride1: stride2);
W3 = reshape(partial, nn3, nn2); 

stride1 = stride2 + 1;
stride2 = stride2 + nn1;
partial = col(stride1: stride2);
b1 = reshape(partial, nn1, 1); 

stride1 = stride2 + 1;
stride2 = stride2 + nn2;
partial = col(stride1: stride2);
b2 = reshape(partial, nn2, 1);

stride1 = stride2 + 1;
stride2 = stride2 + nn3;
partial = col(stride1: stride2);
b3 = reshape(partial, nn3, 1);

a = zeros(1, nPatterns);
for j = 1: nPatterns
   n1 = W1*patterns(:, j) + b1;
   a1 = logsig(n1);

   n2 = W2*a1 + b2;
   a2 = logsig(n2);

   n3 = W3*a2 + b3;
   a(1,j) = n3;
end
error = a - target;
error = error .* error;
errors = sum(error);































