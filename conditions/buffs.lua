local _, NeP = ...
--[[
					BUFFS/DEBUFFS CONDITIONS!
			Only submit BUFF specific conditions here.
					KEEP ORGANIZED AND CLEAN!

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
]]

local heroismBuffs = { 32182, 90355, 80353, 2825, 146555 }
NeP.DSL:Register("hashero", function()
	for i = 1, #heroismBuffs do
		local SpellName = GetSpellName(heroismBuffs[i])
		local buff = NeP.APIs['UnitBuff']('player', SpellName, "any")
		if buff then return true end
	end
	return false
end)

------------------------------------------ BUFFS -----------------------------------------
------------------------------------------------------------------------------------------
NeP.DSL:Register("buff", function(target, spell)
	local buff,_,_,caster = NeP.APIs['UnitBuff'](target, spell)
	if not not buff and (caster == 'player' or caster == 'pet') then
		return true
	end
end)

NeP.DSL:Register("buff.any", function(target, spell)
	local buff = NeP.APIs['UnitBuff'](target, spell, "any")
	if not not buff then
		return true
	end
end)

NeP.DSL:Register("buff.count", function(target, spell)
	local buff,count,_,caster = NeP.APIs['UnitBuff'](target, spell)
	if not not buff and (caster == 'player' or caster == 'pet') then
		return count
	end
	return 0
end)

NeP.DSL:Register("buff.duration", function(target, spell)
	local buff,_,expires,caster = NeP.APIs['UnitBuff'](target, spell)
	if buff and (caster == 'player' or caster == 'pet') then
		return (expires - GetTime())
	end
	return 0
end)

------------------------------------------ DEBUFFS ---------------------------------------
------------------------------------------------------------------------------------------

NeP.DSL:Register("debuff", function(target, spell)
	local debuff,_,_,caster = NeP.APIs['UnitDebuff'](target, spell)
	if not not debuff and (caster == 'player' or caster == 'pet') then
		return true
	end
end)

NeP.DSL:Register("debuff.any", function(target, spell)
	local debuff = NeP.APIs['UnitDebuff'](target, spell, "any")
	if not not debuff then
		return true
	end
end)

NeP.DSL:Register("debuff.count", function(target, spell)
	local debuff,count,_,caster = NeP.APIs['UnitDebuff'](target, spell)
	if not not debuff and (caster == 'player' or caster == 'pet') then
		return count
	end
	return 0
end)

NeP.DSL:Register("debuff.duration", function(target, spell)
	local debuff,_,expires,caster = NeP.APIs['UnitDebuff'](target, spell)
	if debuff and (caster == 'player' or caster == 'pet') then
		return (expires - GetTime())
	end
	return 0
end)