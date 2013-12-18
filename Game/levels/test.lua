function load()
	world = love.physics.newWorld(0, 9.81*64, true)
	
	bunnySprite = love.graphics.newImage("images/bunny_alpha_off.png")

	objects = {}

	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, settings.window.width/2, 460, "static")
	objects.ground.shape = love.physics.newRectangleShape(settings.window.width, 40)
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
	objects.ground.draw = groundDraw
	objects.ground.fixture:setFriction(1.2)

	objects.leftwall = {}
	objects.leftwall.body = love.physics.newBody(world, 0, settings.window.height/2, "static")
	objects.leftwall.shape = love.physics.newRectangleShape(0, settings.window.height)
	objects.leftwall.fixture = love.physics.newFixture(objects.leftwall.body, objects.leftwall.shape)

	objects.rightwall = {}
	objects.rightwall.body = love.physics.newBody(world, settings.window.width, settings.window.height/2, "static")
	objects.rightwall.shape = love.physics.newRectangleShape(0, settings.window.height)
	objects.rightwall.fixture = love.physics.newFixture(objects.rightwall.body, objects.rightwall.shape)

	objects.bunny = {}
	objects.bunny.body = love.physics.newBody(world, 100, 0, "dynamic")
	objects.bunny.shape = love.physics.newRectangleShape(settings.bunny.width, settings.bunny.height)
	objects.bunny.fixture = love.physics.newFixture(objects.bunny.body, objects.bunny.shape)
	objects.bunny.draw = bunnyDraw
	objects.bunny.click = bunnyClick

	objects.bunny.invertx = 1
	objects.bunny.lessx = 0
	objects.bunny.xpos = 0
	objects.bunny.ypos = 0

	tlx, tly, brx, bry = objects.bunny.fixture:getBoundingBox()
	objects.bunny.sx = (brx-tlx)/bunnySprite:getWidth()
	objects.bunny.sy = (bry-tly)/bunnySprite:getHeight()
end

function groundDraw()
	love.graphics.setColor(50,205,50)
	love.graphics.rectangle("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
end

function bunnyDraw()
	love.graphics.setColor(255,255,255)

	--love.graphics.polygon("fill", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints()))

	love.graphics.draw(bunnySprite, objects.bunny.xpos-(settings.bunny.width/2)+objects.bunny.lessx, objects.bunny.ypos-(settings.bunny.height/2), 0, objects.bunny.invertx*objects.bunny.sx, objects.bunny.sy)
end

function bunnyClick()

end

function updateLevel(dt)
	objects.bunny.xpos, objects.bunny.ypos = objects.bunny.body:getPosition()

	if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
		objects.bunny.body:applyForce(400, 0)
		objects.bunny.invertx = 1
		objects.bunny.lessx = 0
	elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
		objects.bunny.body:applyForce(-400, 0)
		objects.bunny.invertx = -1
		objects.bunny.lessx = settings.bunny.width
	end

end

return load