local _, NeP = ...
local T = NeP.Interface.toggleToggle

local L = {
	mastertoggle   = function(state) T(self,'MasterToggle', state) end,
	aoe            = function(state) T(self,'AoE', state) end,
	cooldowns      = function(state) T(self,'Cooldowns', state) end,
	interrupts     = function(state) T(self,'Interrupts', state) end,
    version        = function() NeP.Core:Print(NeP.Version) end,
    show = NeP.Show,
	hide = function()
		NeP:Hide()
		NeP.Core:Print('To Display NerdPack Execute: \n/nep show')
	end,
}

L.mt = L.mastertoggle
L.toggle = L.mastertoggle
L.tg = L.mastertoggle
L.ver = L.version

NeP.Commands:Register('NeP', function(msg)
	local command, rest = msg:match("^(%S*)%s*(.-)$");
	command, rest = tostring(command):lower(), tostring(rest):lower()
	rest = rest == 'on' or false
	if L[command] then L[command](rest) end
end, 'nep', 'nerdpack')