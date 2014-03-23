powerBunny = true
return function(dt)
	fps = 20
	if dt == 0 then return end
	if grabbedTime == nil then grabbedTime = 0 end
	if grabbed == "none" then
		grabbedTime = grabbedTime - dt
	else
		grabbedTime = grabbedTime + dt
	end
	if grabbedTime < 0 then grabbedTime = 0 end
	if grabbedTime > (1/fps)*5 then grabbedTime = (1/fps)*5 end
	
	if grabbedTime < (1/fps)*1 then
		bunnyFrame = 1
	elseif grabbedTime < (1/fps)*2 then
		bunnyFrame = 2
	elseif grabbedTime < (1/fps)*3 then
		bunnyFrame = 3
	elseif grabbedTime < (1/fps)*4 then
		bunnyFrame = 4
	end

	if bunnyInDanger then
		bunnyFrame = math.random(3,4)
	end

	if currentLevel == 4 and objects["swatcar"] ~= nil and powerBunny then
		if levelTime > 7 then
			bunnyFrame = math.min(math.floor(levelTime)-6, 5)
			if bunnyFrame == 5 and powerBunny then
				if secTick == nil then secTick = 0 end
				secTick = secTick + dt
				if secTick > 0.3 then
					secTick = 1
					frozenCar = false
					love.update(0)
					objects["swatcar"][1].body:applyLinearImpulse(-300000, -20000)
					objects["swatcar"][1].body:applyAngularImpulse(-200000000)
					riot = true
					addObject("swat", 6)
					powerBunny = false
				end
			end
		end
	end
	if bunnyFrame == nil then bunnyFrame = 1 end
end