function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	background = love.graphics.newImage("images/bg2.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	--addObject("scientist")

	
end

function updateLevel(dt)

end

function beginContact(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	maxvel = math.abs(math.max(avel, bvel))
	
end

function endContact(a, b, coll)

end

function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load