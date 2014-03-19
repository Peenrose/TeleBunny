blackHoleBG = love.graphics.newImage("images/black_hole_bg.png")
blackHoleFront = love.graphics.newImage("images/black_hole_front.png")

loadObject = function() ob = {draw=function()
	love.graphics.draw(blackHoleBG, (settings.window.width/2), (settings.window.height/2), 0, 0.1,0.1, (blackHoleBG:getWidth()/2), (blackHoleBG:getHeight()/2))
	love.graphics.draw(blackHoleFront, (settings.window.width/2), (settings.window.height/2), playtime*math.pi, 0.1,0.1, (blackHoleFront:getWidth()/2), (blackHoleFront:getHeight()/2))
end } return ob end