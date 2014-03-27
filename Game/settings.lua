settings = {
	physicsMeter = 64,

	window = {
		title = " ",
	},

	displayFlags = {
		fullscreen = true,
		fullscreentype = "desktop",
		vsync = true,
		fsaa = 16,
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
scrx, scry = love.window.getDesktopDimensions()
settings.window.width, settings.window.height = love.window.getDesktopDimensions()

pauseItems = {
	title = "",
	{title = "Resume Game", action = function() togglePause() end},
	{title = "Quit Game", action = function() love.event.push("quit") end},
	{title = "Video Settings", action = function() changePauseMenu(videoItems) end},
	{title = "Stop Music", action = function() if startSong ~= nil then startSong:stop() end if midSong ~= nil then midSong:stop() end if engSong ~= nil then endSong:stop() end end},
}

videoItems = {
	title = "Video Settings",
	{title = "Back", action = function() changePauseMenu(pauseItems) end},
	{title = "Toggle Fullscreen", action = function() settings.displayFlags.fullscreen = not settings.displayFlags.fullscreen; setResolution(settings.window.width, settings.window.height, settings.displayFlags.fullscreen) end},
	{title = "Resolution", action = function() changePauseMenu(resolutionItems) end},
}

resolutionItems = {
	title = "Resolution",
	{title = "Back", action = function() changePauseMenu(videoItems) end},
	{title = "1080p", action = function() setResolution(1920, 1080) end},
	{title = "900p", action = function() setResolution(1600, 900) end},
	{title = "720p", action = function() setResolution(1280, 720) end},
	{title = "576p", action = function() setResolution(1024, 576) end},
	{title = "360p", action = function() setResolution(640, 360) end},
}

levelItems = {
	title = "Load Level",
	{title = "Back", action = function() changePauseMenu(pauseItems) end},
	{title = "Intro", action = function() loadLevel("intro") end},
	{title = "Level One", action = function() loadLevel(1) end},
	{title = "Level Two", action = function() loadLevel(2) end},
	{title = "Level Three", action = function() loadLevel(3) end},
	{title = "Level Four", action = function() loadLevel(4) end},
	{title = "Level Five", action = function() loadLevel(5) end},
}

function togglePause()
	if currentLevel == "intro" then return end
	if paused == true then
		paused = false
		pausedMenu = false
		love.mouse.setGrabbed(true)
	elseif paused == false then
		paused = true
		pausedMenu = pauseItems
		love.mouse.setGrabbed(false)
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

fontSize = 14

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
objects = {}
objectList = {}
removedObjects = {}
info = {}
healthRemaining = {}

feetTouching = {}


bunnyCursor = love.mouse.newCursor("images/cursor.png", 7, 7)
blankCursor = love.mouse.newCursor("images/blank.png", 0, 0)

grabImg = love.graphics.newImage("images/grab.png")

love.mouse.setCursor(bunnyCursor)
font = love.graphics.newFont(20)
love.graphics.setFont(font)

--love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)

pausebackground = love.graphics.newImage("images/pause.png")
love.physics.setMeter(settings.physicsMeter)
love.window.setTitle(settings.window.title)
love.window.setIcon(love.image.newImageData("images/icon.png"))
