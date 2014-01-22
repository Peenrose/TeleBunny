carrot = love.graphics.newImage("images/new_carrot.png")

objects.carrot = {
	body = love.physics.newBody(world, 500, 1, "dynamic"),
	shape = love.physics.newPolygonShape(118,0, 80,50, 37,127, -8,320, 8,330, 145,163, 160,40, 158,38),
	draw = function()
		love.graphics.polygon("line", objects.carrot.body:getWorldPoints(objects.carrot.shape:getPoints()))
		love.graphics.draw(carrotSprite, objects.carrot.body:getX(), objects.carrot.body:getY(), objects.carrot.body:getAngle(), objects.carrot.sx, objects.carrot.sy, scalex, scaley)
	end,
	click = function() end,
	xpos = 0,
	ypos = 0,
	afterload = [[
		objects.carrot.fixture = love.physics.newFixture(objects.carrot.body, objects.carrot.shape)
		tlx, tly, brx, bry = objects.carrot.fixture:getBoundingBox()
		objects.carrot.sx = (brx-tlx)/carrotSprite:getWidth()
		objects.carrot.sy = (bry-tly)/carrotSprite:getHeight()
	]]
}