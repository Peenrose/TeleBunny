settings = {
	physicsMeter = 64,

	window = {
		width = 1920,
		height = 1080,
		title = " "
	},

	displayFlags = {
		fullscreen = false,
		fullscreentype = "normal",
		vsync = true,
		fsaa = 0,
		resizable = false,
		borderless = false,
		centered = true,
		display = 1,
		minwidth = 100,
		minheight = 100
	},

	carrot = {
		width = 160,
		height = 314
	}
}

deltatime = 0
playtime = 0

fps = 0
lastdps = 0
lastfps = 0
playtime = 0

warnings = {}
warnings.noDraw = {}
warnings.noShape = {}
warnings.noClick = {}

grabbed = {}

cursor = love.mouse.newCursor("images/cursor.png", 0, 0)
love.mouse.setCursor(cursor)
font = love.graphics.newFont(20)
love.graphics.setFont(font)

love.physics.setMeter(settings.physicsMeter)
love.window.setTitle(settings.window.title)
love.window.setMode(settings.window.width, settings.window.height, settings.displayFlags)
love.window.setIcon(love.image.newImageData("images/icon.png"))

return settings