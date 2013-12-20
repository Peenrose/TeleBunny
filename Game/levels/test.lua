function load()
	love.window.setTitle("Telekinetic Bunny")
	font = love.graphics.newFont(14)
	love.graphics.setFont(font)

	world = love.physics.newWorld(0, 9.81*64, true)
	
	bunnySprite = love.graphics.newImage("images/bunny.png")


	carrotSprite = love.graphics.newImage("images/carrot.png")


	bunnyx = 400
	bunnyy = 200

	objects = {
		ground = {
			body = love.physics.newBody(world, settings.window.width/2, settings.window.height-100, "static"),
			shape = love.physics.newRectangleShape(settings.window.width, 10),
			draw = groundDraw
		},
		leftwall = {
			body = love.physics.newBody(world, 0, settings.window.height/2, "static"),
			shape = love.physics.newRectangleShape(0, settings.window.height),
		},
		rightwall = {
			body = love.physics.newBody(world, settings.window.width, settings.window.height/2, "static"),
			shape = love.physics.newRectangleShape(0, settings.window.height),
		},
		bunny = {
			body = love.physics.newBody(world, bunnyx, bunnyy, "static"),
			shape = love.physics.newRectangleShape(200, 200),
			draw = bunnyDraw,
		},
		carrot = {
			body = love.physics.newBody(world, 500, 0, "dynamic"),
			shape = love.physics.newRectangleShape(settings.carrot.width, settings.carrot.height),
			draw = carrotDraw,
			click = carrotClick,

			xpos = 0,
			ypos = 0,
			rotation = 0
		}
	}

	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
	objects.ground.fixture:setFriction(1.2)
	objects.leftwall.fixture = love.physics.newFixture(objects.leftwall.body, objects.leftwall.shape)
	objects.rightwall.fixture = love.physics.newFixture(objects.rightwall.body, objects.rightwall.shape)
	objects.carrot.fixture = love.physics.newFixture(objects.carrot.body, objects.carrot.shape)
	objects.bunny.fixture = love.physics.newFixture(objects.bunny.body, objects.bunny.shape)

	tlx, tly, brx, bry = objects.carrot.fixture:getBoundingBox()
	objects.carrot.sx = (brx-tlx)/carrotSprite:getWidth()
	objects.carrot.sy = (bry-tly)/carrotSprite:getHeight()

	tlx, tly, brx, bry = objects.bunny.fixture:getBoundingBox()
	objects.bunny.sx = (brx-tlx)/bunnySprite:getWidth()
	objects.bunny.sy = (bry-tly)/bunnySprite:getHeight()

end

function carrotDraw()
	love.graphics.setColor(255,255,255)
	love.graphics.polygon("fill", objects.carrot.body:getWorldPoints(objects.carrot.shape:getPoints()))
	love.graphics.draw(carrotSprite, objects.carrot.body:getX(), objects.carrot.body:getY(), objects.carrot.body:getAngle(), objects.carrot.sx, objects.carrot.sy, carrotSprite:getWidth()/2, carrotSprite:getHeight()/2)
end

function carrotClick()

end

function groundDraw()
	love.graphics.setColor(50,205,50)
	love.graphics.rectangle("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
end

function bunnyDraw()
	--love.graphics.setColor(255,0,255)

	love.graphics.polygon("fill", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints()))

	love.graphics.draw(bunnySprite, bunnyx-((bunnySprite:getWidth()*objects.bunny.sx)/2), bunnyy-((bunnySprite:getHeight()*objects.bunny.sy)/2), 0, objects.bunny.sx, objects.bunny.sy)
end

function bunnyClick()

end

function updateLevel(dt)

	objects.carrot.xpos, objects.carrot.ypos = objects.carrot.body:getPosition()

end

return load