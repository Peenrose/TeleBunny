blackHoleBG = love.graphics.newImage("images/black_hole_bg.png")
blackHoleFront = love.graphics.newImage("images/black_hole_front.png")
holeAdd = 0
function getHoleScale()
	if holeAdd > 0 then
		return holeAdd + math.sin(playtime)/80
	else return 0 end
end

loadObject = function() ob = {draw=function()
	love.graphics.draw(blackHoleBG, (settings.window.width/2), (settings.window.height/2), 0, getHoleScale(),getHoleScale(), (blackHoleBG:getWidth()/2), (blackHoleBG:getHeight()/2))
	love.graphics.draw(blackHoleFront, (settings.window.width/2), (settings.window.height/2), math.sin(playtime)*math.pi, getHoleScale(),getHoleScale(), (blackHoleFront:getWidth()/2), (blackHoleFront:getHeight()/2))
end } return ob end