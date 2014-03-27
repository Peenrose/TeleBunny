introImages = {
	love.graphics.newImage("images/Story/1.png"),
	love.graphics.newImage("images/Story/2.png"),
	love.graphics.newImage("images/Story/3.png"),
	love.graphics.newImage("images/Story/4.png"),
}
played = {}
function playNarration(name)
	if played[name] == nil then
		played[name] = true
		src = love.audio.newSource("audio/"..name..".mp3", "static")
		src:play()
	end
end

function drawIntro()
	if levelTime < 15.5 then
		love.graphics.draw(introImages[1], 0, 0)
		playNarration("story1")
	elseif levelTime < 26 then
		love.graphics.draw(introImages[2], 0, 0)
		playNarration("story2")
	elseif levelTime < 34 then
		love.graphics.draw(introImages[3], 0, 0)
		playNarration("story3")
	elseif levelTime < 52 then
		love.graphics.draw(introImages[4], 0, 0)
		playNarration("story4")
	else
		playtime = 0
		loadLevel(1)
	end
end

function updateIntro(dt)
	if levelTime == nil then levelTime = 0 end
	levelTime = levelTime + dt
	--levelTime = 45
end

return function() end