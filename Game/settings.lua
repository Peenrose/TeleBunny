settings = {
	physicsMeter = 64,

	window = {
		title = " ",
	},

	displayFlags = {
		fullscreen = false,
		fullscreentype = "desktop",
		vsync = true,
		fsaa = 0,
		resizable = false,
		borderless = false,
		centered = true,
		display = 1,
		minwidth = 100,
		minheight = 100,
	},

	carrot = {
		width = 160,
		height = 314,
	}
}
scalex = 1
scaley = 1

settings.window.width, settings.window.height = love.window.getDesktopDimensions()

pauseItems = {
	title = "",

	{title = "Resume Game", action = function() togglePause() end},
	{title = "Quit Game", action = function() love.event.push("quit") end},
	{title = "Reset Level", action = function() loadLevel(currentLevel) end},
	{title = "Settings", action = function() changePauseMenu(settingsItems) end},
}

settingsItems = {
	title = "Settings",

	{title = "Back", action = function() changePauseMenu(pauseItems) end},
	{title = "Resolution", action = function(button) changeResolution(button) end, value = "1920x1080"},
}

function togglePause()
	if paused == true then
		if resolution.changing then applyResolution() resolution.changing = false end
		paused = false
		pausedMenu = false
	elseif paused == false then
		paused = true
		pausedMenu = pauseItems
	end
end

function changePauseMenu(menu)
	pausedMenu = menu
	pauseHitboxes = {}
	for k, v in pairs(pausedMenu) do
		if v.action ~= nil then
			x, y, mx, my = ((settings.window.width/2)-font:getWidth(v.title)/2)-10, y-10, font:getWidth(v.title)+20, font:getHeight(v.title)+20
			pauseHitboxes[k] = {x=x, y=y, mx=mx+x, my=my+y}
		end
	end
end

resolution = {x=1920, y=1080, changing = false}
currentRes = 8
resolutions = {
	{x=640, y=360},
	{x=854, y=480},
	{x=960, y=540},
	{x=1024, y=576},
	{x=1280, y=720},
	{x=1366, y=768},
	{x=1600, y=900},
	{x=1920, y=1080},
}

function changeResolution(button)
	if button == "l" then
		if currentRes < 8 then
			currentRes = currentRes + 1
			resolution.changing = true
		end
	elseif button == "r" then
		if currentRes > 1 then
			currentRes = currentRes - 1
			resolution.changing = true
		end
	end

	resolution.x, resolution.y = resolutions[currentRes].x, resolutions[currentRes].y
	settings.window.x, settings.window.y = resolutions[currentRes].x, resolutions[currentRes].y
	settingsItems[2].value = resolutions[currentRes].x.."x"..resolutions[currentRes].y
	settings.window.width, settings.window.height = resolutions[currentRes].x, resolutions[currentRes].y
end

function applyResolution()
	love.window.setMode(resolution.x, resolution.y)
	scalex, scaley = resolutions[currentRes].x/1920, resolutions[currentRes].y/1080
	x, y = love.window.getDesktopDimensions()
	if resolutions[currentRes].x == x and resolutions[currentRes].y == y then
		love.window.setMode(x, y, settings.displayFlags)
	end
	loadLevel(currentLevel)
	resolution.changing = false
end

pauseHitboxes = {}

deltatime = 0
playtime = 0

pauseMenu = false
paused = false

welds = {}
toWeld = {}

grabbed = "none"

fps = 0
lastdps = 0
lastfps = 0
playtime = 0
lastclickx, lastclicky = 0, 0

currentlevel = ""

warnings = {}
warnings.noDraw = {}
warnings.noShape = {}
warnings.noClick = {}

infoMessages = {}
fadeOut = {}
scheduled = {}
removals = {}

cursor = love.mouse.newCursor("images/cursor.png", 0, 0)
love.mouse.setCursor(cursor)
font = love.graphics.newFont(20)
love.graphics.setFont(font)


pausebackground = love.graphics.newImage("images/cyanpause.png")
love.physics.setMeter(settings.physicsMeter)
love.window.setTitle(settings.window.title)
love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)
love.window.setIcon(love.image.newImageData("images/icon.png"))

return settings