local SealStuffs = LibStub("AceAddon-3.0"):NewAddon("SealStuffs")
local group = {}
local Masque

sealStuffsSpells = {["sealOfRighteousness"] = true,
					["sealofVengeance"] = true,
					["sealofJustice"] = true,
					["sealofLight"] = true,
					["sealofWisdom"] = true,
					["sealofCommand"] = true}

SealStuffs.seals = {["sealOfRighteousness"] = 21084,
					  ["sealofVengeance"] = 31801,
					  ["sealofJustice"] = 20164,
					  ["sealofLight"] = 20165,
					  ["sealofWisdom"] = 20166,
					  ["sealofCommand"] = 20375}

SealStuffs.icons = {["sealOfRighteousness"] = "Interface/ICONS/Ability_thunderbolt",
					["sealofVengeance"] = "Interface/ICONS/spell_holy_sealofvengeance",
					["sealofJustice"] = "Interface/ICONS/spell_holy_sealofwrath",
					["sealofLight"] = "Interface/ICONS/spell_holy_healingaura",
					["sealofWisdom"] = "Interface/ICONS/spell_holy_righteousnessaura",
					["sealofCommand"] = "Interface/ICONS/ability_warrior_innerrage"}

function SealStuffs:OnInitialize()
	_, self.class = UnitClass("player")
	self.faction = UnitFactionGroup("player")
	if self.class == "PALADIN" then
		self.frame = CreateFrame("FRAME", nil, UIParent)
		self.move = CreateFrame("FRAME", nil, self.frame, BackdropTemplateMixin and "BackdropTemplate")
		Masque = LibStub("Masque", true)
		if Masque ~= nil then
			group = Masque:Group("Seal Stuffs", "Buttons")
		end
		if not sealStuffsFrameX then
			sealStuffsFrameX = 300
		end
		if not sealStuffsFrameY then
			sealStuffsFrameY = 300
		end
		if sealStuffsVertical == nil then
			sealStuffsVertical = false
		end
		if sealStuffsScale == nil then
			sealStuffsScale = 1
		end
		self:SetupFrame(self.frame)
		self:SetupMoveFrame(self.move)
		local options = {
			name = "Seal Stuffs",
			handler = SealStuffs,
			type = "group",
			args = {
				movable = {
					name = "Set Movable",
					type = "toggle",
					desc = "makes bar movable",
					set = "SetMove",
					get = "GetMove"
				},
				layout = {
					name = "Layout",
					type = "group",
					args = {
						vertical = {
							name = "Layout",
							order = 0,
							type = "select",
							desc = "select layout type",
							values = {[true] = "Vertical", [false] = "Horizontal"},
							set = "SetLayout",
							get = "GetLayout",
							style = "radio"
						},
						scale = {
							name = "Scale",
							order = 1,
							type = "range",
							desc = "you scale whole bar up or down",
							width = "full",
							min = 0.5,
							max = 2,
							set = "SetScale",
							get = "GetScale"
						},
					}
				},
				seals = {
					name = "Seals",
					type = "group",
					args = {
						sealOfRighteousness = {
							name = "Seal of Righteousness",
							type = "toggle",
							desc = "Activates Seal of Righteousness",
							set = "Set",
							get = "Get"
						},
						sealofVengeance = {
							name = "Seal of Vengeance",
							type = "toggle",
							desc = "Activates Seal of Vengeance",
							set = "Set",
							get = "Get"
						},
						sealofJustice = {
							name = "Seal of Justice",
							type = "toggle",
							desc = "Activates Seal of Justice",
							set = "Set",
							get = "Get"
						},
						sealofLight = {
							name = "Seal of Light",
							type = "toggle",
							desc = "Activates Seal of Light",
							set = "Set",
							get = "Get"
						},
						sealofWisdom = {
							name = "Seal of Wisdom",
							type = "toggle",
							desc = "Activates Seal of Wisdom",
							set = "Set",
							get = "Get"
						},
						sealofCommand = {
							name = "Seal of Command",
							type = "toggle",
							desc = "Activates Seal of Command",
							set = "Set",
							get = "Get"
						}
					}
				}
			}
		}
		LibStub("AceConfig-3.0"):RegisterOptionsTable("SealStuffs", options, nil)
		LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SealStuffs", "Seal Stuffs")
	end
end

function SealStuffs:SetMove(info, val)
	if val then
		SealStuffs.move:Show()
	else
		SealStuffs.move:Hide()
	end
end

function SealStuffs:GetMove(info)
	return SealStuffs.move:IsShown()
end

function SealStuffs:SetLayout(info, val)
	sealStuffsVertical = val
	if sealStuffsVertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function SealStuffs:GetLayout(info)
	return sealStuffsVertical
end

function SealStuffs:SetScale(info, val)
	sealStuffsScale = val;
	self.frame:SetScale(0.8 * sealStuffsScale)
end

function SealStuffs:GetScale(info)
	return sealStuffsScale
end

function SealStuffs:Set(info, val)
	sealStuffsSpells[info[#info]] = val
	if sealStuffsVertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
	if Masque ~= nil then
		self:RemoveMasqueButtons()
		self:AddMasqueButtons()
		group:ReSkin()
	end
end

function SealStuffs:Get(info)
	return sealStuffsSpells[info[#info]]
end

function SealStuffs:AddMasqueButtons()
	if sealStuffsSpells["sealOfRighteousness"] then
		group:AddButton(self.button1)
	end
	if sealStuffsSpells["sealofJustice"] then
		group:AddButton(self.button2)
	end
	if sealStuffsSpells["sealofVengeance"] then
		group:AddButton(self.button3)
	end
	if sealStuffsSpells["sealofLight"] then
		group:AddButton(self.button4)
	end
	if sealStuffsSpells["sealofWisdom"] then
		group:AddButton(self.button5)
	end
	if sealStuffsSpells["sealofCommand"] then
		group:AddButton(self.button6)
	end
end

function SealStuffs:RemoveMasqueButtons()
	group:RemoveButton(self.button1)
	group:RemoveButton(self.button2)
	group:RemoveButton(self.button3)
	group:RemoveButton(self.button4)
	group:RemoveButton(self.button5)
	group:RemoveButton(self.button6)
end

function SealStuffs.frameOnEvent(self, event, spell)
	if event == "PLAYER_LOGIN" then
		self:SetHeight(40)
		SealStuffs.move:SetHeight(40);
		if sealStuffsVertical then
			SealStuffs:SetupButtonsVertical(self, SealStuffs.move)
		else
			SealStuffs:SetupButtonsHorizontal(self, SealStuffs.move)
		end
		if Masque ~= nil then
			SealStuffs:AddMasqueButtons()
			group:ReSkin()
		end
		self:UnregisterEvent("PLAYER_LOGIN")
	elseif event == "LEARNED_SPELL_IN_TAB" and SealStuffs:NewSpell(spell) then
		self:SetHeight(40)
		SealStuffs.move:SetHeight(40);
		if sealStuffsVertical then
			SealStuffs:SetupButtonsVertical(self, SealStuffs.move)
		else
			SealStuffs:SetupButtonsHorizontal(self, SealStuffs.move)
		end
		if Masque ~= nil then
			SealStuffs:RemoveMasqueButtons()
			SealStuffs:AddMasqueButtons()
			group:ReSkin()
		end
	end
end

function SealStuffs.frameOnDragStart(self)
	SealStuffs.frame:StartMoving()
end

function SealStuffs.frameOnDragStop(self)
	SealStuffs.frame:StopMovingOrSizing()
	sealStuffsFrameX = SealStuffs.frame:GetLeft()
	sealStuffsFrameY = SealStuffs.frame:GetBottom()
end

function SealStuffs:NewSpell(id)
	if self:SpellOnList(id) then
		for i = 121,135,1 do
			_, spell = GetActionInfo(i)
			if spell == id then
				return false
			end
		end
		return true
	end
	return false
end

function SealStuffs:SpellOnList(id)
	local name = GetSpellInfo(id)
	for k, v in pairs(self.seals) do
		if name == v then 
			return true
		end
	end
	return false
end

function SealStuffs:SetupFrame(frame)
	frame:SetMovable(true)
	frame:SetPoint("BOTTOMLEFT", sealStuffsFrameX, sealStuffsFrameY)
	frame:SetScale(0.8 * sealStuffsScale)
	frame:SetFrameStrata("LOW")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
	frame:RegisterEvent("BAG_UPDATE")
	frame:SetScript("OnEvent", SealStuffs.frameOnEvent)
	frame.seals = frame:CreateFontString(nil, "HIGH", "GameFontWhite")
	frame.seals:SetTextColor(0, 1, 0)
end

function SealStuffs:SetupMoveFrame(frame)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetClampedToScreen(true)
	frame:SetPoint("BOTTOMLEFT", 0, 0)
	frame:SetFrameStrata("HIGH")
	local backdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = false,
		tileSize = 0,
	}
	frame:SetBackdrop(backdrop)
	frame:SetBackdropColor(0, 0.75, 0.25, 0.75)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", SealStuffs.frameOnDragStart)
	frame:SetScript("OnDragStop", SealStuffs.frameOnDragStop)
	frame:Hide()
end

function SealStuffs:SetupButtonsVertical(frame, move)
	self:ClearButtons()
	local length = 0
	if sealStuffsSpells["sealOfRighteousness"] then
		self.button1, length = self:SetupButtonVertical("sealStuffsButton1", self.button1, length, "sealOfRighteousness", 121, frame, SealStuffs.icons["sealOfRighteousness"])
	end
	if sealStuffsSpells["sealofJustice"] then
		self.button2, length = self:SetupButtonVertical("sealStuffsButton2", self.button2, length, "sealofJustice", 122, frame, SealStuffs.icons["sealofJustice"])
	end
	if sealStuffsSpells["sealofVengeance"] then
		self.button3, length = self:SetupButtonVertical("sealStuffsButton3", self.button3, length, "sealofVengeance", 123, frame, SealStuffs.icons["sealofVengeance"])
	end
	if sealStuffsSpells["sealofLight"] then
		self.button4, length = self:SetupButtonVertical("sealStuffsButton4", self.button4, length, "sealofLight", 124, frame, SealStuffs.icons["sealofLight"])
	end
	if sealStuffsSpells["sealofWisdom"] then
		self.button5, length = self:SetupButtonVertical("sealStuffsButton5", self.button5, length, "sealofWisdom", 125, frame, SealStuffs.icons["sealofWisdom"])
	end
	if sealStuffsSpells["sealofCommand"] then
		self.button6, length = self:SetupButtonVertical("sealStuffsButton6", self.button6, length, "sealofCommand", 126, frame, SealStuffs.icons["sealofCommand"])
	end
	frame:SetWidth(40)
	move:SetWidth(40)
	frame:SetHeight(-length)
	move:SetHeight(-length)
	frame.seals:ClearAllPoints()
	collectgarbage("collect")
end

function SealStuffs:SetupButtonsHorizontal(frame, move)
	self:ClearButtons()
	local length = 0
	if sealStuffsSpells["sealOfRighteousness"] then
		self.button1, length = self:SetupButtonHorizontal("sealStuffsButton1", self.button1, length, "sealOfRighteousness", 121, frame, SealStuffs.icons["sealOfRighteousness"])
	end
	if sealStuffsSpells["sealofJustice"] then
		self.button2, length = self:SetupButtonHorizontal("sealStuffsButton2", self.button2, length, "sealofJustice", 122, frame, SealStuffs.icons["sealofJustice"])
	end
	if sealStuffsSpells["sealofVengeance"] then
		self.button1, length = self:SetupButtonHorizontal("sealStuffsButton3", self.button3, length, "sealofVengeance", 123, frame, SealStuffs.icons["sealofVengeance"])
	end
	if sealStuffsSpells["sealofLight"] then
		self.button2, length = self:SetupButtonHorizontal("sealStuffsButton4", self.button4, length, "sealofLight", 124, frame, SealStuffs.icons["sealofLight"])
	end
	if sealStuffsSpells["sealofWisdom"] then
		self.button3, length = self:SetupButtonHorizontal("sealStuffsButton5", self.button5, length, "sealofWisdom", 125, frame, SealStuffs.icons["sealofWisdom"])
	end
	if sealStuffsSpells["sealofCommand"] then
		self.button3, length = self:SetupButtonHorizontal("sealStuffsButton6", self.button6, length, "sealofCommand", 126, frame, SealStuffs.icons["sealofCommand"])
	end
	frame:SetWidth(length)
	move:SetWidth(length)
	frame:SetHeight(40)
	move:SetHeight(40)
	frame.seals:ClearAllPoints()
	collectgarbage("collect")
end

function SealStuffs.buttonOnUpdate(self)
	if Masque ~= nil then
		group:ReSkin()
	end
end

function SealStuffs:SetupButtonVertical(name, button, y, index, id, frame, icon)
	if button == nil then
		button = CreateFrame("CHECKBUTTON", name, frame, BackdropTemplateMixin and "BackdropTemplate, SecureActionButtonTemplate, ActionBarButtonTemplate")
	end
	button:Show()
	button:SetWidth(38)
	button:SetHeight(38)
	button:SetPoint("TOPLEFT", 0, y)
	button:SetFrameStrata("MEDIUM")
	button:SetAttribute("showgrid", 1)
	button:SetAttribute("action", id)
	button:SetAttribute("type", "spell")
	button:SetAttribute("spell1", self.seals[index])
	button:SetScript("OnUpdate", self.buttonOnUpdate)
	button:SetScript("OnEnter", function(self) 
					 GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
					 GameTooltip:AddSpellByID(self:GetAttribute("spell1"))
					 GameTooltip:AddLine("\n")
					end)
	button:SetScript("OnLeave", function(self) 
					 GameTooltip:Hide()
					end)
	button:SetBackdrop({bgFile = icon,
					   tile = false,
					   insets = {left = 0,
								 right = 0,
								 top = 0,
								 bottom = 0}})
	return button, y - 40
end

function SealStuffs:SetupButtonHorizontal(name, button, x, index, id, frame, icon)
	if button == nil then
		button = CreateFrame("CHECKBUTTON", name, frame, BackdropTemplateMixin and "BackdropTemplate, SecureActionButtonTemplate, ActionBarButtonTemplate")
	end
	button:Show()
	button:SetWidth(38)
	button:SetHeight(38)
	button:SetPoint("TOPLEFT", x, 0)
	button:SetFrameStrata("MEDIUM")
	button:SetAttribute("showgrid", 1)
	button:SetAttribute("action", id)
	button:SetAttribute("type", "spell")
	button:SetAttribute("spell1", self.seals[index])
	button:SetScript("OnEnter", function(self) 
					 GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
					 GameTooltip:AddSpellByID(self:GetAttribute("spell1"))
					 GameTooltip:AddLine("\n")
					end)
	button:SetScript("OnLeave", function(self) 
					 GameTooltip:Hide()
					end)
	button:SetBackdrop({bgFile = icon,
					   tile = false,
					   insets = {left = 0,
								 right = 0,
								 top = 0,
								 bottom = 0}})
	return button, x + 40
end

function SealStuffs:ClearButtons()
	self:ClearButton(self.button1, 121)
	self:ClearButton(self.button2, 122)
	self:ClearButton(self.button3, 123)
	self:ClearButton(self.button4, 124)
	self:ClearButton(self.button5, 125)
	self:ClearButton(self.button6, 126)
end

function SealStuffs:ClearButton(button, id)
	if button ~= nil then
		button:Hide()
		button:SetAttribute("showgrid", 0)
		button:SetAttribute("action", id)
		button:SetAttribute("type", "spell")
	end
end