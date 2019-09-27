--[[local function checkAdmin(ply)
	local canAdmin = hook.Run("TextscreensCanAdmin", ply) -- run custom hook function to check admin
	if canAdmin == nil then -- if hook hasn't returned anything, default to super admin check
		canAdmin = ply:IsSuperAdmin()
	end
	return canAdmin
end--]]
-- Localization
local hook_Add = hook.Add
local hook_Remove = hook.Remove
local debugprint = print
if AllowDebug == true then
		debugprint = print
		debugprint("AllowDebug is set to true so 3D2D Textscreen debug messages will be printed in console.")
	else
		debugprint = nil
	print("AllowDebug is set to false so 3D2D Textscreen debug messages will not be printed.")
end
-- Server Shit
if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("textscreens_config.lua")
	AddCSLuaFile("textscreens_fontconfig.lua")
	include("textscreens_config.lua")
	include("textscreens_fontconfig.lua")
	CreateConVar("sbox_maxtextscreens", TextscreensLimit, {FCVAR_NOTIFY, FCVAR_REPLICATED})
	local version = "2.0"
	local function GetOS()
		if system.IsLinux() then return "linux" end
		if system.IsWindows() then return "windows" end
		if system.IsOSX() then return "osx" end
		return "unknown"
	end

	local function submitAnalytics()
		--if GetConVar("ss_call_to_home"):GetInt() ~= 1 or submitted then return end
		if AllowAnalytics == true then -- && submitted == false
		-- Debug
		debugprint("Allow Analytics Passed")
		submitted = true
		http.Post("https://jross.me/textscreens/analytics.php", {
			["operating_system"] = GetOS(),
			["server_dedicated"] = game.IsDedicated() && "true" or "false",
			["server_name"] = GetHostName(),
			["server_ip"] = util.CRC(game.GetIPAddress()),
			["version"] = version
		})
		else
		debugprint("Allow Analytics Failed")
		end
	end
	-- Set AllowAnalytics to true to opt-in to anonymous stat tracking
	hook_Add("Initialize", "CallToHomeSS", function()
		timer.Simple(15, function()
			if AllowAnalytics == true then
			submitAnalytics()
				-- Debug
				debugprint("Analytics Sent")
			end
		end)
	end)
	timer.Create( "RemoveCallToHomeSSHook", 30, 1, function()
	hook_Remove("Initialize", "CallToHomeSS")
		print("Succefully removed Call To Home Hook(Analytics)")
	end)

	local function StringRandom(int)
		math.randomseed(os.time())
		local s = ""

		for i = 1, int do
			s = s .. string.char(math.random(65, 90))
		end

		return s
	end

	local textscreens = {}

	local function SpawnPermaTextscreens()
		if UsePermaTextscreens == true then
		print("[3D2D Textscreens] Spawning textscreens...")
		textscreens = file.Read("sammyservers_textscreens.txt", "DATA")
		if not textscreens or textscreens == "" then
			textscreens = {}
			print("[3D2D Textscreens] Spawned 0 textscreens for map " .. game.GetMap())
			return
		end
		textscreens = util.JSONToTable(textscreens)

		local existingTextscreens = {}
		for k,v in pairs(ents.FindByClass("sammyservers_textscreen")) do
			if not v.uniqueName then continue end
			existingTextscreens[v.uniqueName] = true
		end

		local count = 0
		for k, v in pairs(textscreens) do
			if v.MapName ~= game.GetMap() then continue end
			if existingTextscreens[v.uniqueName] then continue end

			local textScreen = ents.Create("sammyservers_textscreen")
			textScreen:SetPos(Vector(v.posx, v.posy, v.posz))
			textScreen:SetAngles(Angle(v.angp, v.angy, v.angr))
			textScreen.uniqueName = v.uniqueName
			textScreen:Spawn()
			textScreen:Activate()
			textScreen:SetMoveType(MOVETYPE_NONE)

			for lineNum, lineData in pairs(v.lines or {}) do
				textScreen:SetLine(lineNum, lineData.text, Color(lineData.color.r, lineData.color.g, lineData.color.b, lineData.color.a), lineData.size, lineData.font)
			end

			textScreen:SetIsPersisted(true)
			count = count + 1
		end

		print("[3D2D Textscreens] Spawned " .. count .. " textscreens for map " .. game.GetMap())
		else
			debugprint("UsePermaTextscreens is set to false so permanent textscreens will not be spawned.")
		end
	end

	hook_Add("InitPostEntity", "loadTextScreens", function()
		timer.Simple(10, SpawnPermaTextscreens)
	end)
	hook_Remove("InitPostEntity", "loadTextScreens")
	-- debugprint("Load textscreens hook succefull removed.")
	hook_Add("PostCleanupMap", "loadTextScreens", SpawnPermaTextscreens)

	concommand.Add("SS_TextScreen", function(ply, cmd, args)
		--[[if not serverguard.player:GetRank(ply) == ServerguardGroups or not args or not args[1] or not args[2] or not (args[1] == "delete" or args[1] == "add") then
			ply:ChatPrint("not authorised, or bad arguments")
			return
		end--]]
		local ent = Entity(args[2])
		if not IsValid(ent) or ent:GetClass() ~= "sammyservers_textscreen" then return false end

		if args[1] == "add" then
			local pos = ent:GetPos()
			local ang = ent:GetAngles()
			local toAdd = {}
			toAdd.posx = pos.x
			toAdd.posy = pos.y
			toAdd.posz = pos.z
			toAdd.angp = ang.p
			toAdd.angy = ang.y
			toAdd.angr = ang.r
			-- So we can reference it easilly later because EntIndexes are so unreliable
			toAdd.uniqueName = StringRandom(10)
			toAdd.MapName = game.GetMap()
			toAdd.lines = ent.lines
			table.insert(textscreens, toAdd)
			file.Write("sammyservers_textscreens.txt", util.TableToJSON(textscreens))
			ent:SetIsPersisted(true)

			return ply:ChatPrint("Textscreen made permanent and saved.")
		else
			for k, v in pairs(textscreens) do
				if v.uniqueName == ent.uniqueName then
					textscreens[k] = nil
				end
			end

			ent:Remove()
			file.Write("sammyservers_textscreens.txt", util.TableToJSON(textscreens))

			return ply:ChatPrint("Textscreen removed and is no longer permanent.")
		end
	end)
end

if CLIENT then
	include("textscreens_config.lua")

	properties.Add("addPermaScreen", {
		MenuLabel = "Make perma textscreen",
		Order = 2001,
		MenuIcon = "icon16/transmit.png",
		Filter = function(self, ent, ply)
			if not IsValid(ent) or ent:GetClass() ~= "sammyservers_textscreen" then return false end
			if ent:GetIsPersisted() then return false end

			return checkAdmin(ply)
		end,
		Action = function(self, ent)
			if not IsValid(ent) then return false end

			return RunConsoleCommand("SS_TextScreen", "add", ent:EntIndex())
		end
	})

	properties.Add("removePermaScreen", {
		MenuLabel = "Remove perma textscreen",
		Order = 2002,
		MenuIcon = "icon16/transmit_delete.png",
		Filter = function(self, ent, ply)
			if not IsValid(ent) or ent:GetClass() ~= "sammyservers_textscreen" then return false end
			if not ent:GetIsPersisted() then return false end

			return checkAdmin(ply)
		end,
		Action = function(self, ent)
			if not IsValid(ent) then return end

			return RunConsoleCommand("SS_TextScreen", "delete", ent:EntIndex())
		end
	})
end
