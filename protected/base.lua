-- TODO: BUILD FACEROOL FRAME

-- Uses Lib Range
local rangeCheck = LibStub("LibRangeCheck-2.0")
function FallBack_Distance(b)
	if UnitExists(b) then
		local minRange, maxRange = rangeCheck:GetRange(b)
		return maxRange or minRange
	end
	return 0
end

function NeP.Protected.Facerool()

	function NeP.Protected:Cast(spell, target, is_ground)
		NeP.Core:Print(spell, target, is_ground)
	end
	
	function NeP.Protected:Distance(a, b)
		local y1, x1, _, instance1 = UnitPosition(a)
		local y2, x2, _, instance2 = UnitPosition(b)
		if y2 and instance1 == instance2 then
			return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
		end
		return FallBack_Distance(b)
	end

end

NeP.Protected.Facerool()