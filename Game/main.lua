function love.load()

	levels = require "levels"
	settings = require "settings"

	love.physics.setMeter(settings.physicsMeter)

end

function love.update(dt)

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