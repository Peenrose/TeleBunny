potatoSprite = love.graphics.newImage("images/potato.png")
local potato = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(144/3,0, 191/3,33/3, 191/3,81/3, 152/3,134/3, 61/3,162/3, 18/3,121/3, 55/3,40/3),
	draw = function()
		love.graphics.polygon("line", objects.potato.body:getWorldPoints(objects.potato.shape:getPoints()))
		love.graphics.draw(potatoSprite, objects.potato.body:getX(), objects.potato.body:getY(), objects.potato.body:getAngle(), 1/3, 1/3)
	end,
	click = function() end,	
}
return potato