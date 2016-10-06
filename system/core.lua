local _, NeP = ...

NeP.Core = {}

function NeP.Core:Print(text)
	print('['..NeP.Color..'NeP|r]: '..tostring(text))
end