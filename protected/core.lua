local _, NeP = ...

NeP.Protected = {}

local unlockers = {}

function NeP.Globals.AddUnlocker(name, test, functions, extended)
	unlockers[name] = {
		name = name,
		test = test,
		functions = functions,
		extended = extended
	}
	if test() then
		NeP.Core:Print('|cffff0000Found:|r ' .. name)
	end
end

NeP.Globals.Protected = function(token, args)
	return NeP.Protected[token](unpack(args))
end

C_Timer.NewTicker(1, (function()
	if NeP.Protected.unlocked then return end
	for name, unlocker in ipairs(unlockers) do
		if unlocker.test() then
			-- Extras
			if unlocker.extended then
				for name, func in ipairs(unlocker.extended) do
					NeP.Protected[name] = fn
				end
			end
			-- Basic here
			for name, func in ipairs(unlocker.functions)
				NeP.Protected[name] = func
			end
			NeP.Protected.unlocked = true
		end
	end
end), nil)