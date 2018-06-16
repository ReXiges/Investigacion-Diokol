Button = {}

function Button:createButton(figureP,idP,nameP)
	local s = {size=25,figure=figureP,name=nameP}
   setmetatable(s,self)
   self.__index = self
   return s
end


function Button:returnID()
	return self.id;
end

function Button: setID(a)
	self.id=a;
end

function Button:returnName()
	return self.name;
end

function Button: setName(a)
	self.name=a;
end

function Button:returnfigure()
	return self.figure;
end

function Button: setFigure(a)
	self.figure=a;
end

function Button:returnSize()
	return self.size;
end

function Button: setSize(a)
	if(a<1) then
		a=1
	end
	self.size=a;
end


function Button:draw(x,y,color)
	event(CLICKED);
	local figure;
	local size= self.size;
	fill(color[1],color[2],color[3])
	if(self.figure=='circle') then
		ellipseMode(CENTER);
		figure=ellipse(x,y,size,size);
	end
	if(self.figure=='rectangle') then
		rectMode(CENTER);
		figure=rect(x,y,size,size)
	end
	if(self.figure=='oval') then
		ellipseMode(CENTER);
		figure=ellipse(x,y,size,size/2);
	end
	if(self.figure=='triangle') then
		figure=triangle(x,y-size/2,x+size/2,y+size/2,x-size/2,y+size/2);
	end
	fill(0)
	text(self.name,x-size/2,y-(size/2)-5);
	return figure;
end
