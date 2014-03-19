function setResolution(x, y, fullscreen)
	local scrx, scry = love.window.getDesktopDimensions()
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
	if full == true and fullscreen == false then full = false end
	love.window.setMode(resolutionX, resolutionY, {fullscreen=full})
end

function love.load()
	settings = require "settings"
	require "load"

	if not love.graphics.isSupported("npot") then addInfo("Warning: your display adapter is susceptible to PO2 Syndrome", 20) end
	assert(love.graphics.isSupported("shader"), "your display adapter does not support shaders")
	assert(love.graphics.isSupported("canvas"), "your display adapter does not support canvas use")

	setResolution(settings.window.width, settings.window.height, settings.displayFlags.fullscreen)

	loadLevel(3)
end

function love.update(dt)
	if not paused then
		dt = math.min(dt, 0.05)
		if bunnyHealth < 3 and bunnyInDanger then dt = math.max(dt*bunnyHealth/3, 0.5*dt) end
		updateFPS(dt)
		updateGrabbed()
		info = {}
		updateFadeOut(dt)
		for k, v in pairs(toWeld) do
			weld = love.physics.newWeldJoint(v.a, v.b, v.x, v.y, v.coll)
			table.insert(welds, weld)
		end
		addInfo("FPS: "..love.timer.getFPS(), 0)
		if world ~= nil then world:update(dt) end
		--if updateLevel ~= nil then updateLevel(dt) end
		if currentLevel == 1 then updateLevelOne(dt) end
		if currentLevel == 2 then updateLevelTwo(dt) end
		if currentLevel == 3 then updateLevelThree(dt) end
		if currentLevel == 5 then updateLevelFive(dt) end
		runAI(dt)
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(resolutionX/1920,resolutionY/1080)
	if drawGameOver ~= nil then drawGameOver() end
	drawAll()
	if paused == false then
		drawInfo(deltatime)
	elseif paused == true then
		drawPauseScreen()
	end
	if grabbed ~= "none" then
		local x, y = grabbedV.body:getWorldPoint(clickX, clickY)
		love.graphics.draw(grabImg, x, y, grabbedV.body:getAngle(), 1, 1, 25, 21)
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
	if grabbedV ~= nil then
		--grabbedV.fixture:setMask()
	end
	grabbed = "none"
end

function getObjects()
	collected = {}
	for name, amount in pairs(objectList) do --all types
		for uid = 1, amount do -- all per type
			if removedObjects[name] ~= nil and removedObjects[name][uid] ~= nil then else
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
	if currentLevel == "game_over" then loadLevel(lastLevel) end
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
								if currentLevel == 1 then if isScientistPart(v.fixture) then return end end
								if mouseJoint ~= nil then
									mouseJoint:destroy()
									mouseJoint = nil
									grabbed = "none"
								end
								for k2, v2 in pairs(getObjects()) do
									if k2 == k then 
										grabbed = k 
									end
								end
								clickX, clickY = v.body:getLocalPoint(love.mouse.getPosition())
								--v.fixture:setMask()
								grabbedV = v
								if currentLevel == 1 then
									if k == "potato #1" then
										frozenPotato = false
										v.fixture:setMask()
									end
									if k == "syringe #1" then
										frozenSyringe = false
										v.fixture:setMask()
									end
									if k == "microscope #1" then
										frozenMicroscope = false
										v.fixture:setMask()
									end
									if k == "pipe #1" then
										frozenPipe = false
										v.fixture:setMask()
									end
								elseif currentLevel == 2 then
									if k == "beaker_3 #1" then
										frozenBeaker_3 = false
										v.fixture:setMask()
									end
									if k == "beaker_4 #1" then
										frozenBeaker_4 = false
										v.fixture:setMask()
									end
									if k == "beaker_5 #1" then
										frozenBeaker_5 = false
										v.fixture:setMask()
									end
								end

								mouseJoint = love.physics.newMouseJoint(v.body, love.mouse.getPosition())
								if currentLevel == 1 then
									mouseJoint:setMaxForce(8000)
								elseif currentLevel == 2 or 3 then
									mouseJoint:setMaxForce(12000)
								end
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

function drawPauseScreen()
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
			x, y, mx, my = ((settings.window.width/2)-font:getWidth(v.title)/2)-10, y-10, font:getWidth(v.title)+20, font:getHeight(v.title)+20
			love.graphics.setColor(127,127,127,200)
			love.graphics.rectangle("fill", x, y, mx, my)
			love.graphics.setColor(255,255,255)
			setFontSize(40)
			love.graphics.printf(v.title, 0, y+10, settings.window.width, "center")
			if v.value ~= nil then
				--last = getFontSize()
				setFontSize(18)
				love.graphics.printf(tostring(v.value), 0, y+50, settings.window.width, "center")
				setFontSize(lastFontSize)
			end
			pauseHitboxes[k] = {x=x, y=y, mx=mx+x, my=my+y}
		end
	end
end

function drawAll()
	love.graphics.setColor(255,255,255)
	if background ~= nil then love.graphics.draw(background, 0, 0) end
	if objects ~= nil and objects["bunny"] ~= nil and currentLevel == 1 then uid = 1 love.graphics.draw(cageOpen, 1720-bunnywidth/2-110, objects["bunny"][uid].body:getY()-bunnyheight/2-75, 0, cageosx, cageosy) end
	if objects ~= nil then
		for name, amount in pairs(objectList) do
			love.graphics.setColor(255,255,255)
			if fadeOut[name] ~= nil and fadeOut[name][1] ~= nil then love.graphics.setColor(255,255,255, fadeOut[name][1].cur) end
			if name == "window" then
				objects["window"][1].draw(1)
			elseif name == "potato" and frozenPotato then
				objects["potato"][1].draw(1)
			elseif name == "syringe" and frozenSyringe then
				objects["syringe"][1].draw(1)
			elseif name == "microscope" and frozenMicroscope then
				objects["microscope"][1].draw(1)
			elseif name == "pipe" and frozenPipe then
				objects["pipe"][1].draw(1)

			elseif name == "beaker_3" and frozenBeaker_3 then
				objects["beaker_3"][1].draw(1)
			elseif name == "beaker_4" and frozenBeaker_4 then
				objects["beaker_4"][1].draw(1)
			elseif name == "beaker_5" and frozenBeaker_5 then
				objects["beaker_5"][1].draw(1)
			end
		end
		for name, amount in pairs(objectList) do
			love.graphics.setColor(255,255,255)
			if fadeOut[name] ~= nil and fadeOut[name][1] ~= nil then love.graphics.setColor(255,255,255, fadeOut[name][1].cur) end
			if name == "potato" and not frozenPotato then
				if objects["potato"][1] ~= nil then objects["potato"][1].draw(1) end
			elseif name == "syringe" and not frozenSyringe then
				if objects["syringe"][1] ~= nil then objects["syringe"][1].draw(1) end
			elseif name == "microscope" and not frozenMicroscope then
				if objects["microscope"][1] ~= nil then objects["microscope"][1].draw(1) end
			elseif name == "pipe" and not frozenPipe then
				if objects["pipe"][1] ~= nil then objects["pipe"][1].draw(1) end


			elseif name == "beaker_3" and not frozenBeaker_3 then
				if objects["beaker_3"][1] ~= nil then objects["beaker_3"][1].draw(1) end
			elseif name == "beaker_4" and not frozenBeaker_4 then
				if objects["beaker_4"][1] ~= nil then objects["beaker_4"][1].draw(1) end
			elseif name == "beaker_5" and not frozenBeaker_5 then
				if objects["beaker_5"][1] ~= nil then objects["beaker_5"][1].draw(1) end

			else
				for uid = 1, objectList[name] do
					if objects[name]~= nil and objects[name][uid] ~= nil then
						if objects[name][uid].draw ~= nil and name ~= "window" and name ~= "syringe" and name ~= "microscope" and name ~= "pipe" and name ~= "potato" and name ~= "beaker_3" and name ~= "beaker_4" and name ~= "beaker_5" then
							love.graphics.setColor(255,255,255)
							if fadeOut[name] ~= nil and fadeOut[name][uid] ~= nil then love.graphics.setColor(255,255,255, fadeOut[name][uid].cur) end
							objects[name][uid].draw(uid)
						end
					end
				end
			end
		end
	end
end

function addInfo(toAdd, time)
	if time == nil then
		table.insert(info, message)
	else
		table.insert(infoMessages, {message=toAdd, time=time})
	end
end

function drawInfo(dt)
	if settingsItems[3].value then
		setFontSize(15)

		for k, v in pairs(infoMessages) do
			table.insert(info, v.message)
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
	deltatime = dt
	playtime = playtime + dt
	lastdt = dt
end

function setFontSize(size)
	lastFontSize = getFontSize()
	fontSize = size
	font = love.graphics.newFont(size)
	love.graphics.setFont(font)
end
function getFontSize() return fontSize end
function beginContactMain(a, b, coll)
	if beginContact ~= nil then beginContact(a, b, coll) end
	if currentLevel == 1 and beginContactOne ~= nil then beginContactOne(a, b, coll) end
	if currentLevel == 2 and beginContactTwo ~= nil then beginContactTwo(a, b, coll) end
	if currentLevel == 3 and beginContactThree ~= nil then beginContactThree(a, b, coll) end
	--if healthRemaining[a]
end

function weldJoint(a, b, x, y, coll)
	table.insert(toWeld, {a=a, b=b, x=x, y=y, coll=coll})
	
end

function endContactMain(a, b, coll) 
	if endContact ~= nil then endContact(a, b, coll) end
	if currentLevel == 1 and endContactOne ~= nil then endContactOne(a, b, coll) end
	if currentLevel == 2 and endContactTwo ~= nil then endContactTwo(a, b, coll) end
	if currentLevel == 3 and endContactThree ~= nil then endContactThree(a, b, coll) end
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