local _, NeP = ...

NeP.CombatRoutines = {
	CR = {}
}

--Global
NeP.Globals.CombatRoutines = NeP.CombatRoutines

local CRs = {}
local UnitClass = UnitClass

function NeP.CombatRoutines:Add(SpecID, Name, InCombat, OutCombat, ExeOnLoad)
	local classIndex = select(3, UnitClass('player'))
	if NeP.ClassTable[classIndex][SpecID] or classIndex == SpecID then
		if not CRs[SpecID] then
			CRs[SpecID] = {}
		end

		-- This compiles the CR
		NeP.Compiler:Iterate(InCombat)
		NeP.Compiler:Iterate(OutCombat)

		CRs[SpecID][Name] = {}
		CRs[SpecID][Name].Exe = ExeOnLoad
		CRs[SpecID][Name][true] = InCombat
		CRs[SpecID][Name][false] = OutCombat
	end
end

function NeP.CombatRoutines:Set(Spec, Name)
	local _, englishClass, classIndex  = UnitClass('player')
	local a, b = englishClass:sub(1, 1):upper(), englishClass:sub(2):lower()
	local classCR = '[NeP] '..a..b..' - Basic'
	if not CRs[Spec][Name] then
		Name = classCR
		Spec = classIndex
	end
	self.CR = CRs[Spec][Name]
	NeP.Config:Write('SELECTED', Spec, Name)
	if self.CR.Exe then
		self.CR.Exe()
	end
end

function NeP.CombatRoutines:GetList(Spec)
	local result = {}
	local classIndex = select(3, UnitClass('player'))
	if CRs[Spec] then
		for k in pairs(CRs[Spec]) do
			result[#result+1] = k
		end
	end
	for k in pairs(CRs[classIndex]) do
		result[#result+1] = k
	end
	return result
end