settings = {
	physicsMeter = 64,

	window = {
		width = 1920,
		height = 1080,
		title = " ",
	},

	displayFlags = {
		fullscreen = true,
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

imageQuad = {
	bunny_off = love.graphics.newQuad(0,0, 1432,1309, 5730,1309),
	bunny_on1 = love.graphics.newQuad(1432,0, 2864,1309, 5730,1309),
	bunny_on2 = love.graphics.newQuad(2864,0, 4296,1309, 5730,1309),
	bunny_on3 = love.graphics.newQuad(4296,0, 5730,1309, 5730,1309),
}

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
	{title = "Resolution", action = function() changeResolution(button) end},
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
function changeResolution()
	resolution.x, resolution.y = 1600, 900
	resolution.changing = true
end

function applyResolution()
	love.window.setMode(resolution.x, resolution.y)
	resolution.changing = false
end

pauseHitboxes = {}

deltatime = 0
playtime = 0

pauseMenu = false
paused = false

welds = {}
toWeld = {}

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