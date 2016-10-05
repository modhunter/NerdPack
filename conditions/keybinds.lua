local KEYBINDS = {
	-- Shift
	['shift'] = function() return IsShiftKeyDown() end,
	['lshift'] = function() return IsLeftShiftKeyDown() end,
	['rshift'] = function() return IsRightShiftKeyDown() end,
	-- Control
	['control'] = function() return IsControlKeyDown() end,
	['lcontrol'] = function() return IsLeftControlKeyDown() end,
	['rcontrol'] = function() return IsRightControlKeyDown() end,
	-- Alt
	['alt'] = function() return IsAltKeyDown() end,
	['lalt'] = function() return IsLeftAltKeyDown() end,
	['ralt'] = function() return IsRightAltKeyDown() end,
	-- Mouse
	['mouse3'] = function() return IsMouseButtonDown(3) end,
	['mouse4'] = function() return IsMouseButtonDown(4) end,
	['mouse5'] = function() return IsMouseButtonDown(5) end,
}

NeP.DSL:RegisterConditon("keybind", function(_, Arg)
	local Arg = Arg:lower()
	return KEYBINDS[Arg] and KEYBINDS[Arg]() and not GetCurrentKeyBoardFocus()
end)