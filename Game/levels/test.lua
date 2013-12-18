function load()
	world = love.physics.newWorld(0, 9.81*64, true)
	
	objects = {}

	objects.ground = {}
	--objects.ground.draw = 
	objects.ground.body = love.physics.newBody(world, settings.window.width/2, 460, "static")
	objects.ground.shape = love.physics.newRectangleShape(settings.window.width, 40)
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
	objects.ground.draw = groundDraw
	objects.ground.click = function() end
end

function groundDraw()
	love.graphics.setColor(50,205,50)
	love.graphics.rectangle("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
end

function updateLevel(dt)

end

return load