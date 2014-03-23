treeSprite = love.graphics.newImage("images/tree.png")

function loadObject(uid)
	local tree = {
		body = love.physics.newBody(world, 1042,90, "dynamic"),
		shape = love.physics.newPolygonShape(175,5, 258,213, 335,711, 224,766, 228,854, 108,844, 145,770, 4,708),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(treeSprite, objects["tree"][uid].body:getX(), objects["tree"][uid].body:getY(), objects["tree"][uid].body:getAngle())
		end,
		click = function() end,
	}
	tree.fixture = love.physics.newFixture(tree.body, tree.shape)
	tree.fixture:setMask(1)
	return tree
end