paperSprite = love.graphics.newImage("images/crumpled_paper.png")

function loadObject(uid)
	local paper = {
		body = love.physics.newBody(world, x, y, "dynamic"),
		shape = love.physics.newPolygonShape(50/4,0, 174/4,9/4, 227/4,56/4, 211/4,173/4, 144/4,218/4, 37/4,203/4, 0,133/4, 0,50/4),
		draw = function()
			--love.graphics.polygon("line", objects["paper"][uid].body:getWorldPoints(objects["paper"][uid].shape:getPoints()))
			love.graphics.draw(paperSprite, objects["paper"][uid].body:getX(), objects["paper"][uid].body:getY(), objects["paper"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,	
	}
	return paper
end