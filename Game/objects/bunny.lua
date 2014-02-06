bunnyheight = 200
bunnywidth = 200
bunnyx = settings.window.width-200
bunnyy = settings.window.height-205

bunnyFrames = {
	love.graphics.newImage("images/Bunny/1.png"),
	love.graphics.newImage("images/Bunny/2.png"),
	love.graphics.newImage("images/Bunny/3.png"),
	love.graphics.newImage("images/Bunny/4.png"),
}

cageOpen = love.graphics.newImage("images/cage_open.png")
cagedBunny = love.graphics.newImage("images/cage_bunny.png")

bunnyFrame = 1

bunnysx = bunnywidth/1147
bunnysy = bunnyheight/1145

cageosx, cageosy = 1, 1
objects.bunny = {
	body = love.physics.newBody(world, bunnyx, bunnyy, "static"),
	shape = love.physics.newRectangleShape(bunnywidth, bunnyheight),
	draw = function()
		--love.graphics.polygon("line", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints())) --hitbox
		if settingsItems[3].value then
			love.graphics.draw(cagedBunny, objects.bunny.body:getX(), objects.bunny.body:getY(), objects.bunny.body:getAngle())
		else
			love.graphics.draw(cageOpen, objects.bunny.body:getX()-bunnywidth/2-110, objects.bunny.body:getY()-bunnyheight/2-75, 0, cageosx, cageosy)
			love.graphics.draw(bunnyFrames[bunnyFrame], objects.bunny.body:getX(), objects.bunny.body:getY(), objects.bunny.body:getAngle(), bunnysx, bunnysy, 580, 888)
		end
		
	end,
	click = function() end
}