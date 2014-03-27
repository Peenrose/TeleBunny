touching_ground = {}
foot_touching_ground = {}
kickReset = {}
lastx = {}
traveledLastSecond = {}
secondCounter = {}

bunnyHealth = 2
frozenTree = true
killedRiot = 0

function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg4.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	addObject("tree")	

	riot = true
	addObject("swatcar")
	fadeOut["swat"] = {}
		startSong:stop()

	if midSong == nil then
		midSong = love.audio.newSource("music/mid_song.mp3")
		midSong:setLooping(true)
		midSong:play()
	end
end

function swatDeath(name)
	x = math.random(1,3)
	if x == 1 then
		play("scientist/pain/swatow")
	elseif x == 2 then
		play("scientist/pain/swatsensualouch")
	elseif x == 3 then
		play("scientist/pain/swatthathurt")
	end
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
	if frozenTree and objects["tree"] ~= nil and objects["tree"][1] ~= nil then
		objects["tree"][1].body:setX(1042)
		objects["tree"][1].body:setY(90)
		objects["tree"][1].body:setLinearVelocity(0,0)
		objects["tree"][1].body:setAngle(0)
	end
	if killedRiot < 6 and objects["bunny"] ~= nil then
		objects["bunny"][1].body:setX(math.max(2000-levelTime*200, 1800))
	end

	if killedRiot == 6 then
		transition = transition + dt
		if transition >= 10 then
			loadLevel(5)
		end
		if transition > 5 then
			objects["bunny"][1].fixture:setMask(1)
			objects["bunny"][1].body:setX(objects["bunny"][1].body:getX()-400*dt)
		end
	end

	if objects["swatcar"] ~= nil and levelTime > 0.5 and frozenCar then
		if objects["swatcar"][1].body:getX() < 860 then
			objects["swatcar"][1].body:setX(objects["swatcar"][1].body:getX()+500*dt)
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

	if uid ~= nil and other ~= nil and forceA+forceB > 10000 and fadeOut["swat"][uid] == nil then
		if math.random(1, 50) == 50 then
			fadeOutObject("swat", uid, 3)
			killedRiot = killedRiot + 1
			swatDeath()
			if math.random(1,2) == 2 and objects["tree"] ~= nil and objects["tree"][1] ~= nil and other == objects["tree"][1].fixture then
				fadeOutObject("tree", 1, 2)
			end
		end
	end

	if isSwatPart(a) and b == objects["bunny"][1].fixture then
		bunnyInDanger = true
	elseif isSwatPart(b) and a == objects["bunny"][1].fixture then
		bunnyInDanger = true
	end
	uid = nil
	other = nil
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