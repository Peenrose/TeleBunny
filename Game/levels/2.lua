frozenBeaker_3 = true
frozenBeaker_4 = true
frozenBeaker_5 = true

thrownObjects = 0
transition = 0
fadeOut["hazmat"] = {}
--http://bit.ly/1nzScTX

function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg2.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	addObject("hazmat", 4)

	addObject("beaker_1")
	addObject("beaker_2")
	addObject("beaker_3")
	addObject("beaker_4")
	addObject("beaker_5")

end

function updateLevelTwo(dt)
	if levelTime == nil then levelTime = 0 end
	levelTime = levelTime + dt

	if thrownObjects < 4 then objects["bunny"][1].body:setX(math.max(2000-levelTime*100, 1720)) end

	if bunnyInDanger then
		bunnyHealth = bunnyHealth - dt
		if bunnyHealth < 0 then
			loadLevel("game_over")
		end
	end

	if frozenBeaker_3 and objects["beaker_3"] ~= nil and objects["beaker_3"][1] ~= nil then
		objects["beaker_3"][1].body:setX(1442)
		objects["beaker_3"][1].body:setY(500)
		objects["beaker_3"][1].body:setLinearVelocity(0,0)
		objects["beaker_3"][1].body:setAngle(0)
	end

	if frozenBeaker_4 and objects["beaker_4"] ~= nil and objects["beaker_4"][1] ~= nil then
		objects["beaker_4"][1].body:setX(1601)
		objects["beaker_4"][1].body:setY(500)
		objects["beaker_4"][1].body:setLinearVelocity(0,0)
		objects["beaker_4"][1].body:setAngle(0)
	end

	if frozenBeaker_5 and objects["beaker_5"] ~= nil and objects["beaker_5"][1] ~= nil then
		objects["beaker_5"][1].body:setX(1154)
		objects["beaker_5"][1].body:setY(225)
		objects["beaker_5"][1].body:setLinearVelocity(0,0)
		objects["beaker_5"][1].body:setAngle(0)
	end
	if thrownObjects >= 4 then
		transition = transition + dt
		if transition >= 10 then
			loadLevel(3)
		end
		if transition > 5 then
			objects["bunny"][1].body:setX(objects["bunny"][1].body:getX()-400*dt)
			objects["bunny"][1].fixture:setMask(1)
		end
	end
	if objects["hazmat"] ~= nil and objects["hazmat"][1] == nil then
		if objects["hazmat"][2] == nil then
			if objects["hazmat"][3] == nil then
				if objects["hazmat"][4] == nil then
					thrownObjects = 5
				end
			end
		end
	end
end

function isHazmatPart(fix)
	if objects["hazmat"] ~= nil then
		for k, v in pairs(objects["hazmat"]) do
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

function isHazmatFoot(fix)
	if objects["hazmat"] ~= nil then
		for k, v in pairs(objects["hazmat"]) do
			if fix == v.leftleg.fixture then return k end
			if fix == v.rightleg.fixture then return k end
		end
	end
	return false
end

function beakerContact(beaker, uid)
	if math.random(1, 10) == 10 and hazmatFlail == true then
		fadeOutObject("hazmat", uid, 2)
		fadeOutObject(beaker, 1, 1.5)
		thrownObjects = thrownObjects + 1
		if grabbedV == objects["beaker_1"][1] then love.mousereleased() end
	end
end

function beginContactTwo(a, b, coll)
	avelx, avely = a:getBody():getLinearVelocity()
	bvelx, bvely = b:getBody():getLinearVelocity()
	avel = math.abs(avelx) + math.abs(avely)
	bvel = math.abs(bvelx) + math.abs(bvely)

	maxvel = math.abs(math.max(avel, bvel))

	hazmatBeginContact(a, b, coll)

	if isHazmatPart(a) then
		uid = isHazmatPart(a)
		other = b
	elseif isHazmatPart(b) then
		uid = isHazmatPart(b)
		other = a
	end

	if uid ~= nil and other ~= nil and objects ~= nil and fadeOut["hazmat"][uid] == nil and maxvel > 400 then

		if objects["beaker_1"] ~= nil and objects["beaker_1"][1] ~= nil and other == objects["beaker_1"][1].fixture and maxvel > 2500 then
			beakerContact("beaker_1", uid)
		end
		if objects["beaker_2"] ~= nil and objects["beaker_2"][1] ~= nil and other == objects["beaker_2"][1].fixture and maxvel > 2500 then
			beakerContact("beaker_2", uid)
		end
		if objects["beaker_3"] ~= nil and objects["beaker_3"][1] ~= nil and other == objects["beaker_3"][1].fixture and maxvel > 2500 then
			beakerContact("beaker_3", uid)
		end
		if objects["beaker_4"] ~= nil and objects["beaker_4"][1] ~= nil and other == objects["beaker_4"][1].fixture and maxvel > 2500 then
			beakerContact("beaker_4", uid)
		end
		if objects["beaker_5"] ~= nil and objects["beaker_5"][1] ~= nil and other == objects["beaker_5"][1].fixture and maxvel > 2500 then
			beakerContact("beaker_5", uid)
		end
		if hazmatFlail == false then hazmatFlailFunction() hazmatFlail = true end
	end



	if isHazmatPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = true
	elseif isHazmatPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = true
	end

end

function endContactTwo(a, b, coll)
	hazmatEndContact(a, b, coll)

	if isHazmatPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = false
	elseif isHazmatPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = false
	end
end

return load