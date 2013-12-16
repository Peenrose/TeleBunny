function load()
	world = love.physics.newWorld(0, 9.81*64, true)

	objects = {}

	objects.background = {}
	objects.background.draw = backgroundDraw
	objects.background.click = backgroundClick

end

function backgroundDraw()

end

function backgroundClick()
	loadWorld("test")
end

return load