book3Sprite = love.graphics.newImage("images/book3.png")

function loadObject(uid)
	local book_3 = {
		body = love.physics.newBody(world, 1610,308, "dynamic"),
		shape = love.physics.newPolygonShape(0,0, 123,0, 123,154, 0,154),
		draw = function()
			love.graphics.draw(book3Sprite, objects["book_3"][uid].body:getX(), objects["book_3"][uid].body:getY(), objects["book_3"][uid].body:getAngle())
		end,
		click = function() end,
	}
	return book_3
end