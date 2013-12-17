function love.load()

	settings = require "settings"

	playtime = 0
	
	warnings = {}
	warnings.noDraw = {}

	cursor = love.mouse.newCursor("images/cursor.png", 0, 0)
	love.mouse.setCursor(cursor)

	font = love.graphics.newFont(14)
	love.graphics.setFont(font)
	love.physics.setMeter(settings.physicsMeter)
	love.window.setTitle(settings.window.title)
	love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)

	loadLevel("menu")
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
				warning("Method "..k.." has no draw function")
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

function love.mouseclick(x, y, button)
	--detect if any object was clicked
	for k, v in pairs(objects) do
		--k is the name v is its table
		if wasclicked then
			objects[k].click()
		end
		--iterate through corners and compare
	end
end

function loadLevel(name)
	load = require ("levels/"..name)
	load()
	load = nil
end

function warning(text)
	fill = ""
	for i = 1, #text+9 do fill = fill.."-" end
	print(fill)
	print("Warning: "..text)
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