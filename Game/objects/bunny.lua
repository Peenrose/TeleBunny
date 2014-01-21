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
cageClosed = love.graphics.newImage("images/cage_closed.png")

bunnyFrame = 1

bunnyInCage = false

bunnysx = bunnywidth/1147
bunnysy = bunnyheight/1145

cageosx, cageosy = 1, 1
objects.bunny = {
	body = love.physics.newBody(world, bunnyx, bunnyy, "static"),
	shape = love.physics.newRectangleShape(bunnywidth, bunnyheight),
	draw = function()
		--love.graphics.polygon("line", objects.bunny.body:getWorldPoints(objects.bunny.shape:getPoints())) hitbox
		if bunnyInCage then

		elseif bunnyInCage == false then
			love.graphics.draw(cageOpen, objects.bunny.body:getX()-bunnywidth/2-110, objects.bunny.body:getY()-bunnyheight/2-75, 0, cageosx, cageosy)
			love.graphics.draw(bunnyFrames[bunnyFrame], objects.bunny.body:getX(), objects.bunny.body:getY(), objects.bunny.body:getAngle(), bunnysx, bunnysy, 580, 888)
		end
		
	end,
	click = function() end,
	update = function(dt)
		fps = 30
		if grabbedTime == nil then grabbedTime = 0 end
		if grabbed ~= "none" then
			grabbedTime = grabbedTime + dt
		elseif grabbed == "none" or grabbed == nil then
			grabbedTime = grabbedTime - dt
		end
		if grabbedTime > (1/fps)*4 then grabbedTime = (1/fps)*4 end
		if grabbedTime < 0 then grabbedTime = 0 end
		if grabbedTime == 0 then
			bunnyFrame = 1
		elseif grabbedTime <= 1/fps then
		bunnyFrame = 2
		elseif grabbedTime <= (1/fps)*2 then
			bunnyFrame = 3
		elseif grabbedTime <= (1/fps)*3 then
			bunnyFrame = 4
		end
	end
}