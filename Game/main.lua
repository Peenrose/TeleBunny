function love.load()

	levels = require "levels"
	settings = require "settings"

	love.physics.setMeter(settings.physicsMeter)
	love.window.setMode(settings.windowSize.width, settings.windowSize.height, settings.displayFlags)

	activeLevel = "menu"
end

function love.update(dt)
	--levels[activeLevel]:update()
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