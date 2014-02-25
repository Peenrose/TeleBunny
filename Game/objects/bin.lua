binSprite = love.graphics.newImage("images/bin.png")
local bin = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(14,14, 58,260, 148,260, 194,0, 166,285, 38,285),
	draw = function()
		love.graphics.polygon("line", objects.bin.body:getWorldPoints(objects.bin.shape:getPoints()))
		love.graphics.draw(binSprite, objects.bin.body:getX(), objects.bin.body:getY(), objects.bin.body:getAngle())
	end,
	click = function() end,	
}
return bin