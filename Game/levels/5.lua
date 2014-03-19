function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = nil
	objects = {}

	addObject("black_hole")
end

function updateLevelFive(dt)
	
end

return load