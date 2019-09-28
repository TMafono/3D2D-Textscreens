textscreenFonts = {}

local function addFont(font, t)
	if CLIENT then
		for i = 1, 100 do
			t.size = i
			surface.CreateFont(font .. i, t)
		end
	end

	table.insert(textscreenFonts, font)
end

--[[
---------------------------------------------------------------------------
Custom fonts - requires server restart to take affect -- "Screens_" will be removed from the font name in spawnmenu
---------------------------------------------------------------------------
--]]

-- Default textscreens font
addFont("Coolvetica outlined", { -- Font 1
	font = "coolvetica",
	weight = 400,
	antialias = false,
	outline = true
})

addFont("Coolvetica", { -- Font 2
	font = "coolvetica",
	weight = 400,
	antialias = false,
	outline = false
})

-- Trebuchet
addFont("Screens_Trebuchet outlined", { -- Font 3
	font = "Trebuchet MS",
	weight = 400,
	antialias = false,
	outline = true
})

addFont("Screens_Trebuchet", { -- Font 4
	font = "Trebuchet MS",
	weight = 400,
	antialias = false,
	outline = false
})

-- Arial
addFont("Screens_Arial outlined", { -- Font 5
	font = "Arial",
	weight = 600,
	antialias = false,
	outline = true
})

addFont("Screens_Arial", { -- Font 6
	font = "Arial",
	weight = 600,
	antialias = false,
	outline = false
})

-- Roboto Bk
addFont("Screens_Roboto outlined", { -- Font 7
	font = "Roboto Bk",
	weight = 400,
	antialias = false,
	outline = true
})

addFont("Screens_Roboto", { -- Font 8
	font = "Roboto Bk",
	weight = 400,
	antialias = false,
	outline = false
})

-- Helvetica
addFont("Screens_Helvetica outlined", { -- Font 9
	font = "Helvetica",
	weight = 400,
	antialias = false,
	outline = true
})

addFont("Screens_Helvetica", { -- Font 10
	font = "Helvetica",
	weight = 400,
	antialias = false,
	outline = false
})

-- akbar
addFont("Screens_Akbar outlined", { -- Font 11
	font = "akbar",
	weight = 400,
	antialias = false,
	outline = true
})

addFont("Screens_Akbar", { -- Font 12
	font = "akbar",
	weight = 400,
	antialias = false,
	outline = false
})

-- csd
addFont("Screens_csd outlined", { -- Font 13
	font = "csd",
	weight = 400,
	antialias = false,
	outline = true
})

addFont("Screens_csd", { -- Font 14
	font = "csd",
	weight = 400,
	antialias = false,
	outline = false
})

if CLIENT then

	local function addFonts(path)
		local files, folders = file.Find("resource/fonts/" .. path .. "*", "MOD")

		for k, v in pairs(files) do
			if string.GetExtensionFromFilename(v) == "ttf" then
				local font = string.StripExtension(v)
				if table.HasValue(textscreenFonts, "Screens_" .. font) then continue end
print("-- "  .. font .. "\n" .. [[
addFont("Screens_ ]] .. font .. [[", {
	font = font,
	weight = 400,
	antialias = false,
	outline = true
})
				]])
			end
		end

		for k, v in pairs(folders) do
			addFonts(path .. v .. "/")
		end
	end

	concommand.Add("get_fonts", function(ply)
		addFonts("")
	end)

end