touching_ground = {}
foot_touching_ground = {}
kickReset = {}
lastx = {}
traveledLastSecond = {}
secondCounter = {}
fadeOut["swat"] = {}
function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg5.png")
	objects = {}
	addObject("walls")
	addObject("bunny")
	riot = true
	--addObject("swat")
	addObject("black_hole")
end

function setFrame(min, max, frame) if levelTime > min and levelTime < max then bunnyFrameSet = frame end end

function addWalls()
	if addedWalls == nil then
		addedWalls = true
		newground = love.physics.newFixture(love.physics.newBody(world, 0, 1080, "static"), love.physics.newRectangleShape(100000, 10))
		rightwall = {
			body = love.physics.newBody(world, 1920, 1080/2, "static"),
			shape = love.physics.newRectangleShape(0, 100000),
		}
		rightwall.fixture = love.physics.newFixture(rightwall.body, rightwall.shape)
		leftwall = {
			body = love.physics.newBody(world, 0, 0, "static"),
			shape = love.physics.newRectangleShape(0, 100000),
		}
		leftwall.fixture = love.physics.newFixture(leftwall.body, leftwall.shape)
		topwall = {
			body = love.physics.newBody(world, 0,0, "static"),
			shape = love.physics.newRectangleShape(100000, 0),
		}
		topwall.fixture = love.physics.newFixture(topwall.body, topwall.shape)
	end
end

function updateLevelFive(dt)
	if swatsRemoved == nil then swatsRemoved = 0 end
	if carrotsSpawned == nil then carrotsSpawned = 0 end
	if levelTime == nil then levelTime = 0 end
	levelTime = levelTime + dt
	if levelTime < 2.5 and objects["bunny"] ~= nil then
		objects["bunny"][1].body:setX(2000-levelTime*75)
	end
	setFrame(6, 15, 6)
	setFrame(15, 15.1, 1)
	setFrame(15.3, 15.5, 2)
	setFrame(15.7, 15.9, 3)
	setFrame(16.1, 17, 4)
	setFrame(17, 10000, 5)

	if levelTime > 13 and not spawnRiot then
		spawnRiot = true
		addObject("swat", 20)
	end

	if objects["swat"] ~= nil then
		for k, v in pairs(objects["swat"]) do
			if v.torso.body:getX() < 400 then
				v.torso.body:applyLinearImpulse(200, -5)
				v.torso.body:applyAngularImpulse(-1000)
				v.rightleg.body:applyAngularImpulse(-600)
			end
			if levelTime > 17.5 then
				x, y = v.torso.body:getLinearVelocity()
				if math.max(x,y) > 20 then
					v.torso.body:setLinearVelocity(x/2, y/2)
				end
			end
		end
	end
	if levelTime > 18 and levelTime < 23 then
		y = objects["bunny"][1].body:getY()
		if y > 300 then
			objects["bunny"][1].body:setY(y-(dt*130))
		end
	end
	if levelTime > 20 and not pulledSwat and black_hole then
		pulledSwat = true
		swatJoint = {}
		for k, v in pairs(objects["swat"]) do
			swatJoint[k] = love.physics.newMouseJoint(v.head.body, v.head.body:getPosition())
			swatJoint[k]:setTarget(850, 300)
			swatJoint[k]:setMaxForce(60000)
		end
		--ground.body:setActive(false)
	end
	if black_hole == true and swatsRemoved < 20 then
		if math.random(1, 60) == 60 and holeAdd >= 0.075 then
			if objects["swat"][swatsRemoved+1].torso.body:getX() > 400 then
				if swatsRemoved == nil then swatsRemoved = 1 else swatsRemoved = swatsRemoved + 1 end
				fadeOutObject("swat", swatsRemoved, 1)
			end
		end
	end
	if black_hole == true and holeAdd < 0.075 and swatsRemoved == 0 then
		holeAdd = holeAdd + 0.075*(dt/3)
	end
	if swatsRemoved == 20 then
		if holeAdd > 0 then
			holeAdd = holeAdd - 0.075*(dt/5)
		end
		if holeAdd < 0 then holeAdd = 0 end
	end
	if swatsRemoved == 20 and holeAdd == 0 then
		y = objects["bunny"][1].body:getY()
		if y < 900 then
			objects["bunny"][1].body:setY(y+(dt*200))
		else bunnyFrameSet = 7 end
		if carrotsSpawned < 500 then
			addWalls()
			addObject("carrot")
			carrotsSpawned = carrotsSpawned + 1
			objects["carrot"][carrotsSpawned].body:setPosition(settings.window.width/2, 400)
			objects["carrot"][carrotsSpawned].body:setLinearVelocity(math.random(-500, 500), math.random(-500, 500))
		end
	end
end

return load