touching_ground = {}
foot_touching_ground = {}
dazed = {}
kickReset = {}
lastx = {}
traveledLastSecond = {}
secondCounter = {}
touching = {}

function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg1.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	addObject("scientist", 2)
	addObject("carrot", 1)
end

function updateLevel(dt)
	--
	if objects["bunny"][1] ~= nil then uid = 1 love.graphics.draw(cageOpen, objects["bunny"][uid].body:getX()-bunnywidth/2-110, objects["bunny"][uid].body:getY()-bunnyheight/2-75, 0, cageosx, cageosy) end
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

function isFoot(fix)
	if objects["scientist"] ~= nil then
		for k, v in pairs(objects["scientist"]) do
			if fix == v.leftleg.fixture then return k end
			if fix == v.rightleg.fixture then return k end
		end
	end
	return false
end

function beginContact(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	maxvel = math.abs(math.max(avel, bvel))
	scientistparts = 0
	if isScientistPart(a) then scientistparts = scientistparts + 1 end
	if isScientistPart(b) then scientistparts = scientistparts + 1 end

	--if scientistparts ~= 2 then if maxvel > 750 then addInfo("Collision! Velocity: "..maxvel, 4) end end


	if isScientistPart(a) or isScientistPart(b) then

		if isScientistPart(a) then
			if touching_ground[isScientistPart(a)] == nil then touching_ground[isScientistPart(a)] = 0 end
			if foot_touching_ground[isScientistPart(a)] == nil then foot_touching_ground[isScientistPart(a)] = 0 end
		elseif isScientistPart(b) then
			if touching_ground[isScientistPart(b)] == nil then touching_ground[isScientistPart(b)] = 0 end
			if foot_touching_ground[isScientistPart(b)] == nil then foot_touching_ground[isScientistPart(b)] = 0 end
		end
	end

	if isScientistPart(a) then
		if isFoot(a) then
			if b == ground.fixture then
				foot_touching_ground[isScientistPart(a)] = foot_touching_ground[isScientistPart(a)] + 1
			end
		else
			if b == ground.fixture then
				touching_ground[isScientistPart(a)] = touching_ground[isScientistPart(a)] + 1
			end
		end
	elseif isScientistPart(b) then
		if isFoot(b) then
			if a == ground.fixture then
				foot_touching_ground[isScientistPart(b)] = foot_touching_ground[isScientistPart(b)] + 1
			end
		else
			if a == ground.fixture then
				touching_ground[isScientistPart(b)] = touching_ground[isScientistPart(b)] + 1
			end
		end
	end

	if isScientistPart(a) then
		if maxvel > 800 then
			uid = isScientistPart(a)
			if dazed[uid] == nil then dazed[uid] = 0 end
			dazed[uid] = math.abs(math.min(dazed[uid] + ((maxvel-1000)/1000), 3))
		end
	end
	if isScientistPart(b) then
		if maxvel > 800 then
			uid = isScientistPart(b)
			if dazed[uid] == nil then dazed[uid] = 0 end
			dazed[uid] = math.abs(math.min(dazed[uid] + ((maxvel-1000)/1000), 3))
		end
	end
end

function endContact(a, b, coll)
	if isScientistPart(a) then
		if isFoot(a) then
			if b == ground.fixture then
				foot_touching_ground[isScientistPart(a)] = foot_touching_ground[isScientistPart(a)] - 1
			end
		else
			if b == ground.fixture then
				touching_ground[isScientistPart(a)] = touching_ground[isScientistPart(a)] - 1
			end
		end
	elseif isScientistPart(b) then
		if isFoot(b) then
			if a == ground.fixture then
				foot_touching_ground[isScientistPart(b)] = foot_touching_ground[isScientistPart(b)] - 1
			end
		else
			if a == ground.fixture then
				touching_ground[isScientistPart(b)] = touching_ground[isScientistPart(b)] - 1
			end
		end
	end
end

function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load