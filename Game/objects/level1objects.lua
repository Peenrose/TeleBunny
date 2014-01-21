objects.potato = {
	body = love.physics.newBody(world, x, y, "dynamic")
	shape = love.physics.newPolygonShape(coords)
	draw = function()
		love.graphics.polygon(objects.potato.body:getWorldPoints(objects.potato.shape:getPoints()))
	end,
	click = function() end,	
}

objects.bin = {
	body = love.physics.newBody(world, x, y, "dynamic")
	shape = love.physics.newPolygonShape(coords)
	draw = function()
		love.graphics.polygon(objects.bin.body:getWorldPoints(objects.bin.shape:getPoints()))
	end,
	click = function() end,	
}

objects.syringee = {
	body = love.physics.newBody(world, x, y, "dynamic")
	shape = love.physics.newPolygonShape(coords)
	draw = function()
		love.graphics.polygon(objects.syringee.body:getWorldPoints(objects.syringee.shape:getPoints()))
	end,
	click = function() end,	
}

objects.syringef = {
	body = love.physics.newBody(world, x, y, "dynamic")
	shape = love.physics.newPolygonShape(coords)
	draw = function()
		love.graphics.polygon(objects.syringef.body:getWorldPoints(objects.syringef.shape:getPoints()))
	end,
	click = function() end,	
}

objects.microscope = {
	body = love.physics.newBody(world, x, y, "dynamic")
	shape = love.physics.newPolygonShape(coords)
	draw = function()
		love.graphics.polygon(objects..body:getWorldPoints(objects..shape:getPoints()))
	end,
	click = function() end,	
}

objects.orange = {
	body = love.physics.newBody(world, x, y, "dynamic")
	shape = love.physics.newPolygonShape(coords)
	draw = function()
		love.graphics.polygon(objects..body:getWorldPoints(objects..shape:getPoints()))
	end,
	click = function() end,	
}

objects.paper = {
	body = love.physics.newBody(world, x, y, "dynamic")
	shape = love.physics.newPolygonShape(coords)
	draw = function()
		love.graphics.polygon(objects..body:getWorldPoints(objects..shape:getPoints()))
	end,
	click = function() end,	
}
