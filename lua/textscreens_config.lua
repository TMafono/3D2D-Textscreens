textscreenConfig = {}
--[[  Textscreens client config. (Serverside configuration that affects players.) --]]

			/* Changes made to these values only apply after a server restart */
			/*LUA Refresh sucks, so fuck it even though most of these values can be changed with LUA refresh on.*/

-- Allow analytics such as Server IP, Operating System, Server. (true/false)
AllowAnalytics = false
-- If you want debug information to be printed to console them set this to true. (true/false)
-- A little broken. I am working on fixing some messages not printing.(LOL THE DEBUG MESSAGES ARE BROKEN. I guess i'll have to debug them.)
AllowDebug = false
-- If you want to use PermaTextscreens then set this to true.(true/false)
UsePermaTextscreens = true
-- Set the textscreen render distance here. Default: 1500
TextscreenRDistance = 1500
-- Max amount of characters that can be on a single line for a Textscreen. Default: 180
MaxTextscreenCharacters = 45
-- Minimum textsize for textscreens. Default: 20 - I recommened 25 as minimum.
TextMinSize = 20
-- Maximum textsize for textscreens. Default: 100 - I recommened 80 as maximum.
TextMaxSize = 100
-- Set the max amount of textscreens here. Make sure this is higher than the MaxTextScreenLimit set below. Default: 3
TextscreensLimit = 5
			/* Player's Name Section */

-- Set this to true or false to enable displaying players names under their textscreen. - I would personally enable this as it makes it easier for staff to locate textscreen owners.
DisplayNames = true
-- Set this to true to enable. This will print in console when someone attempts to set the textscreen Min/Max size below or above their set vaues.
PrintScreenAbuse = false
-- This sets the player name size that is displayed under the textscreen. 
-- If you want it to use the text Min/Max size then put "TextMinSize" or "TextMaxSize"
-- If you want it to default to the TextMinSize then put nil.
PlayerNameSize = 50
-- This is the color of the players name.
PlayerNameColor = Color(255,255,255)

			/* Advertisements */

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

			/* Permissions */
-- Set to true if you are using serverguard set to false to use GetUserGroup.
UsingMotherfuckingServerguard = false
-- These are the groups that can manipulate Textscreens(Physgun/Remove).
-- Not used yet.
PriveledgedGroups = {
	user,
}
-- customCheck = function(ply) return table.HasValue({PriveledgedGroups}, ply:GetNWString("usergroup")) end,
-- You set a group max textscreen limit here enjoy :)
MaxTextScreenLimit = {
	user = 1,
	--superadmin = 1,
}
-- This is the fall back max textscreens incase the rank could be be found.
FailsafeMaxTextscreens = 2