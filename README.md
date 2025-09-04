
# Práctica 1 – Introducción al manejo de señales biomédicas: imagen

---

## 1. Descarga/adquisición de datos

Descargar/adquirir los datos fuente que se utilizarán durante la práctica. Se utilizarán los siguientes:

* Descargar una **Imagen de cerebro/cráneo obtenida mediante Resonancia Magnética Nuclear (NMRI)**. Específicamente una imagen que presente algún tumor cerebral. Utilizar bases de datos gratuitas, por ejemplo:

  * [Kaggle](https://www.kaggle.com/)
  * [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets.php)

---

## 2. Configuración y despliegue de datos en Matlab

1. Colocar la imagen en un directorio de trabajo.
2. Ejecutar **Matlab**.
3. En esta parte de la práctica la idea es desplegar y familiarizarse con los diferentes tipos de datos.

Ejemplos de comandos:

```matlab
% Ejemplos para leer la imagen
Ax = imread('meningioma.jpg');

% Ejemplo para convertir una imagen, es recomendable validar, para los cassos en los que la imagen ya esté en escala de grises
% ndims retorna las dimensiones de la matriz, si llega a ser de 3 es decir mayor de dos, no es necesaria la conversion, esto nos evita errores

if(ndims(Ax)>2)
    Axg = rgb2gray(Ax);
else
    Axg=Ax;
end

% Ejemplos para graficar la imagen
imshow(Axg);
imagesc(Axg, [0 255]);
%En este caso porque la imagen tiene 8 bits por pixel, por lo tanto, el valor máximo por pixel será 255.
```

---

## 3. Cuantificación de la señal

Escribir una función:

```matlab
function Yout = cuantificador(Xin, Nbits)
   p=(max(Xin)/(2^Nbits))-1 :(max(Xin)/(2^Nbits)): max(Xin);
   Yout = quantiz (Xin,p);
end

```

La función debe tomar como entrada:

* La señal en forma de vector a cuantificar `Xin`.
* El número de bits `Nbits` del cuantificador (es decir, 2^Nbits).

Y debe generar una señal de salida **Yout** cuantificada.

Notas:

* Para convertir la matriz `Ax` en vector columna:

```matlab
Avector = Ax(:);
```

* Para convertir el vector de nuevo en matriz:

```matlab
Ax2 = reshape(Ax, size(Ax,1), size(Ax,2));
```

* Puede ser de utilidad la función de Matlab **quantiz**.
quantiz pedira el vector en una dimension de toda la imagen, en este caso Avector y el vector de particion, de este modo asignara un nivel nuevo al que mas se acerque.

```matlab
max(Xin);
```
* Se utiliza para saber de cual es el valor maximo que puede tomar cada pixel, asi si la hay dos imagenes con diferentes resoluciones por pixel sea 4,2,8 etc no es necesario cambiar el valor si no que automaticamente segun la imagen lo tomara.

---

## 4. Generación y comparación de imágenes

* Generar varias versiones de la imagen original usando diferentes valores para el número de niveles de cuantificación `Nbits`.
* Desplegar de manera simultánea la imagen original y las imágenes cuantificadas (utilizar el comando `subplot`) y comparar los resultados.

Referencias:

* [Wikipedia - MRI](http://en.wikipedia.org/wiki/MRI)
* [Kaggle](https://www.kaggle.com/)
* [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets.php)

```matlab
figure;
for i = 1:8
        Vcuantificado=cuantificador(Avector,i);
        Ax2 = reshape(Vcuantificado, size(Axg,1), size(Axg,2));
        subplot(2,4,i);
        imshow(Ax2);
        imagesc(Ax2, [0 max(Ax2(:))]);
        colormap('Gray');

end
```  

---

## 5. Análisis de resultados

Explicar cómo afecta a la imagen los diferentes valores del parámetro `Nbits`.

Elaborar una tabla en la que se especifique:

* La profundidad de bit.
* La calidad mostrada a esa profundidad.
* Las observaciones correspondientes.

Responder: **¿Cuál es la profundidad de bit adecuada para la imagen de esta práctica? **
La profundidad adecuada depende del objetivo, si estamos buscando la máxima calidad dejando de lado el rendimiento siempre será mejor utilizar más bits, sin embargo, la mejor resolución relación rendimiento/calidad en mi opinión son 5 bits ya que a partir de esta resolución por bit difícilmente se observan cambios al aumentar el número de bits, y hace que la imagen sea mucho más ligera y fácil de procesar.

| Profundidad de bit o Nbits (niveles de cuantificación) | Calidad (MB/B/R/M/MM) | Observaciones                    |
| ------------------------------------------------------ | -------------------- | -------------------------------- |
| 1 (2)                                                  | MM                   |                La calidad de imagen es muy mala, no se puede distinguir prácticamente nada al ser únicamente blanco y negro.               |
| 2 (4)                                                  | M                    |              Pocos niveles de gris, por lo que se perciben grandes puntos sin cambio de tonalidad.                 |
| 3 (8)                                                  | R                    |                 La calidad de imagen es regular, un experto podría identificar cada estructura, pero un inexperto podría perderse.               |
| 4 (16)                                                 | B                    |           La calidad de imagen mejora, ya es facil apreciar cualquier estructura y si estamos buscando optimizar no es un mal nivel para ver la imagen.                       |
| 5 (32)                                                 | MB                   |              La calidad de imagen se ve muy bien en relación al resto, tomando en cuenta que estamos en escala de grises.                     |
| 6 (64)                                                 | MB                   |                 Imagen muy buena, diferencias sutiles entre tonalidades que ayudan a la percepción de la imagen.               |
| 7 (128)                                                | MB                   |             Resolución alta, no presenta diferencias con la resolución anterior a simple vista                 |
| 8 (256)                                                | MB                   |            Resolución muy alta no presenta diferencias con la resolución anterior a simple vista.                      |

<img width="1610" height="869" alt="image" src="https://github.com/user-attachments/assets/05a57881-39e7-43b6-a09e-769f7c85586b" />
