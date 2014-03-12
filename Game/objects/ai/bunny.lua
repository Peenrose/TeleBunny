return function(dt)
	local fps = 20
	if grabbedTime == nil then grabbedTime = 0 end
	if grabbed == "none" then
		grabbedTime = grabbedTime - dt
	else
		grabbedTime = grabbedTime + dt
	end
	if grabbedTime < 0 then grabbedTime = 0 end
	if grabbedTime > (1/fps)*4 then grabbedTime = (1/fps)*4 end

	bunnyFrame = nil

	if grabbedTime > (1/fps)*1 then
		bunnyFrame = 1
	elseif grabbedTime > (1/fps)*2 then
		bunnyFrame = 2
	elseif grabbedTime > (1/fps)*3 then
		bunnyFrame = 3
	elseif grabbedTime > (1/fps)*4 then
		bunnyFrame = 4
	end

	if bunnyFrame == nil then bunnyFrame = 1 end
end