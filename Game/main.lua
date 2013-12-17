function love.load()

	settings = require "settings"


	warnings = {}
	warnings.noDraw = {}

	font = love.graphics.newFont(14)
	love.graphics.setFont(font)
	love.physics.setMeter(settings.physicsMeter)
	love.window.setTitle(settings.window.title)
	love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)

	loadLevel("menu")
end

function love.update(dt)
	lastfps = 1/dt
	if world then world:update(dt) end
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