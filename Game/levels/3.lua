thrownObjects = 0

touching_ground = {}
foot_touching_ground = {}
dazed = {}
kickReset = {}
lastx = {}
traveledLastSecond = {}
secondCounter = {}

bunnyHealth = 3
frozenCouch = true
frozenPainting = true

function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg3.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	
	addObject("swat", 5)

	--addObject("fan")
	addObject("lava_lamp")
	addObject("8_ball")
	
	addObject("couch")
	addObject("painting")
	addObject("table")

	--addObject("book_1")
	--addObject("book_2")
	--addObject("book_3")
	addObject("book_4")

	fadeOut["swat"] = {}
end

function updateLevelThree(dt)
	if levelTime == nil then levelTime = 0 end
	levelTime = levelTime + dt

	if bunnyInDanger then
		bunnyHealth = bunnyHealth - dt
		if bunnyHealth < 0 then
			loadLevel("game_over")
		end
	end

	if thrownObjects < 4 and objects["bunny"] ~= nil then objects["bunny"][1].body:setX(math.max(2000-levelTime*100, 1720)) end

	if thrownObjects >= 4 then
		transition = transition + dt
		if transition >= 10 then
			loadLevel(2)
		end
		if transition > 5 then
			objects["bunny"][1].body:setX(objects["bunny"][1].body:getX()-400*dt)
		end
	end
	-- if frozenCouch and objects["couch"] ~= nil and objects["couch"][1] ~= nil then
	-- 	objects["couch"][1].body:setX(590)
	-- 	objects["couch"][1].body:setY(658)
	-- 	objects["couch"][1].body:setLinearVelocity(0,0)
	-- 	objects["couch"][1].body:setAngle(0)
	-- end
	if frozenPainting and objects["painting"] ~= nil and objects["painting"][1] ~= nil then
		objects["painting"][1].body:setX(212)
		objects["painting"][1].body:setY(206)
		objects["painting"][1].body:setLinearVelocity(0,0)
		objects["painting"][1].body:setAngle(0)
	end
	if mouseJoint ~= nil then
		strength = math.min(10000+levelTime*100, 40000)
		mouseJoint:setMaxForce(strength)
		addInfo(strength, 0)
	end
end

function isSwatPart(fix)
	if objects["swat"] ~= nil then
		for k, v in pairs(objects["swat"]) do
			if fix == v.torso.fixture then return k end
			if fix == v.leftleg.fixture then return k end
			if fix == v.rightleg.fixture then return k end
			if fix == v.leftarm.fixture then return k end
			if fix == v.rightarm.fixture then return k end
			if fix == v.head.fixture then return k end
		end
	end
	return false
end

function isSwatFoot(fix)
	if objects["swat"] ~= nil then
		for k, v in pairs(objects["swat"]) do
			if fix == v.leftleg.fixture then return k end
			if fix == v.rightleg.fixture then return k end
		end
	end
	return false
end

function beginContactThree(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	maxvel = math.abs(math.max(avel, bvel))

	swatBeginContact(a, b, coll)

	if isSwatPart(a) then
		uid = isSwatPart(a)
		other = b
	elseif isSwatPart(b) then
		uid = isSwatPart(b)
		other = a
	end

	if uid ~= nil and other ~= nil and objects ~= nil and fadeOut["swat"][uid] == nil and maxvel > 400 then

		-- if objects["beaker_1"] ~= nil and objects["beaker_1"][1] ~= nil and other == objects["beaker_1"][1].fixture and maxvel > 1000 then
		-- 	if math.random(1, 5) == 4 then
		-- 		fadeOutObject("swat", uid, 2)
		-- 		fadeOutObject("beaker_1", 1, 1.5)
		-- 		thrownObjects = thrownObjects + 1
		-- 		if grabbedV == objects["beaker_1"][1] then love.mousereleased() end
		-- 	end
		-- end
	end



	if isSwatPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = true
	elseif isSwatPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = true
	end

end

function endContactThree(a, b, coll)
	swatEndContact(a, b, coll)

	if isSwatPart(a) and objects["bunny"][1] ~= nil and b == objects["bunny"][1].fixture then
		bunnyInDanger = false
	elseif isSwatPart(b) and objects["bunny"][1] ~= nil and a == objects["bunny"][1].fixture then
		bunnyInDanger = false
	end
end

return load