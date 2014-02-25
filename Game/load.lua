function loadLevelRaw(levelToLoad)
	lastLevel = currentLevel
	currentLevel = levelToLoad
	if world ~= nil then world:destroy() world = nil end
	objects = nil
	fadeOut = {}
	drawLevelBackground = nil
	drawLevelForeground = nil

	load = require ("levels/"..levelToLoad)
	load()
	load = nil
	if objects == nil then objects = {} end
	if world == nil then world = love.physics.newWorld(0, 9.81*64, true) end
	for k, v in pairs(objects) do
		checkObject(k, v)
	end
	for k, v in pairs(objects) do
		if v.afterload ~= nil then
			loadstring(v.afterload)()
		end
	end
	world:setCallbacks(beginContactMain, endContactMain, preSolveMain, postSolveMain)
	return true
end

function loadLevel(name)
	result, err = pcall(loadLevelRaw, name)
	if not result then 
		error("error loading level: "..name.."\n"..tostring(err))
	else 
		levelToLoad = nil
		addInfo("Level Loaded: "..name, 10)
		currentLevel = name
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
			if name == "scientist" then joinScientist(objectList[name]) end
			if love.filesystem.exists("objects/ai/"..name..".lua") then
				if aiList[name] == nil then 
					aiList[name] = 1
				else 
					if aiList[name] >= 1 then 
						aiList[name] = aiList[name] + 1 
					end 
				end
				if ais[name] == nil then ais[name] = {} end
				--local ai = love.filesystem.load("objects/ai/"..name..".lua")(uid, deltatime)
				--ais[name][aiList[name]] = ai
			else
				addInfo("'objects/ai/"..name..".lua' has no AI", 5)
			end
		end
	else
		addInfo("Object not found: 'objects/"..name..".lua'", 10)
	end
end

function addObjectFunctions(k, v)
	v.remove = function(self)
		objects[self].body:setActive(false)
		objects[self].draw = nil
	end
	v.fadeout = function(aps) --alpha value per second
		fadeOut[k] = {cur=255,aps=aps}
	end
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
	if not nil then return end
	for k, v in pairs(ais) do 
		for uid = 1, aiList[k] do
			addInfo("Running AI For: "..k.." #"..uid)
			ais[k][uid](uid, dt)
		end
	end 
end