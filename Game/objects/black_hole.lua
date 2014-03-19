blackHoleBG = love.graphics.newImage("images/black_hole_bg.png")
blackHoleFront = love.graphics.newImage("images/black_hole_front.png")

function getHoleScale()
	btime = playtime
	while btime > 2*math.pi do btime = btime - 2*math.pi end
	return 0.1 + math.sin(btime)/40
end

loadObject = function() ob = {draw=function()
	love.graphics.draw(blackHoleBG, (settings.window.width/2), (settings.window.height/2), 0, getHoleScale(),getHoleScale(), (blackHoleBG:getWidth()/2), (blackHoleBG:getHeight()/2))
	love.graphics.draw(blackHoleFront, (settings.window.width/2), (settings.window.height/2), playtime*math.pi, getHoleScale(),getHoleScale(), (blackHoleFront:getWidth()/2), (blackHoleFront:getHeight()/2))
end } return ob end