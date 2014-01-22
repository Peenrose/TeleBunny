carrotSprite = love.graphics.newImage("images/new_carrot.png")

objects.carrot = {
	body = love.physics.newBody(world, 500, 1, "dynamic"),
	shape = love.physics.newPolygonShape(0,379/3, 38/3,318/3, 84/3,124/3, 145/3,84/3, 211/3,110/3, 211/3,177/3, 63/3,343/3),
	draw = function()
		love.graphics.polygon("line", objects.carrot.body:getWorldPoints(objects.carrot.shape:getPoints()))
		love.graphics.draw(carrotSprite, objects.carrot.body:getX(), objects.carrot.body:getY(), objects.carrot.body:getAngle(), 1/3, 1/3)
	end,
	click = function() end,
}