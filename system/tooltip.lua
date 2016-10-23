local _, NeP = ...

NeP.Tooltip = {}
NeP.Globals.Tooltip = NeP.Tooltip

local frame = CreateFrame('GameTooltip', 'NeP_ScanningTooltip', UIParent, 'GameTooltipTemplate')

local function pPattern(text, pattern)
	if type(pattern) == 'string' then
		local match = text:lower():match(pattern)
		if match then return true end
	elseif type(pattern) == 'table' then
		for i=1, #pattern do
			local match = text:lower():match(pattern[i])
			if match then return true end
		end
	end
end

function NeP.Tooltip:Scan_Buff(target, pattern)
	for i = 1, 40 do
		frame:SetOwner(UIParent, 'ANCHOR_NONE')
		frame:SetUnitBuff(target, i)
		local tooltipText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
		return tooltipText and pPattern(tooltipText, pattern)
	end
	return false
end

function NeP.Tooltip:Scan_Debuff(target, pattern)
	for i = 1, 40 do
		frame:SetOwner(UIParent, 'ANCHOR_NONE')
		frame:SetUnitDebuff(target, i)
		local tooltipText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
		return tooltipText and pPattern(tooltipText, pattern)
	end
	return false
end

function NeP.Tooltip:Unit(target, pattern)
	frame:SetOwner(UIParent, 'ANCHOR_NONE')
	frame:SetUnit(target)
	local tooltipText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
	if pPattern(UnitName(target):lower(), pattern) then return true end
	return tooltipText and pPattern(tooltipText, pattern)
end

function NeP.Tooltip:Tick_Time(target)
	frame:SetOwner(UIParent, 'ANCHOR_NONE')
	frame:SetUnitBuff(target)
	local tooltipText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
	local match = tooltipText:lower():match("[0-9]+%.?[0-9]*")
	return tonumber(match)
end
