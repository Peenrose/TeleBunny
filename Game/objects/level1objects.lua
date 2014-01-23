x = 600
y = 100

potatoSprite = love.graphics.newImage("images/potato.png")
binSprite = love.graphics.newImage("images/bin.png")
syringeSprite = love.graphics.newImage("images/syringe_full.png")
microscopeSprite = love.graphics.newImage("images/microscope.png")
orangeSprite = love.graphics.newImage("images/orange.png")
paperSprite = love.graphics.newImage("images/crumpled_paper.png")
beakerSprite = love.graphics.newImage("images/beaker1.png")

objects.potato = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(144/3,0, 191/3,33/3, 191/3,81/3, 152/3,134/3, 61/3,162/3, 18/3,121/3, 55/3,40/3),
	draw = function()
		love.graphics.polygon("line", objects.potato.body:getWorldPoints(objects.potato.shape:getPoints()))
		love.graphics.draw(potatoSprite, objects.potato.body:getX(), objects.potato.body:getY(), objects.potato.body:getAngle(), 1/3, 1/3)
	end,
	click = function() end,	
}

objects.bin = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(14,14, 58,260, 148,260, 194,0, 166,285, 38,285),
	draw = function()
		love.graphics.polygon("line", objects.bin.body:getWorldPoints(objects.bin.shape:getPoints()))
		love.graphics.draw(binSprite, objects.bin.body:getX(), objects.bin.body:getY(), objects.bin.body:getAngle())
	end,
	click = function() end,	
}

objects.syringe = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(39/4,0, 137/4,0, 137/4,489/4, 99/4,499/4, 88/4,620/4, 78/4,500/4, 39/4,488/4),
	draw = function()
		love.graphics.polygon("line", objects.syringe.body:getWorldPoints(objects.syringe.shape:getPoints()))
		love.graphics.draw(syringeSprite, objects.syringe.body:getX(), objects.syringe.body:getY(), objects.syringe.body:getAngle(), 1/4, 1/4)
	end,
	click = function() end,	
}

objects.microscope = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(186/3,0, 266/3,108/3, 306/3,300/3, 236/3,521/3, 8/3,521/3, 8/3,218/3),
	draw = function()
		love.graphics.polygon("line", objects.microscope.body:getWorldPoints(objects.microscope.shape:getPoints()))
		love.graphics.draw(microscopeSprite, objects.microscope.body:getX(), objects.microscope.body:getY(), objects.microscope.body:getAngle(), 1/3, 1/3)
	end,
	click = function() end,	
}

objects.orange = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(0,103/5, 97/5,19/5, 221/5,19/5, 304/5,113/5, 284/5,221/5, 184/5,296/5, 79/5,271/5, 16/5,203/5),
	draw = function()
		love.graphics.polygon("line", objects.orange.body:getWorldPoints(objects.orange.shape:getPoints()))
		love.graphics.draw(orangeSprite, objects.orange.body:getX(), objects.orange.body:getY(), objects.orange.body:getAngle(), 1/5, 1/5)
	end,
	click = function() end,	
}

objects.paper = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(50/4,0, 174/4,9/4, 227/4,56/4, 211/4,173/4, 144/4,218/4, 37/4,203/4, 0,133/4, 0,50/4),
	draw = function()
		love.graphics.polygon("line", objects.paper.body:getWorldPoints(objects.paper.shape:getPoints()))
		love.graphics.draw(paperSprite, objects.paper.body:getX(), objects.paper.body:getY(), objects.paper.body:getAngle(), 1/4, 1/4)
	end,
	click = function() end,	
}

objects.beaker = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
	draw = function()
		love.graphics.polygon("line", objects.beaker.body:getWorldPoints(objects.beaker.shape:getPoints()))
		love.graphics.draw(beakerSprite, objects.beaker.body:getX(), objects.beaker.body:getY(), objects.beaker.body:getAngle(), 1/4, 1/4)
	end,
	click = function() end,
}