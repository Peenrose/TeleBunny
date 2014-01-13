function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	bunnyheight = 200
	bunnywidth = 200
	bunnyx = settings.window.width-200
	bunnyy = settings.window.height-205


	world = love.physics.newWorld(0, 9.81*64, true)

	--bunnySprite = love.graphics.newImage("images/bunny.png")
	carrotSprite = love.graphics.newImage("images/carrot.png")
	scientistSprite = love.graphics.newImage("images/scientist.png")

	bunnyFrames = {
		love.graphics.newImage("images/Bunny_Frames/1.png"),
		love.graphics.newImage("images/Bunny_Frames/2.png"),
		love.graphics.newImage("images/Bunny_Frames/3.png"),
		love.graphics.newImage("images/Bunny_Frames/4.png"),
	}

	bunnyFrame = 1

	bunnysx = {}
	bunnysy = {}
	bunnysx[1], bunnysy[1] = bunnywidth/bunnyFrames[1]:getWidth(), bunnyheight/bunnyFrames[1]:getHeight()
	bunnysx[2], bunnysy[2] = bunnywidth/bunnyFrames[2]:getWidth(), bunnyheight/bunnyFrames[2]:getHeight()
	bunnysx[3], bunnysy[3] = bunnywidth/bunnyFrames[3]:getWidth(), bunnyheight/bunnyFrames[3]:getHeight()
	bunnysx[4], bunnysy[4] = bunnywidth/bunnyFrames[4]:getWidth(), bunnyheight/bunnyFrames[4]:getHeight()

	objects = {
		ground = {
			body = love.physics.newBody(world, settings.window.width, settings.window.height-(100*scaley), "static"),
			shape = love.physics.newRectangleShape(settings.window.width*2, 10*scaley),
			draw = function()
				love.graphics.setColor(50,205,50)
				love.graphics.rectangle("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
			end,
			afterload = [[
				objects.ground.fixture:setFriction(1.2)
			]]
		},
		leftwall = {
			body = love.physics.newBody(world, 0, settings.window.height/2*scaley, "static"),
			shape = love.physics.newRectangleShape(0, settings.window.height*scaley),
			draw = function() end,
		},
		rightwall = {
			body = love.physics.newBody(world, settings.window.width*scalex, settings.window.height/2*scaley, "static"),
			shape = love.physics.newRectangleShape(0, settings.window.height*scaley),
			draw = function() end,
		},
		topwall = {
			body = love.physics.newBody(world, 0,0, "static"),
			shape = love.physics.newRectangleShape(settings.window.width*2*scalex, 0),
			draw = function() end,
		},
		bunny = {
			body = love.physics.newBody(world, bunnyx*scalex, bunnyy*scaley, "static"),
			shape = love.physics.newRectangleShape(bunnywidth*scalex, bunnyheight*scaley),
			draw = function()
				love.graphics.polygon("line", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints()))
				--love.graphics.draw(bunnySheet, bunnyQuad, objects.bunny.body:getX(), objects.bunny.body:getY(), objects.bunny.body:getAngle(), 0.139616, 0.152788, 730, 660)
				love.graphics.draw(bunnyFrames[bunnyFrame], objects.bunny.body:getX(), objects.bunny.body:getY(), objects.bunny.body:getAngle(), bunnysx[bunnyFrame]*scalex, bunnysy[bunnyFrame]*scaley, bunnyFrames[bunnyFrame]:getWidth()/2, bunnyFrames[bunnyFrame]:getHeight()/2)
			end,
			click = function() end
		},
		carrot = {
			body = love.physics.newBody(world, 500*scalex, 1*scaley, "dynamic"),
			shape = love.physics.newPolygonShape(118*scalex,0, 80*scalex,50*scaley, 37*scalex,127*scaley, -8*scalex,320*scaley, 8*scalex,330*scaley, 145*scalex,163*scaley, 160*scalex,40*scaley, 158*scalex,38*scaley),
			draw = function()
				love.graphics.polygon("line", objects.carrot.body:getWorldPoints(objects.carrot.shape:getPoints()))
				love.graphics.draw(carrotSprite, objects.carrot.body:getX(), objects.carrot.body:getY(), objects.carrot.body:getAngle(), objects.carrot.sx, objects.carrot.sy, scalex, scaley)
			end,
			click = function() end,
			xpos = 0,
			ypos = 0,
			afterload = [[
				objects.carrot.fixture = love.physics.newFixture(objects.carrot.body, objects.carrot.shape)
				tlx, tly, brx, bry = objects.carrot.fixture:getBoundingBox()
				objects.carrot.sx = (brx-tlx)/carrotSprite:getWidth()*scalex
				objects.carrot.sy = (bry-tly)/carrotSprite:getHeight()*scaley
			]]
		},
		scientist = {
			body = love.physics.newBody(world, 300*scalex, settings.window.height-200*scaley, "dynamic"),
			shape = love.physics.newRectangleShape(0,0, 69*scalex,190*scaley),
			draw = function()
				love.graphics.draw(scientistSprite, objects.scientist.body:getX(), objects.scientist.body:getY(), objects.scientist.body:getAngle(), 1*scalex, 1*scaley, 35, 95)
				love.graphics.polygon("line", objects.scientist.body:getWorldPoints(objects.scientist.shape:getPoints()))
			end,
			click = function() end,
		},
		box1 = {
			body = love.physics.newBody(world, 25*scalex, 25*scaley, "dynamic"),
			shape = love.physics.newRectangleShape(0,0, 50*scalex,50*scaley),
			draw = function() 
				love.graphics.polygon("fill", objects.box1.body:getWorldPoints(objects.box1.shape:getPoints()))
			end,
			click = function() end,
		},
		box2 = {
			body = love.physics.newBody(world, 25*scalex, 25*scaley, "dynamic"),
			shape = love.physics.newRectangleShape(0,0, 50*scalex,50*scaley),
			draw = function()
				love.graphics.polygon("fill", objects.box2.body:getWorldPoints(objects.box2.shape:getPoints()))
			end,
			click = function() end,
			afterload = [[
				boxjoint = love.physics.newRevoluteJoint(objects.box1.body, objects.box2.body, 50,50, false)
			]]
		}
	}
end

function updateBunnyFrame(dt)
	fps = 20

	if grabbedTime == nil then grabbedTime = 0 end
	if grabbed ~= "none" then
		grabbedTime = grabbedTime + dt
	elseif grabbed == "none" or grabbed == nil then
		grabbedTime = grabbedTime - dt
	end
	if grabbedTime > (1/fps)*4 then grabbedTime = (1/fps)*4 end
	if grabbedTime < 0 then grabbedTime = 0 end
	if grabbedTime == 0 then
		bunnyFrame = 1
	elseif grabbedTime <= 1/fps then
		bunnyFrame = 2
	elseif grabbedTime <= (1/fps)*2 then
		bunnyFrame = 3
	elseif grabbedTime <= (1/fps)*3 then
		bunnyFrame = 4
	end
	addInfo("Object Grab Time: "..grabbedTime)
end

stime = 0
function scientistAI(dt)
	stime = stime + dt
	if stime > 2 then
		rotation = objects.scientist.body:getAngle()*57.2957795 --radians to degrees
		while rotation > 360 do rotation = rotation - 360 end
		while rotation < -360 do rotation = rotation + 360 end
		if round(rotation, 0) == 90 then
			objects.scientist.body:setAngularVelocity(-10.4)
		elseif round(rotation, 0) == -90 then
			objects.scientist.body:setAngularVelocity(10.4)
		else
			objects.scientist.body:applyLinearImpulse(math.random(-400*scalex^2, 400*scalex^2), math.random(-400*scaley^2, -200*scaley^2))
		end
		stime = 0
	end
end

function updateLevel(dt)
	updateBunnyFrame(dt)
	scientistAI(dt)
end

function beginContact(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	--addInfo("Collision! Velocity: "..a:getBody():getLinearVelocity().. " and "..b:getBody():getLinearVelocity(), 1)
	if objects.scientist ~= nil then
		if a == objects.scientist.fixture or b == objects.scientist.fixture then
			if avel > 600 or bvel > 600 then
				if fadeOut["scientist"] == nil then
					objects.scientist.fadeout(100)
				end
				yell = "[Scientist:] "
				force = math.max(avel, bvel)
				repeat
					yell = yell.."A"
					force = force - 150
				until force <= 0
				yell = yell.."!"
				addInfo(yell, 5)
			end
		end
	end
end

function endContact(a, b, coll) end
function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load