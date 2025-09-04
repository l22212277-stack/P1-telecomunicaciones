clc
clear all
close all

% Ejemplos para leer la imagen
Ax = imread('angiografia.jpg');

% Ejemplo para convertir una imagen
if(ndims(Ax)>2)
    Axg = rgb2gray(Ax);
else
    Axg=Ax;
end



% Convertir imagen a vector columna
Avector = Axg(:);

%Llamas funcion para cuantificar
N=8;
Vcuantificado=cuantificador(Avector,N);

%reconstruir matriz

Ax2 = reshape(Vcuantificado, size(Axg,1), size(Axg,2));

% Figura para ver diferentes imagenes
figure;
for i = 1:8
        N=i;
        Vcuantificado=cuantificador(Avector,N);
        Ax2 = reshape(Vcuantificado, size(Axg,1), size(Axg,2));
        subplot(4,2,i);
        imshow(Ax2);
        imagesc(Ax2, [0 max(Ax2(:))]);
        colormap('Gray');

end


