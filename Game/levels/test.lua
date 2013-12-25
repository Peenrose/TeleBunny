function load()
	love.window.setTitle("Telekinetic Bunny")
	font = love.graphics.newFont(14)
	love.graphics.setFont(font)

	world = love.physics.newWorld(0, 9.81*64, true)
	
	bunnySheet = love.graphics.newImage("images/Bunny Frames/bunny_sheet.png")
	bunnyQuad = imageQuad.bunny_off

	carrotSprite = love.graphics.newImage("images/carrot.png")

	bunnyx = settings.window.width-200
	bunnyy = settings.window.height-205

	grabbedTime = 0

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
		topwall = {
			body = love.physics.newBody(world, 0,0, "static"),
			shape = love.physics.newRectangleShape(settings.window.width*2, 0),
		},
		bunny = {
			body = love.physics.newBody(world, bunnyx, bunnyy, "static"),
			shape = love.physics.newRectangleShape(200, 200),
			draw = bunnyDraw,
			click = bunnyClick
		},
		carrot = {
			body = love.physics.newBody(world, 500, 1, "dynamic"),
			shape = love.physics.newPolygonShape(118,0, 80,50, 37,127, -8,320, 8,330, 145,163, 160,40, 158,38),
			draw = carrotDraw,
			click = carrotClick,

			xpos = 0,
			ypos = 0
		}
	}

	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
	objects.ground.fixture:setFriction(1.2)
	objects.leftwall.fixture = love.physics.newFixture(objects.leftwall.body, objects.leftwall.shape)
	objects.rightwall.fixture = love.physics.newFixture(objects.rightwall.body, objects.rightwall.shape)
	objects.topwall.fixture = love.physics.newFixture(objects.topwall.body, objects.topwall.shape)

	objects.carrot.fixture = love.physics.newFixture(objects.carrot.body, objects.carrot.shape)
	objects.bunny.fixture = love.physics.newFixture(objects.bunny.body, objects.bunny.shape)

	tlx, tly, brx, bry = objects.carrot.fixture:getBoundingBox()
	objects.carrot.sx = (brx-tlx)/carrotSprite:getWidth()
	objects.carrot.sy = (bry-tly)/carrotSprite:getHeight()

end

function carrotDraw()
	love.graphics.setColor(255,255,255)
	love.graphics.polygon("line", objects.carrot.body:getWorldPoints(objects.carrot.shape:getPoints()))
	love.graphics.draw(carrotSprite, objects.carrot.body:getX(), objects.carrot.body:getY(), objects.carrot.body:getAngle(), objects.carrot.sx, objects.carrot.sy)
end

function carrotClick()

end

function groundDraw()
	love.graphics.setColor(50,205,50)
	love.graphics.rectangle("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
end

function bunnyDraw()
	love.graphics.setColor(255,255,255)

	love.graphics.polygon("line", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints()))

	love.graphics.draw(bunnySheet, bunnyQuad, objects.bunny.body:getX(), objects.bunny.body:getY(), objects.bunny.body:getAngle(), 0.139616, 0.152788, 730, 660)
end

function bunnyClick()
	--
end

function updateLevel(dt)
	--calculate what bunny sprite to do
	if grabbed.grabbed ~= "none" then
		grabbedTime = grabbedTime + dt
	else
		if grabbedTime > 0 then
			grabbedTime = grabbedTime - dt
		end
	end
	if grabbedTime > 0.15 then grabbedTime = 0.15 end
	if grabbedTime < 0 then grabbedTime = 0 end

	if grabbedTime == 0 then
		bunnyQuad = imageQuad.bunny_off
	elseif grabbedTime <= 0.05 then
		bunnyQuad = imageQuad.bunny_on1
	elseif grabbedTime <= 0.1 then
		bunnyQuad = imageQuad.bunny_on2
	elseif grabbedTime <= 0.15 then
		bunnyQuad = imageQuad.bunny_on3
	end
end

return load