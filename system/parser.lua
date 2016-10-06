local _, NeP = ...

NeP.Parser = {}

local function IsMountedCheck()
	for i = 1, 40 do
		local mountID = select(11, UnitBuff('player', i))
		if mountID and NeP.ByPassMounts(mountID) then
			return true
		end
	end
	return not IsMounted()
end

local function castingTime()
	local time = GetTime()
	local a_endTime = select(6,UnitCastingInfo("player"))
	if a_endTime then return (a_endTime/1000 )-time end
	local b_endTime = select(6,UnitChannelInfo("player"))
	if b_endTime then return (b_endTime/1000)-time end
	return 0
end

local fake_target = {
  func = function()
    return UnitExists('target') and 'target' or 'player'
  end
}

function NeP.Parser:Target(eval)
  -- This is so we dont generate garbage when using fake_target
	eval = eval or fake_target
  if eval.func then
    eval.target = eval.func()
  end
  -- Check unit
  if UnitExists(eval.target) and UnitIsVisible(eval.target)
	and Engine.LineOfSight('player', eval.target) then
    return true
  end
end

function NeP.Parser:Spell(eval)
  if eval.tokens then
    --TODO, actions like &, @ or function
  end
	local skillType = GetSpellBookItemInfo(eval.spell)
	local isUsable, notEnoughMana = IsUsableSpell(eval.spell)
	if skillType ~= 'FUTURESPELL' and isUsable and not notEnoughMana then
		local GCD = NeP.DSL:Get('gcd')()
		if GetSpellCooldown(eval.spell) <= GCD then
			return true
		end
	end
end

function NeP.Parser:Parse(eval)
  local spell, cond, target = eval
  if type(spell) == 'table' then
    --if conditions_pass then
      local r = self:Parse(spell)
      if r then return true end
    --end
  elseif spell.interrupts or spell.token or (castingTime('player') == 0) then
    if self:Target(target) then
      if self:Spell(spell) --[[AND conditions_pass]]then
        -- Cancels the current cast
        if spell.interrupts then
          SpellStopCasting()
        end
        -- TODO, EXECUTE/CAST
        return true
      end
    end
  end
end

C_Timer.NewTicker(0.1, (function()
	if NeP.DSL:Get('toggle')(nil, 'mastertoggle') then
        if not UnitIsDeadOrGhost('player') and IsMountedCheck() then
          local table = NeP.CR.CR[InCombatLockdown()]
          for i=1, #table do
            local r = NeP.Parser:Parse(table[i])
            if r then break end
          end
        end
	end
end), nil)