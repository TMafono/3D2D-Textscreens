textscreenConfig = {}
--[[  Textscreens client config. (Serverside configuration that affects players.) 

			Changes made to these values only apply after a server restart.
			LUA Refresh sucks, so fuck it even though most of these values(Like 90%) can be changed with LUA refresh on.
--]]
--[[
			General Section
]]--
-- Allow analytics such as Server IP, Operating System, Server. (true/false)
AllowAnalytics = false
-- If you want debug information to be printed to console them set this to true. (true/false)
-- A little broken. I am working on fixing some messages not printing.(LOL THE DEBUG MESSAGES ARE BROKEN. I guess i'll have to debug them.)
AllowDebug = false
-- If you want to use PermaTextscreens then set this to true.(true/false)
-- Performance improvment if disabled, only effects server start. (When it initially loads the permanent textscreens.)
UsePermaTextscreens = true
-- Set the textscreen render distance here. Default: 1500
TextscreenRDistance = 1500
-- Set this to false to disable the textscreen render both sides at the same time.
-- Make bring a performance improvement. Default: True
ShouldDrawBothSides = true
-- Max amount of characters that can be on a single line for a Textscreen. Default: 180
MaxTextscreenCharacters = 180
-- Setting this to true enable the max amount of characters to dynamically change depending on the players font size.
-- V1.1 release. Not Ready.
AdaptiveCharacterLimit = true
-- This is the table used to set the character depending on th font size font size. Row One: FontSize, Row Two: Character limit.
-- V1.1 release. Not Ready.
AdaptiveCharactersTable = {
	40 == 180
}
-- Minimum textsize for textscreens. Default: 20 - I recommened 25 as minimum.
TextMinSize = 20
-- Maximum textsize for textscreens. Default: 100 - I recommened 80 as maximum.
TextMaxSize = 100
-- Set the max amount of textscreens here. Make sure this is higher than the MaxTextScreenLimit set below for groups. Default: 3
TextscreensLimit = 3
--[[
			Player's Section
]]--
-- Set this to true or false to enable displaying players names under their textscreen. - I would personally enable this as it makes it easier for staff to locate textscreen owners.
DisplayNames = false
-- This will display the player's SteamID next to their name. Textscreen are cached so their name doesn't update on the textscreen if it changes. 
-- Disable DisplayNames to only display the SteamID.
-- If DisplayNames & DisplaySteamID are false then nothing will be displayed.
DisplaySteamID = false
-- Set this to true to enable. This will print in console when someone attempts to set the textscreen Min/Max size below or above their set vaues.
PrintScreenAbuse = false
-- This sets the player name size that is displayed under the textscreen. 
-- If you want it to use the text Min/Max size then put "TextMinSize" or "TextMaxSize"
-- If you want it to default to the TextMinSize then put nil.
PlayerNameSize = 50
-- This is the color of the players name.
PlayerNameColor = Color(255,255,255)
-- 
PlayerNameFont = 1
--[[
			Advertisements
]]--
-- WHAT?!?! You can have it where every player advertises for you?
-- All right, don't get your hopes so high. You only get a single line of the textscreen, but you are correct.
EnableAdvertising = false
-- This is the actual advertisement text. This does abide by the character limit.
Advertisement = "This is a test advertisement."
-- The color that the advertisement is.
AdvertisementTextColor = Color(255,255,255)
-- The Text Size of the advertisement.
-- Don't be a dick with this or i'll add a sneaky little method to combat abuse of it.
AdvertisementTextSize = 50
-- The Advertisement Font, Aka the font the advertisement uses.
-- This needs to  be a number. View the textscreens_fontconfig file. They are numbered for you :)
AdvertisementFont = 1
--[[
			 Permissions
]]--
-- Set to true if you are using serverguard set to false to use GetUserGroup.
UsingMotherfuckingServerguard = false
-- These are the groups that can manipulate Textscreens(Physgun/Remove).
-- Not used yet.
PriveledgedGroups = {
	superadmin = true,
	superadmin,
}
-- You set a group max textscreen limit here enjoy :)
MaxTextScreenLimit = {
	superadmin = 5,
}
-- This is the fall back max textscreens incase the rank couldn't be found.
FailsafeMaxTextscreens = 2