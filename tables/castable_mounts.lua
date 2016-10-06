--[[
165803/telaari-talbuk
164222/frostwolf-war-wolf
221883/divine-steed
221887/divine-steed
221673/storms-reach-worg
221595/storms-reach-cliffwalker
221672/storms-reach-greatstag
221671/storms-reach-warbear
]]

local ByPassMounts = {
	165803,164222,221883,221887,
	221673,221595,221672,221671
}

local _, NeP = ...
function NeP.ByPassMounts(ID)
	for i=1, #ByPassMounts do
		if tonumber(ID) == ByPassMounts[i] then
			return true
		end
	end
end