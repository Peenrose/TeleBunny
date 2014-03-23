thrownObjects = 0

touching_ground = {}
foot_touching_ground = {}
kickReset = {}
lastx = {}
traveledLastSecond = {}
secondCounter = {}

bunnyHealth = 2
frozenCouch = true
frozenPainting = true
killedHazmat = 0

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

	if killedHazmat < 5 and objects["bunny"] ~= nil then objects["bunny"][1].body:setX(math.max(2000-levelTime*100, 1720)) end

	if killedHazmat >= 5 then
		transition = transition + dt
		if transition >= 10 then
			loadLevel(4)
		end
		if transition > 5 then
			objects["bunny"][1].fixture:setMask(1)
			objects["bunny"][1].body:setX(objects["bunny"][1].body:getX()-400*dt)
		end
	end
	if mouseJoint ~= nil then
		strength = math.min(10000+levelTime*200, 20000)
		mouseJoint:setMaxForce(strength)
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
	avelx, avely = a:getBody():getLinearVelocity()
	bvelx, bvely = b:getBody():getLinearVelocity()
	avel = math.abs(avelx) + math.abs(avely)
	bvel = math.abs(bvelx) + math.abs(bvely)

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

	if uid ~= nil and other ~= nil and forceA+forceB > 3000 and isSwatPart(other) == false then
		if math.random(1, 20) == 20 then fadeOutObject("swat", uid, 3) killedHazmat = killedHazmat + 1 end
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