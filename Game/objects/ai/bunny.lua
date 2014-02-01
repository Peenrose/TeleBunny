return function(dt)
	fps = 30
	if grabbedTime == nil then grabbedTime = 0 end
	if grabbed ~= "none" then
		grabbedTime = grabbedTime + dt
	elseif grabbed == "none" or grabbed == nil then
		grabbedTime = grabbedTime - dt
	end
	if grabbedTime > (1/fps)*4 then grabbedTime = (1/fps)*4 end
	if grabbedTime < 0 then grabbedTime = 0 end
	if grabbedTime == 0 then
		bunnyFrame = 1
	elseif grabbedTime <= 1/fps then
	bunnyFrame = 2
	elseif grabbedTime <= (1/fps)*2 then
		bunnyFrame = 3
	elseif grabbedTime <= (1/fps)*3 then
		bunnyFrame = 4
	end
end