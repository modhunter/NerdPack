NeP.Compiler = {}

local spellTokens = {
  {'actions', '^%'},
  {'along', '^&'},
  {'lib', '^@'}
}

-- Takes a string a produces a table in its place
function NeP.Compiler:Spell(eval)
  eval = {
    spell = eval
  }
  if eval.spell:find('^!') then
    eval.interrupts = true
    eval.spell = eval.spell:sub(2)
  end
  for i=1, #spellTokens do
    local kind, patern = unpack(spellTokens[i])
    if eval.spell:find(patern) then
      eval.spell = eval.spell:sub(2)
      eval.token = kind
    end
  end
  eval.spell = NeP.Spells:Convert(eval.spell)
end

function NeP.Compiler:Target(eval)
  eval = {
    target = eval
  }
  if eval.spell:find('.ground') then
    eval.target = eval.target:sub(0,-8)
    eval.ground = true
  end
end

function NeP.Compiler:Itearte(eval)
  local spell, cond, target = unpack(eval)
  -- Take care of spell
  if type(spell) == 'table' then
    self:Itearte(spell)
  elseif type(spell) == 'string' then
    self:Spell(spell)
  elseif type(spell) == 'function' then
    spell = {
      spell = spell,
      token = 'func'
    }
  end
  -- Take care of target
  if type(target) == 'table' then
    self:Itearte(target)
  elseif type(target) == 'string' then
    self:Spell(target)
  end
end