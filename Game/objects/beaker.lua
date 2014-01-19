beakerUnbrokenSprite = love.graphics.newImage()
beakerBrokenSprite = love.graphics.newImage()

objects.beaker = {
	body = love.physics.newBody(world, bunnyx, bunnyy, "static"),
	shape = love.physics.newRectangleShape(bunnywidth, bunnyheight),
	draw = function()
		--love.graphics.polygon("line", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints())) hitbox
		love.graphics.draw(bunnyFrames[bunnyFrame], objects.bunny.body:getX(), objects.bunny.body:getY(), objects.bunny.body:getAngle(), bunnysx, bunnysy, 580, 888)
	end,
	click = function() end,
	update = function(dt)

	end
}