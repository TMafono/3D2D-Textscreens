textscreenConfig = {}
--[[
 Textscreens client config. (Serverside configuration that affects players.)
--]]
			/* Changes made to these values only apply after a server restart */
-- Allow analytics such as Server IP, Operating System, Server. (true/false)
AllowAnalytics = false
-- If you want debug information to be printed to console them set this to true. (true/false)
-- A little broken. I am working on fixing some messages not printing.(LOL THE DEBUG MESSAGES ARE BROKEN. I guess i'll have to debug them.)
AllowDebug = false
-- If you want to use PermaTextscreens then set this to true.(true/false)
UsePermaTextscreens = true
-- Set the textscreen render distance here. Default: 1500
TextscreenRDistance = 1500
-- Minimum textsize for textscreens. Default: 20
TextMinSize = 25
-- Maximum textsize for textscreens. Default: 100
TextMaxSize = 100
-- These are the groups that can manipulate Textscreens(Physgun/Remove).
-- Not used yet.
ServerguardGroups = {}