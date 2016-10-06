local _, NeP = ...
--[[
						CLASS CONDITIONS!
			Only submit class specific conditions here.
					KEEP ORGANIZED AND CLEAN!

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
]]

NeP.DSL:RegisterConditon('energy', function(target)
	return UnitPower(target, UnitPowerType(target))
end)

-- Returns the amount of energy you have left till max (e.g. you have a max of 100 energy and 80 energy now, so it will return 20)
NeP.DSL:RegisterConditon('energydiff', function(target)
	local max = UnitPowerMax(target, UnitPowerType(target))
	local curr = UnitPower(target, UnitPowerType(target))
	return (max - curr)
end)

NeP.DSL:RegisterConditon('mana', function(target)
	if UnitExists(target) then
		return math.floor((UnitMana(target) / UnitManaMax(target)) * 100)
	end
	return 0
end)

--------------------------------------------------- PRIEST ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('insanity', function(target)
	return UnitPower(target, SPELL_POWER_INSANITY)
end)

--------------------------------------------------- HUNTER ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('petrange', function(target)
	if target then
		return NeP.Engine.Distance('pet', target)
	end
	return 0
end)

NeP.DSL:RegisterConditon('focus', function(target)
	return UnitPower(target, SPELL_POWER_FOCUS)
end)

--------------------------------------------------- DEATHKNIGH -----------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('runicpower', function(target)
	return UnitPower(target, SPELL_POWER_RUNIC_POWER)
end)

NeP.DSL:RegisterConditon('runes', function()
	local count = 0
	local next = 0
	for i = 1, 6 do
		local _, duration, runeReady = GetRuneCooldown(i)
		if runeReady then
			count = count + 1
		elseif duration > next then
			next = duration
		end
	end
	if next > 0 then count = count + (next / 10) end
	return count
end)

--------------------------------------------------- SHAMMMAN -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('maelstrom', function(target)
    return UnitPower(target, SPELL_POWER_MAELSTROM)
end)

NeP.DSL:RegisterConditon('totem', function(_, totem)
	for index = 1, 4 do
		local totemName = select(2, GetTotemInfo(index))
		if totemName == GetSpellName(totem) then
			return true
		end
	end
	return false
end)

NeP.DSL:RegisterConditon('totem.duration', function(_, totem)
	for index = 1, 4 do
		local _, totemName, startTime, duration = GetTotemInfo(index)
		if totemName == GetSpellName(totem) then
			return floor(startTime + duration - GetTime())
		end
	end
	return 0
end)

NeP.DSL:RegisterConditon('totem.time', function(_, totem)
	for index = 1, 4 do
		local _, totemName, _, duration = GetTotemInfo(index)
		if totemName == GetSpellName(totem) then
			return duration
		end
	end
	return 0
end)

--------------------------------------------------- WARLOCK --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('soulshards', function(target)
	return UnitPower(target, SPELL_POWER_SOUL_SHARDS)
end)

--------------------------------------------------- MONK -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('chi', function(target)
	return UnitPower(target, SPELL_POWER_CHI)
end)

-- Returns the number of chi you have left till max (e.g. you have a max of 5 chi and 3 chi now, so it will return 2)
NeP.DSL:RegisterConditon('chidiff', function(target)
    local max = UnitPowerMax(target, SPELL_POWER_CHI)
    local curr = UnitPower(target, SPELL_POWER_CHI)
    return (max - curr)
end)

--------------------------------------------------- DRUID ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('form', function()
	return GetShapeshiftForm()
end)

NeP.DSL:RegisterConditon('lunarpower', function(target)
    return UnitPower(target, SPELL_POWER_LUNAR_POWER)
end)

NeP.DSL:RegisterConditon('mushrooms', function()
	local count = 0
	for slot = 1, 3 do
	if GetTotemInfo(slot) then
		count = count + 1 end
	end
	return count
end)

--------------------------------------------------- PALADIN --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('holypower', function(target)
	return UnitPower(target, SPELL_POWER_HOLY_POWER)
end)

--------------------------------------------------- WARRIOR --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('rage', function(target)
	return UnitPower(target, SPELL_POWER_RAGE)
end)

NeP.DSL:RegisterConditon('stance', function()
	return GetShapeshiftForm()
end)

--------------------------------------------------- DEMONHUNTER ----------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('fury', function(target)
	return UnitPower(target, SPELL_POWER_FURY)
end)
-- Returns the number of fury you have left till max (e.g. you have a max of 100 fury and 80 fury now, so it will return 20)
NeP.DSL:RegisterConditon('furydiff', function(target)
	local max = UnitPowerMax(target, SPELL_POWER_FURY)
	local curr = UnitPower(target, SPELL_POWER_FURY)
	return (max - curr)
end)

NeP.DSL:RegisterConditon('pain', function(target)
	return UnitPower(target, SPELL_POWER_PAIN)
end)

--------------------------------------------------- MAGE -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('arcanecharges', function(target)
	return UnitPower(target, SPELL_POWER_ARCANE_CHARGES)
end)

--------------------------------------------------- ROGUE ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL:RegisterConditon('combopoints', function(target)
	return UnitPower(target, SPELL_POWER_COMBO_POINTS)
end)
