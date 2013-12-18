function load()
	love.window.setIcon(love.image.newImageData("images/icon.png"))
	world = love.physics.newWorld(0, 9.81*64, true)

	objects = {}

	objects.background = {}
	objects.background.body = love.physics.newBody(world, settings.window.width/2, settings.window.height/2, "static")
	objects.background.shape = love.physics.newRectangleShape(settings.window.width, settings.window.height)
	objects.background.fixture = love.physics.newFixture(objects.background.body, objects.background.shape)
	objects.background.draw = backgroundDraw
	objects.background.click = backgroundClick
end

function backgroundDraw()
	love.graphics.setColor(255,255,255)
	love.graphics.polygon("fill", objects.background.body:getWorldPoints(objects.background.shape:getPoints()))

	love.graphics.setColor(0,0,0)
	line = "Click to begin!"
	love.graphics.print(line, getCenterCoords(line, "x"), getCenterCoords(line, "y"))
end

function backgroundClick()
	loadLevel("test")
end

return load