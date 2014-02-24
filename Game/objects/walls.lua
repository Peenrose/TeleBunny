function getGroundHeight()
	if currentLevel == "2" then return 1070 end
	return 980
end
objects.ground = {
	body = love.physics.newBody(world, settings.window.width, getGroundHeight(), "static"),
	shape = love.physics.newRectangleShape(settings.window.width*2, 10),
	draw = function()
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	end,
	afterload = [[
		objects.ground.fixture:setFriction(1.2)
	]]
}
objects.leftwall = {
	body = love.physics.newBody(world, 0, settings.window.height/2, "static"),
	shape = love.physics.newRectangleShape(0, settings.window.height),
	afterload = [[objects.leftwall.fixture:setRestitution(0.1)]],
}
objects.rightwall = {
	body = love.physics.newBody(world, settings.window.width, settings.window.height/2, "static"),
	shape = love.physics.newRectangleShape(0, settings.window.height),
	afterload = [[objects.rightwall.fixture:setRestitution(0.1)]],
}
objects.topwall = {
	body = love.physics.newBody(world, 0,0, "static"),
	shape = love.physics.newRectangleShape(settings.window.width*2, 0),
	afterload = [[objects.topwall.fixture:setRestitution(0.1)]],
}