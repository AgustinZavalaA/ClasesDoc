function [patronTrain, patronTest, categoricalTrain, categoricalTest] = getImagesFromFolder(folderDir, sizeFactor, trainPercentage)
    %default en nuetro caso imagenes de 120*90
    %patron = zeros(120*sizeFactor*90*sizeFactor*3,480);
    %proteccion por si no se encuentra el directorio
    if ~isfolder(folderDir)
      errorMessage = sprintf('Error: The following folder does not exist:\n%s', folderDir);
      uiwait(warndlg(errorMessage));
      patronTrain = 0;
      return;
    end
    %carga todos los png de la carpeta
    filePattern = fullfile(folderDir, '*.png');
    %carga una lista de nombres de las imagenes
    jpegFiles = dir(filePattern);
    %patron = cell(length(jpegFiles));
    %patron = zeros(120*sizeFactor*90*sizeFactor*3,length(jpegFiles));
    patronTrain = zeros(96, 128, 3,length(jpegFiles));
    for k = 1:length(jpegFiles)
        % si ya se llego al limite se rompe el ciclo
        %if endIndex == k
         %   break;
        %end
        %obtiene el nombre de la lista
        baseFileName = jpegFiles(k).name;
        %obtiene la imagen
        fullFileName = fullfile(folderDir, baseFileName);
        fprintf(1, 'Now reading %s\n', fullFileName);
        imageArray = imread(fullFileName);
        imageArray = imresize(imageArray, sizeFactor);
        patronTrain(:, :, :, k) = imageArray;
        %imshow(imageArray);  % Display image.
    end
    
    t = size(patronTrain, 4);
    factor = floor( trainPercentage*t);
    patronBase = patronTrain;
    nombreCarpeta = regexp(folderDir, "\w+$", 'match');
    
    patronTrain = uint8(patronBase(:,:,:,1:factor));
    patronTest = uint8(patronBase(:,:,:,factor:t));
    
    categoricalTrain= strings([factor, 1]);
    categoricalTest = strings([t - factor+1,1]);
    categoricalTrain(:) = nombreCarpeta;
    categoricalTest(:) = nombreCarpeta;
    categoricalTrain= categorical(categoricalTrain);
    categoricalTest = categorical(categoricalTest);
    end