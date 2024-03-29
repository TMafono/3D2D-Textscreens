TOOL.Category = "Construction"
TOOL.Name = "#tool.textscreen.name"
TOOL.Command = nil
TOOL.ConfigName = "textscreens_config.lua"
local textBox = {}
local lineLabels = {}
local labels = {}
local sliders = {}

for i = 1, 5 do
	TOOL.ClientConVar["text" .. i] = ""
	TOOL.ClientConVar["size" .. i] = TextMinSize
	TOOL.ClientConVar["r" .. i] = 255
	TOOL.ClientConVar["g" .. i] = 255
	TOOL.ClientConVar["b" .. i] = 255
	TOOL.ClientConVar["a" .. i] = 255
	TOOL.ClientConVar["font" .. i] = 1
end

include("textscreens_fontconfig.lua")
cleanup.Register("threedtwodtextScreen") --  textscreens

if (CLIENT) then
	TOOL.Information = {
		{ name = "left" },
		{ name = "right" },
		{ name = "reload" },
	}

	language.Add("tool.textscreen.name", "3D2D Textscreen")
	language.Add("#player.textscreen.name", "Player Name Customization")
	language.Add("#player.textscreen.desc", "This is where you can customize your name displayed on your textscreen.")
	language.Add("tool.textscreen.desc", "Create a textscreen with multiple lines, font colours and sizes.")
	language.Add("tool.textscreen.left", "Spawn a textscreen.") -- Does not work with capital T in tool. Same with right and reload.
	language.Add("tool.textscreen.right", "Update textscreen with settings.")
	language.Add("tool.textscreen.reload", "Copy textscreen.")
	language.Add("Undone.textscreens", "Removed textscreen")
	language.Add("Undone_textscreens", "Removed textscreen")
	language.Add("Cleanup.textscreens", "Textscreens")
	language.Add("Cleanup_textscreens", "Textscreens")
	language.Add("Cleaned.textscreens", "Cleaned up all 3D2D Textscreen.")
	language.Add("Cleaned_textscreens", "Cleaned up all 3D2D Textscreen.")
	language.Add("SBoxLimit.textscreens", "You've hit the textscreen limit!")
	language.Add("SBoxLimit_textscreens", "You've hit the textscreen limit!")
end

function TOOL:LeftClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end
	local ply = self:GetOwner() or self:LocalPlayer()
	if UsingMotherfuckingServerguard == true then
		local textMax = MaxTextScreenLimit[serverguard.player:GetRank(ply)] or FailsafeMaxTextscreens
		if table.Count(ents.FindByClass( "sammyservers_textscreen" )) >= textMax or table.Count(ents.FindByClass( "sammyservers_textscreen" )) >= TextscreensLimit then return false end
		else
		local textMax = MaxTextScreenLimit[self:GetOwner():GetUserGroup()] or FailsafeMaxTextscreens
		if table.Count(ents.FindByClass( "sammyservers_textscreen" )) >= textMax or table.Count(ents.FindByClass( "sammyservers_textscreen" )) >= TextscreensLimit then return false end
	end
	local hasText = false
	for i = 1, 7 do
		local text = self:GetClientInfo("text" .. i) or ""
		if text ~= "" then
			hasText = true
		end
	end
	if not hasText then return false end
	local threedtwodtextScreen = ents.Create("sammyservers_textscreen")
	threedtwodtextScreen:SetPos(tr.HitPos)
	local angle = tr.HitNormal:Angle()
	angle:RotateAroundAxis(tr.HitNormal:Angle():Right(), -90)
	angle:RotateAroundAxis(tr.HitNormal:Angle():Forward(), 90)
	threedtwodtextScreen:SetAngles(angle)
	threedtwodtextScreen:Spawn()
	threedtwodtextScreen:Activate()

	undo.Create("3D2D Textscreen")
	undo.AddEntity(threedtwodtextScreen)
	undo.SetPlayer(ply)
	undo.Finish()
	ply:AddCount("3D2D Textscreen", threedtwodtextScreen)
	ply:AddCleanup("3D2D Textscreen", threedtwodtextScreen)
	for i = 1, 7 do
		threedtwodtextScreen:SetLine(
			i, -- Line
			self:GetClientInfo("text" .. i) or "", -- text
			Color( -- Color
				tonumber(self:GetClientInfo("r" .. i)) or 255,
				tonumber(self:GetClientInfo("g" .. i)) or 255,
				tonumber(self:GetClientInfo("b" .. i)) or 255,
				tonumber(self:GetClientInfo("a" .. i)) or 255
			),
			tonumber(self:GetClientInfo("size" .. i)) or TextMinSize,
			-- font
			tonumber(self:GetClientInfo("font" .. i)) or 1
		)
		if DisplayNames == true and DisplaySteamID == false then
		threedtwodtextScreen:SetLine(
			6, -- Line
			self:GetOwner():Name() or "Jane Doe",
			PlayerNameColor or 255,
			PlayerNameSize or TextMinSize,
			-- font
			1)
		elseif DisplayNames == true and DisplaySteamID == true then
			threedtwodtextScreen:SetLine(
			6, -- Line
			self:GetOwner():Name() .. " - " .. ply:SteamID() or "Jane Doe",
			PlayerNameColor or 255,
			PlayerNameSize or TextMinSize,
			-- font
			1)
		elseif DisplayNames == false and DisplaySteamID == true then
			threedtwodtextScreen:SetLine(
			6, -- Line
			ply:SteamID() or "Jane Doe",
			PlayerNameColor or 255,
			PlayerNameSize or TextMinSize,
			-- font
			1)
		end
		if EnableAdvertising == true then
			threedtwodtextScreen:SetLine(
				7, -- Line
				Advertisement,
				AdvertisementTextColor or 255,
				AdvertisementTextSize or TextMinSize,
				-- font
				AdvertisementFont or 1)
		end
	end
	return true
end

function TOOL:RightClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end
	local TraceEnt = tr.Entity

	if (IsValid(TraceEnt) and TraceEnt:GetClass() == "sammyservers_textscreen") then
		for i = 1, 5 do
			TraceEnt:SetLine(
				i, -- Line
				tostring(self:GetClientInfo("text" .. i)), -- text
				Color( -- Color
					tonumber(self:GetClientInfo("r" .. i)) or 255,
					tonumber(self:GetClientInfo("g" .. i)) or 255,
					tonumber(self:GetClientInfo("b" .. i)) or 255,
					tonumber(self:GetClientInfo("a" .. i)) or 255
				),
				tonumber(self:GetClientInfo("size" .. i)) or TextMinSize,
				-- font
				tonumber(self:GetClientInfo("font" .. i)) or 1
			)
		end
		if DisplayNames == true then
		TraceEnt:SetLine(
			6, -- Line
			self:GetOwner():Name() or "Jane Doe",
			PlayerNameColor or 255,
			PlayerNameSize or TextMinSize,
			-- font
			PlayerNameFont)
		elseif DisplayNames == true and DisplaySteamID == true then
			TraceEnt:SetLine(
			6, -- Line
			self:GetOwner():Name() .. " - " .. ply:SteamID() or "Jane Doe",
			PlayerNameColor or 255,
			PlayerNameSize or TextMinSize,
			-- font
			PlayerNameFont)
		elseif DisplayNames == false and DisplaySteamID == true then
			TraceEnt:SetLine(
			6, -- Line
			ply:SteamID() or "Jane Doe",
			PlayerNameColor or 255,
			PlayerNameSize or TextMinSize,
			-- font
			PlayerNameFont)
		end
		TraceEnt:Broadcast()

		return true
	end
end

function TOOL:Reload(tr)
	local TraceEnt = tr.Entity
	if (not isentity(TraceEnt) or TraceEnt:GetClass() ~= "sammyservers_textscreen") then return false end

	for i = 1, 5 do
		local linedata = TraceEnt.lines[i]
		RunConsoleCommand("textscreen_r" .. i, linedata.color.r)
		RunConsoleCommand("textscreen_g" .. i, linedata.color.g)
		RunConsoleCommand("textscreen_b" .. i, linedata.color.b)
		RunConsoleCommand("textscreen_a" .. i, linedata.color.a)
		RunConsoleCommand("textscreen_size" .. i, linedata.size)
		RunConsoleCommand("textscreen_text" .. i, linedata.text)
		RunConsoleCommand("textscreen_font" .. i, linedata.font)
	end

	return true
end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel(CPanel)
	include("textscreens_fontconfig.lua")
	include("textscreens_config.lua")
	include("textscreens_config.lua")
	CPanel:AddControl("Header", {
		Text = "#tool.textscreen.name",
		Description = "#tool.textscreen.desc"
	})

	local function TrimFontName(fontnum)
		return string.Left(textscreenFonts[fontnum], 8) == "Screens_" and string.TrimLeft(textscreenFonts[fontnum], "Screens_") or textscreenFonts[fontnum]
	end

	local changefont
	local fontnum = textscreenFonts[GetConVar("textscreen_font1"):GetInt()] ~= nil and GetConVar("textscreen_font1"):GetInt() or 1
	local fontsize = {}

	cvars.AddChangeCallback("textscreen_font1", function(convar_name, value_old, value_new)
		fontnum = textscreenFonts[tonumber(value_new)] ~= nil and tonumber(value_new) or 1
		local font = TrimFontName(fontnum)
		changefont:SetText("Change font (" .. font .. ")")
	end)

	local function ResetFont(lines, text)
		if #lines >= 6 then
			fontnum = 1
			for i = 1, 6 do
				RunConsoleCommand("textscreen_font" .. i, 1)
			end
		end
		for k, i in pairs(lines) do
			if text then
				RunConsoleCommand("textscreen_text" .. i, "")
				labels[i]:SetText("")
			end
			labels[i]:SetFont(textscreenFonts[fontnum] .. fontsize[i])
		end
	end

	resetall = vgui.Create("DButton", resetbuttons)
	resetall:SetSize(100, 25)
	resetall:SetText("Reset all")

	resetall.DoClick = function()
		local menu = DermaMenu()

		menu:AddOption("Reset colors", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r" .. i, 255)
				RunConsoleCommand("textscreen_g" .. i, 255)
				RunConsoleCommand("textscreen_b" .. i, 255)
				RunConsoleCommand("textscreen_a" .. i, 255)
			end
		end)

		menu:AddOption("Reset sizes", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_size" .. i, TextMinSize)
				fontsize[i] = TextMinSize
				sliders[i]:SetValue(TextMinSize)
				labels[i]:SetFont(textscreenFonts[fontnum] .. fontsize[i])
			end
		end)

		menu:AddOption("Reset textboxes", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_text" .. i, "")
				textBox[i]:SetValue("")
			end
		end)

		menu:AddOption("Reset fonts", function()
			ResetFont({1, 2, 3, 4, 5}, false)
		end)

		menu:AddOption("Reset everything", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r" .. i, 255)
				RunConsoleCommand("textscreen_g" .. i, 255)
				RunConsoleCommand("textscreen_b" .. i, 255)
				RunConsoleCommand("textscreen_a" .. i, 255)
				RunConsoleCommand("textscreen_size" .. i, TextMinSize)
				sliders[i]:SetValue(math.Round(TextMinSize))
				RunConsoleCommand("textscreen_text" .. i, "")
				RunConsoleCommand("textscreen_font" .. i, 1)
				textBox[i]:SetValue("")
				fontsize[i] = TextMinSize
			end
			ResetFont({1, 2, 3, 4, 5}, true)
		end)

		menu:Open()
	end

	CPanel:AddItem(resetall)
	resetline = vgui.Create("DButton")
	resetline:SetSize(100, 25)
	resetline:SetText("Reset line")

	resetline.DoClick = function()
		local menu = DermaMenu()

		for i = 1, 5 do
			menu:AddOption("Reset line " .. i, function()
				RunConsoleCommand("textscreen_r" .. i, 255)
				RunConsoleCommand("textscreen_g" .. i, 255)
				RunConsoleCommand("textscreen_b" .. i, 255)
				RunConsoleCommand("textscreen_a" .. i, 255)
				RunConsoleCommand("textscreen_size" .. i, TextMinSize)
				sliders[i]:SetValue(TextMinSize)
				RunConsoleCommand("textscreen_text" .. i, "")
				textBox[i]:SetValue("")
				fontsize[i] = 20
				ResetFont({i}, true)
			end)
		end

		menu:AddOption("Reset all lines", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r" .. i, 255)
				RunConsoleCommand("textscreen_g" .. i, 255)
				RunConsoleCommand("textscreen_b" .. i, 255)
				RunConsoleCommand("textscreen_a" .. i, 255)
				RunConsoleCommand("textscreen_size" .. i, TextMinSize)
				sliders[i]:SetValue(TextMinSize)
				RunConsoleCommand("textscreen_text" .. i, "")
				RunConsoleCommand("textscreen_font" .. i, 1)
				textBox[i]:SetValue("")
				fontsize[i] = TextMinSize
			end
			ResetFont({1, 2, 3, 4, 5}, true)
		end)

		menu:Open()
	end

	CPanel:AddItem(resetline)

	-- Change font
	changefont = vgui.Create("DButton")
	changefont:SetSize(100, 25)
	changefont:SetText("Change font (" .. TrimFontName(fontnum) .. ")" )

	changefont.DoClick = function()
		local menu = DermaMenu()

		for i = 1, #textscreenFonts do
			local font = TrimFontName(i)
			menu:AddOption(font, function()
				fontnum = i
				for o = 1,5 do
					RunConsoleCommand("textscreen_font" .. o, i)
					labels[o]:SetFont(textscreenFonts[fontnum] .. fontsize[o])
				end
				changefont:SetText("Change font (" .. font .. ")")
			end)
		end

		menu:Open()
	end

	CPanel:AddItem(changefont)

	CPanel:AddControl("ComboBox", {
		MenuButton = 1,
		Folder = "textscreen",
		Options = {
			["#preset.default"] = ConVarsDefault
		},
		CVars = table.GetKeys(ConVarsDefault)
	})
	for i = 1, 5 do
		fontsize[i] = TextMinSize

		lineLabels[i] = CPanel:AddControl("Label", {
			Text = "Line " .. i,
			Description = "Line " .. i
		})

		lineLabels[i]:SetFont("Default")

		CPanel:AddControl("Color", {
			Label = "Line " .. i .. " font color",
			Red = "textscreen_r" .. i,
			Green = "textscreen_g" .. i,
			Blue = "textscreen_b" .. i,
			Alpha = "textscreen_a" .. i,
			ShowHSV = 1,
			ShowRGB = 1,
			Multiplier = 255
		})
		sliders[i] = vgui.Create("DNumSlider")
		sliders[i]:SetText("Font size")
		sliders[i]:SetMinMax(TextMinSize, TextMaxSize)
		sliders[i]:SetDecimals(0)
		sliders[i]:SetValue(GetConVar("textscreen_size" .. TextMinSize))
		sliders[i]:SetConVar("textscreen_size" .. i)
		sliders[i].OnValueChanged = function(panel, value)
			fontsize[i] = math.Round(tonumber(value))
			if GetConVar("textscreen_size" .. i):GetInt() < TextMinSize then
				sliders[i]:SetValue(GetConVar("textscreen_size" .. TextMinSize))
				if PrintScreenAbuse == true then
					print(LocalPlayer():Name(),"attempted to set the text size smaller then the set limits.")
				end
			elseif GetConVar("textscreen_size" .. i):GetInt() > TextMaxSize then
				sliders[i]:SetValue(GetConVar("textscreen_size" .. TextMaxSize))
				if PrintScreenAbuse == true then
					print(LocalPlayer():Name(),"attempted to set the text size bigger then the set limits.")
				end
			end
			labels[i]:SetFont(textscreenFonts[fontnum] .. fontsize[i])
			labels[i]:SetHeight(fontsize[i])
		end

		CPanel:AddItem(sliders[i])
		textBox[i] = vgui.Create("DTextEntry")
		textBox[i]:SetUpdateOnType(true)
		textBox[i]:SetEnterAllowed(true)
		textBox[i]:SetConVar("textscreen_text" .. i)
		textBox[i]:SetValue(GetConVar("textscreen_text" .. i):GetString())

		textBox[i].OnTextChanged = function()
			labels[i]:SetText(textBox[i]:GetValue())
		end

		CPanel:AddItem(textBox[i])

		labels[i] = CPanel:AddControl("Label", {
			Text = #GetConVar("textscreen_text" .. i):GetString() >= 1 and GetConVar("textscreen_text" .. i):GetString() or "Line " .. i,
			Description = "Line " .. i
		})

		labels[i]:SetFont(textscreenFonts[fontnum] .. fontsize[i])
		labels[i]:SetAutoStretchVertical(true)
		labels[i]:SetDisabled(true)

		labels[i].Think = function()
			labels[i]:SetColor(
				Color(
					GetConVar("textscreen_r" .. i):GetInt(),
					GetConVar("textscreen_g" .. i):GetInt(),
					GetConVar("textscreen_b" .. i):GetInt(),
					GetConVar("textscreen_a" .. i):GetInt()
				)
			)
		end
	end
end