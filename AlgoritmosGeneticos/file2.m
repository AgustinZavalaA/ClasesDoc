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

R = 16;
nPatterns = sizeN1 + sizeN2  +  sizeN3;
patternsM = double(zeros(height, width, 3, nPatterns));

for i = 1: sizeN1
    x= imread( [n1(i).folder '/' n1(i).name] );
    x= imresize(x, [height width]);
    patternsM(:,:,:, i) = x;
end

for i = 1: sizeN2
    x= imread( [n2(i).folder '/' n2(i).name] );
    x= imresize(x, [height width]);
    patternsM(:,:,:, i + sizeN1) = x;
end

for i = 1: sizeN3
    x= imread( [n3(i).folder '/' n3(i).name] );
    x= imresize(x, [height width]);
    patternsM(:,:,:, i + sizeN1 + sizeN2) = x;
end

patternsM = patternsM/255.0;
patternsM = patternsM - 0.5;

target   = zeros(1, nPatterns);
target(1, 1:sizeN1) = 1;
target(1, sizeN1 + 1 : sizeN1 + sizeN2) = 2;
target(1, sizeN1 + sizeN2 + 1 : nPatterns) = 3;

nn1 =10;
nn3 = 1;

a = zeros(1, nPatterns);

maskH = 3;
maskW = 3;
strideMaskH = 2;
strideMaskW = 2;
sizeMask = maskH * maskW;

L = nn1 * 16 + nn1*nn3 + nn1 + nn3 + sizeMask;
sizePopulation = floor(L/3);
initial_population = -6.0 + 12.0*rand(L, sizePopulation);
nIterations = 1200;

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
        stride2 = stride2 + ( nn3 * nn1 );
        partial = col(stride1: stride2);
        W3 = reshape(partial, nn3, nn1); 

        stride1 = stride2 + 1;
        stride2 = stride2 + nn1;
        partial = col(stride1: stride2);
        b1 = reshape(partial, nn1, 1); 

        stride1 = stride2 + 1;
        stride2 = stride2 + nn3;
        partial = col(stride1: stride2);
        b3 = reshape(partial, nn3, 1);
        
        stride1 = stride2 + 1;
        stride2 = stride2 + sizeMask;
        partial = col(stride1: stride2);
        mask    = partial;

        a = zeros(1, nPatterns);
        for j = 1: nPatterns
             %init stage 1
            auxPattern = patternsM(:,:,:, j);
            auxPattern = IMGtoOpenCVFormat(auxPattern);
            for v1 = 3: strideMaskH: size(auxPattern, 1) - 3
               for v2 = 3: strideMaskW: size(auxPattern, 2) -3
                  v5 = 0;
                  v6 = 0;
                  v7 = 0;
                  v8 = 1;
                  %for v3 = 1:maskH
                  %for v4 = 1:maskW
                  for v3 = -1:1
                     for v4 = -1:1
                        v5 = v5  + ( auxPattern(v1 + v3, v2+v4, 1 ) * mask(v8));
                        v6 = v6  + ( auxPattern(v1 + v3, v2+v4, 2 ) * mask(v8));
                        v7 = v7  + ( auxPattern(v1 + v3, v2+v4, 3 ) * mask(v8));
                        v8 = v8  + 1;
                     end
                  end
                  auxPattern(v1,v2,1) = v5;
                  auxPattern(v1,v2,2) = v6;
                  auxPattern(v1,v2,3) = v7;
               end
            end

            %tabla de 4 x 4
            strideSubH = floor( size(patternsM, 1) / 4 );
            strideSubW = floor( size(patternsM, 2) / 4 );
            pp = zeros(16, 1);
            step = 1;
            for v1 = 1: strideSubH: size(auxPattern, 1) - strideSubH + 2
               for v2 = 1: strideSubW: size(auxPattern, 2)- strideSubW + 2
                  %for v3 = 1:strideSubH
                   %  for v4 = 1:strideSubW
                         %if (v1 + v3) < size(auxPattern, 1) && (v2+v4) < size(auxPattern, 2)
                    %         v9 = v9  + sum(auxPattern(v1 + v3, v2+v4, :));
                         %end
                     %end
                  %end
                  v9 = auxPattern(v1:v1+strideSubH-1, v2:v2+strideSubW-1, :);
                  pp(step) = sum(v9(:));
                  step = step + 1;
               end
            end

            
            % end stage 1
           pp = pp*0.01;
           n1 = W1*pp + b1;
           a1 = logsig(n1);

           n3 = W3*a1 + b3;
           a(1,j) = n3;
        end
        error = a - target;
        error = error .* error;
        errors(i, 1) = i;
        errors(i, 2) = sum(error);
    end

    rateSel = floor(sizePopulation/3);
    D = sortrows(errors, 2);
    newPopulation = population;
    newPopulation(:, 1:rateSel) = population(:, D(1:rateSel, 1));
    D(1,2)
    myNetwork2 = newPopulation(:, 1);  % guardarlo con save

      j = rateSel+1;
    while j < sizePopulation
   % for j = rateSel+1: sizePopulation
      parent1 = randi([1 rateSel]);
      parent2 = randi([1 rateSel]);
      aux = randi(3);
      %aux = 3;
      auxDual = 0;
      if aux == 1
          mid = floor(L/2);
          newPopulation(1:mid, j)   = newPopulation(1:mid,   parent1);
          newPopulation(mid+1:L, j) = newPopulation(mid+1:L, parent2);
      elseif aux == 2
          newPopulation(:, j) = 0.5*( newPopulation(:, parent1) + newPopulation(:,parent2) );
      else
          newPopulation(:, j) = 0.3*( newPopulation(:, parent1) )  + 0.7*(newPopulation(:,parent2) );
          newPopulation(:, j+1) = 0.6*( newPopulation(:, parent1) )  + 0.4*(newPopulation(:,parent2) );
          auxDual = 1;
      end
      for m = 1: 10
          x1 = randi(L);
          x2 = randi(3);
          if x2 == 1
             newPopulation(x1, j) = 1.2*newPopulation(x1, j);
             if auxDual == 1
                 newPopulation(x1, j+1) = 1.2*newPopulation(x1, j+1);
             end
          elseif x2 == 2
                 newPopulation(x1, j) = 0.8*newPopulation(x1, j);
                 if auxDual == 1
                    newPopulation(x1, j+1) = 0.8*newPopulation(x1, j+1);
                 end
          else
              newPopulation(x1, j) = -newPopulation(x1, j);
              if auxDual == 1
                 newPopulation(x1, j+1) = -newPopulation(x1, j+1);
              end
          end
      end
      j = j+1;
      if auxDual == 1
          j = j+1;
      end
    end

    population = newPopulation;
    k
end

a
a-target
round(a)



%save('miRed2.mat', 'myNetwork2');



























