function love.load()

	settings = require "settings"

	deltatime = 0
	playtime = 0

	fps = 0
	lastdps = 0
	playtime = 0

	warnings = {}
	warnings.noDraw = {}
	warnings.noShape = {}
	warnings.noClick = {}

	grabbed = {}

	cursor = love.mouse.newCursor("images/cursor.png", 0, 0)
	love.mouse.setCursor(cursor)
	font = love.graphics.newFont(20)
	love.graphics.setFont(font)
	
	love.physics.setMeter(settings.physicsMeter)
	love.window.setTitle(settings.window.title)
	love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)
	love.window.setIcon(love.image.newImageData("images/icon.png"))

	loadLevel("menu")
end

function love.update(dt)
	if not love.mouse.isDown() then grabbed = {} end

	----[[
	if objects ~= nil then
		for k, v in pairs(objects) do
			if grabbed[k] == true then
				mx, my = love.mouse:getPosition()
				bx, by = v.body:getPosition()

				--local coords of click
				v.body:applyForce()
			end
		end
	end
	----]]

	deltatime = dt
	playtime = playtime + dt
	lastdt = dt
	lastfps = 1/dt

	dt = math.min(dt, 0.05)

	if world ~= nil then world:update(dt) end
	if updateLevel ~= nil then updateLevel(dt) end
end

function love.draw()

	love.graphics.setColor(255,255,255)
	fps = (0.20*lastfps)+(0.80*fps)
	love.graphics.print("FPS: "..math.ceil(fps), 0, 0)

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

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
	if key == "rctrl" then debug.debug() end
	--set up key bind api
end

function love.mousepressed(x, y, button)
	clickedon = ""
	clickedamount = 0
	for k, v in pairs(objects) do
		if objects[k].shape ~= nil then
			localx, localy = objects[k].body:getLocalPoint(x, y)
			if objects[k].shape:testPoint(0, 0, 0, localx, localy) then
				grabbed[k] = true
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
		print(err)
	else 
		levelToLoad = nil 
		print("Level Loaded: "..name) 
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

function getCenterCoords(text, ori, max, xory) --returns cordinates of start point
	x, y = 0, 0
	if xory == "x" then
		return ((max-ori)/2)-(font:getWidth(line)/2)
	elseif xory == "y" then
		return ((max-ori)/2)-(font:getHeight(line)/2)
	end
end