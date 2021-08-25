% cd /home/agustin/Code/Matlab/ClasesDoc/AlgoritmosGeneticos;
% clc
% clear all
% close all
format long

%load('miRed2.mat');

%load 1 image
x = imread('/home/agustin/Code/Matlab/ClasesDoc/AlgoritmosGeneticos/Pictures/c1/img_048.png');
% x = imresize(x, [50 50]);

x = IMGtoOpenCVFormat(x);
% x =
%    R             G                  B
% 1   2  3      10 11 12          13 14 15
% 16 17 18      19 20 21          22 23 24

% matlab (:)
% 1 16 2 17 3 18 10 19 11 20 12 21 ....

% opencv img.data
% 13 10 1 14 11 2 15 12 3 ...

%matlab

%a = classifyImage(myNetwork2, x);
%a
