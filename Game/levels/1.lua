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
	--addObject("level1objects")
	touching_ground = 0
	foot_touching_ground = 0
end

function updateLevel(dt)

end

function isScientistPart(fix) 
	if objects["scientist"] ~= nil then
		for uid = 1, objectList["scientist"] do
			for k, v in pairs(objects["scientist"][uid]) do
				if type(v) == "table" then
					for k2, v2 in pairs(v) do
						if k2 == "fixture" and v2 == fix then return true end
					end
				end
			end
		end
	end
	return false
end
function isFoot(fix) 
	if isScientistPart(fix) == true then
		for uid = 1, objectList["scientist"] do
			for k, v in pairs(objects["scientist"][uid]) do
				if k == "leftleg" or k == "rightleg" then
					if v.fixture == fix then return true end
				end
			end
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

	if objects.scientist_torso ~= nil then
		if isScientistPart(a) or isScientistPart(a) then
			if avel > 2000 or bvel > 2000 then
				--dazed face
			end
		end
	end

	if isScientistPart(a) then
		if b == objects.bunny.fixture then
			--error("Game Over.\nInsert Carrot To Continue")
		end
	elseif isScientistPart(b) then
		if a == objects.bunny.fixture then
			--error("Game Over.\nInsert Carrot To Continue")
		end
	end

	if isFoot(a) or isFoot(b) then if a == ground.fixture or b == ground.fixture then foot_touching_ground = foot_touching_ground + 1 end end

	if isScientistPart(a) then
		if b == ground.fixture then
			touching_ground = touching_ground + 1
		end
	elseif isScientistPart(b) then
		if a == ground.fixture then
			touching_ground = touching_ground + 1
		end
	end

	if scientistparts == 1 then
		if maxvel > 800 then
			--scientistDazed = math.abs(math.min(scientistDazed + ((maxvel-1000)/1000), 3))
		end
	end
end

function endContact(a, b, coll)
	if isFoot(a) or isFoot(b) then if a == ground.fixture or b == ground.fixture then foot_touching_ground = foot_touching_ground - 1 end end

	if isScientistPart(a) then
		if b == ground.fixture then
			touching_ground = touching_ground - 1
		end
	elseif isScientistPart(b) then
		if a == ground.fixture then
			touching_ground = touching_ground - 1
		end
	end
end

function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load