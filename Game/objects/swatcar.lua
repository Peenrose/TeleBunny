swatcarSprite = love.graphics.newImage("images/swatcar.png")

function loadObject(uid)
	local swatcar = {
    		body = love.physics.newBody(world, 54,524, "dynamic"),
		shape = love.physics.newPolygonShape(2,59, 551,39, 638,139, 797,174, 797,390, 486,451, 87,380, 12,283),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(swatcarSprite, objects["swatcar"][uid].body:getX(), objects["swatcar"][uid].body:getY(), objects["swatcar"][uid].body:getAngle())
		end,
		click = function() end,
	}
	swatcar.fixture = love.physics.newFixture(swatcar.body, swatcar.shape)
	swatcar.fixture:setDensity(swatcar.fixture:getDensity()*3)
	return swatcar
end