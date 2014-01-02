function love.load()
	settings = require "settings"
	loadLevel("menu")
end

function love.update(dt)
	dt = math.min(dt, 0.05)
	updateFPS(dt)
	updateGrabbed()
	info = {}
	if currentLevel ~= "menu" then
		addInfo("FPS: "..math.ceil(fps))
		--addInfo("RAM Usage: "..(collectgarbage("count")/1024).."MB")
	end
	if world ~= nil then world:update(dt) end
	if updateLevel ~= nil then updateLevel(dt) end
end

function love.draw()
	drawAll()
	drawInfo(deltatime)
end

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
	if key == "rctrl" then debug.debug() end
end

function love.mousereleased() grabbed = {}; grabbed.grabbed = "none" end

function love.mousepressed(x, y, button)
	clickedon = ""
	clickedamount = 0
	for k, v in pairs(objects) do
		if objects[k].body:isActive() == true then
			if objects[k].shape ~= nil and objects[k].body ~= nil then
				localx, localy = objects[k].body:getLocalPoint(x, y)
				if objects[k].shape:testPoint(0, 0, 0, localx, localy) then
					if objects[k].body:getType() ~= "static" then
						grabbed[k] = {}
						grabbed.grabbed = k
						grabbed[k].x, grabbed[k].y = localx, localy
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
end

function loadLevelRaw()
	load = require ("levels/"..levelToLoad)
	load()
	load = nil
	return true
end

function loadLevel(name)
	levelToLoad = name
	result, err = pcall(loadLevelRaw)
	if not result then 
		addInfo(err, 10)
	else 
		levelToLoad = nil
		addInfo("Level Loaded: "..name, 5)
		currentLevel = name
	end
end

function updateGrabbed()
	if objects ~= nil then
		for k, v in pairs(objects) do
			if grabbed[k] ~= nil then
				mx, my = love.mouse:getPosition()
				bx, by = v.body:getWorldPoint(grabbed[k].x, grabbed[k].y)
				xdif = mx-bx
				ydif = my-by
				lx, ly = v.body:getLocalPoint(mx, my)
				v.body:setLinearVelocity(0, 0)
				v.body:applyLinearImpulse(xdif*75, ydif*75, lx, ly)
				v.body:setAngularVelocity(0)
			end
		end
	end
end

function getCenterCoords(text, ori, max, xory)
	x, y = 0, 0
	if xory == "x" then
		return ((max-ori)/2)-(font:getWidth(line)/2)
	elseif xory == "y" then
		return ((max-ori)/2)-(font:getHeight(line)/2)
	end
end

function drawAll()
	love.graphics.setColor(0,0,0)
	if objects ~= nil then
		for k, v in pairs(objects) do
			if k ~= nil and v.body then
				if v.draw ~= nil and type(v.draw) == "function" then
					v.draw()
				else
					if warnings.noDraw[v] == nil then
						addInfo("Method '"..k.."' has no draw function!", 5)
						warnings.noDraw[v] = true
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
	font = love.graphics.newFont(14)
	love.graphics.setFont(font)

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