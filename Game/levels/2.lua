function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg2.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	addObject("hazmat")


end

function updateLevel(dt)
	if bunnyInDanger then
		bunnyHealth = bunnyHealth - dt
		if bunnyHealth < 0 then
			loadLevel("game_over")
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

function beginContact(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	maxvel = math.abs(math.max(avel, bvel))

	hazmatBeginContact(a, b, coll)

	if isHazmatPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = true
	elseif isHazmatPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = true
	end

end

function endContact(a, b, coll)
	hazmatEndContact(a, b, coll)

	if isHazmatPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = false
	elseif isHazmatPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = false
	end
end

function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load