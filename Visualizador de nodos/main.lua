--Ejemplo de visualizacion de datos en diferentes nodos, los cuales se pueden editar con diferentes opciones.
--Autores: Sergie Salas 2016138296 y Jose Gonzalez 2016157695

	--Todos los nodos deben estar en el archivo nodes.tsv en la misma carpeta en la que se encuentra la aplicacion
	--En este archivo los campos deben estar separados por una tabulacion horizontal
	
	
	--El formato de cada nodo debe seguir el siguiente orden separados por un tab:
	--figure: esta es la seleccion las opciones son rectangle, triangle, circle o oval
	--TAG: esta es una seccion de identificador es lo que saldra a un lado de la figura debe ser un string
	--nombre: este es el nombre del nodo
	--R: cañon de color Rojo numero de 0 a 255 (se recomienda poner en cero y editar posteriormente con la aplicacion)
	--G: cañon de color verde numero de 0 a 255 (se recomienda poner en cero y editar posteriormente con la aplicacion)
	--B: cañon de color azul numero de 0 a 255 (se recomienda poner en cero y editar posteriormente con la aplicacion)
	--X: posicion en el eje X (se recomienda poner en cero y editar posteriormente con la aplicacion)
	--Y: posicion en el eje Y (se recomienda poner en cero y editar posteriormente con la aplicacion)
	--Comentario Extra: algun comentario corto sobre el nodo que se desee agregar
	--tamaño: un valor mayor o igual a 1, este refleja el tamaño de la figura (se recomienda poner en 20 y editar posteriormente con la aplicacion)
	--valor: un valor entero que se le quiera asignar al nodo.
	
	
	-- un ejemplo de un nodo es el siguiente(ignorar la primera linea, solo es de guia): 
	
	-- Figura   Tag nombre  R    G  B    X   Y    comentario    tam valor 
	--triangle	PN	primero	0	255	0	171	111	Esto es un nodo	24	23
	
	--se deseaba poner el ingreso de nuevos nodos desde la aplicacion, lastimosamente por limitaciones con la herramienta no se pudo implementar.

	--Las funcionalidades que tiene esta aplicacion son incrementar o decrementar el tamaño de una figura con la rueda del mouse.
	--Cambiar el color o forma de la figura.
	--Mover la posicion de la figura, se mueve la figura seleccionada.
	--Guardar cualquier cambio hecho.
	--Visualizar los datos dentro del nodo
	
	--Para poder hacer los cambios se debe activar esta funcion, esta en la posicion superior derecha de la pantalla con un boton, este es blanco para desactivado y gris para activado.
	--Para seleccionar un nodo para editar o visualizar su informacion se le hace click.
	--Debido a limitaciones de software para poder editar un nodo diferente al seleccionado actualmente se debe desactivar los cambios y volverlos a activar y luego seleccionar el nuevo nodo.
	--para guardar cualquier cambio hecho se da click en el boton negro en la parte superior derecha.

	--para el uso correcto de la aplicacion se deben tener las clases csv.lua, Node.lua y Button.lua en la misma carpeta que la aplicacion.
	
	--tambien se provee un archivo de ejemplo con algunos nodos prehechos para prueba.

local csv = require("csv");
require "Node";
require "Button";


local data;
local selectedNode=nil;
local nodes={};

--Botones
local moveB;
local redB;
local blueB;
local greenB;
local yellowB;
local purpleB;
local orangeB;
local saveB;
local rectB;
local circleB;
local ovalB;
local triangleB;

--Variables utililes y colores
local move=false;
local white={255,255,255};
local grey={125,125,125};
local colorMove=white;
local red= {255,43,28};
local blue= {0,255,255};
local green={0,255,0};
local yellow={255,233,0};
local purple={253,63,146};
local orange={255,165,0};
local black={0,0,0}


function setup()
  size(800,800)
  local font = createFont("data/Vera.ttf",12)
  textFont(font)
  readNodes()
  --creacion de todos los botones
  moveB=Button:createButton('rectangle',1,'Enable Changes');
  redB=Button:createButton('rectangle',2,'Change to red');
  blueB=Button:createButton('rectangle',3,'Change to blue');
  greenB=Button:createButton('rectangle',4,'Change to green');
  purpleB=Button:createButton('rectangle',5,'Change to pink');
  yellowB=Button:createButton('rectangle',6,'Change to yellow');
  orangeB=Button:createButton('rectangle',7,'Change to orange');
  saveB=Button:createButton('rectangle',8,'Save Changes');
  triangleB=Button:createButton('triangle',9,'Change to triangle');
  rectB=Button:createButton('rectangle',10,'Change to rectangle');
  circleB=Button:createButton('circle',11,'Change to circle');
  ovalB=Button:createButton('oval',12,'Change to oval');
end

function draw()
	background(255);
	stroke(128);
	for i,node in pairs(nodes) do
		if(node:draw()) then
			selectedNode=i;
		end
	end
	fill(0,125,125);
	rectMode(CORNER);	
	rect(width()*0.70,0,width()*0.30,height())
	if(moveB:draw(width()*0.75,30,colorMove))then
		move= not(move)
		if(move)then
			colorMove=grey;
		else
			colorMove=white;
			selectedNode=nil;
		end
	end
	
	if(redB:draw(width()*0.75,80,red) and not(selectedNode==nil) and move)then
		nodes[selectedNode]:setColor(red);
	end
	
	if(blueB:draw(width()*0.75,120,blue) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setColor(blue);
	end
	
	if(greenB:draw(width()*0.75,160,green) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setColor(green);
	end
	
	if(yellowB:draw(width()*0.89,80,yellow) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setColor(yellow);
	end
	
	if(purpleB:draw(width()*0.89,120,purple) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setColor(purple);
	end
	
	if(orangeB:draw(width()*0.89,160,orange) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setColor(orange); 
	end
	--Aqui se guarda cualquier cambio que se haga a los datos
	if(saveB:draw(width()*0.89,30, black)) then
		local file = io.open("nodes.tsv", "w")
		for i,node in pairs(nodes) do
			file:write(node:returnFigure().."\t"..node:returnID().."\t"..node:returnName().."\t"..
			tostring(node:returnColor()[1]).."\t"..tostring(node:returnColor()[2]).."\t"..tostring(node:returnColor()[3])..
			"\t"..tostring(node:returnLocation()[1]).."\t"..tostring(node:returnLocation()[2]).."\t"..node:returnData().."\t"..
			tostring(node:returnSize()).."\t"..tostring(node:returnValue()).."\n");
		end
		file:close();
	end
	
	if(rectB:draw(width()*0.75,200,white) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setFigure("rectangle"); 
	end
	
	if(triangleB:draw(width()*0.75,240,white) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setFigure("triangle"); 
	end
	
	if(circleB:draw(width()*0.75,280,white) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setFigure("circle"); 
	end
	
	if(ovalB:draw(width()*0.75,320,white) and not(selectedNode==nil)and move)then
		nodes[selectedNode]:setFigure("oval"); 
	end
	
	text("Node name:",width()*0.75,340);
	
	text("Node value:",width()*0.75,380);
	
	text("Aditional Data:",width()*0.75,420);
	
	if(not(selectedNode==nil)) then
		text(nodes[selectedNode]:returnName(),width()*0.75,360);
		text(nodes[selectedNode]:returnValue(),width()*0.75,400);
		text(nodes[selectedNode]:returnData(),width()*0.75,440);
	end
end


function mouseWheel(n)

	if(not(selectedNode==nil) and move) then
		nodes[selectedNode]:setSize(nodes[selectedNode]:returnSize()+n);
	end
end

function mouseClicked(x,y)

	if(not(selectedNode==nil) and move and x<width()*0.7) then
		nodes[selectedNode]:setLocation({x,y});
	end
end

function readNodes()
	
	local data = csv.open("nodes.tsv")
	local node;
	for fields in data:lines() do
		node=Node:createNode(fields[1],fields[2],fields[3],{tonumber(fields[4]),tonumber(fields[5]),tonumber(fields[6])},tonumber(fields[7]),tonumber(fields[8]),fields[9],tonumber(fields[10]),tonumber(fields[11]));
		table.insert(nodes,node);
	end
end