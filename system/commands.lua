local _, NeP = ...

NeP.Commands = {}

function NeP.Commands:Register(name, func, ...)
	SlashCmdList[name] = func
	local command = ''
	for i = 1, select('#', ...) do
		command = select(i, ...)
		if strsub(command, 1, 1) ~= '/' then
			command = '/' .. command
		end
		_G['SLASH_'..name..i] = command
	end
end

NeP.Globals.Commands = {
	Register = NeP.Commands.Register
}