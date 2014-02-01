function load()

end

function drawLevelBackground()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 0,0, settings.window.width,settings.window.height)
	
	setFontSize(140)
	love.graphics.setColor(0,0,0)
	love.graphics.printf("TeleBunny", 0, settings.window.height/10-6, settings.window.width, "center")
	love.graphics.printf("TeleBunny", 0, settings.window.height/10+6, settings.window.width, "center")
	love.graphics.printf("TeleBunny", 0, settings.window.height/10, settings.window.width-6, "center")
	love.graphics.printf("TeleBunny", 0, settings.window.height/10, settings.window.width+6, "center")

	love.graphics.printf("TeleBunny", 0, settings.window.height/10+6, settings.window.width+6, "center")
	love.graphics.printf("TeleBunny", 0, settings.window.height/10-6, settings.window.width-6, "center")
	love.graphics.printf("TeleBunny", 0, settings.window.height/10+6, settings.window.width-6, "center")
	love.graphics.printf("TeleBunny", 0, settings.window.height/10-6, settings.window.width+6, "center")

	love.graphics.setColor(255,255,255)
	love.graphics.printf("TeleBunny", 0, settings.window.height/10, settings.window.width, "center")

end

function updateLevel(dt)

end

return load