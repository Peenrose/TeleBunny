thrownObjects = 0

touching_ground = {}
foot_touching_ground = {}
kickReset = {}
lastx = {}
traveledLastSecond = {}
secondCounter = {}

bunnyHealth = 2

function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg4.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	
	riot = true
	addObject("swatcar")
	fadeOut["swat"] = {}
end

function updateLevelFour(dt)
	if levelTime == nil then levelTime = 0 end
	levelTime = levelTime + dt
	if frozenCar and objects["swatcar"] ~= nil then
		objects["swatcar"][1].body:setFixedRotation(true)
	elseif frozenCar == false and objects["swatcar"] ~= nil then
		objects["swatcar"][1].body:setFixedRotation(false)
	end
	if bunnyInDanger then
		bunnyHealth = bunnyHealth - dt
		if bunnyHealth < 0 then
			loadLevel("game_over")
		end
	end

	if thrownObjects < 4 and objects["bunny"] ~= nil then
		objects["bunny"][1].body:setX(math.max(2000-levelTime*100, 1800))
	end

	if thrownObjects >= 4 then
		transition = transition + dt
		if transition >= 10 then
			loadLevel(2)
		end
		if transition > 5 then
			objects["bunny"][1].body:setX(objects["bunny"][1].body:getX()-400*dt)
		end
	end

	if objects["swatcar"] ~= nil and levelTime > 5 and frozenCar then
		if objects["swatcar"][1].body:getX() < 860 then
			objects["swatcar"][1].body:setX(objects["swatcar"][1].body:getX()+100*dt)
		end
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

function beginContactFour(a, b, coll)
	avelx, avely = a:getBody():getLinearVelocity()
	bvelx, bvely = b:getBody():getLinearVelocity()
	avel = math.abs(avelx) + math.abs(avely)
	bvel = math.abs(bvelx) + math.abs(bvely)
	maxvel = math.abs(math.max(avel, bvel))
	maxmass = math.abs(math.max(a:getBody():getMass(), b:getBody():getMass()))

	forceA = avel*a:getBody():getMass()
	forceB = bvel*b:getBody():getMass()

	if swatBeginContact ~= nil then swatBeginContact(a, b, coll) end

	if isSwatPart(a) then
		uid = isSwatPart(a)
		other = b
	elseif isSwatPart(b) then
		uid = isSwatPart(b)
		other = a
	end

	if uid ~= nil and other ~= nil and forceA+forceB > 8000 then
		addInfo("Scientist Collision: "..forceA.." : "..forceB, 2)
		if math.random(1, 50) == 50 then fadeOutObject("swat", uid, 3) end
	end

	if isSwatPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = true
	elseif isSwatPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = true
	end
end

function endContactFour(a, b, coll)
	if swatEndContact ~= nil then swatEndContact(a, b, coll) end

	if isSwatPart(a) and objects["bunny"][1] ~= nil and b == objects["bunny"][1].fixture then
		bunnyInDanger = false
	elseif isSwatPart(b) and objects["bunny"][1] ~= nil and a == objects["bunny"][1].fixture then
		bunnyInDanger = false
	end
end

return load