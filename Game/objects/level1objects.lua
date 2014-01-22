x = 600
y = 100

----[[
potatoSprite = love.graphics.newImage("images/potato.png")
binSprite = love.graphics.newImage("images/bin.png")
syringeSprite = love.graphics.newImage("images/syringe_full.png")
microscopeSprite = love.graphics.newImage("images/microscope.png")
orangeSprite = love.graphics.newImage("images/orange.png")
paperSprite = love.graphics.newImage("images/crumpled_paper.png")
beakerSprite = love.graphics.newImage("images/beaker1.png")
--]]--
objects.potato = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(144,0, 191,33, 191,81, 152,134, 61,162, 18,121, 55,40),
	draw = function()
		love.graphics.polygon("line", objects.potato.body:getWorldPoints(objects.potato.shape:getPoints()))
		love.graphics.draw(potatoSprite, objects.potato.body:getX(), objects.potato.body:getY(), objects.potato.body:getAngle())
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
	shape = love.physics.newPolygonShape(39,0, 137,0, 137,489, 99,499, 88,620, 78,500, 39,488),
	draw = function()
		love.graphics.polygon("line", objects.syringe.body:getWorldPoints(objects.syringe.shape:getPoints()))
		love.graphics.draw(syringeSprite, objects.syringe.body:getX(), objects.syringe.body:getY(), objects.syringe.body:getAngle())
	end,
	click = function() end,	
}

objects.microscope = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(186,0, 266,108, 306,300, 236,521, 8,521, 8,218),
	draw = function()
		love.graphics.polygon("line", objects.microscope.body:getWorldPoints(objects.microscope.shape:getPoints()))
		love.graphics.draw(microscopeSprite, objects.microscope.body:getX(), objects.microscope.body:getY(), objects.microscope.body:getAngle())
	end,
	click = function() end,	
}

objects.orange = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(0,103, 97,19, 221,19, 304,113, 284,221, 184,296, 79,271, 16,203),
	draw = function()
		love.graphics.polygon("line", objects.orange.body:getWorldPoints(objects.orange.shape:getPoints()))
		love.graphics.draw(orangeSprite, objects.orange.body:getX(), objects.orange.body:getY(), objects.orange.body:getAngle())
	end,
	click = function() end,	
}

objects.paper = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(50,0, 174,9, 227,56, 211,173, 144,218, 37,203, 0,133, 0,50),
	draw = function()
		love.graphics.polygon("line", objects.paper.body:getWorldPoints(objects.paper.shape:getPoints()))
		love.graphics.draw(paperSprite, objects.paper.body:getX(), objects.paper.body:getY(), objects.paper.body:getAngle())
	end,
	click = function() end,	
}

objects.beaker = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(155,11, 240,11, 240,209, 403,581, 0,581, 155,209),
	draw = function()
		love.graphics.polygon("line", objects.beaker.body:getWorldPoints(objects.beaker.shape:getPoints()))
		love.graphics.draw(beakerSprite, objects.beaker.body:getX(), objects.beaker.body:getY(), objects.beaker.body:getAngle())
	end,
	click = function() end,
}