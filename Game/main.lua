function love.load()
	settings = require "settings"

	loadLevel("menu")
end

function love.update(dt)
	dt = math.min(dt, 0.05)
	
	updateFPS(dt)
	info = {}
	
	addInfo("FPS: "..math.ceil(fps))
	addMessages(dt)

	if objects ~= nil then
		for k, v in pairs(objects) do
			if grabbed[k] ~= nil then
				mx, my = love.mouse:getPosition()
				bx, by = v.body:getWorldPoint(grabbed[k].x, grabbed[k].y)
				xdif = mx-bx
				ydif = my-by
				lx, ly = v.body:getLocalPoint(mx, my)
				if xdif<0 then invx=-1 else invx=1 end
				if ydif<0 then invy=-1 else invy=1 end
				v.body:setLinearVelocity(0, 0)
				v.body:applyLinearImpulse(xdif*80, ydif*80, lx, ly)
				v.body:setAngularVelocity(0.5)
			end
		end
	end

	

	if world ~= nil then world:update(dt) end
	if updateLevel ~= nil then updateLevel(dt) end
end

function love.draw()
	drawAll()
	drawInfo({"FPS: "..math.ceil(fps)})
end

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
	if key == "rctrl" then debug.debug() end
	--set up key bind api
end

function love.mousereleased() grabbed = {} end

function love.mousepressed(x, y, button)
	clickedon = ""
	clickedamount = 0
	for k, v in pairs(objects) do
		if objects[k].shape ~= nil then
			localx, localy = objects[k].body:getLocalPoint(x, y)
			if objects[k].shape:testPoint(0, 0, 0, localx, localy) then
				if objects[k].body:getType() ~= "static" then
					grabbed[k] = {}
					grabbed[k].x, grabbed[k].y = localx, localy
				end
				if objects[k].click ~= nil and type(objects[k].click) == "function" then
					objects[k].click()
				else
					if warnings.noClick[v] == nil then
						warning("Method '"..k.."' has no click function")
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
				warning("Method '"..k.."' has no shape")
				warnings.noShape[k] = true
			end
		end
	end
	if clickedon == "" then clickedon = " on nothing" end
	print("click at: ("..x..", "..y..")"..clickedon)
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
		warning("Failed to load level: "..name)
		showMessage(err, 1)
	else 
		levelToLoad = nil 
		showMessage("Level Loaded: "..name, 2) 
	end
end

function warning(text)
	fill = ""
	for i = 1, (#text/2)-4 do fill = fill.."-" end
	fill = fill.." Error! "
	for i = 1, (#text/2)-4 do fill = fill.."-" end
	print(fill)
	print(text)
	fill = ""
	for i = 1, #text do fill = fill.."-" end	
	print(fill)
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
			if v.draw ~= nil and type(v.draw) == "function" then
				v.draw()
			else
				if warnings.noDraw[v] == nil then
					warning("Method '"..k.."' has no draw function")
					warnings.noDraw[v] = true
				end
			end
		end
	end
end

function addInfo(toAdd) table.insert(info, toAdd) end
function getInfo() return info end

function addMessages(dt)
	for k, v in pairs(infoMessages) do
		addInfo(v.message)
		v.time = v.time - dt
		if v.time <= 0 then
			table.remove(infoMessages, k)
		end
	end
end

function showMessage(message, time)
	local messagetable = {}
	messagetable.message = message
	messagetable.time = time
	table.insert(infoMessages, messagetable)
end

function drawInfo()
	info = getInfo()
	love.graphics.setColor(255,255,255)

	if info ~= nil and type(info) == "table" then
		for k, v in pairs(info) do
			love.graphics.print(v, 0, (k*12)-12)
		end
	end
end

function updateFPS(dt)
	fps = (0.20*lastfps)+(0.80*fps)
	deltatime = dt
	playtime = playtime + dt
	lastdt = dt
	lastfps = 1/dt
end