local _, NeP = ...

NeP.Core = {}

function NeP.Core:Print(text)
	print('[|cff'..NeP.Color..'NeP|r]: '..tostring(text))
end

local d_color = {
	hex = 'FFFFFF',
	rgb = {1,1,1}
}

function NeP.Core:ClassColor(unit, type)
	if UnitExists(unit) then
		local classid  = select(3, UnitClass(unit))
		if classid then
			return NeP.ClassTable[classid][type:lower()]
		end
	end
	return d_color[type:lower()]
end

NeP.Color = NeP.Core:ClassColor('player', 'hex')