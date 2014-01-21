objects.ground = {
	body = love.physics.newBody(world, settings.window.width, settings.window.height-(100), "static"),
	shape = love.physics.newRectangleShape(settings.window.width*2, 10),
	draw = function()
		--love.graphics.setColor(50,205,50)
		--love.graphics.rectangle("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	end,
	afterload = [[
		objects.ground.fixture:setFriction(1.2)
	]]
}
objects.leftwall = {
	body = love.physics.newBody(world, 0, settings.window.height/2, "static"),
	shape = love.physics.newRectangleShape(0, settings.window.height),
	draw = function() end,
}
objects.rightwall = {
	body = love.physics.newBody(world, settings.window.width, settings.window.height/2, "static"),
	shape = love.physics.newRectangleShape(0, settings.window.height),
	draw = function() end,
}
objects.topwall = {
	body = love.physics.newBody(world, 0,0, "static"),
	shape = love.physics.newRectangleShape(settings.window.width*2, 0),
	draw = function() end,
}