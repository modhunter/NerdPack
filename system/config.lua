local n_name, NeP = ...

NeP.Config = {}
local Data = {}
local Delays = {}

function NeP.Config:WhenLoad(key, func)
	if Delays then
		Delays[key] = func
	else
		func()
	end
end

NeP.Listener:Add("NeP_Config", "ADDON_LOADED", function(addon)
	if addon:lower() == n_name:lower() then
		if NePDATA == nil then
			NePDATA = {}
		end
		Data = NePDATA
	end
	if Delays then
		for k,v in pairs(Delays) do
			v()
		end
		Delays = nil
	end
end)

function NeP.Config:Read(key1, key2, default)
	return Data[key1] and Data[key1][key2] or default
end

function NeP.Config:Write(key1, key2, value)
	if not Data[key1] then
		Data[key1] = {}
	end
	Data[key1][key2] = value
end