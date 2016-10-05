NeP.DSL = {}

local DSL = NeP.DSL

local conditions = {}

local Deprecated_Warn = {}
local function Deprecated(Strg)
	if Deprecated_Warn[Strg] then
		NeP.Core.Print(Strg..' Was deprecated, use: '..Deprecated_Warn[Strg].replace..'instead.')
		Deprecated_Warn[Strg] = nil
	end
end

function DSL:Get(Strg)
	Strg = Strg:lower()
	if conditions[Strg] then
		Deprecated(Strg)
		return conditions[Strg]
	end
end

function DSL:RegisterConditon(name, condition, overwrite)
	local name = name:lower()
	if not conditions[name] or overwrite then
		conditions[name] = condition
	end
end

function DSL:RegisterConditon_Deprecated(name, replace, condition, overwrite)
	name = name:lower()
	self:RegisterConditon(name, condition, overwrite)
	if not Deprecated_Warn[name] then
		Deprecated_Warn[name] = {}
		Deprecated_Warn[name].replace = replace
	end
end