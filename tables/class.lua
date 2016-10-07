local _, NeP = ...

NeP.ClassTable = {
	{ -- Warrior
		hex = 'c79c6e',
		rgb = {0.78,0.61,0.43},
		[71] = {
			range = 'melee',
			name = 'Arms',
			role = 'DPS'
		},
		[72] = {
			range = 'melee',
			name = 'Fury',
			role = 'DPS'
		},
		[73] = {
			range = 'melee',
			name = 'Protection',
			role = 'TANK'
		}
	},
	{  -- Paladin
		hex = 'f58cba',
		rgb = {0.96,0.55,0.73},
		[65] = {
			range = 'melee',
			name = 'Holy',
			role = 'HEALER'
		},
		[66] = {
			range = 'melee',
			name = 'Protection',
			role = 'TANK'
		},
		[70] = {
			range = 'melee',
			name = 'Retribution',
			role = 'DPS'
		}
	},
	{ -- Hunter
		hex = 'abd473',
		rgb = {0.67,0.83,0.45},
		[253] = {
			range = 'melee',
			name = 'Beast Mastery',
			role = 'DPS'
		},
		[254] = {
			range = 'melee',
			name = 'Marksmanship',
			role = 'DPS'
		},
		[255] = {
			range = 'melee',
			name = 'Survival',
			role = 'DPS'
		}
	},
	{ -- Rogue
		hex = 'fff569',
		rgb = {1,0.96,0.41},
		[259] = {
			range = 'melee',
			name = 'Assassination',
			role = 'DPS'
		},
		[260] = {
			range = 'melee',
			name = 'Outlaw',
			role = 'DPS'
		},
		[261] = {
			range = 'melee',
			name = 'Subtlety',
			role = 'DPS'
		}
	},
	{  -- Priest
		hex = 'ffffff',
		rgb = {1,1,1},
		[256] = {
			range = 'Ranged',
			name = 'Discipline',
			role = 'HEALER'
		},
		[257] = {
			range = 'Ranged',
			name = 'Holy',
			role = 'HEALER'
		},
		[258] = {
			range = 'Ranged',
			name = 'Shadow',
			role = 'HEALER'
		}
	},
	{ -- DeathKnight
		hex = 'c41f3b',
		rgb = {0.77,0.12,0.23},
		[250] = {
			range = 'melee',
			name = 'Blood',
			role = 'TANK'
		},
		[251] = {
			range = 'melee',
			name = 'Frost',
			role = 'DPS'
		},
		[252] = {
			range = 'melee',
			name = 'Unholy',
			role = 'DPS'
		}
	},
	{  -- Shaman
		hex = '0070de',
		rgb = {0,0.44,0.87},
		[262] = {
			range = 'Ranged',
			name = 'Elemental',
			role = 'DPS'
		},
		[263] = {
			range = 'melee',
			name = 'Enhancement',
			role = 'DPS'
		},
		[264] = {
			range = 'Ranged',
			name = 'Restoration',
			role = 'HEALER'
		}
	},
	{  -- Mage
		hex = '69ccf0',
		rgb = {0.41,0.8,0.94},
		[62] = {
			range = 'Ranged',
			name = 'Arcane',
			role = 'DPS'
		},
		[63] = {
			range = 'Ranged',
			name = 'Fire',
			role = 'DPS'
		},
		[64] = {
			range = 'Ranged',
			name = 'Frost',
			role = 'DPS'
		}
	},
	{ -- Warlock
		hex = '9482c9',
		rgb = {0.58,0.51,0.79},
		[265] = {
			range = 'Ranged',
			name = 'Affliction',
			role = 'DPS'
		},
		[266] = {
			range = 'Ranged',
			name = 'Demonology',
			role = 'DPS'
		},
		[267] = {
			range = 'Ranged',
			name = 'Destruction',
			role = 'DPS'
		}
	},
	{ -- Monk
		hex = '00ff96',
		rgb = {r = 0,1,0.59},
		[268] = {
			range = 'melee',
			name = 'Brewmaster',
			role = 'TANK'
		},
		[269] = {
			range = 'melee',
			name = 'Windwalker',
			role = 'DPS'
		},
		[270] = {
			range = 'Ranged',
			name = 'Mistweaver',
			role = 'HEALER'
		}
	},
	{ -- Druid
		hex = 'ff7d0a',
		rgb = {1,0.49,0.04},
		[102] = {
			range = 'Ranged',
			name = 'Balance',
			role = 'DPS'
		},
		[103] = {
			range = 'melee',
			name = 'Feral Combat',
			role = 'DPS'
		},
		[104] = {
			range = 'melee',
			name = 'Guardian',
			role = 'TANK'
		},
		[105] = {
			range = 'Ranged',
			name = 'Restoration',
			role = 'HEALER'
		}
	},
	{ -- Demon Hunter
		hex = 'A330C9',
		rgb = {0.64,0.19,0.79},
		[577] = {
			range = 'melee',
			name = 'Havoc',
			role = 'DPS'
		},
		[581] = {
			range = 'melee',
			name = 'Vengeance',
			role = 'TANK'
		}
	}
}