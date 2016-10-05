NeP.Compiler = {}

local spellTokens = {
  {'actions', '^%'},
  {'along', '^&'},
  {'lib', '^@'}
  {'macro', '^/'}
}

-- Takes a string a produces a table in its place
function NeP.Compiler:Spell(eval)
  local ref = eval[1]
  ref = {
    spell = ref
  }
  if ref.spell:find('^!') then
    ref.interrupts = true
    ref.spell = ref.spell:sub(2)
  end
  for i=1, #spellTokens do
    local kind, patern = unpack(spellTokens[i])
    if ref.spell:find(patern) then
      ref.spell = ref.spell:sub(2)
      ref.token = kind
    end
  end
  ref.spell = NeP.Spells:Convert(ref.spell)
end

function NeP.Compiler:Target(eval)
  local ref = eval[3]
  ref = {
    target = ref
  }
  if ref.spell:find('.ground') then
    ref.target = ref.target:sub(0,-8)
    ref.ground = true
  end
end

function NeP.Compiler:Itearte(eval)
  local spell, cond, target = unpack(eval)
  -- Take care of spell
  if type(spell) == 'table' then
    self:Itearte(spell)
  elseif type(spell) == 'string' then
    self:Spell(eval)
  elseif type(spell) == 'function' then
    eval[1] = {
      spell = spell,
      token = 'func'
    }
  end
  -- Take care of target
  self:Target(eval)
end