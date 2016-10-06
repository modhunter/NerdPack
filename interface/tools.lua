local _, NeP = ...
NeP.Interface = {}
NeP.Globals.Interface = {}

function NeP.Interface:AddBorder(parent)
	parent.border = parent:CreateTexture(nil,"BACKGROUND")
	parent.border:SetColorTexture(0,0,0,1)
	parent.border:SetPoint("TOPLEFT",-2,2)
	parent.border:SetPoint("BOTTOMRIGHT",2,-2)
	parent.border:SetVertexColor(0.85,0.85,0.85,1) -- half-alpha light grey
	parent.body = parent:CreateTexture(nil,"ARTWORK")
	parent.body:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	parent.body:SetAllPoints(parent)
	parent.body:SetVertexColor(0.1,0.1,0.1,1) -- solid dark grey
end

function NeP.Interface:NewFrame(key, parent, loc, size)
	local temp = CreateFrame("Frame", key, parent)
	temp:SetPoint(unpack(loc))
	temp:SetSize(unpack(size))
	temp:SetMovable(true)
	temp:SetFrameLevel(0)
	temp:SetClampedToScreen(true)
	return temp
end

function NeP.Interface:AddContent(parent)
	local size = {parent:GetWidth(), parent:GetHeight()-20}
	parent.content = self:NewFrame(nil, parent, {'TOP',0,-22}, size)
	local temp = parent.title
	temp:SetFrameLevel(1)
end

function NeP.Interface:AddText(parent, text, loc)
	local temp = parent:CreateFontString()
	temp:SetFont("Fonts\\FRIZQT__.TTF", 16)
	temp:SetShadowColor(0,0,0, 0.8)
	temp:SetShadowOffset(-1,-1)
	temp:SetPoint(loc or "CENTER", parent)
	temp:SetText(text)
end

function NeP.Interface:Tittlebar(parent, text)
	local size = {parent:GetWidth(), 20}
	parent.title = self:NewFrame(nil, parent, {'TOP'}, size)
	local temp = parent.title
	self:AddBorder(temp)
	temp:SetFrameLevel(1)
	temp.text = self:AddText(temp, text)
	temp:EnableMouse(true)
	temp:RegisterForDrag('LeftButton', 'RightButton')
	temp:SetScript('OnDragStart', function() parent:StartMoving() end)
	temp:SetScript('OnDragStop', function() parent:StopMovingOrSizing() end)
end

function NeP.Interface:BuildGUI(eval)
	local title = eval.title or '???'
	local size = eval.size or {200,200}
	local loc = eval.loc or {'CENTER'}
	local temp = self:NewFrame(title, UIParent, loc, size)
	self:AddBorder(temp)
	self:Tittlebar(temp, title)
	self:AddContent(temp)
	-- Resize with the frame (there has to be a better way for this...)
	temp:SetScript("OnUpdate", function(self)
		self.title:SetSize(temp:GetWidth(), 20)
		self.content:SetSize(temp:GetWidth(), temp:GetHeight()-temp.title:GetHeight())
	end)
	return temp
end

-- Gobals
NeP.Globals.Interface.BuildGUI = NeP.Interface.BuildGUI