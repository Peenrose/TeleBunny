syringeSprite = love.graphics.newImage("images/syringe_full.png")
local syringe = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(39/4,0, 137/4,0, 137/4,489/4, 99/4,499/4, 88/4,620/4, 78/4,500/4, 39/4,488/4),
	draw = function()
		love.graphics.polygon("line", objects.syringe.body:getWorldPoints(objects.syringe.shape:getPoints()))
		love.graphics.draw(syringeSprite, objects.syringe.body:getX(), objects.syringe.body:getY(), objects.syringe.body:getAngle(), 1/4, 1/4)
	end,
	click = function() end,	
}
return syringe