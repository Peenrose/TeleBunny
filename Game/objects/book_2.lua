book2Sprite = love.graphics.newImage("images/book2.png")

function loadObject(uid)
	local book_2 = {
		body = love.physics.newBody(world, 1610,308, "dynamic"),
		shape = love.physics.newPolygonShape(0,0, 123,0, 123,154, 0,154),
		draw = function()
			love.graphics.draw(book2Sprite, objects["book_2"][uid].body:getX(), objects["book_2"][uid].body:getY(), objects["book_2"][uid].body:getAngle())
		end,
		click = function() end,
	}
	return book_2
end