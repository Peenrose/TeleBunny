function love.load()

	settings = require "settings"

	love.physics.setMeter(settings.physicsMeter)
	love.window.setTitle(settings.window.title)
	love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)

	loadWorld("menu")
end

function love.update(dt)
	lastfps = 1/dt
	if world then world:update(dt) end
end

function love.draw()
	for k, v in pairs(objects) do
		v.draw()
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

function loadWorld(name)
	load = require ("levels/"..name)
	load()
	load = nil
end