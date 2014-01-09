function load()
	fontSize = 20
	world = love.physics.newWorld(0, 9.81*64, true)
	objects = {
		background = {
			body = love.physics.newBody(world, settings.window.width/2, (settings.window.height/2), "static"),
			shape = love.physics.newRectangleShape(settings.window.width, settings.window.height),
			draw = backgroundDraw,
			click = backgroundClick
		}
	}
end

function backgroundDraw()
	love.graphics.setColor(255,255,255)
	love.graphics.polygon("fill", objects.background.body:getWorldPoints(objects.background.shape:getPoints()))

	love.graphics.setColor(0,0,0)
	if prompt then
		if liney == settings.window.height/2 then donewithliney = true end
		if donewithliney then
			love.graphics.printf("Click To Start", 0, settings.window.height/2, settings.window.width, "center")
		else
			love.graphics.printf("Click To Start", 0, liney, settings.window.width, "center")
		end
	else
		love.graphics.printf(line, 0, settings.window.height/2, settings.window.width, "center")
	end
end

function backgroundClick()
	loadLevel("test")
end

titletime = 0
progress = 0
prompt = false
titledone = false
liney = (settings.window.height/2)
donewithliney = false
title = " "
titleLetters = {"T", "e", "l", "e", "k", "i", "n", "e", "t", "i", "c", " ", "B", "u", "n", "n", "y", "!", ""}
titleLetters[0] = ""
line = "Telekinetic Bunny!"

function updateLevel(dt)
	titletime = titletime + dt

	setFontSize(fontSize)

	if not titledone then 
		updateTitle(dt) 
	else
		if titletime >= 0.5 then
			movePromptDown(dt)
		end
	end
end

function movePromptDown(dt)
	if liney < (settings.window.height/2-font:getHeight(liney)) then
		liney = liney + dt*200
	else
		if titletime < 20 then titletime = 20 end
		titletime = titletime + dt*6
		if titletime < 100 then
			fontSize = titletime
		end
	end
end

function updateTitle(dt)
	if progress <= 18 then
		if progress == 0 then
			if titletime < 1.5 then
				return
			end
		end
		if titletime >= 0.1 then
			title = ""
			line = ""
			for i = 1, progress do title = title..titleLetters[i] end
			for i = 1, 18-progress do title = title.."  " end
			line = ""
			for i = 1, progress do line = line.." " end
			for i = progress, 18 do line = line..titleLetters[i+1] end
			titletime = 0
			progress = progress + 1
		end
	end
	if titletime >= 2 and progress >= 19 then prompt = true titledone = true title = "Telekinetic Bunny!" titletime = 0 liney = 0-font:getHeight("Click To Start") end
	love.window.setTitle(title)
end

return load