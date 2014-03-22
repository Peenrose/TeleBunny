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
	background = love.graphics.newImage("images/bg4.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	
	addObject("swat", 5)

	fadeOut["swat"] = {}
end

function updateLevelFour(dt)
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
	maxmass = math.abs(math.max(a:getBody():getMass(), b:getBody():getMass()))

	forceA = avel*a:getBody():getMass()
	forceB = bvel*b:getBody():getMass()

	swatBeginContact(a, b, coll)

	if isSwatPart(a) then
		uid = isSwatPart(a)
		other = b
	elseif isSwatPart(b) then
		uid = isSwatPart(b)
		other = a
	end

	if uid ~= nil and other ~= nil and forceA+forceB > 4000 and isSwatPart(other) == false then
		addInfo("Scientist Collision: "..forceA.." : "..forceB, 2)
		if math.random(1, 25) == 25 then fadeOutObject("swat", uid, 3) end
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