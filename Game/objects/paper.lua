paperSprite = love.graphics.newImage("images/crumpled_paper.png")
local paper = {
	body = love.physics.newBody(world, x, y, "dynamic"),
	shape = love.physics.newPolygonShape(50/4,0, 174/4,9/4, 227/4,56/4, 211/4,173/4, 144/4,218/4, 37/4,203/4, 0,133/4, 0,50/4),
	draw = function()
		love.graphics.polygon("line", objects.paper.body:getWorldPoints(objects.paper.shape:getPoints()))
		love.graphics.draw(paperSprite, objects.paper.body:getX(), objects.paper.body:getY(), objects.paper.body:getAngle(), 1/4, 1/4)
	end,
	click = function() end,	
}
return paper