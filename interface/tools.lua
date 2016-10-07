local _, NeP = ...
NeP.Interface = {}
NeP.Globals.Interface = {}

local DiesalGUI = LibStub("DiesalGUI-1.0")

function NeP.Interface:BuildGUI(eval)
	local parent = DiesalGUI:Create('Window')
	parent:SetWidth(eval.width or 200)
	parent:SetHeight(eval.height or 300)
	parent.frame:SetClampedToScreen(true)

	if not eval.color then eval.color = "ee2200" end
	if type(eval.color) == 'function' then eval.color = eval.color() end

	if eval.title then
		parent:SetTitle("|cff"..eval.color..eval.title.."|r", eval.subtitle)
	end

	return parent
end

-- Gobals
NeP.Globals.Interface.BuildGUI = NeP.Interface.BuildGUI