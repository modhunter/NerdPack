local _, NeP = ...

NeP.Core = {}

function NeP.Core:Print(text)
	print('['..NeP.Color..'NeP|r]: '..tostring(text))
end

local d_color = {
	hex = 'FFFFFF',
	rbg = {1,1,1}
}

function NeP.Core:ClassColor(unit, type)
	if UnitExists(unit) then
		local classid  = select(3, UnitClass(unit))
		return NeP.ClassTable[classid][type:lower()]
	end
	return d_color[type:lower()]
end