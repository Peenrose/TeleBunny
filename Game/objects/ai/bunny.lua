return function(dt)
	fps = 20

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
	
	addInfo("Grab Time: "..grabbedTime, 0)
	if bunnyFrame == nil then bunnyFrame = 1 end
end