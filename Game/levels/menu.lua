function load()
	
	world = love.physics.newWorld(0, 9.81*64, true)

	objects = {}

	objects.background = {}
	objects.background.body = love.physics.newBody(world, settings.window.width/2, (settings.window.height/2), "static")
	objects.background.shape = love.physics.newRectangleShape(settings.window.width, settings.window.height)
	objects.background.fixture = love.physics.newFixture(objects.background.body, objects.background.shape)
	objects.background.draw = backgroundDraw
	objects.background.click = backgroundClick
end

function backgroundDraw()
	love.graphics.setColor(255,255,255)
	love.graphics.polygon("fill", objects.background.body:getWorldPoints(objects.background.shape:getPoints()))

	love.graphics.setColor(0,0,0)
	if prompt then
		if liney == settings.window.height/2 then donewithliney = true end
		if donewithliney then
			love.graphics.print("Click To Start", getCenterCoords("Click To Start", 0, settings.window.width, "x"), getCenterCoords("Click To Start", 0, settings.window.height, "y"))
		else
			love.graphics.print("Click To Start", getCenterCoords("Click To Start", 0, settings.window.width, "x"), liney)
		end
	else
		love.graphics.print(line, 398.5, (settings.window.height/2)-50)
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

	if not titledone then 
		updateTitle(dt) 
	else
		if titletime >= 1 then
			movePromptDown(dt)
		end
	end
end

function movePromptDown(dt)
	if liney < (settings.window.height/2-font:getHeight(liney)) then
		liney = liney + dt*200
	else
		if titletime < 20 then titletime = 20 end
		titletime = titletime + dt*5
		font = love.graphics.newFont(titletime)
		love.graphics.setFont(font)
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
	if titletime >= 2 and progress >= 19 then prompt = true titledone = true title = "Telekinetic Bunny" titletime = 0 liney = 0-font:getHeight("Click To Start") end
	love.window.setTitle(title)
end

return load