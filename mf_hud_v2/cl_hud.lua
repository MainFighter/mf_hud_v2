HUDSettings = {} -- Don't remove this
--[[
This HUD was made by Anonymous (http://steamcommunity.com/profiles/76561198027291542).
Please don't remove the credits. No one will see them besides you anyway! Thank you for understanding.

This is abondened if you need help with this version of my HUD I will not provide it.
I abondened this after I scraped everything and remade a new HUD for my server.

Alot of this HUD is broken and has lua errors also some of the settings do not work.

I have sinced fixed all of the errors that are in this HUD in my new one but I really couldn't be fucked going back to update a HUD I will not be using.

Feel free to do whatever you want with it just please leave the credits that I orginally made it, thanks.

Current Version: 1.3.1
]]--

/*----------------------------------
HUD Settings
----------------------------------*/

--These will be placed on the screen at the positions you can set.
--Set to "" to disable.
HUDSettings.ExtraText1 		= ""
HUDSettings.ExtraText2 		= ""
HUDSettings.ExtraText3 		= ""
HUDSettings.ExtraText4 		= ""

--X = Horizontal
--Y = Vertical
--^ Basic math there guys xD
--Changes the position on the X and Y axis
HUDSettings.ExtraText1PosX 		= 0
HUDSettings.ExtraText1PosY 		= 0
--Changes the position on the X and Y axis
HUDSettings.ExtraText2PosX		= 0
HUDSettings.ExtraText2PosY		= 0
--Changes the position on the X and Y axis
HUDSettings.ExtraText3PosX		= 0
HUDSettings.ExtraText3PosY		= 0
--Changes the position on the X and Y axis
HUDSettings.ExtraText4PosX		= 0
HUDSettings.ExtraText4PosY		= 0

--This will align the text to either Left, Right or Center.
-- TAL = Left
-- TAC = Center
-- TAR = Right
HUDSettings.ExtraTextAlign1		= TAL
HUDSettings.ExtraTextAlign2		= TAR
HUDSettings.ExtraTextAlign3   	= TAL
HUDSettings.ExtraTextAlign4  	= TAL

--Default fonts are Bebas10 through to Bebas 50 going in 10 intervals.
--If you want to add more fonts go into the cl_fonts.lua and add the fonts you want.
HUDSettings.ExtraText1Font		= "Bebas20"
HUDSettings.ExtraText2Font		= "Bebas20"
HUDSettings.ExtraText3Font		= "Bebas20"
HUDSettings.ExtraText4Font		= "Bebas20"

--Uses RGB, Color(RED, GREEN, BLUE, ALPHA (Transparency)) for example Color(255, 0, 0, 255) will be Red.
HUDSettings.ColorExtraText1		= Color(255, 255, 255, 255) --Sets the text color of ExtraText1 on the HUD.
HUDSettings.ColorExtraText2		= Color(255, 255, 255, 255) --Sets the text color of ExtraText2 on the HUD.
HUDSettings.ColorExtraText3		= Color(255, 255, 255, 255) --Sets the text color of ExtraText3 on the HUD.
HUDSettings.ColorExtraText4		= Color(255, 255, 255, 255) --Sets the text color of ExtraText4 on the HUD.

--True = Enable
--False = Disable
--These will enable/disable the elements displaying on the screen.
HUDSettings.Minimap			= false 	-- Enables/Disables the Minimap at top right corner
HUDSettings.PlayerDarkRP	= true 		-- Enables/Disables DarkRP Info. (Eg. Job, Wallet, etc)
HUDSettings.PlayerHealth	= true 		-- Enables/Disables Health Bar
HUDSettings.PlayerArmor 	= true 		-- Enables/Disables Armor Bar
--Only one of these can be enabled at one time!
--If both are disabled the 3rd bar on the HUD will just show "PLACEHOLDER" and a black bar.
HUDSettings.PlayerHunger	= false 	-- Enables/Disables DarkRP Hunger
HUDSettings.PlayerStamina 	= false 	-- Enables/Disables TCB Stamina

/*----------------------------------
HUD Settings
----------------------------------*/

/*-------------------------------------------------------------------------------------------------------------------------------
DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!!
DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!!
DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!!
DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!!
DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!!
DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!!
-------------------------------------------------------------------------------------------------------------------------------*/

/*----------------------------------
Disable DarkRP and GMOD HUD elements
----------------------------------*/

local HideElementsTable = { 
 	-- DarkRP 
 	["DarkRP_HUD"]				= true, 
 	["DarkRP_EntityDisplay"] 	= false, 
 	["DarkRP_ZombieInfo"] 		= false, 
 	["DarkRP_LocalPlayerHUD"] 	= true, 
 	["DarkRP_Hungermod"] 		= true, 
 	["DarkRP_Agenda"] 			= true, 
 	-- GMod 
 	["CHudHealth"]				= true, 
 	["CHudBattery"]				= true, 
 	["CHudSuitPower"]			= true, 
 	["CHudAmmo"]				= true,
 	["CHudSecondaryAmmo"]		= true,
} 

local function HideElements( element )
	if HideElementsTable[ element ] then
		return false
	end
end
hook.Add ("HUDShouldDraw", "HideElements", HideElements)

/*----------------------------------
Variables for text alignment
----------------------------------*/

local TAL = TEXT_ALIGN_LEFT
local TAR = TEXT_ALIGN_RIGHT
local TAC = TEXT_ALIGN_CENTER

/*----------------------------------
Formating Number
----------------------------------*/

function FormatNumber( n )
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)	
	end
	return n
end

/*----------------------------------
Text Overflow, Not functional
----------------------------------*/

function TextOverflow( text, font, width )
	surface.SetFont(font)
	local ellipsissize = surface.GetTextSize("...")
	for len = 1, #text do 
		local substr = text:sub(1, len)
		local subsize = surface.GetTextSize(substr)
		if(subsize > width - ellipsissize) then
			return text:sub(1, len - 1) .. "..."
		end
	end
	return text
end

/*----------------------------------
HUD Elements
----------------------------------*/
local function HUDExtraText()
	draw.DrawText(HUDSettings.ExtraText1, HUDSettings.ExtraText1Font, HUDSettings.ExtraText1PosX, HUDSettings.ExtraText1PosY, HUDSettings.ColorExtraText1, HUDSettings.ExtraTextAlign1)
	draw.DrawText(HUDSettings.ExtraText2, HUDSettings.ExtraText2Font, HUDSettings.ExtraText2PosX, HUDSettings.ExtraText2PosY, HUDSettings.ColorExtraText2, HUDSettings.ExtraTextAlign2)
	draw.DrawText(HUDSettings.ExtraText3, HUDSettings.ExtraText3Font, HUDSettings.ExtraText3PosX, HUDSettings.ExtraText3PosY, HUDSettings.ColorExtraText3, HUDSettings.ExtraTextAlign3)	
	draw.DrawText(HUDSettings.ExtraText4, HUDSettings.ExtraText4Font, HUDSettings.ExtraText4PosX, HUDSettings.ExtraText4PosY, HUDSettings.ColorExtraText4, HUDSettings.ExtraTextAlign4)	
end

local function HUDPlayerInfo1()
	local PlayerName = LocalPlayer():Nick() or ""
	local PlayerSteamID = LocalPlayer():SteamID() or ""
	local PlayerJob  = LocalPlayer():getDarkRPVar("job") or ""
	local PlayerWallet = LocalPlayer():getDarkRPVar("money") or 0
	local PlayerSalary = LocalPlayer():getDarkRPVar("salary") or 0
	
	local PlayerWalletFormated 	= "$"..FormatNumber( PlayerWallet )
	local PlayerSalaryFormated 	= "$"..FormatNumber( PlayerSalary )
	
	draw.RoundedBoxEx(0, 10, ScrH() - 85, 256, 76, Color(255, 255, 255, 255))
	draw.DrawText(PlayerName, "Bebas45", 90, ScrH() - 85, Color(0,0,0,255), TAL)	
	if HUDSettings.PlayerDarkRP then draw.DrawText(PlayerJob, "Bebas45", 90, ScrH() - 50, Color(0,0,0,255), TAL) end
	
	if HUDSettings.PlayerDarkRP then draw.RoundedBoxEx(0, ScrW() / 2 - 150, ScrH() - 85, 300, 76, Color(255, 255, 255, 255)) end
	if HUDSettings.PlayerDarkRP then draw.DrawText(PlayerWalletFormated, "Bebas45", ScrW() / 2 , ScrH() - 85, Color(0,0,0,255), TAC)	end
	if HUDSettings.PlayerDarkRP then draw.DrawText(PlayerSalaryFormated, "Bebas45", ScrW() / 2, ScrH() - 50, Color(0,0,0,255), TAC)	end
end

local function HUDPlayerInfo2()
	draw.RoundedBoxEx(0, ScrW() - 270, ScrH() - 85, 256, 76, Color(255, 255, 255, 255))

	//Health
	if HUDSettings.PlayerHealth then
		draw.RoundedBox(0, ScrW() - 260, ScrH() - 79, 235, 20, Color(0,0,0,255))

		local DrawValue = LocalPlayer():Health() or 0
		local EchoValue = LocalPlayer():Health() or 0

		if DrawValue > 100 then DrawValue = 100 end
		if DrawValue < 0 then DrawValue = 0 end
			
		if DrawValue != 0 then
			draw.RoundedBox(0, ScrW() - 260, ScrH() - 79, (235) * DrawValue / 100, 20, Color(170, 0, 0, 255))
		end
		draw.DrawText("Health", "Bebas20", ScrW() - 255, ScrH() - 78, Color(255, 255, 255, 255), TAL)
		draw.DrawText(EchoValue.."%", "Bebas20", ScrW() - 30, ScrH() - 78, Color(255, 255, 255, 255), TAR)
	end

	//Armor
	if HUDSettings.PlayerArmor then
		draw.RoundedBox(0, ScrW() - 260, ScrH() - 57, 235, 20, Color(0,0,0,255))

		local DrawValue = LocalPlayer():Armor() or 0
		local EchoValue = LocalPlayer():Armor() or 0

		if DrawValue > 100 then DrawValue = 100 end
		if DrawValue < 0 then DrawValue = 0 end
			
		if DrawValue != 0 then
			draw.RoundedBox(0, ScrW() - 260, ScrH() - 57, (235) * DrawValue / 100, 20, Color(0, 0, 0, 255))
		end
		draw.DrawText("Armor", "Bebas20", ScrW() - 255, ScrH() - 56, Color(255, 255, 255, 255), TAL)
		draw.DrawText(EchoValue.."%", "Bebas20", ScrW() - 30, ScrH() - 56, Color(255, 255, 255, 255), TAR)
	end

	//Hunger (DarkRP)
	if HUDSettings.PlayerHunger then
		draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, 235, 20, Color(0,0,0,255))

		local DrawValue = math.ceil( LocalPlayer():getDarkRPVar( "Energy" ) or 0 )
		local EchoValue = math.ceil( LocalPlayer():getDarkRPVar( "Energy" ) or 0 )

		if DrawValue > 100 then DrawValue = 100 end
		if DrawValue < 0 then DrawValue = 0 end
		
		if DrawValue != 0 then
			draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, (235) * DrawValue / 100, 20, Color(170, 0, 0, 255))
		end
		draw.DrawText("Hunger", "Bebas20", ScrW() - 255, ScrH() - 34, Color(255, 255, 255, 255), TAL)
		draw.DrawText(EchoValue.."%", "Bebas20", ScrW() - 30, ScrH() - 34, Color(255, 255, 255, 255), TAR)
	else
		draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, 235, 20, Color(0,0,0,255))

		draw.DrawText("PLACEHOLDER", "Bebas20", ScrW() - 255, ScrH() - 34, Color(255, 255, 255, 255), TAL)
	end

	//Stamina (TCB)
	if HUDSettings.PlayerStamina == true then
		draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, 235, 20, Color(0,0,0,255))

		local DrawValue = math.ceil( LocalPlayer():GetNWInt("tcb_stamina") or 0 )
		local EchoValue = math.ceil( LocalPlayer():GetNWInt("tcb_stamina") or 0 )

		if DrawValue > 100 then DrawValue = 100 end
		if DrawValue < 0 then DrawValue = 0 end
		
		if DrawValue != 0 then
			draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, (235) * DrawValue / 100, 20, Color(0, 170, 0, 255))
		end
		draw.DrawText("Stamina", "Bebas20", ScrW() - 255, ScrH() - 34, Color(255, 255, 255, 255), TAL)
		draw.DrawText(EchoValue.."%", "Bebas20", ScrW() - 30, ScrH() - 34, Color(255, 255, 255, 255), TAR)
	else
		draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, 235, 20, Color(0,0,0,255))

		draw.DrawText("PLACEHOLDER", "Bebas20", ScrW() - 255, ScrH() - 34, Color(255, 255, 255, 255), TAL)
	end
end

local function HUDLevels()
	draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, 235, 20, Color(0,0,0,255))
	
	local MFPlayerLevel = LocalPlayer():getDarkRPVar('level') or 0
	local MFPlayerXP = LocalPlayer():getDarkRPVar('xp') or 0

	local XPPercent = ((MFPlayerXP or 0)/(((10+(((MFPlayerLevel or 1)*((MFPlayerLevel or 1)+1)*90))))*LevelSystemConfiguration.XPMult)) 

	local drawXP = Lerp(8*FrameTime(),OldXP,XPPercent)
	OldXP = drawXP
	
	local XPPercent2 = XPPercent*100
	XPPercent2 = math.Round(XPPercent2)
	XPPercent2 = math.Clamp(XPPercent2, 0, 99) //Make sure it doesn't round past 100%
		
	draw.RoundedBox(0, ScrW() - 260, ScrH() - 35, (235) * XPPercent2 / 100, 20, Color(0, 170, 0, 255))
	draw.DrawText("XP", "Bebas20", ScrW() - 255, ScrH() - 34, Color(255, 255, 255, 255), TAL)
	draw.DrawText(XPPercent2.."%", "Bebas20", ScrW() - 30, ScrH() - 34, Color(255, 255, 255, 255), TAR)
	//Draw Levels (Top right hand corner)
	draw.DrawText("Level: "..MFPlayerLevel, "Bebas60", ScrW() - 10, 0, Color(255, 255, 255, 255), TAR)
end

local function HUDMinimap()
	if HUDSettings.Minimap then
		if LocalPlayer():Alive() then
		draw.RoundedBox(0, ScrW() - 168, 12, 155, 155, Color(255,255,255,255))
			do
				local CamData = {}
				CamData.angles = Angle(90,LocalPlayer():EyeAngles().yaw,0)
				CamData.origin = Vector(LocalPlayer():GetPos().X,LocalPlayer():GetPos().Y,950)
				CamData.x = ScrW() - 165
				CamData.y = 15
				CamData.drawviewmodel = false
				CamData.w = 150
				CamData.h = 150
				render.RenderView( CamData )
				local Bullet = Material("icon16/bullet_black.png")
				surface.SetMaterial(Bullet)
				surface.SetDrawColor( 255, 255, 255, 255)
				surface.DrawTexturedRect(ScrW() - 160 + 150 / 2 - 8 , 10 + 150 / 2 - 8, 16, 16)
			end
		end
	end
end

local function HUDPlayerAvatar()
	local Avatar = vgui.Create( "AvatarImage", Panel )
	Avatar:SetSize( 64, 64 )
	Avatar:SetPos( 16, ScrH() - 80 )
	Avatar:SetPlayer( LocalPlayer(), 64 )
end

local function HUDAmmo()
   	if LocalPlayer():Alive() then 
   		local Ammo1 = LocalPlayer():GetActiveWeapon():Clip1() or 0
   		local Ammo2 = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) or 0

   		//if Ammo1 < 10 then Ammo1 = "0"..Ammo1 end
   		//if Ammo2 < 10 then Ammo2 = "0"..Ammo2 end

   		if Ammo1 and Ammo2 > 0 then
			draw.DrawText("Ammo: "..Ammo1.."|"..Ammo2, "Bebas50", ScrW() / 2, ScrH() - 130, Color(255,255,255,255), TAC)
		end
	end
end

local function HUDAgenda()
	local agenda = localplayer:getAgendaTable()
	if not agenda then return end
	agendaText = agendaText or DarkRP.textWrap((localplayer:getDarkRPVar("agenda") or ""):gsub("//", "\n"):gsub("\\n", "\n"), "Bebas20", 440)

	//draw.RoundedBox(0, 8, 8, 460, 110, Color(0, 0, 0, 200))
	draw.RoundedBox(0, 10, 10, 456, 106, Color(255, 255, 255, 150))
	draw.RoundedBox(0, 10, 10, 456, 20, Color(0, 0, 0, 255))

	draw.DrawNonParsedText(agenda.Title, "Bebas20", 14, 11, Color(255, 255, 255, 255), 0)
	draw.DrawNonParsedText(agendaText, "Bebas20", 14, 35, Color(0, 0, 0, 255), 0)
end

local function HUDLockdown()
	if GetGlobalBool("DarkRP_LockDown") then
		draw.RoundedBoxEx(0, ScrW() / 2 - 285, 10, 570, 28, Color(255, 255, 255, 255))
		local cin = (math.sin(CurTime()) + 1) / 2
		draw.DrawNonParsedText(DarkRP.getPhrase("lockdown_started"), "Bebas30", ScrW() / 2, 10, Color(cin * 255, 0, 255 - (cin * 255), 255), TAC)
	end
end

local Page = Material("icon16/page_white_text.png")
local Exclamation = Material("icon16/exclamation.png")
local function HUDWantedLicense()
	surface.SetMaterial(Page)
	surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawTexturedRect(270, ScrH() - 42, 32, 32)
	if localplayer:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(Page)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(270, ScrH() - 42, 32, 32)
	end

	surface.SetMaterial(Exclamation)
	surface.SetDrawColor(0,0,0,150)
	surface.DrawTexturedRect(305, ScrH() - 42, 32, 32)
	if LocalPlayer():getDarkRPVar("wanted") then
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(305, ScrH() - 42, 32, 32)	
	end
end

local HUDArrested = function() end
usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()

	HUDArrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and localplayer:getDarkRPVar("Arrested") then
			draw.RoundedBoxEx(0, ScrW() / 2 - 180, 1000, 360, 28, Color(255, 255, 255, 255))
			draw.DrawText(DarkRP.getPhrase("youre_arrested", math.ceil(ArrestedUntil - (CurTime() - StartArrested))), "Bebas30", ScrW() / 2, 1000, Color(0, 0, 0, 255), 1)
		elseif not localplayer:getDarkRPVar("Arrested") then
			Arrested = function() end
		end
	end
end)

local function LevelsAboveHeadDisplay_TEMP()
local shouldDraw, players = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_EntityDisplay")
	if shouldDraw == false then return end
	local shootPos = LocalPlayer():GetShootPos()
	local aimVec = LocalPlayer():GetAimVector()
	for k, ply in pairs(players or player.GetAll()) do
		if not ply:Alive() then continue end
		local hisPos = ply:GetShootPos()
		if GAMEMODE.Config.globalshow and ply ~= localplayer then
				local pos = ply:EyePos()
				pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
				pos = pos:ToScreen()
				pos.y = pos.y-20
				draw.DrawText('Level: '..(ply:getDarkRPVar('level') or 0), "DarkRPHUD2", pos.x+1, pos.y -56, Color(0,0,0,255), 1)
				draw.DrawText('Level: '..(ply:getDarkRPVar('level') or 0), "DarkRPHUD2", pos.x, pos.y -55, Color(255,255,255,200), 1)
		elseif not GAMEMODE.Config.globalshow and hisPos:Distance(shootPos) < 250 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()

				local trace = util.QuickTrace(shootPos, pos, localplayer)
				if trace.Hit and trace.Entity ~= ply then return end
					local pos = ply:EyePos()
					pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
					pos = pos:ToScreen()
					pos.y = pos.y-20
					draw.DrawText('Level: '..(ply:getDarkRPVar('level') or 0), "DarkRPHUD2", pos.x, pos.y -58, Color(0,0,0,255), 1)
					draw.DrawText('Level: '..(ply:getDarkRPVar('level') or 0), "DarkRPHUD2", pos.x+1, pos.y -57, Color(255,255,255,200), 1)
		end
	end
 
	local tr = LocalPlayer():GetEyeTrace()

end
/*----------------------------------
Drawing the HUD elements on the screen
----------------------------------*/

local function DrawHUD()
	localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
	if not IsValid(localplayer) then return end

	HUDExtraText()
	HUDPlayerInfo1()
	HUDPlayerInfo2()
	HUDLevels()
	HUDMinimap()
	HUDAmmo()
	HUDLockdown()
	HUDAgenda()
	HUDWantedLicense()
	HUDArrested()
	LevelsAboveHeadDisplay_TEMP()
end

hook.Add("HUDPaint", "DrawHUD", DrawHUD)
hook.Add("InitPostEntity", "HUDPlayerAvatar", function() HUDPlayerAvatar() end)
hook.Add("DarkRPVarChanged", "agendaHUD", function(ply, var, _, new)
	if ply ~= localplayer then return end
	if var == "agenda" and new then
		agendaText = DarkRP.textWrap(new:gsub("//", "\n"):gsub("\\n", "\n"), "DarkRPHUD1", 440)
	else
		agendaText = nil
	end
end)