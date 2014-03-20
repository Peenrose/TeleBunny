book1Sprite = love.graphics.newImage("images/book1.png")

function loadObject(uid)
	local book_1 = {
		body = love.physics.newBody(world, 1610,308, "dynamic"),
		shape = love.physics.newPolygonShape(0,0, 123,0, 123,154, 0,154),
		draw = function()
			love.graphics.draw(book1Sprite, objects["book_1"][uid].body:getX(), objects["book_1"][uid].body:getY(), objects["book_1"][uid].body:getAngle())
		end,
		click = function() end,
	}
	return book_1
end