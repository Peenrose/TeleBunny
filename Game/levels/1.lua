touching_ground = {}
foot_touching_ground = {}
dazed = {}
kickReset = {}
lastx = {}
traveledLastSecond = {}
secondCounter = {}
touching = {}
binKick = false
dazedImmune = {}
fadeOut["scientist"] = {}
potatoX = 648
potatoY = 560

microscopeX = 326
microscopeY = 403

syringeX = 1547
syringeY = 575

thrownObjects = -1
transition = 0
binKicked = 0

bunnyHealth = 3
bunnyInDanger = false

function load()
	frozenPotato, frozenSyringe, frozenMicroscope, frozenPipe, frozenPipe = true, true, true, true, true
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg1.png")
	windowSprite = love.graphics.newImage("images/window.png")
	objects = {}
	window = {
		body = love.physics.newBody(world, 451,489, "static"),
		shape = love.physics.newRectangleShape(1092, 348)
	}
	window.fixture = love.physics.newFixture(window.body, window.shape)
	window.fixture:setMask(1)

	addObject("walls")
	addObject("bunny")
	addObject("scientist", 3)
	addObject("carrot")
	addObject("bin")
	addObject("beaker_1")
	addObject("syringe")
	addObject("microscope")
	addObject("potato")
	addObject("pipe")
	addObject("window")
end

function updateLevelOne(dt)
	if objects["bunny"][1] ~= nil then uid = 1 love.graphics.draw(cageOpen, objects["bunny"][uid].body:getX()-bunnywidth/2-110, objects["bunny"][uid].body:getY()-bunnyheight/2-75, 0, cageosx, cageosy) end
	love.graphics.draw(windowSprite, window.body:getX(), window.body:getY(), 1, 1)

	if bunnyInDanger then
		bunnyHealth = bunnyHealth - dt
		if bunnyHealth < 0 then
			loadLevel("game_over")
		end
	end
	if getScientistsLeft() == 0 then thrownObjects = 5 end

	if objects ~= nil and objects["potato"] == nil then return end
	if frozenPotato == true then
		objects["potato"][1].body:setX(potatoX)
		objects["potato"][1].body:setY(potatoY)
		objects["potato"][1].body:setLinearVelocity(0,0)
		objects["potato"][1].body:setAngle(0)
	end

	if frozenMicroscope and objects["microscope"] ~= nil and objects["microscope"][1] ~= nil then
		objects["microscope"][1].body:setX(microscopeX)
		objects["microscope"][1].body:setY(microscopeY)
		objects["microscope"][1].body:setLinearVelocity(0,0)
		objects["microscope"][1].body:setAngle(0)
	end

	if frozenSyringe and objects["syringe"] ~= nil and objects["syringe"][1] ~= nil then
		objects["syringe"][1].body:setX(syringeX)
		objects["syringe"][1].body:setY(syringeY)
		objects["syringe"][1].body:setLinearVelocity(0,0)
		objects["syringe"][1].body:setAngle(1.5)
	end

	if frozenPipe and objects["pipe"] ~= nil and objects["pipe"][1] ~= nil then
		objects["pipe"][1].body:setX(950)
		objects["pipe"][1].body:setY(-14)
		objects["pipe"][1].body:setLinearVelocity(0,0)
		objects["pipe"][1].body:setAngle(0)
	end
	if objects["scientist"] ~= nil then if objects["scientist"][1] == nil and objects["scientist"][2] == nil and objects["scientist"][3] == nil then objects["scientist"] = nil love.mousereleased() end end
	if objects["scientist"] == nil then
		transition = transition + dt
		if transition >= 10 then
			loadLevel(2)
		end
		if transition > 5 then
			objects["bunny"][1].body:setX(objects["bunny"][1].body:getX()-400*dt)
		end
	end
end

function isScientistPart(fix)
	if objects["scientist"] ~= nil then
		for k, v in pairs(objects["scientist"]) do
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

function isScientistFoot(fix)
	if objects["scientist"] ~= nil then
		for k, v in pairs(objects["scientist"]) do
			if fix == v.leftleg.fixture then return k end
			if fix == v.rightleg.fixture then return k end
		end
	end
	return false
end

function binKick(uid)
	binKicked = binKicked + 1
	if binKicked >= 2 then
		fadeOutObject("bin", 1, 1)
		thrownObjects = thrownObjects + 1
		if thrownObjects % 2 == 0 then fadeOutObject("scientist", uid, 2) end
	end
end

function getScientistsLeft()
	if objects["scientist"] ~= nil then
		ct = 0
		if objects["scientist"][1] ~= nil then ct = ct + 1 end
		if objects["scientist"][2] ~= nil then ct = ct + 1 end
		if objects["scientist"][3] ~= nil then ct = ct + 1 end
	return ct
	else
		return 0
	end
end

function beginContactOne(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	maxvel = math.abs(math.max(avel, bvel))

	scientistBeginContact(a, b, coll)

	if isScientistPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = true
	elseif isScientistPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = true
	end

	for uid = 1, 3 do
		if kickReset[uid] == nil then kickReset[uid] = 0 end
		if kickReset[uid] > 0.8 then
			if isScientistPart(a) and objects["bin"] ~= nil and b == objects["bin"][1] then
				binKick(uid)
			elseif isScientistPart(b) and objects["bin"] ~= nil and a == objects["bin"][1] then
				binKick(uid)
			end
		end
	end

	if objects["pipe"][1] ~= nil and fadeOut["pipe"] == nil then
		if a == objects["pipe"][1].fixture then
			if isScientistPart(b) then
				fadeOutObject("scientist", isScientistPart(b), 1)
				fadeOutObject("pipe", 1, 1)
				thrownObjects = thrownObjects + 1
			end
		elseif b == objects["pipe"][1].fixture then
			if isScientistPart(a) then
				fadeOutObject("scientist", isScientistPart(a), 1)
				fadeOutObject("pipe", 1, 1)
				thrownObjects = thrownObjects + 1

				if ct == 0 then thrownObjects = 5 end
			end
		end
	end

	if isScientistPart(a) then
		local uid = isScientistPart(a)
		other = b
	elseif isScientistPart(b) then
		local uid = isScientistPart(b)
		other = a
	end

	if uid ~= nil and other ~= nil and objects ~= nil and fadeOut["scientist"][uid] == nil then
		if objects["potato"] ~= nil and objects["potato"][1] ~= nil and other == objects["potato"][1].fixture and maxvel > 3000 then
			fadeOutObject("potato", 1, 1.5)
			thrownObjects = thrownObjects + 1
			if thrownObjects % 2 == 0 then fadeOutObject("scientist", uid, 2) end
			if grabbedV == objects["potato"][1] then love.mousereleased() end
		end
		if objects["beaker_1"] ~= nil and objects["beaker_1"][1] ~= nil and other == objects["beaker_1"][1].fixture and maxvel > 2000 then
			fadeOutObject("beaker_1", 1, 1.5)
			thrownObjects = thrownObjects + 1
			if thrownObjects % 2 == 0 then fadeOutObject("scientist", uid, 2) end
			if grabbedV == objects["beaker_1"][1] then love.mousereleased() end
		end
		if objects["carrot"] ~= nil and objects["carrot"][1] ~= nil and other == objects["carrot"][1].fixture and maxvel > 3000 then
			fadeOutObject("carrot", 1, 1.5)
			thrownObjects = thrownObjects + 1
			if thrownObjects % 2 == 0 then fadeOutObject("scientist", uid, 2) end
			if grabbedV == objects["carrot"][1] then love.mousereleased() end
		end
		if objects["syringe"] ~= nil and objects["syringe"][1] ~= nil and other == objects["syringe"][1].fixture and maxvel > 3000 then
			fadeOutObject("syringe", 1, 1.5)
			thrownObjects = thrownObjects + 1
			if thrownObjects % 2 == 0 then fadeOutObject("scientist", uid, 2) end
			if grabbedV == objects["syringe"][1] then love.mousereleased() end
		end
		if objects["microscope"] ~= nil and objects["microscope"][1] ~= nil and other == objects["microscope"][1].fixture and maxvel > 1800 then
			fadeOutObject("microscope", 1, 1.5)
			thrownObjects = thrownObjects + 1
			if thrownObjects % 2 == 0 then fadeOutObject("scientist", uid, 2) end
			if grabbedV == objects["microscope"][1] then love.mousereleased() end
		end
		if objects["bin"] ~= nil and objects["bin"][1] ~= nil and other == objects["bin"][1].fixture and maxvel > 600 then
			fadeOutObject("bin", 1, 1.5)
			thrownObjects = thrownObjects + 1
			if thrownObjects % 2 == 0 then fadeOutObject("scientist", uid, 2) end
			if grabbedV == objects["bin"][1] then love.mousereleased() end
		end
	end
end

function endContactOne(a, b, coll)
	scientistEndContact(a, b, coll)

	if isScientistPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = false
	elseif isScientistPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = false
	end
end

function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load