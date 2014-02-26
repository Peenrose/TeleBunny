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
	require "load"

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
			--addInfo("FPS: "..math.floor(fps))
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

function getObjects()
	collected = {}
	for name, amount in pairs(objectList) do --all types
		for uid = 1, amount do -- all per type
			if removedObjects[name] ~= nil and removedObjects[name][uid] ~= nil then

			else
				if objects[name] == nil or objects[name][uid] == nil then break end
				if objects[name][uid].fixture then
					local objectName = name.." #"..uid
					collected[objectName] = objects[name][uid]
				end
				local objectName = name.." #"..uid
				if objects[name][uid].torso ~= nil then collected[objectName.." (torso)"] = objects[name][uid].torso end
				if objects[name][uid].head ~= nil then collected[objectName.." (head)"] = objects[name][uid].head end
				if objects[name][uid].leftleg ~= nil then collected[objectName.." (leftleg)"] = objects[name][uid].leftleg end
				if objects[name][uid].rightleg ~= nil then collected[objectName.." (rightleg)"] = objects[name][uid].rightleg end
				if objects[name][uid].rightarm ~= nil then collected[objectName.." (rightarm)"] = objects[name][uid].rightarm end
				if objects[name][uid].leftarm ~= nil then collected[objectName.." (leftarm)"] = objects[name][uid].leftarm end
			end
		end
	end
	--error(to_string(objects["scientist"]))
	return collected
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
								for k2, v2 in pairs(getObjects()) do
									if k2 == k then grabbed = k end 
								end
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

function updateGrabbed()
	if mouseJoint ~= nil then
		mouseJoint.setTarget(mouseJoint, love.mouse.getPosition())
	end
end

function drawAll()
	love.graphics.setColor(255,255,255)
	if background ~= nil then love.graphics.draw(background, 0, 0) end
	if objects ~= nil then
		for name, amount in pairs(objectList) do
			for uid = 1, objectList[name] do
				--error(name..": \n"..to_string(objects[name]))
				if objects[name][uid] ~= nil then
					if objects[name][uid].draw ~= nil then
						objects[name][uid].draw(uid)
					end
				end
			end
		end
	end
end
--[[
function drawAll()
	love.graphics.setColor(255,255,255)
	if background ~= nil then love.graphics.draw(background, 0, 0) end
	if objects ~= nil then
		for k, v in pairs(objects) do
			for k2, v2 in pairs(objectList) do
				if v2.draw ~= nil and type(v2.draw) == "function" then 
					if fadeOut[k2] ~= nil then
						if fadeOut[k2].cur < 0 then fadeOut[k2].cur = 0 end
						love.graphics.setColor(255,255,255, fadeOut[k2].cur)
						v2.draw()
					else
						love.graphics.setColor(255,255,255)
						v2.draw(uid)
					end
				end
			end
		end
	end
end
]]--

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

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end