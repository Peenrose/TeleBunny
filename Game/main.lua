--crash when destroyed body has weld joint attached
--error when destroyed body has mouse joint attached

function love.load()
	settings = require "settings"

	if not love.graphics.isSupported("npot") then addInfo("Warning: your display adapter is susceptible to PO2 Syndrome", 20) end
	assert(love.graphics.isSupported("shader"), "your display adapter does not support shaders")
	assert(love.graphics.isSupported("canvas"), "your display adapter does not support canvases")

	loadLevel("menu")
end

function love.update(dt)
	if not pausedScreen then
		dt = math.min(dt, 0.05)
		updateFPS(dt)
		updateGrabbed()
		info = {}
		if currentLevel ~= "menu" then
			addInfo("FPS: "..math.floor(fps))
			--addInfo("RAM Usage: "..(collectgarbage("count")/1024).."MB")
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
		for k, v in pairs(scheduled) do
			v.time = v.time - dt
			if v.time >= 0 then
				v.action()
				table.remove(k, scheduler)
			end
		end
		for k, v in pairs(toWeld) do
			weld = love.physics.newWeldJoint(v.a, v.b, v.x, v.y, v.coll)
			table.insert(welds, weld)
		end
		--addInfo("Current Level: "..currentLevel)
		if world ~= nil then world:update(dt) end
		if updateLevel ~= nil then updateLevel(dt) end
	end
end

function love.draw()
	if pausedScreen == false then
		drawAll()
		drawInfo(deltatime)
	elseif pausedScreen == true then
		drawAll()
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(pausebackground)

		if settingsScreen == true then
			setFontSize(80)
			love.graphics.printf("Paused", 0, 100, 1920, "center")
			setFontSize(30)
			love.graphics.printf("Settings", 0, 175, 1920, "center")
			y = 200
			setFontSize(40)
			for k, v in pairs(settingsItems) do
				y = y + 100
				love.graphics.printf(v.title, 0, y, 1920, "center")
				x, y, mx, my = ((settings.window.width/2)-font:getWidth(v.title)/2)-10, y-10, font:getWidth(v.title)+20, font:getHeight(v.title)+20
				love.graphics.rectangle("line", x, y, mx, my)
				settingsHitboxes[k] = {x=x, y=y, mx=mx+x, my=my+y}
			end
		elseif settingsScreen == false then
			setFontSize(80)
			love.graphics.printf("Paused", 0, 100, 1920, "center")
			y = 200
			setFontSize(40)
			for k, v in pairs(pauseItems) do
				y = y + 100
				love.graphics.printf(v.title, 0, y, 1920, "center")
				x, y, mx, my = ((settings.window.width/2)-font:getWidth(v.title)/2)-10, y-10, font:getWidth(v.title)+20, font:getHeight(v.title)+20
				love.graphics.rectangle("line", x, y, mx, my)
				pauseHitboxes[k] = {x=x, y=y, mx=mx+x, my=my+y}
			end
		end
	end
end

function love.keypressed(key)
	if key == "escape" then pausedScreen = not pausedScreen; settingsScreen = false end
	if key == "rctrl" then debug.debug() end
end

function love.mousereleased()
	if mouseJoint ~= nil then
		mouseJoint:destroy()
		mouseJoint = nil
	end
end

function love.mousepressed(x, y, button)
	if pausedScreen == false then
		clickedon = ""
		clickedamount = 0
		for k, v in pairs(objects) do
			if objects[k].body:isActive() == true then
				if objects[k].shape ~= nil and objects[k].body ~= nil then
					localx, localy = objects[k].body:getLocalPoint(x, y)
					if objects[k].shape:testPoint(0, 0, 0, localx, localy) then
						if objects[k].body:getType() ~= "static" then
							if mouseJoint ~= nil then
								mouseJoint:destroy()
								mouseJoint = nil
							end
							mouseJoint = love.physics.newMouseJoint(objects[k].body, love.mouse.getPosition())
							--mouseJoint:setMaxForce(15000)
						end
						if objects[k].click ~= nil and type(objects[k].click) == "function" then 
							objects[k].click()
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
		if clickedon == "" then clickedon = " on nothing" end
		addInfo("click at: ("..x..", "..y..")"..clickedon, 3)
	elseif pausedScreen == true then
		lastclickx, lastclicky = x, y
		if settingsScreen == false then
			for k, v in pairs(pauseHitboxes) do
				if x > v.x and x < v.mx and y > v.y and y < v.my then
					pauseItems[k].action(button)
				end
			end
		elseif settingsScreen == true then
			for k, v in pairs(settingsHitboxes) do
				if x > v.x and x < v.mx and y > v.y and y < v.my then
					settingsItems[k].action(button)
				end
			end
		end
	end
end

function love.quit()

end

function schedule(func, time)
	table.insert(scheduled, {time=time, func=func})
end

function loadLevelRaw(levelToLoad)
	if world ~= nil then world:destroy() world = nil end
	objects = nil
	load = require ("levels/"..levelToLoad)
	load()
	load = nil
	for k, v in pairs(objects) do
		v.remove = function(self)
			objects[self].body:setActive(false)
			objects[self].draw = nil
		end
		v.fadeout = function(aps) --alpha value per second
			fadeOut[k] = {cur=255,aps=aps}
		end
		if v.fixture == nil then
			v.fixture = love.physics.newFixture(objects[k].body, objects[k].shape)
		end
	end
	for k, v in pairs(objects) do
		if v.afterload ~= nil then
			loadstring(v.afterload)()
		end
	end
	world:setCallbacks(beginContactMain, endContactMain, preSolveMain, postSolveMain)
	currentLevel = name
	return true
end

function loadLevel(name)
	result, err = pcall(loadLevelRaw, name)
	if not result then 
		addInfo(err, 60)
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
				--[[
				else
					if warnings.noDraw[v] == nil then
						addInfo("Method '"..k.."' has no draw function!", 5)
						warnings.noDraw[v] = true
					end
				]]--
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
	setFontSize(14)

	for k, v in pairs(infoMessages) do
		addInfo(v.message)
		v.time = v.time - dt
		if v.time <= 0 then
			table.remove(infoMessages, k)
		end
	end
	x, y = "", 0
	for k, v in pairs(info) do
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

function updateFPS(dt)
	fps = (0.20*lastfps)+(0.80*fps)
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