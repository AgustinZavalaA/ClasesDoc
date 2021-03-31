function patron = getImagesFromFolder(folderDir, startIndex, endIndex, sizeFactor)
    %default en nuetro caso imagenes de 120*90
    %patron = zeros(120*sizeFactor*90*sizeFactor*3,480);
    %proteccion por si no se encuentra el directorio
    if ~isfolder(folderDir)
      errorMessage = sprintf('Error: The following folder does not exist:\n%s', folderDir);
      uiwait(warndlg(errorMessage));
      patron = 0;
      return;
    end
    %carga todos los png de la carpeta
    filePattern = fullfile(folderDir, '*.png');
    %carga una lista de nombres de las imagenes
    jpegFiles = dir(filePattern);
    %patron = cell(length(jpegFiles));
    patron = zeros(120*sizeFactor*90*sizeFactor*3,length(jpegFiles));
    for k = 1:length(jpegFiles)
        % si ya se llego al limite se rompe el ciclo
        if endIndex == k
            break;
        end
        %obtiene el nombre de la lista
        baseFileName = jpegFiles(k).name;
        %obtiene la imagen
        fullFileName = fullfile(folderDir, baseFileName);
        fprintf(1, 'Now reading %s\n', fullFileName);
        imageArray = imread(fullFileName);
        imageArray = imresize(imageArray, sizeFactor);
        patron(:,k) = imageArray(:);
        %imshow(imageArray);  % Display image.
    end
    
    patron = double(patron(:,startIndex:endIndex));