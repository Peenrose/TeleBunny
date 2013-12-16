function love.load()

	settings = require "settings"

	love.physics.setMeter(settings.physicsMeter)
	love.window.setMode(settings.windowSize.width, settings.windowSize.height, settings.displayFlags)

	loadWorld("menu")
end

function love.update(dt)
	if world then world:update(dt) end
end

function love.draw()
	--draw all objects in active level
end

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
	if key == "rctrl" then debug.debug() end
end

function love.mouseclick(x, y, button)
	--detect if any object was clicked
end

function loadWorld(name)
	load = require ("levels/"..name)
	load()
	load = nil
end