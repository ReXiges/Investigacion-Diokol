# Investigacion-Diokol
Jose Gonzalez 2016157695\

Sergie Salas 2016138296
# Visualizador de grafos interactivo
Se le muestra al usuario la siguiente interfaz:

![](Visualizador%20de%20Grafos%20interactivo/f1.PNG)

Los botones de Resetear y Atras hacen lo que dicen, cualquier boton en Diokol tiene el problema de que a veces se apreta varias veces.

Una vez se usa el slider se pueden visualizar mas niveles:

![](Visualizador%20de%20Grafos%20interactivo/f4.PNG)

Luego se puede hacer click en uno de los nodos(los cuales muestran su nombre con el mouse encima):

![](Visualizador%20de%20Grafos%20interactivo/fAbriendo.PNG)

y se va a abrir ese nodo como el centro para poder ver el resto del grafo, esto sirve para grafos infinitos o enciclados, ya que se limita el numero de niveles a ver.

Todo se carga de un archivo llamado set.csv en la carpeta data de Diokol

PD: El problema de toda la vida con Diokol, si hay muchos nodos se puede cerrar forzosamente.

#Visualizador de nodos

Todos los nodos deben estar en el archivo nodes.tsv en la misma carpeta en la que se encuentra la aplicacion
En este archivo los campos deben estar separados por una tabulacion horizontal.
	
	
El formato de cada nodo debe seguir el siguiente orden separados por un tab:

figura: esta es la seleccion las opciones son rectangle, triangle, circle o oval

TAG: esta es una seccion de identificador es lo que saldra a un lado de la figura debe ser un string

Nombre: este es el nombre del nodo

R: cañon de color Rojo numero de 0 a 255 (se recomienda poner en cero y editar posteriormente con la aplicacion)

G: cañon de color verde numero de 0 a 255 (se recomienda poner en cero y editar posteriormente con la aplicacion)

B: cañon de color azul numero de 0 a 255 (se recomienda poner en cero y editar posteriormente con la aplicacion)

X: posicion en el eje X (se recomienda poner en cero y editar posteriormente con la aplicacion)

Y: posicion en el eje Y (se recomienda poner en cero y editar posteriormente con la aplicacion)

Comentario Extra: algun comentario corto sobre el nodo que se desee agregar

Tamaño: un valor mayor o igual a 1, este refleja el tamaño de la figura (se recomienda poner en 20 y editar posteriormente con la aplicacion)

Valor: un valor entero que se le quiera asignar al nodo.
	
	
un ejemplo de un nodo es el siguiente(ignorar la primera linea, solo es de guia): 
	
Figura   Tag nombre  R    G  B    X   Y    comentario    tam valor 

triangle	PN	primero	0	255	0	171	111	Esto es un nodo	24	23
	
se deseaba poner el ingreso de nuevos nodos desde la aplicacion, lastimosamente por limitaciones con la herramienta no se pudo implementar.

Las funcionalidades que tiene esta aplicacion son incrementar o decrementar el tamaño de una figura con la rueda del mouse.
Cambiar el color o forma de la figura.
Mover la posicion de la figura, se mueve la figura seleccionada.
Guardar cualquier cambio hecho.
Visualizar los datos dentro del nodo
	
Para poder hacer los cambios se debe activar esta funcion, esta en la posicion superior derecha de la pantalla con un boton, este es blanco para desactivado y gris para activado.
Para seleccionar un nodo para editar o visualizar su informacion se le hace click.
Debido a limitaciones de software para poder editar un nodo diferente al seleccionado actualmente se debe desactivar los cambios y volverlos a activar y luego seleccionar el nuevo nodo.
Para guardar cualquier cambio hecho se da click en el boton negro en la parte superior derecha.

Para el uso correcto de la aplicacion se deben tener las clases csv.lua, Node.lua y Button.lua en la misma carpeta que la aplicacion.
Tambien se provee un archivo de ejemplo con algunos nodos prehechos para prueba.

un ejemplo de como se ve el ejemplo dado:

![](Visualizador%20de%20nodos/ejemplo.png)
