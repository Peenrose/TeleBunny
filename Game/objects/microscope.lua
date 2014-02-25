microscopeSprite = love.graphics.newImage("images/microscope.png")
local microscope = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(186/3,0, 266/3,108/3, 306/3,300/3, 236/3,521/3, 8/3,521/3, 8/3,218/3),
	draw = function()
		love.graphics.polygon("line", objects.microscope.body:getWorldPoints(objects.microscope.shape:getPoints()))
		love.graphics.draw(microscopeSprite, objects.microscope.body:getX(), objects.microscope.body:getY(), objects.microscope.body:getAngle(), 1/3, 1/3)
	end,
	click = function() end,	
}
return microscope