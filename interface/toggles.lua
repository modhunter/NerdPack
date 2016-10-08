local _, NeP = ...
local mainframe = NeP.Interface.MainFrame

local ButtonsSize = 40
local ButtonsPadding = 2

local Toggles = {}
local tcount = 0

local function SetTexture(parent, icon)
	temp = parent:CreateTexture()
	if icon then
		temp:SetTexture(icon)
		temp:SetTexCoord(.08, .92, .08, .92)
	else
		local r,g,b = unpack(NeP.Core:ClassColor('player', 'rgb'))
		temp:SetColorTexture(r,g,b,.7)
	end
	temp:SetAllPoints(parent)
	return temp
end

local function OnClick(self, func, button)
	if button == 'LeftButton' then
		self.actv = not self.actv
		NeP.Config:Write('TOGGLE_STATES', self.key, self.actv)
	end
	if func then
		func(self, button)
	end
	self:SetChecked(self.actv)
end

local function OnEnter(self, name, text)
	local OnOff = self.actv and 'ON' or 'OFF'
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddDoubleLine(name, OnOff)
	if text then
		GameTooltip:AddLine('|cffFFFFFF'..text)
	end
	GameTooltip:Show()
end

local function CreateToggle(eval)
	local pos = (ButtonsSize*tcount)+(tcount*ButtonsPadding)-(ButtonsSize+ButtonsPadding)
	Toggles[eval.key] = CreateFrame("CheckButton", eval.key, mainframe.content)
	local temp = Toggles[eval.key]
	temp:SetFrameStrata("high")
	temp:SetFrameLevel(1)
	temp.key = eval.key:lower()
	temp:SetPoint("LEFT", mainframe.content, pos, 0)
	temp:SetSize(ButtonsSize, ButtonsSize)
	temp:SetFrameLevel(1)
	temp:SetNormalFontObject("GameFontNormal")
	temp.texture = SetTexture(temp, eval.icon)
	temp.actv = NeP.Config:Read('TOGGLE_STATES', eval.key, false)
	temp:SetChecked(temp.actv)
	temp.Checked_texture = SetTexture(temp)
	temp:SetCheckedTexture(temp.Checked_texture)
	temp:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	temp:SetScript("OnClick", function(self, button) OnClick(self, eval.func, button) end)
	temp:SetScript("OnEnter", function(self) OnEnter(self, eval.name, eval.text) end)
	temp:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
end

function NeP.Interface:AddToggle(eval)
	tcount = tcount + 1
	if Toggles[eval.key] then
		Toggles[eval.key]:Show()
	else
		CreateToggle(eval)
	end
	NeP.Interface:RefreshToggles()
end

function NeP.Interface:RefreshToggles()
	mainframe.settings.width = tcount*(ButtonsSize+ButtonsPadding)-ButtonsPadding
	mainframe.settings.height = ButtonsSize+18
	
	mainframe.settings.minHeight = mainframe.settings.height
	mainframe.settings.minWidth = mainframe.settings.width
	mainframe.settings.maxHeight = mainframe.settings.height
	mainframe.settings.maxWidth = mainframe.settings.width
	mainframe:ApplySettings()
end

function NeP.Interface:ResetToggles()
	tcount = 0
	for k,v in pairs(Toggles) do
		Toggles[k]:Hide()
	end
	self:DefaultToggles()
end

function NeP.Interface:toggleToggle(key, state)
	local self = Toggles[key:lower()]
	if not self then return end
	self.actv = state or not self.actv
	self:SetChecked(self.actv)
	NeP.Config:Write('TOGGLE_STATES', self.key, self.actv)
end

-- Globals
NeP.Globals.Interface.toggleToggle = NeP.Interface.toggleToggle
NeP.Globals.Interface.AddToggle = NeP.Interface.AddToggle