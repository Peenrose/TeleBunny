function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	bg1 = love.graphics.newImage("images/bg1.png")
	objects = {}
	
	addObject("walls")
	addObject("bunny")
	addObject("scientist")
	--addObject("carrot")
	--addObject("level1objects")
end

function updateLevel(dt)

end

function beginContact(a, b, coll)
	avel = math.abs(a:getBody():getLinearVelocity())
	bvel = math.abs(b:getBody():getLinearVelocity())

	--addInfo("Collision! Velocity: "..a:getBody():getLinearVelocity().. " and "..b:getBody():getLinearVelocity(), 1)

	--[[ --Scientist Scream and fade out
	if objects.scientist_torso ~= nil then
		if isScientistPart(a) or isScientistPart(a) then
			if avel > 5200 or bvel > 5200 then
				if fadeOut["scientist"] == nil then
					objects.scientist_torso.fadeout(100)
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
	]]--

	if isScientistPart(a) then
		if b == objects.bunny.fixture then
			--error("Game Over.\nInsert Carrot To Continue")
		end
	elseif isScientistPart(b) then
		if a == objects.bunny.fixture then
			--error("Game Over.\nInsert Carrot To Continue")
		end
	end
end

function endContact(a, b, coll) end
function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load