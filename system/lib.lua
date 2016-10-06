local _, NeP = ...

NeP.Library = {}

NeP.Globals.Library = NeP.Library

local libs = {}

function NeP.Library:Add(name, lib)
	if not libs[name] then
		libs[name] = setmetatable({}, {__index=lib})
	end
end

function NeP.Library:Fetch(name)
	return libs[name]
end

function NeP.Library:Parse(Strg)
	local a, b = strsplit(".", Strg, 2)
	return libs[a][b]()
end