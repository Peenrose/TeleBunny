--drag radius
--get objects function

function setResolution(x, y)
	--love.window.setMode(x, y, {fullscreen=fullscreen})
	local scrx, scry = love.window.getDesktopDimensions()
	local full = true
	if scrx == x and scry == y then 
		full = true
		resolutionX, resolutionY = x, y
	elseif x > scrx or y > scry then
		full = true
		resolutionX, resolutionY = love.graphics.getResolution()
	else
		full = false
		resolutionX, resolutionY = x, y
		if x/y ~= 1920/1080 then
			addInfo("Incorrect aspect ratio")
		end
	end
	setMode(resolutionX, resolutionY, settings.displayFlags.fullscreen)
end

function setMode(x, y, full)
	love.window.setMode(x, y, {fullscreen=full})
end

function love.load()
	settings = require "settings"

	if not love.graphics.isSupported("npot") then addInfo("Warning: your display adapter is susceptible to PO2 Syndrome", 20) end
	assert(love.graphics.isSupported("shader"), "your display adapter does not support shaders")
	assert(love.graphics.isSupported("canvas"), "your display adapter does not support canvas use")

	setResolution(settings.window.width, settings.window.height)

	loadLevel("1")
end

function love.update(dt)
	if not paused then
		dt = math.min(dt, 0.05)
		updateFPS(dt)
		updateGrabbed()
		info = {}
		if currentLevel ~= "menu" and fps < 50 then
			addInfo("FPS: "..math.floor(fps))
		end
		
		for k, v in pairs(fadeOut) do
			if fadeOut[k].cur < 0 then fadeOut[k].cur = 0 end
			if fadeOut[k].cur > 0 then
				fadeOut[k].cur = fadeOut[k].cur - fadeOut[k].aps*dt
			elseif fadeOut[k].cur == 0 then 
				objects[k].remove(k)
				fadeOut[k] = nil
			end
		end
		for k, v in pairs(toWeld) do
			weld = love.physics.newWeldJoint(v.a, v.b, v.x, v.y, v.coll)
			table.insert(welds, weld)
		end
		--addInfo("Current Level: "..currentLevel)
		if world ~= nil then world:update(dt) end
		if updateLevel ~= nil then updateLevel(dt) end
		runAI(dt)
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(resolutionX/1920,resolutionY/1080)

	if paused == false then
		drawAll()
		drawInfo(deltatime)
	elseif paused == true then
		drawAll()
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(pausebackground)
		setFontSize(80)
		love.graphics.printf("Paused", 0, 100, settings.window.width, "center")
		setFontSize(30)
		love.graphics.printf(pausedMenu.title, 0, 175, settings.window.width, "center")
		y = 200
		setFontSize(40)
		for k, v in pairs(pausedMenu) do
			if v.action ~= nil then
				y = y + 100
				love.graphics.printf(v.title, 0, y, settings.window.width, "center")
				setFontSize(18)
				if v.value ~= nil then love.graphics.printf(tostring(v.value), 0, y+37, settings.window.width, "center") end
				setFontSize(40)
				x, y, mx, my = ((settings.window.width/2)-font:getWidth(v.title)/2)-10, y-10, font:getWidth(v.title)+20, font:getHeight(v.title)+20
				love.graphics.rectangle("line", x, y, mx, my)
				pauseHitboxes[k] = {x=x, y=y, mx=mx+x, my=my+y}
			end
		end
	end

	love.graphics.pop()
end

function love.keypressed(key)
	if key == "escape" then togglePause() end
	if key == "rctrl" then debug.debug() end
end

function love.mousereleased()
	if mouseJoint ~= nil then
		mouseJoint:destroy()
		mouseJoint = nil
	end
	grabbed = "none"
end

function getObjects(inside, collected)
	collected = {}
	for k, v in pairs(objects) do
		if v.fixture ~= nil then
			collected.k = v
		end
	end
	return objects
end

oldGetPosition = love.mouse.getPosition
function love.mouse.getPosition()
	x, y = oldGetPosition()
	x, y = x/(resolutionX/1920), y/(resolutionY/1080)
	return x,y
end
function love.mousepressed(x, y, button)
	x = x/(resolutionX/1920)
	y = y/(resolutionY/1080)

	if paused == false then
		clickedon = ""
		clickedamount = 0
		if objects ~= nil then
			for k, v in pairs(getObjects()) do
				if v.body ~= nil and v.body:isActive() == true then
					if v.shape ~= nil and v.body ~= nil then
						localx, localy = v.body:getLocalPoint(x, y)
						if v.shape:testPoint(0, 0, 0, localx, localy) then
							if v.body:getType() ~= "static" then
								if mouseJoint ~= nil then
									mouseJoint:destroy()
									mouseJoint = nil
									grabbed = "none"
								end
								grabbed = objects[k]
								mouseJoint = love.physics.newMouseJoint(v.body, love.mouse.getPosition())
								--mouseJoint:setMaxForce(15000)
							end
							if v.click ~= nil and type(v.click) == "function" then 
								v.click()
							else
								if warnings.noClick[v] == nil then
									addInfo("Method '"..k.."' has no click function!", 5)
									warnings.noClick[v] = true
								end
							end
							if clickedamount == 0 then
								clickedon = " on "..k
								clickedamount = clickedamount + 1
							else
								clickedon = clickedon.." and "..k
								clickedamount = clickedamount + 1
							end
						end
					else
						if warnings.noShape[k] == nil then
							addInfo("Method '"..k.."' has no shape!", 5)
							warnings.noShape[k] = true
						end
					end
				end
			end
		end
		if clickedon == "" then clickedon = " on nothing" end
		addInfo("click at: ("..x..", "..y..")"..clickedon.." with "..button.." button", 3)
	elseif paused == true then
		lastclickx, lastclicky = x, y
		for k, v in pairs(pauseHitboxes) do
			if x > v.x and x < v.mx and y > v.y and y < v.my then
				pausedMenu[k].action(button)
			end
		end
	end
end

function love.quit()

end

function schedule(func, time)
	table.insert(scheduled, {time=time, func=func})
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

function checkObject(k, v)
	if type(v) == "table" then
		for k2, v2 in pairs(v) do
			checkObject(k2, v2)
		end
		if v.body ~= nil and v.shape ~= nil then
			addObjectFunctions(k, v)
		end
	end
end

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
		error("error loading level: "..name.."\n"..err)
	else 
		levelToLoad = nil
		addInfo("Level Loaded: "..name, 10)
		currentLevel = name
	end
end

function updateGrabbed()
	if mouseJoint ~= nil then
		mouseJoint.setTarget(mouseJoint, love.mouse.getPosition())
	end
end

function drawAll()
	love.graphics.setColor(255,255,255)
	if background ~= nil then love.graphics.draw(background, 0, 0) end
	if objects ~= nil then
		for k, v in pairs(objects) do
			if k ~= nil and v.body then
				if v.draw ~= nil and type(v.draw) == "function" then 
					if fadeOut[k] ~= nil then
						if fadeOut[k].cur < 0 then fadeOut[k].cur = 0 end
						love.graphics.setColor(255,255,255, fadeOut[k].cur)
						v.draw()
					else
						love.graphics.setColor(255,255,255)
						v.draw()
					end
				end
			end
		end
	end
end

function addInfo(toAdd, time)
	if time == nil then
		table.insert(info, toAdd)
	else
		table.insert(infoMessages, {message=toAdd, time=time})
	end
end

function drawInfo(dt)
	if settingsItems[2].value then
		setFontSize(15)

		for k, v in pairs(infoMessages) do
			addInfo(v.message)
			v.time = v.time - dt
			if v.time <= 0 then
				table.remove(infoMessages, k)
			end
		end
		x, y = "", 0
		for k, v in pairs(info) do
			v = tostring(v)
			if #v > #x then x = v end
			y = k*16
		end

		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill", 0, 0, font:getWidth(x), y)
		love.graphics.setColor(255,255,255)

		for k, v in pairs(info) do
			love.graphics.print(v, 0, (k*16)-16)
		end
	end
end


function updateFPS(dt)
	fps = (0.80*lastfps)+(0.20*fps)
	deltatime = dt
	playtime = playtime + dt
	lastdt = dt
	lastfps = 1/dt
end

function setFontSize(size)
	font = love.graphics.newFont(size)
	love.graphics.setFont(font)
end

function beginContactMain(a, b, coll)
	if beginContact ~= nil then beginContact(a, b, coll) end
	--if healthRemaining[a]
end

function weldJoint(a, b, x, y, coll)
	table.insert(toWeld, {a=a, b=b, x=x, y=y, coll=coll})
	
end

function endContactMain(a, b, coll) 
	if endContact ~= nil then endContact(a, b, coll) end
end

function preSolveMain(a, b, coll) 
	if preSolve ~= nil then preSolve(a, b, coll) end
end

function postSolveMain(a, b, coll) 
	if postSolve ~= nil then postSolve(a, b, coll) end
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function addObject(name, amount)
	if not amount then amount = 1 end
	for i = 1, amount do
		if love.filesystem.exists("objects/"..name..".lua") then
			if objectList[name] == nil then 
				objectList[name] = 1 
			else
				if objectList[name] >= 1 then objectList[name] = objectList[name] + 1 end
			end

			object = love.filesystem.load("objects/"..name..".lua")()
			if love.filesystem.exists("objects/ai/"..name..".lua") then
				ais[name] = love.filesystem.load("objects/ai/"..name..".lua")(deltatime)
				
				addInfo("AI loaded for "..name, 5)
			else
				addInfo("'objects/ai/"..name..".lua' has no AI", 5)
			end
		else
			addInfo("Object not found: 'objects/"..name..".lua'", 10)
			break
		end
	end
end

function runAI(dt)
	for k, v in pairs(ais) do
		func = v
		func(dt)
	end
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end