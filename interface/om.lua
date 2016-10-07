local _, NeP = ...

local Round = NeP.Core.Round
local DiesalGUI = LibStub('DiesalGUI-1.0')

local statusBars = {}
local statusBarsUsed = {}

local parent = NeP.Interface:BuildGUI({
	key = 'NePOMgui',
	width = 500,
	height = 250,
	title = 'ObjectManager GUI'
})
parent:Hide()
NeP.Interface:Add('ObjectManager', function() parent:Show() end)

local dOM = 'Enemy'
local bt = {
	ENEMIE = {a = 'TOPLEFT', b = 'Enemy'},
	FRIENDLY = {a = 'TOP', b = 'Friendly'},
	DEAD = {a = 'TOPRIGHT', b = 'Dead'}
}
for k,v in pairs(bt) do
	bt[k] = DiesalGUI:Create("Button")
	parent:AddChild(bt[k])
	bt[k]:SetParent(parent.content)
	bt[k]:SetPoint(v.a, parent.content, v.a, 0, 0)
	bt[k].frame:SetSize(parent.content:GetWidth()/3, 30)
	bt[k]:AddStyleSheet(NeP.UI.buttonStyleSheet)
	bt[k]:SetEventListener("OnClick", function() dOM = v.b end)
	bt[k]:SetText(v.b)
end

local ListWindow = DiesalGUI:Create('ScrollFrame')
parent:AddChild(ListWindow)
ListWindow:SetParent(parent.content)
ListWindow:SetPoint("TOP", parent.content, "TOP", 0, -30)
ListWindow.frame:SetSize(parent.content:GetWidth(), parent.content:GetHeight()-30)
ListWindow.parent = parent

local function getStatusBar()
	local statusBar = tremove(statusBars)
	if not statusBar then
		statusBar = DiesalGUI:Create('StatusBar')
		statusBar:SetParent(ListWindow.content)
		parent:AddChild(statusBar)
		statusBar.frame:SetStatusBarColor(1,1,1,0.35)
	end
	statusBar:Show()
	table.insert(statusBarsUsed, statusBar)
	return statusBar
end

local function recycleStatusBars()
	for i = #statusBarsUsed, 1, -1 do
		statusBarsUsed[i]:Hide()
		tinsert(statusBars, tremove(statusBarsUsed))
	end
end

local function RefreshGUI()
	local offset = -5
	recycleStatusBars()
	local temp = NeP.OM:Get(dOM)
	for guid, Obj in pairs(temp) do
		local Health = UnitHealth(Obj.key) and math.floor((UnitHealth(Obj.key) / UnitHealthMax(Obj.key)) * 100) or 100
		local statusBar = getStatusBar()
		statusBar.frame:SetPoint('TOP', ListWindow.content, 'TOP', 2, offset )
		statusBar.frame.Left:SetText('|cff'..NeP.Core:ClassColor(Obj.key, 'hex')..Obj.name)
		statusBar.frame.Right:SetText('( |cffff0000ID|r: '..Obj.id..' / |cffff0000Health|r: '..Health..' / |cffff0000Dist|r: '..(Obj.distance or 0)..' )')
		statusBar.frame:SetScript('OnMouseDown', function(self) TargetUnit(Obj.key) end)
		statusBar:SetValue(Health)
		offset = offset -18
	end
end

C_Timer.NewTicker(0.1, (function()
	if parent:IsShown() then 
		RefreshGUI()
	end
end), nil)