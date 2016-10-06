local _, NeP = ...
local LibDispellable = LibStub('LibDispellable-1.0')
local tlp = NeP.Tooltip

local States = {
	charm = 		{'^charmed'},
	disarm = 		{'disarmed'},
	disorient = 	{'^disoriented'},
	dot = 			{'damage every.*sec', 'damage per.*sec'},
	fear = 			{'^horrified', '^fleeing', '^feared', '^intimidated', '^cowering in fear', '^running in fear', '^compelled to flee'},
	incapacitate = 	{'^incapacitated', '^sapped'},
	misc = 			{'unable to act', '^bound', '^frozen.$', '^cannot attack or cast spells', '^shackled.$'},
	root = 			{'^rooted', '^immobil', '^webbed', 'frozen in place', '^paralyzed', '^locked in place', '^pinned in place'},
	stun = 			{'^stunned', '^webbed'},
	silence = 		{'^silenced'},
	sleep = 		{'^asleep'},
	snare = 		{'^movement.*slowed', 'movement speed reduced', '^slowed by', '^dazed', '^reduces movement speed'}
}

local Immune = {
	all = 			{'dematerialize', 'deterrence', 'divine shield', 'ice block'},
	charm = 		{'bladestorm', 'desecrated ground', 'grounding totem effect', 'lichborne'},
	disorient = 	{'bladestorm', 'desecrated ground'},
	fear = 			{'berserker rage', 'bladestorm', 'desecrated ground', 'grounding totem','lichborne', 'nimble brew'},
	incapacitate = 	{'bladestorm', 'desecrated ground'},
	melee = 		{'dispersion', 'evasion', 'hand of protection', 'ring of peace', 'touch of karma'},
	misc = 			{'bladestorm', 'desecrated ground'},
	silence = 		{'devotion aura', 'inner focus', 'unending resolve'},
	polly = 		{'immune to polymorph'},
	sleep = 		{'bladestorm', 'desecrated ground', 'lichborne'},
	snare = 		{'bestial wrath', 'bladestorm', 'death\'s advance', 'desecrated ground','dispersion', 'hand of freedom', 'master\'s call', 'windwalk totem'},
	spell = 		{'anti-magic shell', 'cloak of shadows', 'diffuse magic', 'dispersion','massspell reflection', 'ring of peace', 'spell reflection', 'touch of karma'},
	stun = 			{'bestial wrath', 'bladestorm', 'desecrated ground', 'icebound fortitude','grounding totem', 'nimble brew'}
}

NeP.DSL:Register('state.purge', function(target, spell)
	spell = GetSpellID(GetSpellName(spell))
	return LibDispellable:CanDispelWith(target, spell)
end)

NeP.DSL:Register('state', function(target, arg)
	local match = States[tostring(arg)]
	return match and tlp:Scan_Debuff(target, match)
end)

NeP.DSL:Register('immune', function(target, arg)
	local match = Immune[tostring(arg)]
	return match and tlp:Scan_Debuff(target, match)
end)
