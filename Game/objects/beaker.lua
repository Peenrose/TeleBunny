beakerSprite = love.graphics.newImage("images/beaker1.png")
local beaker = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
	draw = function()
		love.graphics.polygon("line", objects.beaker.body:getWorldPoints(objects.beaker.shape:getPoints()))
		love.graphics.draw(beakerSprite, objects.beaker.body:getX(), objects.beaker.body:getY(), objects.beaker.body:getAngle(), 1/4, 1/4)
	end,
	click = function() end,
}
return beaker