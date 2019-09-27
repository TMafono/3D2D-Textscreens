This is a modified version of 3D2D Textscreens. All credit for this addon should go to the original author. I'll only take credit for the work I have done.

You can find the official verion here. https://github.com/Cherry/3D2D-Textscreens

## Features: 
* Create 3D2D text anywhere in the world 
* Rotate and manipulate this text simply via your physgun 
* Up to 5 lines of text 
* Multiple different fonts, font sizes, and colours
* Heavily optimised
  * Full scale testing on a highly popular RP server 
  * Draw distance optimisations 
  * Minimal FPS hit
* Permanent text screens
  * Hold C for context menu, right click on the textscreen, and make the text screen permanent (only works for admins). This is perfect for welcome messages or rules.
* Presets
  * Define preset textscreen data (size, text, colours, etc) and save/load these for future use at any time. This is very useful to trying to replicate multiple textscreens across maps.


## Server owners:
* Use the textscreens_config.lua to change configuration options.

[<img src="https://loading.ncba.gg/github/3d2dtextscreens/config_one.PNG" alt="3D2D Textscreens cfg 1" width="600px">]

[<img src="https://loading.ncba.gg/github/3d2dtextscreens/config_two.PNG" alt="3D2D Textscreens cfg 2" width="600px">]

### Custom admin permissions:
This addon supports custom permissions via the use of a `TextscreensCanAdmin` hook. When this hook isn't present, or doesn't return anything, it defaults to an `IsSuperAdmin` check. If you want to override this behaviour for your own admin permissions, create a hook that exists both server *and* client side, similar to the following:
```lua
hook.Add("TextscreensCanAdmin", "MyCustomAdminFunc", function(ply)
	return ply:SteamID() == "STEAM_0:0:43716939"
end)
```

---

Further information can be found on the [Steam Workshop for Garry's Mod](https://steamcommunity.com/sharedfiles/filedetails/?id=109643223).