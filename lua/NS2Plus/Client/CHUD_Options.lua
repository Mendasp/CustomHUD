local function CHUDRestartScripts(scripts)

	for _, currentScript in pairs(scripts) do
		local script = ClientUI.GetScript(currentScript)
		if script then
			script:Uninitialize()
			script:Initialize()
		end
	end
	
end

local uiScaleTime = 0
local function CHUDApplyNewUIScale()
	uiScaleTime = Shared.GetTime()
end

local function CheckUIScaleTime()
	if uiScaleTime ~= 0 and uiScaleTime + 1 < Shared.GetTime() then
		local xRes = Client.GetScreenWidth()
		local yRes = Client.GetScreenHeight()
		GetGUIManager():OnResolutionChanged(xRes, yRes, xRes, yRes)
		uiScaleTime = 0
	end
end

Event.Hook("UpdateRender", CheckUIScaleTime)

CHUDOptions =
{
			mingui = {
				name = "CHUD_MinGUI",
				label = "Minimal GUI",
				tooltip = "Removes backgrounds/scanlines from all UI elements.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
				sort = "A1",
			},
			wps = {
				name = "CHUD_Waypoints",
				label = "Waypoints",
				tooltip = "Disables or enables all waypoints except Attack orders (waypoints can still be seen on minimap).",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "A2",
			},
			autowps = { 
				name = "CHUD_AutoWPs",
				label = "Automatic waypoints",
				tooltip = "Enables or disables automatic waypoints (not given by the commander).",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "A3",
			},
			minwps = {
				name = "CHUD_MinWaypoints",
				label = "Minimal waypoints",
				tooltip = "Toggles all text/backgrounds and only leaves the waypoint icon.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "func",
				valueType = "bool",
				helpImage = "ui/helpImages/minwps.dds",
				helpImageSize = Vector(150, 100, 0),
				sort = "A4",
			},
			nameplates = {
				name = "CHUD_Nameplates",
				label = "Nameplate style",
				tooltip = "Changes building names and health/armor bars for teammates and structures.",
				type = "select",
				values  = { "Default", "Percentages", "Bars only" },
				defaultValue = 0,
				category = "func",
				valueType = "int",
				helpImage = "ui/helpImages/nameplates.dds",
				helpImageSize = Vector(260, 100, 0),
				sort = "A5",
			},
			smallnps = {
				name = "CHUD_SmallNameplates",
				label = "Small nameplates",
				tooltip = "Makes fonts in the nameplates smaller.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({ "GUIUnitStatus" }) end,
				sort = "A6",
			},
			nameplatesdistance = {
				name = "CHUD_Nameplates_Distance",
				label = "Nameplates Distance",
				tooltip = "Chooses how far away, in meters, the nameplates render (ie. when aiming at a building to check its health). This includes teammate names while not aiming at them. High values will decrease performance.",
				type = "slider",
				defaultValue = 13,
				minValue = 5,
				maxValue = 30,
				category = "func",
				valueType = "float",
				sort = "A7",
			},
			av = {
				name = "CHUD_AV",
				label = "Alien vision",
				tooltip = "Lets you choose between different Alien Vision types.",
				type = "select",
				values  = { "Default", "Huze's Old AV", "Huze's Minimal AV", "Uke's AV", "Old AV (Fanta)" },
				valueTable = {
					"shaders/DarkVision.screenfx",
					"shaders/HuzeOldAV.screenfx",
					"shaders/HuzeMinAV.screenfx",
					"shaders/UkeAV.screenfx",
					"shaders/FantaVision.screenfx",
				},
				defaultValue = 0,
				category = "func",
				valueType = "int",
				applyFunction = function() CHUDRestartScripts({ "GUIAlienHUD" }) end,
				sort = "B1",
				resetSettingInBuild = 237,
			},
			avstate = { 
				name = "CHUD_AVState",
				label = "Default AV state",
				tooltip = "Sets the state the alien vision will be in when you respawn.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "B2",
			},
			hpbar = {
				name = "CHUD_HPBar",
				label = "Marine health bars",
				tooltip = "Enables or disables the health bars from the bottom left of the marine HUD and only leaves the numbers.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "func",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
				sort = "C1",
			},
			aliencircles = {
				name = "CHUD_AlienBars",
				label = "Alien circles",
				tooltip = "Lets you choose between different alien energy/health circles.",
				type = "select",
				values  = { "Default", "Oma", "Rantology" },
				valueTable  = { "ui/alien_hud_health.dds", "ui/oma_alien_hud_health.dds", "ui/rant_alien_hud_health.dds" },
				defaultValue = 0,
				category = "func",
				valueType = "int",
				applyFunction = function() CHUDRestartScripts({ "GUIAlienHUD" }) end,
				helpImage = "ui/helpImages/aliencircles.dds",
				helpImageSize = Vector(192, 120, 0),
				sort = "C2",
			}, 
			instantalienhealth = {
				name = "CHUD_InstantAlienHealth",
				label = "Instant Alien Health Bar",
				tooltip = "The alien health circle displays the current value instead of using animations when health changes.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "C3"
			},
			motiontracking = {
				name = "CHUD_MotionTracking",
				label = "Motion tracking circle",
				tooltip = "Lets you choose between default scan circles and a less obstructing one.",
				type = "select",
				values  = { "Default", "Minimal" },
				defaultValue = 0,
				category = "func",
				valueType = "int",
				helpImage = "ui/helpImages/motiontracking.dds",
				helpImageSize = Vector(160, 80, 0),
				sort = "C4"
			},
			dmgcolor_m = {
				name = "CHUD_DMGColorM",
				label = "Marine damage numbers color",
				tooltip = "Changes the color of the marine damage numbers.",
				valueType = "color",
				defaultValue = 0x4DDBFF,
				category = "func",
				sort = "D1",
				resetSettingInBuild = 264,
			},
			dmgcolor_a = {
				name = "CHUD_DMGColorA",
				label = "Alien damage numbers color",
				tooltip = "Changes the color of the alien damage numbers.",
				defaultValue = 0xFFCA3A,
				category = "func",
				valueType = "color",
				sort = "D2",
				resetSettingInBuild = 264,
			},
			blur = {
				name = "CHUD_Blur",
				label = "Blur",
				tooltip = "Removes the background blur from menus/minimap.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "E1"
			},
			particles = {
				name = "CHUD_Particles",
				label = "Minimal particles",
				tooltip = "Toggles between default and less vision obscuring particles.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = SetCHUDCinematics,
				applyOnLoadComplete = true,
				sort = "E2"
			}, 
			tracers = {
				name = "CHUD_Tracers",
				label = "Weapon tracers",
				tooltip = "Enables or disables weapon tracers.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "E3",
			},
			serverblood = {
				name = "CHUD_ServerBlood",
				label = "Server-side blood hits",
				tooltip = "Disables predicted blood on the client and turns it into server-confirmed blood.",
				type = "select",
				values  = { "Predicted", "Server confirmed" },
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = function()
					local message = { }
					message.serverblood = CHUDGetOption("serverblood")
					Client.SendNetworkMessage("SetCHUDServerBlood", message)
				end,
				sort = "E4",
			},
			maxdecallifetime = {
				name = "CHUD_MaxDecalLifeTime",
				label = "Max decal lifetime (minutes)",
				tooltip = "Changes the maximum decal lifetime, you still have to set the slidebar to your liking in the vanilla options.",
				type = "slider",
				defaultValue = 1,
				minValue = 0,
				maxValue = 100,
				multiplier = 1,
				category = "func",
				valueType = "float",
				sort = "E5",
			},
			commhighlight = {
				name = "CHUD_CommHighlight",
				label = "(Comm) Building highlight",
				tooltip = "Highlights the buildings of the same type that you're about to drop in the minimap in a different color.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "func",
				valueType = "bool",
				children = { "commhighlightcolor" },
				hideValues = { false },
				sort = "E6",
			},
			commhighlightcolor = {
				name = "CHUD_CommHighlightColor",
				label = "(Comm) Building highlight color",
				tooltip = "Selects the color of the building highlight.",
				valueType = "color",
				defaultValue = 0xFFFF00,
				category = "func",
				sort = "E7",
			},


			score = {
				name = "CHUD_ScorePopup",
				label = "Score popup",
				tooltip = "Disables or enables score popup (+5).",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "A1",
			},
			scorecolor = {
				name = "CHUD_ScorePopupColor",
				label = "Score popup color",
				tooltip = "Changes the color of the score popup.",
				defaultValue = 0x19FF19,
				category = "hud",
				valueType = "color",
				applyFunction = function()
					GUINotifications.kScoreDisplayKillTextColor = ColorIntToColor(CHUDGetOption("scorecolor"))
				end,
				sort = "A2",
				resetSettingInBuild = 264,
			},
			assists = {
				name = "CHUD_Assists",
				label = "Assist score popup",
				tooltip = "Disables or enables the assists score popup.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "A3",
			},
			assistscolor = {
				name = "CHUD_AssistsPopupColor",
				label = "Assists popup color",
				tooltip = "Changes the color of the assists popup.",
				defaultValue = 0xBFBF19,
				category = "hud",
				valueType = "color",
				applyFunction = function()
					GUINotifications.kScoreDisplayTextColor = ColorIntToColor(CHUDGetOption("assistscolor"))
				end,
				sort = "A4",
				resetSettingInBuild = 264,
			},
			dmgscale = {
				name = "CHUD_DMGScale",
				label = "Damage numbers scale",
				tooltip = "Lets you scale down the damage numbers.",
				type = "slider",
				defaultValue = 1,
				minValue = 0.5,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				sort = "A5",
			}, 
			banners = {
				name = "CHUD_Banners",
				label = "Objective banners",
				tooltip = "Enables or disables the banners in the center of the screen (\"Commander needed\", \"Power node under attack\", \"Evolution lost\", etc.).",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "B1",
			},
			unlocks = {
				name = "CHUD_Unlocks",
				label = "Research notifications",
				tooltip = "Enables or disables the research completed notifications on the right side of the screen.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "B2",
			}, 
			minimap = {
				name = "CHUD_Minimap",
				label = "Marine minimap",
				tooltip = "Enables or disables the minimap and location name.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C1",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
			},
			showcomm = {
				name = "CHUD_CommName",
				label = "Comm name/Team res",
				tooltip = "Enables or disables showing the commander name and team resources.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C2",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
			}, 
			gametime = {
				name = "CHUD_Gametime",
				label = "Game time",
				tooltip = "Adds or removes the game time on the top left of the HUD.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C3",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
			},
			commactions = {
				name = "CHUD_CommActions",
				label = "Marine comm actions",
				tooltip = "Shows or hides the last commander actions.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C4",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
			}, 
			uniqueshotgunhits = {
				name = "CHUD_UniqueShotgunHits",
				label = "Shotgun damage numbers",
				tooltip = "Optionally show unique damage numbers for each shotgun shot.",
				type = "select",
				values  = { "Default", "Per shot" },
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				sort = "C5",
			},
			fasterdamagenumbers = {
				name = "CHUD_FasterDamageNumbers",
				label = "Faster damage numbers",
				tooltip = "Lets you choose the speed of the \"counting up\" text animation for the damage numbers.",
				type = "select",
				values  = { "Default", "Faster", "Instant" },
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = 
					function() 
						local speeds = { [0] = 220, [1] = 800, [2] = 9001 }
						kWorldDamageNumberAnimationSpeed = speeds[CHUDGetOption("fasterdamagenumbers")]
					end,
				sort = "C6",
			},
			overkilldamagenumbers = {
				name = "CHUD_OverkillDamageNumbers",
				label = "Overkill damage numbers",
				tooltip = "Makes damage numbers display overkill values on the killing blow. This displays the damage done even if it's higher than the target's remaining HP instead of the actual damage dealt.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				applyFunction = function()
					local message = { }
					message.overkill = CHUDGetOption("overkilldamagenumbers")
					Client.SendNetworkMessage("SetCHUDOverkill", message)
				end,
				sort = "C6b",
			},
			damagenumbertime = 
			{
				name = "CHUD_DamageNumberTime",
				label = "Damage number fade time",
				tooltip = "Controls how long damage numbers are on screen.",
				type = "slider",
				defaultValue = kWorldMessageLifeTime,
				minValue = 0,
				maxValue = 3,
				category = "hud",
				valueType = "float",
				sort = "C6c"
			},
			hitindicator = { 
				name = "CHUD_HitIndicator",
				label = "Hit indicator fade time",
				tooltip = "Controls how long the crosshair hit indicator will last after hitting a target.",
				type = "slider",
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function() Player.kShowGiveDamageTime = CHUDGetOption("hitindicator") end,
				applyOnLoadComplete = true,
				sort = "C7"
			},
			minimapalpha = { 
				name = "CHUD_MinimapAlpha",
				label = "Overview opacity",
				tooltip = "Sets the trasparency of the map overview.",
				type = "slider",
				defaultValue = 0.85,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					local minimapScript = ClientUI.GetScript("GUIMinimapFrame")
					if minimapScript then
						minimapScript:GetMinimapItem():SetColor(Color(1,1,1,CHUDGetOption("minimapalpha")))
					end
				end,
				sort = "C8",
			},
			locationalpha = { 
				name = "CHUD_LocationAlpha",
				label = "Location text opacity",
				tooltip = "Sets the trasparency of the location text on the minimap.",
				type = "slider",
				defaultValue = 0.65,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					Shared.ConsoleCommand("setmaplocationcolor 255 255 255 " .. tostring(tonumber(CHUDGetOption("locationalpha"))*255))
				end,
				sort = "C9",
			},
			minimaparrowcolorcustom = { 
				name = "CHUD_MinimapArrowColorCustom",
				label = "Use custom minimap arrow color",
				tooltip = "Lets you set the color of the arrow indicating your position in the minimap.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				applyFunction = function()
					local minimapScript = ClientUI.GetScript("GUIMinimapFrame")
					local playerIconColor = nil
					if CHUDGetOption("minimaparrowcolorcustom") then
						playerIconColor = ColorIntToColor(CHUDGetOption("minimaparrowcolor"))
					end
					if minimapScript then
						minimapScript:SetPlayerIconColor(playerIconColor)
					end
					CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" })
				end,
				hideValues = { false },
				children = { "minimaparrowcolor" },
				sort = "C9b",
			},
			minimaparrowcolor = { 
				name = "CHUD_MinimapArrowColor",
				label = "Minimap arrow color",
				tooltip = "Sets the color of the arrow indicating your position in the minimap.",
				defaultValue = 0xFFFF00,
				category = "hud",
				applyFunction = function()
					local minimapScript = ClientUI.GetScript("GUIMinimapFrame")
					local playerIconColor = nil
					if CHUDGetOption("minimaparrowcolorcustom") then
						playerIconColor = ColorIntToColor(CHUDGetOption("minimaparrowcolor"))
					end
					if minimapScript then
						minimapScript:SetPlayerIconColor(playerIconColor)
					end
					CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" })
				end,
				valueType = "color",
				sort = "C9c",
				resetSettingInBuild = 265,
			},
			playercolor_m = { 
				name = "CHUD_PlayerColor_M",
				label = "Marine minimap player color",
				tooltip = "Sets the color of marine players in the minimap different from the structures.",
				defaultValue = 0x00D8FF,
				category = "hud",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
				valueType = "color",
				sort = "C9d",
				resetSettingInBuild = 264,
			},
			playercolor_a = { 
				name = "CHUD_PlayerColor_A",
				label = "Alien minimap player color",
				tooltip = "Sets the color of alien players in the minimap different from the structures.",
				defaultValue = 0xFF8A00,
				category = "hud",
				valueType = "color",
				sort = "C9e",
				resetSettingInBuild = 264,
			},
			mapelementscolor = {
				name = "CHUD_MapElementsColor",
				label = "Tech point/Res node minimap color",
				tooltip = "Sets the color for the empty Tech Points and Resource Nodes in the minimap.",
				defaultValue = 0xFFFFA0,
				category = "hud",
				valueType = "color",
				sort = "C9f",
			},
			pglines = { 
				name = "CHUD_MapConnectorLines",
				label = "Phase Gate Lines",
				tooltip = "Cutomizes the look of the PG lines in the minimap.",
				type = "select",
				values  = { "Solid line", "Static arrows", "Animated lines", "Animated arrows" },
				defaultValue = 3,
				category = "hud",
				valueType = "int",
				sort = "D1",
			},
			classicammo = {
				name = "CHUD_ClassicAmmo",
				label = "Classic ammo counter",
				tooltip = "Enables or disables a classic ammo counter on the bottom right of the marine HUD, above the personal resources text.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				applyFunction = function()
					CHUDEvaluateGUIVis()
				end,
				sort = "D2",
			},
			friends = {
				name = "CHUD_Friends",
				label = "Friends highlighting",
				tooltip = "Enables or disables the friend highlighting in the minimap.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				applyFunction = function() 	local friends = CHUDGetOption("friends")
					ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendAlien =
						ConditionalValue(friends, kMinimapBlipTeam.FriendAlien, kMinimapBlipTeam.Alien) } )
					ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendMarine =
						ConditionalValue(friends, kMinimapBlipTeam.FriendMarine, kMinimapBlipTeam.Marine) } )
				end,
                sort = "D3",
			}, 
			kda = {
				name = "CHUD_KDA",
				label = "KDA/KAD",
				tooltip = "Switches the scoreboard columns between KAD and KDA.",
				type = "select",
				values  = { "KAD", "KDA" },
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({ "GUIScoreboard" }) end,
                sort = "D4",
			},
			rtcount = {
				name = "CHUD_RTcount",
				label = "RT count dots",
				tooltip = "Toggles the RT count dots at the bottom and replaces them with a number.",
				type = "select",
				values  = { "Number", "Dots" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				helpImage = "ui/helpImages/rtcount.dds",
				helpImageSize = Vector(256, 128, 0),
				sort = "D5",
			},
			uplvl = {
				name = "CHUD_UpgradeLevel",
				label = "Upgrade level UI",
				tooltip = "Changes between disabled, default or old icons for marine upgrades.",
				type = "select",
				values  = { "Disabled", "Default", "NS2 Beta" },
				defaultValue = 1,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" })
				end,
				helpImage = "ui/helpImages/uplvl.dds",
				helpImageSize = Vector(160, 128, 0),
				sort = "D6",
			},
			welderup = {
				name = "CHUD_WelderUp",
				label = "Show welder as upgrade",
				tooltip = "When you have a welder it shows up under the armor and weapon level.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				helpImage = "ui/helpImages/welderup.dds",
				helpImageSize = Vector(160, 160, 0),
				sort = "D7",
				resetSettingInBuild = 262,
			},
			killfeedscale = {
				name = "CHUD_KillFeedScale",
				label = "Killfeed scale",
				tooltip = "Lets you scale the killfeed.",
				type = "slider",
				defaultValue = 1,
				minValue = 1,
				maxValue = 2,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D8",
			},
			killfeediconscale = {
				name = "CHUD_KillFeedIconScale",
				label = "Killfeed icon scale",
				tooltip = "Lets you scale the size of the icons in the killfeed.",
				type = "slider",
				defaultValue = 1,
				minValue = 1,
				maxValue = 2,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D9a",
			},
			killfeedhighlight = {
				name = "CHUD_KillFeedHighlight",
				label = "Killfeed highlight",
				tooltip = "Enables or disables the border for your player kills in the killfeed.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = 1,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D9b",
			},
			killfeedcolorcustom = {
				name = "CHUD_KillFeedHighlightColorCustom",
				label = "Use custom killfeed highlight color",
				tooltip = "Lets you choose the color of the highlight border for your kills in the killfeed.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				hideValues = { false },
				children = { "killfeedcolor" },
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D9c",
			},
			killfeedcolor = {
				name = "CHUD_KillFeedHighlightColor",
				label = "Killfeed highlight color",
				tooltip = "Chooses the color of the highlight border for your kills in the killfeed.",
				defaultValue = 0xFF0000,
				category = "hud",
				valueType = "color",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D9d",
				resetSettingInBuild = 265,
			},
			lowammowarning = {
				name = "CHUD_LowAmmoWarning",
				label = "Low ammo warning",
				tooltip = "Enables or disables the low ammo warning in the weapon displays.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				helpImage = "ui/helpImages/lowammowarning.dds",
				helpImageSize = Vector(128, 128, 0),
				sort = "E1",
			},
			hudbars_m = {
				name = "CHUD_CustomHUD_M",
				label = "HUD bars (Marine)",
				tooltip = "HL2 Style displays health/armor and ammo next to the crosshair. NS1 Style puts big bars at the bottom on each side.",
				type = "select",
				values  = { "Disabled", "HL2 Style", "NS1 Style" },
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					local classicammoScript = "NS2Plus/Client/CHUDGUI_ClassicAmmo"
					local hudbarsScript = "NS2Plus/Client/CHUDGUI_HUDBars"
					if GetGUIManager():GetGUIScriptSingle(hudbarsScript) then
						GetGUIManager():DestroyGUIScriptSingle(hudbarsScript)
					end
					if GetGUIManager():GetGUIScriptSingle(classicammoScript) then
						GetGUIManager():DestroyGUIScriptSingle(classicammoScript)
					end
					CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD", "GUIJetpackFuel" })
					CHUDEvaluateGUIVis()
				end,
				sort = "E2",
			},
			hudbars_a = {
				name = "CHUD_CustomHUD_A",
				label = "HUD bars (Alien)",
				tooltip = "HL2 Style displays health/armor and ammo next to the crosshair. NS1 Style puts big bars at the bottom on each side.",
				type = "select",
				values  = { "Disabled", "HL2 Style", "NS1 Style" },
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					local hudbarsScript = "NS2Plus/Client/CHUDGUI_HUDBars"
					if GetGUIManager():GetGUIScriptSingle(hudbarsScript) then
						GetGUIManager():DestroyGUIScriptSingle(hudbarsScript)
					end
					CHUDRestartScripts({ "GUIAlienHUD" })
					CHUDEvaluateGUIVis()
				end,
				sort = "E3",
			},
			inventory = {
				name = "CHUD_Inventory",
				label = "Weapon Inventory",
				tooltip = "Lets you customize the functionality of the inventory.",
				type = "select",
				values  = { "Default", "Hide", "Show ammo", "Always on", "Always on + ammo" },
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					"GUIProgressBar",
					}) end,
				helpImage = "ui/helpImages/inventory.dds",
				helpImageSize = Vector(256, 128, 0),
				sort = "E4",
			},
			crosshairscale = {
				name = "CHUD_CrosshairScale",
				label = "Crosshair scale",
				tooltip = "Lets you increase or decrease the size of your crosshair.",
				type = "slider",
				defaultValue = 1,
				minValue = 0.01,
				maxValue = 2,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					CHUDRestartScripts({ "GUICrosshair" })
					if GetGUIManager and GetGUIManager():GetGUIScriptSingle("NS2Plus/Client/CHUDGUI_HUDBars") then
						GetGUIManager():GetGUIScriptSingle("NS2Plus/Client/CHUDGUI_HUDBars"):Reset()
					end
				end,
				sort = "E5",
			},


			hitsounds = {
				name = "CHUD_Hitsounds",
				label = "Hitsounds",
				tooltip = "Chooses between different server confirmed hitsounds.",
				type = "select",
				values  = { "Vanilla", "Quake 3", "Quake 4", "Dystopia" },
				valueTable = { "null",
					"sound/hitsounds.fev/hitsounds/q3",
					"sound/hitsounds.fev/hitsounds/q4",
					"sound/hitsounds.fev/hitsounds/dys",
				},
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				children = { "hitsounds_pitch" },
				hideValues = { 0 },
				sort = "A1",
			},
			hitsounds_pitch = { 
				name = "CHUD_HitsoundsPitch",
				label = "Hitsounds pitch modifier",
				tooltip = "Sets the pitch for high damage hits on variable damage weapons. This setting has no effect for vanilla hitsounds.",
				type = "select",
				values  = { "Low pitch", "High pitch" },
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "A2",
			},
			ambient = {
				name = "CHUD_Ambient",
				label = "Ambient sounds",
				tooltip = "Enables or disables map ambient sounds.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				applyFunction = SetCHUDAmbients,
				applyOnLoadComplete = true,
				sort = "B1",
			}, 
			mapparticles = {
				name = "CHUD_MapParticles",
				label = "Map particles",
				tooltip = "Enables or disables particles, holograms and other map specific effects.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				applyFunction = SetCHUDCinematics,
				applyOnLoadComplete = true,
				sort = "B2",
			}, 
			nsllights = {
				name = "lowLights",
				label = "NSL Low lights",
				tooltip = "Replaces the low quality option lights with the lights from the NSL maps.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				applyFunction = function()
					lowLightsSwitched = false
					CHUDLoadLights()
				end,
				sort = "B3",
			}, 
			flashatmos = { 
				name = "CHUD_FlashAtmos",
				label = "Flashlight atmospherics",
				tooltip = "Sets the atmospheric density of flashlights.",
				type = "slider",
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "comp",
				valueType = "float",
				sort = "C1",
			},
			deathstats = { 
				name = "CHUD_DeathStats",
				label = "Stats UI",
				tooltip = "Enables or disables the stats you get after you die and at the end of the round. Also visible on voiceover menu (default: X).",
				type = "select",
				values  = { "Fully disabled", "Only voiceover menu", "Enabled" },
				defaultValue = 2,
				disabledValue = 0,
				category = "comp",
				valueType = "int",
				sort = "D1",
			},
			endstatsorder = { 
				name = "CHUD_EndStatsOrder",
				label = "End Game Stats UI Order",
				tooltip = "Sets the order in which the stats after a round ends are displayed.",
				type = "select",
				values  = { "Team stats first", "Personal stats first" },
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "D2",
			},
			autopickup = { 
				name = "CHUD_AutoPickup",
				label = "Weapon autopickup",
				tooltip = "Picks up weapons automatically as long as the slot they belong to is empty.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "E1",
				applyFunction = function()
					local message = { }
					message.autoPickup = CHUDGetOption("autopickup")
					message.autoPickupBetter = CHUDGetOption("autopickupbetter")
					Client.SendNetworkMessage("SetCHUDAutopickup", message)
				end,
			},
			autopickupbetter = { 
				name = "CHUD_AutoPickupBetter",
				label = "Autopickup better weapon",
				tooltip = "Picks up better weapons in the primary slot automatically.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "E2",
				applyFunction = function()
					local message = { }
					message.autoPickup = CHUDGetOption("autopickup")
					message.autoPickupBetter = CHUDGetOption("autopickupbetter")
					Client.SendNetworkMessage("SetCHUDAutopickup", message)
				end,
			},
			pickupexpire = { 
				name = "CHUD_PickupExpire",
				label = "Pickup expiration bar",
				tooltip = "Adds a bar indicating the time left for the pickupable to disappear.",
				type = "select",
				values  = { "Disabled", "Equipment Only", "All pickupables" },
				defaultValue = 2,
				category = "comp",
				valueType = "int",
				sort = "E3",
				resetSettingInBuild = 191,
			},
			pickupexpirecolor = { 
				name = "CHUD_PickupExpireBarColor",
				label = "Dynamically colored expiration bar",
				tooltip = "Makes the expire bar colored depending on time left.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "E4",
			},
			wrenchicon = { 
				name = "CHUD_DynamicWrenchColor",
				label = "Dynamically colored repair icon",
				tooltip = "Makes the wrench on the marine HUD be color coded with the amount of damage received.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = 1,
				category = "comp",
				valueType = "int",
				sort = "E5",
			},
			instantdissolve = { 
				name = "CHUD_InstantDissolve",
				label = "Ragdoll instant dissolve effect",
				tooltip = "Makes the ragdoll start to disappear immediatly after kill.",
				type = "select",
				values  = { "Disabled", "Enabled" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "E6",
			},
			minimaptoggle = { 
				name = "CHUD_MinimapToggle",
				label = "Minimap key behavior",
				tooltip = "Lets you make the minimap key a toggle instead of holding.",
				type = "select",
				values  = { "Hold", "Toggle" },
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "F1",
			},
			marinecommselect = { 
				name = "CHUD_MarineCommSelect",
				label = "(Comm) Marine Click Selection",
				tooltip = "Lets you disable click selecting for Marines.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				sort = "F2",
			},
			commqueue_playeronly = { 
				name = "CHUD_CommQueuePlayerOnly",
				label = "(Comm) Spacebar Player Alerts",
				tooltip = "Allows the spacebar alert queue to only respond to player requests.",
				type = "select",
				values  = { "Default", "Only Player Alerts" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "F3",
			},
			sensitivity_perteam = { 
				name = "CHUD_SensitivityPerTeam",
				label = "Team specific sensitivities",
				tooltip = "Lets you have different sensitivities for aliens and marines.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				applyFunction = function()
					CHUDApplyTeamSpecificStuff()
				end,
				children = { "sensitivity_m", "sensitivity_a" },
				hideValues = { false },
				sort = "G1",
			},
			sensitivity_m = { 
				name = "CHUD_Sensitivity_M",
				label = "Marine sensitivity",
				tooltip = "Sensitivity for marines.",
				type = "slider",
				defaultValue = 5,
				minValue = 0.01,
				maxValue = 20,
				multiplier = 1,
				category = "comp",
				valueType = "float",
				applyFunction = function()
					CHUDApplyTeamSpecificStuff()
				end,
				sort = "G2",
			},
			sensitivity_a = { 
				name = "CHUD_Sensitivity_A",
				label = "Alien sensitivity",
				tooltip = "Sensitivity for aliens.",
				type = "slider",
				defaultValue = 5,
				minValue = 0.01,
				maxValue = 20,
				multiplier = 1,
				category = "comp",
				valueType = "float",
				applyFunction = function()
					CHUDApplyTeamSpecificStuff()
				end,
				sort = "G3",
			},
			fov_perteam = { 
				name = "CHUD_FOVPerTeam",
				label = "Team specific FOV",
				tooltip = "Lets you have different FOVs for aliens and marines.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				applyFunction = function()
					CHUDApplyTeamSpecificStuff()
				end,
				children = { "fov_m", "fov_a" },
				hideValues = { false },
				sort = "G4",
			},
			fov_m = { 
				name = "CHUD_FOV_M",
				label = "Marine FOV",
				tooltip = "FOV for marines.",
				type = "slider",
				defaultValue = 0,
				minValue = 0,
				maxValue = 1,
				multiplier = 20,
				category = "comp",
				valueType = "float",
				applyFunction = function()
					CHUDApplyTeamSpecificStuff()
				end,
				sort = "G5",
			},
			fov_a = { 
				name = "CHUD_FOV_A",
				label = "Alien FOV",
				tooltip = "FOV for aliens.",
				type = "slider",
				defaultValue = 0,
				minValue = 0,
				maxValue = 1,
				multiplier = 20,
				category = "comp",
				valueType = "float",
				applyFunction = function()
					CHUDApplyTeamSpecificStuff()
				end,
				sort = "G6",
			},
			drawviewmodel = { 
				name = "CHUD_DrawViewModel",
				label = "Draw viewmodel",
				tooltip = "Enables or disables showing the viewmodel.",
				type = "select",
				values  = { "Display all", "Hide marines", "Hide aliens", "Hide both", "Only Exosuits" },
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "G7",
				applyFunction = function()
					CHUDEvaluateGUIVis()
					CHUDRestartScripts({"Hud/Marine/GUIMarineHUD"})
				end,
				resetSettingInBuild = 214,
			},
			sbcenter = { 
				name = "CHUD_SBCenter",
				label = "Auto-center scoreboard",
				tooltip = "Enable or disable the scoreboard scrolling to your entry in the scoreboard automatically after opening it.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				sort = "G8",
			},
			castermode = { 
				name = "CHUD_CasterMode",
				label = "Caster mode",
				tooltip = "Makes NS2+ use all the default values without overwriting your current config.",
				type = "select",
				values  = { "Off", "On" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				applyFunction = function()
					for name, option in pairs(CHUDOptions) do
						if name ~= "castermode" then
							if option.applyFunction then
								option.applyFunction()
							end
						end
					end
				end,
				sort = "H1",
			},
			overheadsmoothing = { 
				name = "CHUD_OverheadSmoothing",
				label = "Spectator overhead smoothing",
				tooltip = "Toggles between smoothed and instant camera movement when clicking on the minimap as an overhead spectator.",
				type = "select",
				values  = { "Instant", "Smoothed" },
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				sort = "H2",
			},
			brokenscaling = { 
				name = "CHUD_BrokenScaling",
				label = "UI Scaling version",
				tooltip = "Revert the amazing UI Scaling introduced in build 276 by the sexiest man alive and use the inferior, disgusting and broken stuff from previous builds. Use at your own risk.",
				type = "select",
				values  = { "Default", "Old" },
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				applyFunction = function()
					CHUDApplyNewUIScale()
				end,
				children = { "uiscale" },
				hideValues = { true },
				sort = "H3",
			},
			uiscale = { 
				name = "CHUD_UIScaling",
				label = "UI Scaling",
				tooltip = "Change the scaling for the UI. Note that not everything will adapt to this as not everything is using the same scaling function and some elements might break. Use at your own risk.",
				type = "slider",
				defaultValue = 1,
				minValue = 0.05,
				maxValue = 2,
				multiplier = 100,
				category = "comp",
				valueType = "float",
				applyFunction = function()
					CHUDApplyNewUIScale()
				end,
				sort = "H4",
			},
}