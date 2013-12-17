function love.load()

	settings = require "settings"

	playtime = 0

	warnings = {}
	warnings.noDraw = {}
	warnings.noShape = {}

	cursor = love.mouse.newCursor("images/cursor.png", 0, 0)
	love.mouse.setCursor(cursor)

	font = love.graphics.newFont(14)
	love.graphics.setFont(font)
	love.physics.setMeter(settings.physicsMeter)
	love.window.setTitle(settings.window.title)
	love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)

	loadLevel("menu")
	print("Loaded")
end

function love.update(dt)
	playtime = playtime + dt
	lastdt = dt
	lastfps = 1/dt

	if world ~= nil then world:update(dt) end
end

function love.draw()
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
			hit = objects[k].shape:testPoint(0, 0, 0, x, y)
			if hit then 
				objects[k].click()
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
end

function loadLevel(name)
	levelToLoad = name
	if not pcall(loadLevelRaw) then warning("Failed to load level: "..name) else levelToLoad = nil end
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

function getCenterCoords(text, xory) --returns cordinates of start point
	x, y = 0, 0
	if xory == "x" then
		return (settings.window.width/2)-(font:getWidth(line)/2)
	elseif xory == "y" then
		return (settings.window.height/2)-(font:getHeight(line)/2)
	end
end