local _, NeP = ...

local function BuildCRs(Spec, Last)
	local CrList = NeP.CR:GetList(Spec)
	for i=1, #CrList do
		local Name = CrList[i]
		NeP.Interface:AddCR(Spec, Name, (Name == Last))
	end
end

NeP.Listener:Add("NeP_Config", "PLAYER_LOGIN", function()
	local Spec = GetSpecializationInfo(GetSpecialization())
	local englishClass  = select(2, UnitClass('player'))
	local a, b = englishClass:sub(1, 1):upper(), englishClass:sub(2):lower()
	local classCR = '[NeP] '..a..b..' - Basic'
	local last = NeP.Config:Read('SELECTED', Spec, classCR)
	
	NeP.Interface:ResetCRs()
	BuildCRs(Spec, last)

	NeP.CR:Set(Spec, last)
	NeP.Spells:Filter()
end)