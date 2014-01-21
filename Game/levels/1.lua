function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)

	carrotSprite = love.graphics.newImage("images/carrot.png")

	scientistWidth = 277
	scientistHeight = 329

	objects = {}

	addObject("bunny")
	addObject("scientist")
	addObject("carrot")
	addObject("walls")
end

function updateLevel(dt)

end

function beginContact(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	--addInfo("Collision! Velocity: "..a:getBody():getLinearVelocity().. " and "..b:getBody():getLinearVelocity(), 1)
	if objects.scientist ~= nil then
		if a == objects.scientist.fixture or b == objects.scientist.fixture then
			if avel > 600 or bvel > 600 then
				if fadeOut["scientist"] == nil then
					--objects.scientist.fadeout(100)
				end
				yell = "[Scientist:] "
				force = math.max(avel, bvel)
				repeat
					yell = yell.."A"
					force = force - 150
				until force <= 0
				yell = yell.."!"
				addInfo(yell, 5)
			end
		end
	end
end

function endContact(a, b, coll) end
function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load