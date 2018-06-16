node={}

--la idea es poder cambiar el nodo del centro para poder ver los demas relativos a ese
--asi que les puede hacer click para entrar
--Problemas es cuando encuentra uno en que hay que ver muchos nodos
--y cuando se apreta un boton a veces se apreta doble por el tiempo que da diokol

--Funcion que crea el nodo, solo me interesa el nombre y su id por ahora
function node:createNode(pid,pname)
	local s = {id=pid,nodes={},name=pname}
	setmetatable(s,self)
	self.__index = self
	return s
end


--aqui le pongo los hijos
function node:addNode(pnode)
	table.insert(self.nodes,pnode)
end

--la funcion que es basicamente toda la investigacion, separa 
--la circunferencia de un circulo y pone los nodos ahi, crea las lineas y
--se llama recursivamente en el for para graficar los demas
function node:drawNodes(from,to,separation,layer,maxDepth)
	local angle = from + (to-from)/2
	
	local distance=layer * separation
	local x= distance * math.cos(angle)/2
	local y= distance * math.sin(angle)/2
	
	event(0)
	local touched = ellipse(x,y,10,10)
	if touched then text(self.name,x,y) end
	noEvent()
	
	event(2)
	local touched = ellipse(x,y,10,10)
	if touched then centro = self table.insert(atras,self) end
	noEvent()
	
	if #self.nodes == 0 or layer >= maxDepth then return {x,y} end
	local space = (to-from)/#self.nodes
	for i=1,#self.nodes do
		local son = nodes[self.nodes[i]]:drawNodes(from + space*(i-1),from + space*i , separation ,layer+1,maxDepth)
		line(x,y,son[1],son[2])
	end
	return {x,y}
end


function setup()
	size(800, 600);
	nodes = readNodes(readFile('data/set.csv',','))
	f = createFont("data/Vera.ttf",14)
	textFont(f)
	centro = nodes[1]
	sliders={{150,10,160,0,0}}
	ancho =10
	maxLayer=5
	atras={nodes[1]}
end

function draw()

	textAlign(CENTER)
	background(3,79,132);
	event(2)
	fill(146,168,209)
	boton = rect(0,0,60,30)
	
	if boton then centro = nodes[1] end 
	fill(0)
	text("Resetear",30,15)

	fill(146,168,209)
	boton = rect(60,0,60,30)
	if boton then 
	if #atras>1 then 
	table.remove(atras,#atras)
	centro = atras[#atras]
	end	
	end
	fill(0)
	text("Atras",90,15)
	noEvent()



	pushMatrix()
	translate(400,300)
	fill(247,120,107)
	stroke(247,202,201)
	centro:drawNodes(0,2*PI,100,0,sliders[1][4]/40 + 1)
	popMatrix()
	
	--el baner de abaajo
	textAlign(LEFT)
	fill(255)
	rect(0,480,250,120)
	fill(0)
	text("Si escoge un nodo con muchos hijos",0,500)
	text("o una profundidad muy grande",0,520)
	text("es posible que se caiga",0,540)
	text("tbm cuesta apretar los botones solo 1 vez",0,560)
	text("Es problema de Diokol",0,580)
	
	-- funcion de dibujar sliders, pude haber hecho otro objeto
	-- pero al final es lo mismo y esta funciona bien
	drawSliders()
	

end

--Una funcion generica que he usado todo el curso para obtener las lineas de un archivo
--lo separa de una vez
function readFile(filename,separator)
	local file = io.open(filename,"r");
	local result ={}
	while true do
		local line = file:read()
			if line == nil then break end
			local linea ={}
			for str in string.gmatch(line, "([^".. separator .."]+)") do
				table.insert(linea,str)
			end
			table.insert(result,linea)
	end
	return result
end

--procesa la informacion obtenida en readFile y crea los objetos nodos
function readNodes(data)
	local result={}
	for i=2,#data do
		local nodeId=tonumber(data[i][1])
		result[nodeId] = node:createNode(nodeId,data[i][2])
		for j=3,#data[i] do
			result[nodeId]:addNode(tonumber(data[i][j]))
		end
	end
	return result
end

function drawSliders()
	event(DRAGGED)
	for i=1,#sliders do 
		stroke(0)
		fill(255)
		tocado = rect(sliders[i][1],sliders[i][2],sliders[i][3],ancho)
		if tocado then 
			sliders[i][4]= tocado.mouseX - sliders[i][1]                                          
		end 

		text("Profundidad:"..sliders[i][4]/40 + 1, sliders[i][3]+sliders[i][1]+30 ,sliders[i][2]+ancho/2)

		fill(0,0,255)
		rect(sliders[i][1]+sliders[i][4],sliders[i][2],10,ancho)

		fill(0)
		stroke(0)
		line(sliders[i][1],sliders[i][2]+ancho/2,sliders[i][1]+sliders[i][3],sliders[i][2]+ancho/2)
	end
end
