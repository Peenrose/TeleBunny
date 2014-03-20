book4Sprite = love.graphics.newImage("images/book4.png")

function loadObject(uid)
	local book_4 = {
		body = love.physics.newBody(world, 200,308, "dynamic"),
		shape = love.physics.newPolygonShape(0,0, 123,0, 123,154, 0,154),
		draw = function()
			love.graphics.draw(book4Sprite, objects["book_4"][uid].body:getX(), objects["book_4"][uid].body:getY(), objects["book_4"][uid].body:getAngle())
		end,
		click = function() end,
	}
	return book_4
end