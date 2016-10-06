local _, NeP = ...

local function checkChanneling(target)
	local name, _, _, _, startTime, endTime, _, notInterruptible = UnitChannelInfo(target)
	if name then return name, startTime, endTime, notInterruptible end
end

local function checkCasting(target)
	local name, startTime, endTime, notInterruptible = checkChanneling(target)
	if name then return name, startTime, endTime, notInterruptible end
	local name, _,_,_, startTime, endTime, _,_, notInterruptible = UnitCastingInfo(target)
	if name then return name, startTime, endTime, notInterruptible end
end

NeP.DSL:Register('timetomax', function(target, spell)
	local max = UnitPowerMax(target)
	local curr = UnitPower(target)
	local regen = select(2, GetPowerRegen(target))
	return (max - curr) * (1.0 / regen)
end)

NeP.DSL:Register('toggle', function(_, toggle)
	return NeP.Config:Read('TOGGLE_STATES', toggle:lower(), false)
end)

NeP.DSL:Register('casting.percent', function(target, spell)
	local name, startTime, endTime, notInterruptible = checkCasting(target)
	if name and not notInterruptible then
		local castLength = (endTime - startTime) / 1000
		local secondsLeft = endTime / 1000  - GetTime()
		return ((secondsLeft/castLength)*100)
	end
	return 0
end)

NeP.DSL:Register('casting.delta', function(target, spell)
	local name, startTime, endTime, notInterruptible = checkCasting(target)
	if name and not notInterruptible then
		local castLength = (endTime - startTime) / 1000
		local secondsLeft = endTime / 1000 - GetTime()
		return secondsLeft, castLength
	end
	return 0
 end)

NeP.DSL:Register('channeling', function (target, spell)
	local name, startTime, endTime, notInterruptible = checkChanneling(target)
	local spell = GetSpellName(spell)
	if spell and (name == spell) then
		return true
	end
	return false
end)

NeP.DSL:Register('casting', function(target, spell)
	local name, startTime, endTime, notInterruptible = checkCasting(target)
	local spell = GetSpellName(spell)
	if spell and (name == spell) then
		return true
	end
	return false
end)

NeP.DSL:Register('interruptAt', function (target, spell)
	if UnitIsUnit('player', target) then return false end
	if spell and NeP.DSL.Conditions['toggle'](nil, 'Interrupts') then
		local stopAt = tonumber(spell) or 35
		local stopAt = stopAt + math.random(-5, 5)
		local secondsLeft, castLength = NeP.DSL.Conditions['casting.delta'](target)
		if secondsLeft ~= 0 and 100 - (secondsLeft / castLength * 100) > stopAt then
			return true
		end
	end
	return false
end)

NeP.DSL:Register('spell.cooldown', function(_, spell)
	local start, duration, enabled = GetSpellCooldown(spell)
	if not start then return 0 end
	if start ~= 0 then
		return (start + duration - GetTime())
	end
	return 0
end)

NeP.DSL:Register('spell.recharge', function(_, spell)
	local charges, maxCharges, start, duration = GetSpellCharges(spell)
	if not start then return false end
	if start ~= 0 then
		return (start + duration - GetTime())
	end
	return 0
end)

NeP.DSL:Register('spell.usable', function(_, spell)
	return (IsUsableSpell(spell) ~= nil)
end)

NeP.DSL:Register('spell.exists', function(_, spell)
	if GetSpellBookIndex(spell) then
		return true
	end
	return false
end)

NeP.DSL:Register('spell.charges', function(_, spell)
	local charges, maxCharges, start, duration = GetSpellCharges(spell)
	if duration and charges ~= maxCharges then
		charges = charges + ((GetTime() - start) / duration)
	end
	return charges or 0
end)

NeP.DSL:Register('spell.count', function(_, spell)
	return select(1, GetSpellCount(spell))
end)

NeP.DSL:Register('spell.range', function(target, spell)
	local spellIndex, spellBook = GetSpellBookIndex(spell)
	if not spellIndex then return false end
	return spellIndex and IsSpellInRange(spellIndex, spellBook, target)
end)

NeP.DSL:Register('spell.casttime', function(_, spell)
	local CastTime = select(4, GetSpellInfo(spell)) / 1000
	if CastTime then return CastTime end
	return 0
end)

NeP.DSL:Register('combat.time', function(target)
	return NeP.CombatTracker.CombatTime(target)
end)

NeP.DSL:Register('timeout', function(target, args)
	local name, time = strsplit(',', args, 2)
	local time = tonumber(time)
	if time then
		if NeP.timeOut.check(name) then return false end
		NeP.timeOut.set(name, time)
		return true
	end
	return false
end)

local waitTable = {}
NeP.DSL:Register('waitfor', function(target, args)
	local name, time = strsplit(',', args, 2)
	if time then
		local time = tonumber(time)
		local GetTime = GetTime()
		local currentTime = GetTime % 60
		if waitTable[name] then
			if waitTable[name] + time < currentTime then
				waitTable[name] = nil
				return true
			end
		else
			waitTable[name] = currentTime
		end
	end
	return false
end)

NeP.DSL:Register('IsNear', function(target, args)
	local targetID, distance = strsplit(',', args, 2)
	local targetID = tonumber(targetID) or 0
	local distance = tonumber(distance) or 60
		for i=1,#NeP.OM['unitEnemie'] do
			local Obj = NeP.OM['unitEnemie'][i]
			if Obj.id == targetID then
				if NeP.Engine.Distance('player', target) <= distance then
					return true
				end
			end
		end
	return false
end)

NeP.DSL:Register('equipped', function(_, item)
	return IsEquippedItem(item)
end)

NeP.DSL:Register('gcd', function()
	local class = select(3,UnitClass("player"))
	-- Some class's always have GCD = 1
	if class == 4 or (class == 11 and GetShapeshiftForm()== 2) then
		return 1
	end
	return math.floor((1.5 / ((GetHaste() / 100) + 1)) * 10^3 ) / 10^3
end)

NeP.DSL:Register('UI', function(_, key)
	local SelectedCR = NeP.Interface.GetSelectedCR().Name
	return NeP.Interface.fetchKey(SelectedCR, key)
end)

NeP.DSL:Register('haste', function(unit)
	return UnitSpellHaste(unit)
end)
