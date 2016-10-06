local _, NeP = ...

local dToggles = {
	{
		key = 'mastertoggle',
		name = 'MasterToggle',
		text = 'THIS IS A TOOLTIP!',
		icon = 'Interface\\ICONS\\Ability_repair.png',
		func = function(self, button)
			if button == "RightButton" then
				if IsControlKeyDown() then
					NeP.Interface.MainFrame.drag:Show()
				else
					NeP.Interface:DropMenu()
				end
			end
		end
	},
	{
		key = 'interrupts',
		name = 'Interrupts',
		icon = 'Interface\\ICONS\\Ability_Kick.png',
	},
	{
		key = 'cooldowns',
		name = 'Cooldowns',
		icon = 'Interface\\ICONS\\Achievement_BG_winAB_underXminutes.png',
	},
	{
		key = 'aoe',
		name = 'Multitarget',
		icon = 'Interface\\ICONS\\Ability_Druid_Starfall.png',
	}
}

function NeP.Interface:DefaultToggles()
	for i=1, #dToggles do
		self:AddToggle(dToggles[i])
	end
end

NeP.Listener:Add("NeP_TOGGLES", "PLAYER_LOGIN", function(...)
	NeP.Interface:DefaultToggles()
end)