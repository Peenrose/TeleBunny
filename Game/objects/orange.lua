orangeSprite = love.graphics.newImage("images/orange.png")
local orange = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(0,103/5, 97/5,19/5, 221/5,19/5, 304/5,113/5, 284/5,221/5, 184/5,296/5, 79/5,271/5, 16/5,203/5),
	draw = function()
		love.graphics.polygon("line", objects.orange.body:getWorldPoints(objects.orange.shape:getPoints()))
		love.graphics.draw(orangeSprite, objects.orange.body:getX(), objects.orange.body:getY(), objects.orange.body:getAngle(), 1/5, 1/5)
	end,
	click = function() end,	
}
return orange