local inCombat = {
	{'Mend Pet', 'pet.health < 100'},
	{'Kill Command', 'target.petrange < 25'},
	{'Cobra Shot'}
}

local outCombat = {
	
}

NeP.CR:Add(3, '[NeP] Hunter - Basic', inCombat, outCombat)