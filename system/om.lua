local _, NeP = ...

NeP.OM = {}

local OM = {
	Enemies = {},
	Friendly = {},
	Dead = {},
	Objects = {}
}

function NeP.OM:Get(ref)
	return OM[ref]
end

function NeP.OM:Filter(ref, GUID)
	if not OM[ref][GUID] then return end
	local key = OM[ref][GUID].key
	local distance = NeP.Protected:Distance('player', Obj)
	OM[ref][GUID].distance = distance
	return true
end

function NeP.OM:Insert(ref, Obj)
	-- Filter units
	if self:Filter(ref, Obj) then return end
	-- Add it
	local GUID = UnitGUID(Obj) or '0'
	local objectType, _, _, _, _, ObjID, _ = strsplit('-', GUID)
	local distance = NeP.Protected:Distance('player', Obj)
	OM[ref][GUID] = {
		key = Obj,
		name = UnitName(Obj),
		distance = distance,
		id = tonumber(ObjID) or '0',
		guid = GUID,
	}
end

function NeP.OM:Add(Obj)
	-- Dead Units
	if UnitIsDeadOrGhost(Obj) then
		self:Insert('Enemies', Obj)
	-- Friendly
	elseif UnitIsFriend('player', Obj) then
		self:Insert('Friendly', Obj)
	-- Enemie
	elseif UnitCanAttack('player', Obj) then
		self:Insert('Dead', Obj)
	-- Object
	elseif ObjectWithIndex and ObjectIsType(Obj, ObjectTypes.GameObject) then
		self:Insert('Objects', Obj)
	end
end

C_Timer.NewTicker(0.1, (function()
	
end), nil)

-- Gobals
NeP.Globals.OM = {
	Add = NeP.OM.Add,
	Get = NeP.OM.Get
}