function loadLevelRaw(levelToLoad)
	if tonumber(levelToLoad) ~= nil then levelToLoad = tonumber(levelToLoad) end
	levelToLoad = levelToLoad
	lastLevel = currentLevel
	currentLevel = levelToLoad
	for name, data in pairs(objects) do
		for uid, v in pairs(data) do
			removeObject(name, uid)
		end
	end
	love.mousereleased()
	if world ~= nil then world:destroy() world = nil end
	objects = nil
	grabbed = "none"
	grabbedV = nil
	objectList = {}
	removedObjects = {}
	fadeOut = {scientist={}}
	drawLevelBackground = nil
	LevelForeground = nil
	touching_ground = {}
	foot_touching_ground = {}
	thrownObjects = -1
	transition = 0
	binKicked = 0
	bunnyHealth = 3
	bunnyInDanger = false
	binKicked = 0
	ais = {}
	love.mouse.setCursor(bunnyCursor)
	if mouseJoint ~= nil then
		mouseJoint:destroy()
		mouseJoint = nil
	end
	background = nil
	drawGameOver = nil
	if grabbedV ~= nil then grabbedV = nil end
	frozenPotato, frozenSyringe, frozenMicroscope, frozenPipe, frozenPipe = true, true, true, true, true
	load = require ("levels/"..levelToLoad)
	load()
	load = nil
	if objects == nil then objects = {} end
	if world == nil then world = love.physics.newWorld(0, 9.81*64, true) end
	for k, v in pairs(objects) do
		checkObject(k, v)
	end
	for name, v in pairs(objects) do
		for uid, data in pairs(v) do
			if v.afterload ~= nil then
				uid = uid
				loadstring(v.afterload)()
			end
		end
	end
	world:setCallbacks(beginContactMain, endContactMain, preSolveMain, postSolveMain)
	return true
end

function loadLevel(name)
	result, err = pcall(loadLevelRaw, name)
	if not result then 
		error("error: "..tostring(err), 20)
		paused = false
	else 
		levelToLoad = nil
		addInfo("Level Loaded: "..name, 5)
		currentLevel = name
		if currentLevel == "1" then currentLevel = 1 end
	end
end

function addObject(name, amount, args)
	if not amount then amount = 1 end
	if not args then args = {} end
	if love.filesystem.exists("objects/"..name..".lua") then
		for i = 1, amount do
			if objectList[name] == nil then 
				objectList[name] = 1 
			else
				if objectList[name] >= 1 then 
					objectList[name] = objectList[name] + 1 
				end
			end
			if objects[name] == nil then objects[name] = {} end
			objects[name][objectList[name]] = {}
			love.filesystem.load("objects/"..name..".lua")()
			objects[name][objectList[name]] = loadObject(objectList[name])
			if love.filesystem.exists("objects/ai/"..name..".lua") then
				if ais[name] == nil then
					ais[name] = love.filesystem.load("objects/ai/"..name..".lua")(deltatime)
				end
			end
		end
	else
		addInfo("Object not found: 'objects/"..name..".lua'", 10)
	end
end

function removeObject(name, uid)
		if objects[name] ~= nil and objects[name][uid] ~= nil then else return end
		if objects[name][uid].body ~= nil then objects[name][uid].body:setActive(false) end
		if name == "scientist" then
			objects[name][uid].torso.body:setActive(false)
			objects[name][uid].head.body:setActive(false)
			objects[name][uid].leftarm.body:setActive(false)
			objects[name][uid].rightarm.body:setActive(false)
			objects[name][uid].leftleg.body:setActive(false)
			objects[name][uid].rightleg.body:setActive(false)
		end
		world:update(0)
		objects[name][uid].draw = nil

		objects[name][uid] = nil
		if removedObjects[name] == nil then removedObjects[name] = {} end
		removedObjects[name][uid] = true
		grabbed = "none"
		grabbedV = nil
end

function updateFadeOut(dt)
	for name, things in pairs(fadeOut) do --name
		for k, v in pairs(things) do --uid
			v.cur = v.cur - v.aps*dt
			if v.cur <= 0 then
				removeObject(name, k)
				fadeOut[name][k] = nil
			end
		end
	end
end

function fadeOutObject(name, uid, seconds)
	if fadeOut[name] == nil then fadeOut[name] = {} end
	if fadeOut[name][uid] == nil then
		addInfo("Fading Out: "..name.." #"..tostring(uid), seconds*2)
		fadeOut[name][uid] = {cur=255, aps=255/seconds}
	end
end

function addObjectFunctions(k, v)
	if v.fixture == nil then
		if v.body ~= nil then
			if v.shape ~= nil then
				v.fixture = love.physics.newFixture(v.body, v.shape)
			else
				if warnings.noShape[k] == nil then
					warnings.noShape[k] = true
					addInfo(k.." Has no shape :(", 20)
				end
			end
		else
			if warnings.noBody[k] == nil then
				warnings.noBody[k] = true
				addInfo(k.." Has no body :(", 20)
			end
		end
	end
end

function table_print (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs (tt) do
      table.insert(sb, string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        table.insert(sb, "{\n");
        table.insert(sb, table_print (value, indent + 2, done))
        table.insert(sb, string.rep (" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
            "%s = \"%s\"\n", tostring (key), tostring(value)))
       end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

function to_string( tbl )
    if  "nil"       == type( tbl ) then
        return tostring(nil)
    elseif  "table" == type( tbl ) then
        return table_print(tbl)
    elseif  "string" == type( tbl ) then
        return tbl
    else
        return tostring(tbl)
    end
end

function runAI(dt)
	for k, v in pairs(ais) do 
		ais[k](dt)
	end 
end