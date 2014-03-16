return function(dt)
	local fps = 5
	if grabbedTime == nil then grabbedTime = 0 end
	if grabbed == "none" then
		grabbedTime = grabbedTime - dt
	else
		grabbedTime = grabbedTime + dt
	end
	if grabbedTime < 0 then grabbedTime = 0 end
	grabTime = grabbedTime

	bunnyFrame = nil

	if grabTime < (1/fps)*1 then
		bunnyFrame = 1
	elseif grabTime < (1/fps)*2 then
		bunnyFrame = 2
	elseif grabTime < (1/fps)*3 then
		bunnyFrame = 3
	elseif grabTime < (1/fps)*4 then
		bunnyFrame = 4
	end
	bunnyFrame = math.random(1, 4)
	addInfo("Grab Time: "..grabTime, 0)
	if bunnyFrame == nil then bunnyFrame = 1 end
end