carrotSprite = love.graphics.newImage("images/new_carrot.png")

function loadObject(uid)
carrot = {
	body = love.physics.newBody(world, 500, 1, "dynamic"),
	shape = love.physics.newPolygonShape(0,379/3, 38/3,318/3, 84/3,124/3, 145/3,84/3, 211/3,110/3, 211/3,177/3, 63/3,343/3),
	draw = function(uid)
		love.graphics.polygon("line", objects["carrot"][uid].body:getWorldPoints(objects["carrot"][uid].shape:getPoints()))
		love.graphics.draw(carrotSprite, objects["carrot"][uid].body:getX(), objects["carrot"][uid].body:getY(),objects["carrot"][uid].body:getAngle(), 1/3, 1/3)
	end,
	click = function() end,
}
return carrot
end