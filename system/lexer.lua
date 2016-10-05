NeP.Lexer = {}

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

function NeP.Lexer:Tokenize(Strg, list)
	local index = 1
	while index < #Strg+1 do
		for i = 1, #tokens do
			local token, patterns = tokens[i][1], tokens[i][2]
			for i = 1, #patterns do
				local sI, eI = Strg:find(patterns[i], index)
				if sI then
					index = eI + 1
					list[#list+1] = {
						kind = token,
						value = Strg:sub(sI, eI),
						from = sI,
						to = eI
					}
				end
			end
		end
	end
end

--/run NeP.Lexer:STRING('player.buff(Soul Fragments).count<4&player.incdmg(4)')
function NeP.Lexer:STRING(eval)
	local list = {}
	self:Tokenize(eval, list)
end

function NeP.Lexer:TABLE(eval)
	for i=1, #eval do
		self:Lex(eval[i])
	end
end

function NeP.Lexer:FUNCTION(eval)
	eval = {
		type = 'func',
		func = eval
	}
end

function NeP.Lexer:Lex(eval)
	local type = type(eval):upper()
	print(type)
	if self[type] then
		self[type](self, eval)
	end
end