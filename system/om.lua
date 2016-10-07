local _, NeP = ...

NeP.OM = {}

local OM_c = {
	Enemies = {},
	Friendly = {},
	Dead = {},
	Objects = {}
}

function NeP.OM:Garbage()
	for tb in pairs(OM_c) do
		for _, obj in pairs(OM_c[tb]) do
			if not UnitExists(obj.key) then
				obj = nil
			end
		end 
	end
end

function NeP.OM:Get(ref)
	return OM_c[ref]
end

function NeP.OM:Filter(ref, GUID)
	if not OM_c[ref][GUID] then return end
	local key = OM_c[ref][GUID].key
	local distance = NeP.Protected:Distance('player', Obj)
	OM_c[ref][GUID].distance = distance
	return true
end

function NeP.OM:Insert(ref, Obj)
	-- Filter units
	if self:Filter(ref, Obj) then return end
	-- Add it
	local GUID = UnitGUID(Obj) or '0'
	local ObjID = select(6, strsplit('-', GUID))
	local distance = NeP.Protected:Distance('player', Obj)
	OM_c[ref][GUID] = {
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
		NeP.OM:Insert('Enemies', Obj)
	-- Friendly
	elseif UnitIsFriend('player', Obj) then
		NeP.OM:Insert('Friendly', Obj)
	-- Enemie
	elseif UnitCanAttack('player', Obj) then
		NeP.OM:Insert('Dead', Obj)
	-- Object
	elseif ObjectWithIndex and ObjectIsType(Obj, ObjectTypes.GameObject) then
		NeP.OM:Insert('Objects', Obj)
	end
end

C_Timer.NewTicker(0.1, (function()
	NeP.OM:Garbage()
end), nil)

-- Gobals
NeP.Globals.OM = {
	Add = NeP.OM.Add,
	Get = NeP.OM.Get,
	test = NeP.OM.Garbage
}