function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg1.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	addObject("scientist")
	--addObject("carrot")
	addObject("level1objects")
	touching_ground = 0
	foot_touching_ground = 0
end

function updateLevel(dt)

end

function beginContact(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	maxvel = math.abs(math.max(avel, bvel))
	scientistparts = 0
	if isScientistPart(a) then scientistparts = scientistparts + 1 end
	if isScientistPart(b) then scientistparts = scientistparts + 1 end
	if scientistparts ~= 2 then if maxvel > 750 then addInfo("Collision! Velocity: "..maxvel, 4) end end

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

	if isFoot(a) or isFoot(b) then if a == objects.ground.fixture or b == objects.ground.fixture then foot_touching_ground = foot_touching_ground + 1 end end

	if isScientistPart(a) then
		if b == objects.ground.fixture then
			touching_ground = touching_ground + 1
		end
	elseif isScientistPart(b) then
		if a == objects.ground.fixture then
			touching_ground = touching_ground + 1
		end
	end

	if scientistparts == 1 then
		maxvel = math.max(math.abs(xvel), math.abs(yvel))
		if maxvel > 800 then
			scientistDazed = math.abs(math.min(scientistDazed + ((maxvel-1000)/1000), 3))
		end
	end
end

function endContact(a, b, coll)
	if isFoot(a) or isFoot(b) then if a == objects.ground.fixture or b == objects.ground.fixture then foot_touching_ground = foot_touching_ground - 1 end end

	if isScientistPart(a) then
		if b == objects.ground.fixture then
			touching_ground = touching_ground - 1
		end
	elseif isScientistPart(b) then
		if a == objects.ground.fixture then
			touching_ground = touching_ground - 1
		end
	end
end

function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load