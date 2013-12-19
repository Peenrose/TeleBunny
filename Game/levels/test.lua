function load()
	font = love.graphics.newFont(14)
	love.graphics.setFont(font)

	world = love.physics.newWorld(0, 9.81*64, true)
	
	bunnyOff = love.graphics.newImage("images/bunny_alpha_off.png")
	bunnyOn = love.graphics.newImage("images/bunny_alpha_on.png")

	bunnySprite = bunnyOff

	carrotSprite = love.graphics.newImage("images/carrot.png")

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

	objects.carrot = {}
	objects.carrot.body = love.physics.newBody(world, 600, 0, "dynamic")
	objects.carrot.shape = love.physics.newRectangleShape(settings.carrot.width, settings.carrot.height)
	objects.carrot.fixture = love.physics.newFixture(objects.carrot.body, objects.carrot.shape)
	objects.carrot.draw = carrotDraw
	objects.carrot.click = carrotClick

	objects.carrot.xpos = 0
	objects.carrot.ypos = 0

	tlx, tly, brx, bry = objects.carrot.fixture:getBoundingBox()
	objects.carrot.sx = (brx-tlx)/carrotSprite:getWidth()
	objects.carrot.sy = (bry-tly)/carrotSprite:getHeight()
end

function carrotDraw()
	love.graphics.setColor(255,255,255)
	love.graphics.polygon("fill", objects.carrot.body:getWorldPoints(objects.carrot.shape:getPoints()))
	love.graphics.draw(carrotSprite, objects.carrot.xpos-(settings.carrot.width/2), objects.carrot.ypos-(settings.carrot.height/2), 0, objects.carrot.sx, objects.carrot.sy)
end

function carrotClick()

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
	objects.carrot.xpos, objects.carrot.ypos = objects.carrot.body:getPosition()

	if love.keyboard.isDown("d") then
		objects.bunny.body:applyForce(400, 0)
		objects.bunny.invertx = 1
		objects.bunny.lessx = 0
	elseif love.keyboard.isDown("a") then
		objects.bunny.body:applyForce(-400, 0)
		objects.bunny.invertx = -1
		objects.bunny.lessx = settings.bunny.width
	end

	if love.keyboard.isDown("w") and objects.bunny.ypos > 413 then
		print("jump")
		x, y = objects.bunny.body:getLinearVelocity()
		objects.bunny.body:setLinearVelocity(x, y-350)
	end

end

return load