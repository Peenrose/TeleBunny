settings = {
	physicsMeter = 64,

	window = {
		title = " ",
	},

	displayFlags = {
		fullscreen = true,
		fullscreentype = "desktop",
		vsync = false,
		fsaa = 0,
		resizable = false,
		borderless = false,
		centered = true,
		display = 1,
		minwidth = 100,
		minheight = 100,
	},
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
	{title = "Load Level", action = function() changePauseMenu(levelItems) end},
	--{title = "Cage Bunny", action = function() bunnyInCage = not bunnyInCage; pauseItems[6].value = not pauseItems[6].value end, value = false}
}

settingsItems = {
	title = "Settings",
	{title = "Back", action = function() changePauseMenu(pauseItems) end},
	{title = "Debug Log", action = function() settingsItems[2].value = not settingsItems[2].value end, value = true},
	{title = "Caged Bunny", action = function() settingsItems[3].value = not settingsItems[3].value end, value = false},
}

levelItems = {
	title = "Load Level",
	{title = "Back", action = function() changePauseMenu(pauseItems) end},
	{title = "Menu", action = function() loadLevel("menu") end},
	{title = "One", action = function() loadLevel("1") end},
}

function togglePause()
	if paused == true then
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

pauseHitboxes = {}

ssx = (settings.window.width/1080)
ssy = (settings.window.width/1920)

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
warnings.noBody = {}
warnings.noClick = {}

infoMessages = {}
fadeOut = {}
scheduled = {}
removals = {}

ais = {}
objectList = {}

cursor = love.mouse.newCursor("images/cursor.png", 0, 0)
love.mouse.setCursor(cursor)
font = love.graphics.newFont(20)
love.graphics.setFont(font)

love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)

pausebackground = love.graphics.newImage("images/cyanpause.png")
love.physics.setMeter(settings.physicsMeter)
love.window.setTitle(settings.window.title)
love.window.setIcon(love.image.newImageData("images/icon.png"))

return settings