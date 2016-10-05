local string = string
local find = string.find
local sub = string.sub

local token_patterns = {
  { 'space', '^%s+' },
  { 'library', '^@' },
  { 'string', { '^\'.-\'', '^".-"' } },
  { 'logic', { '^and', '^or', '^&&', '^||', '^&', '^|' } },
  { 'not', { '^not%s', '^not$', '^!' } },
  { 'constant', { '^true', '^false', '^nil' } },
  { 'identifier', '^[_%a][_%w]*' },
  { 'comma', '^,' },
  { 'character', '^[:\']' },
  { 'number', { '^[%+%-]?%d+%.?%d*', '^%d+%.?%d*', '^%.%d+' } },
  { 'openParen', { '^%(', '^{' } },
  { 'closeParen', { '^%)', '^}' } },
  { 'openBracket', '^%[' },
  { 'closeBracket', '^%]' },
  { 'math', { '^%*', '^/', '^%-', '^%+', '^%%' } },
  { 'comparator', { '^>=', '^=>',  '^>', '^<=', '^=<', '^<', '^==', '^=', '^!=', '~=' } },
  { 'period', '^%.' }
}

local function tokenize(str, ignore_tokens)
  if not ignore_tokens then
    ignore_tokens = { space = false }
  end

  local tokens = {}

  local index = 1
  local length = #str + 1
  while index < length do
    local found = false

    for i = 1, #token_patterns do
      local token, patterns = token_patterns[i][1], token_patterns[i][2]

      local loops = 1
      local patternType = type(patterns)
      if patternType == 'table' then loops = #patterns end

      for j = 1, loops do
        local pattern

        if patternType == 'table' then
          pattern = patterns[j]
        elseif patternType == 'string' then
          pattern = patterns
        end

        local start_index, end_index = find(str, pattern, index)
        if start_index then
          local part = sub(str, start_index, end_index)

          index = end_index + 1
          found = true

          if ignore_tokens[token] then break end

          tokens[#tokens+1] = { token, part }

          break
        end
      end

      if found then break end
    end

    if not found then return tokens, sub(str, index) end
  end

  return tokens
end

local function parse(rule)
  local tokens, err = tokenize(rule)
end

return {
  parse = parse,
}