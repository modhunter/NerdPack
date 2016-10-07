local _, NeP = ...

NeP.Protected.Cast = function(spell, target)
end

NeP.Protected.CastGround = function(spell, target)
end

NeP.Protected.Macro = function(text)
end

NeP.Protected.UseItem = function(name, target)
end

NeP.Protected.UseInvItem = function(name)
end

local rangeCheck = LibStub("LibRangeCheck-2.0")
NeP.Protected.Distance = function (a, b)
	if UnitExists(b) then
		local minRange, maxRange = rangeCheck:GetRange(b)
		return maxRange or minRange
	end
	return 0
end

NeP.Protected.Infront = function (a, b)
end

NeP.Protected.CastGround = function (spell, target)
end

NeP.Protected.UnitCombatRange = function (unitA, unitB)
end

NeP.Protected.UnitCombatRange = function (unitA, unitB)
end

NeP.Protected.UnitAttackRange = function (unitA, unitB, rType)
end

NeP.Protected.LineOfSight = function (a, b)
end

-- Name Plate stuff
local lnr = LibStub("AceAddon-3.0"):NewAddon("NerdPack", "LibNameplateRegistry-1.0")

function lnr:OnEnable()
	self:LNR_RegisterCallback("LNR_ON_NEW_PLATE")
	self:LNR_RegisterCallback("LNR_ON_RECYCLE_PLATE")
end

function lnr:LNR_ON_NEW_PLATE(_, _, plateData)
	local tK = plateData.unitToken
	NeP.OM:Add(tK)
end

function lnr:LNR_ON_RECYCLE_PLATE()
	NeP.OM:Garbage()
end