local _, NeP = ...

NeP.Listener = {}

local listeners = {}

local frame = CreateFrame('Frame', 'NeP_Events')
frame:SetScript('OnEvent', function(self, event, ...)
	if not listeners[event] then return end
	for k,v in pairs(listeners[event]) do
		listeners[event][k](...)
	end
end)

function NeP.Listener:Add(name, event, callback)
	if not listeners[event] then
		frame:RegisterEvent(event)
		listeners[event] = {}
	end
	listeners[event][name] = callback
end

function NeP.Listener:Remove(name, event)
	if listeners[event] then
		listeners[event][name] = nil
	end
end

function NeP.Listener:Trigger(event, ...)
	onEvent(nil, event, ...)
end