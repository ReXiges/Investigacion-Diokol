Node = {}

function Node:createNode(figureP,idP,nameP,colorP,xP,yP,dataP,sizeP, valueP)
	local s = {size=sizeP,figure=figureP,name=nameP,id=idP,x=xP,y=yP,data=dataP,color=colorP,value=valueP}
   setmetatable(s,self)
   self.__index = self
   return s
end

function Node:returnID()
	return self.id;
end

function Node:returnName()
	return self.name;
end

function Node:returnValue()
	return self.value;
end

function Node:returnData()
	return self.data;
end

function Node:returnColor()
	return self.color;
end

function Node:setColor(a)
	self.color=a;
end


function Node:returnLocation()
	return {self.x,self.y};
end

function Node:setLocation(a)
	self.x=a[1];
	self.y=a[2];
end

function Node:returnFigure()
	return self.figure;
end

function Node:setFigure(a)
	self.figure=a;
end

function Node:returnSize()
	return self.size;
end

function Node:setSize(a)
	if(a<1) then
		a=1
	end
	self.size=a;
end

function Node:draw()
	event(CLICKED);
	local figure;
	local size= self.size;
	local color=self.color
	fill(color[1],color[2],color[3])
	if(self.figure=='circle') then
		ellipseMode(CENTER);
		figure=ellipse(self.x,self.y,size,size);
	end
	if(self.figure=='rectangle') then
		rectMode(CENTER);
		figure=rect(self.x,self.y,size,size)
	end
	if(self.figure=='oval') then
		ellipseMode(CENTER);
		figure=ellipse(self.x,self.y,size,size/2);
	end
	if(self.figure=='triangle') then
		figure=triangle(self.x,self.y-size,self.x+size,self.y+size,self.x-size,self.y+size);
	end
	fill(125)
	text(self.id,self.x,self.y)
	return figure;
end
