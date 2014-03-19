bunnyheight = 200
bunnywidth = 200

if currentLevel == "2" then
	bunnyy = 1020-(205-90)
else
	bunnyy = 1080-205
end
bunnyx = settings.window.width-200

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

function loadObject(uid)
	bunny = {
		body = love.physics.newBody(world, bunnyx, bunnyy, "static"),
		shape = love.physics.newRectangleShape(bunnywidth, bunnyheight),
		draw = function()
			--love.graphics.polygon("line", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints())) --hitbox
			if transition == 0 then
				local red = math.min((255-((bunnyHealth/3)*255)), 255) / 1.2
				love.graphics.setColor(255, 255-red, 255-red)
			else
				--local green = math.min((255-((transition/10)*255)), 255) / 1.2
				--love.graphics.setColor(green, 255, green)
			end
			love.graphics.draw(bunnyFrames[bunnyFrame], objects["bunny"][uid].body:getX(), objects["bunny"][uid].body:getY(), objects["bunny"][uid].body:getAngle(), bunnysx, bunnysy, 580, 888)
		end,
		click = function() end
	}
	return bunny
end