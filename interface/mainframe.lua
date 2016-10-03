local logo = '|T'..NeP.Media..'logo.blp:10:10|t'

NeP.Interface.MainFrame = NeP.Interface:BuildGUI({
	color = {0,0,0,0.6},
	size = {100, 0},
	title = logo..NeP.Color..NeP.Name..' v:'..NeP.Version
})

local menuFrame = CreateFrame("Frame", "ExampleMenuFrame", NeP.Interface.MainFrame, "UIDropDownMenuTemplate")
menuFrame:SetPoint("BOTTOMLEFT", NeP.Interface.MainFrame, "BOTTOMLEFT", 0, 0)
menuFrame:Hide()

local function BuildMenu()
	local result = {}
	table.insert(result, {text = logo..'['..NeP.Name..' |rv:'..NeP.Version..']', isTitle = 1, notCheckable = 1})
	local Spec = GetSpecializationInfo(GetSpecialization())
	local CrList = NeP.CombatRoutines:GetList(Spec)
	local last = NeP.Config:Read('SELECTED', Spec, 'NONE')
	for i=1, #CrList do
		local Name = CrList[i]
		table.insert(result, {
			text = Name,
			checked = (last == Name),
			func = function()
				NeP.Interface:ResetToggles()
				NeP.Core:Print('Loaded: '..Name)
				NeP.CombatRoutines:Set(Spec, Name)
			end
		})
	end
	return result
end

function NeP.Interface:DropMenu()
	EasyMenu(BuildMenu(), menuFrame, menuFrame, 0, 0, "MENU")
end