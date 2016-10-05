NeP.Protected = {
	Unlocker = nil,
}

NeP.Interface:Add('|cffff0000Unlock!', function()
	NeP.Protected.Unlocker = nil
	NeP.Protected.Generic_Check = false
	NeP.Engine.FaceRoll()
	pcall(RunMacroText, '/run NeP.Protected.Generic_Check = true')
end)

local unlockers = {}
function NeP.Protected:Add(global, func, name)
	unlockers[global] = {func = func, name = name}
end

function NeP.Protected:Find()
	for global, v in pairs(unlockers) do
			if _G[global] then
				self.Unlocker = v.name
				v.func()
				NeP.Core:Print('|cffff0000Found:|r '..v.name)
				break
			end
		end
end

C_Timer.NewTicker(1, (function()
	if not NeP.Protected.Unlocker then
		NeP.Protected:Find()
	end
end), nil)