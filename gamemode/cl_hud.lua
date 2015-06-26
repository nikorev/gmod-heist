
local function heisthud()
	if LocalPlayer():Alive() then
	
	-- PLAYER LIST TOP LEFT
		draw.RoundedBox(0, 50, 50, 300, 50, Color(189, 189, 189, 255))
		--draw.RoundedBox(0, 50, 100, 300, 250, Color(0, 0, 0, 200))
		draw.DrawText("SQUAD", "DermaLarge", 200, 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	
	
	-- HEALTH AND ARMOR
		draw.DrawText(LocalPlayer():Health(), "DermaLarge", 100, 65, Color(229, 115, 115, 255), TEXT_ALIGN_CENTER)
		draw.DrawText(LocalPlayer():Armor(), "DermaLarge", 300, 65, Color(121, 134, 203, 255), TEXT_ALIGN_CENTER)
		
	-- MONEY
		draw.DrawText("$5000", "Default", 200, 85, Color(197, 225, 165, 255), TEXT_ALIGN_CENTER)
		
	-- PLAYER COUNT	
		draw.DrawText(#player.GetAll().."\n PLAYERS", "TargetID", ScrW() / 2, ScrH() - 75, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		
		
		
	-- CROSSHAIR
		draw.RoundedBox(0, ScrW() / 2 - 1, ScrH() / 2 + 5, 2, 10, Color(255, 255, 255, 255))
		draw.RoundedBox(0, ScrW() / 2 - 1, ScrH() / 2 - 16, 2, 10, Color(255, 255, 255, 255))
		
		surface.DrawCircle( ScrW() / 2, ScrH() / 2, 10, Color(255, 255, 255, 255) )
		
		draw.RoundedBox(0, ScrW() / 2 + 5, ScrH() / 2 - 1, 10, 2, Color(255, 255, 255, 255))
		draw.RoundedBox(0, ScrW() / 2 - 16, ScrH() / 2 - 1, 10, 2, Color(255, 255, 255, 255))
		
	end
end
hook.Add("HUDPaint", "heisthud", heisthud)


local function HideThings( name )
	if(name == "CHudHealth") or (name == "CHudBattery") or (name == "CHudCrosshair") then
             return false
        end

end
hook.Add( "HUDShouldDraw", "HideThings", HideThings )


local function teamlistderma()

local NextThink = CurTime() + .1
local NextThink2 = CurTime() + .1


-- TEAM LIST
local basepanel = vgui.Create( "DFrame" )
basepanel:SetPos( 50, 100 )
basepanel:SetSize( 300, 250 )
basepanel:SetTitle( "" )
basepanel:SetDraggable( false )
basepanel:SetVisible(true)
basepanel:ShowCloseButton(false)
basepanel:ParentToHUD()

basepanel.Paint = function()

end

basepanel.Think = function()
	if !LocalPlayer():Alive() then
		basepanel:Close()
	end
end


-- SLIDE IN FRAME
local blackpanel = vgui.Create( "DScrollPanel", basepanel )
blackpanel:SetPos( 0, 0 )
blackpanel:SetSize( 300, 0 )
blackpanel:SetVisible(true)

blackpanel.Paint = function()
	draw.RoundedBox(0, 0, 0, 300, blackpanel:GetTall(), Color(0, 0, 0, 200))
end


blackpanel.Think = function()
	if CurTime() >= NextThink then
		if blackpanel:GetTall() != 250 then
			blackpanel:SetSize(300, blackpanel:GetTall() + 1)
			NextThink = CurTime() + .001
		else
			NextThink = 0
		end
	end
end
	

-- PLAYERS ON THE MENU
local playerpanel = vgui.Create( "DPanel", basepanel )
playerpanel:SetPos( 0, 0 )
playerpanel:SetSize( 300, 0 )
playerpanel:SetVisible(true)

blackpanel:AddItem(playerpanel)

playerpanel.Paint = function()
	--draw.RoundedBox(0, 0, 0, 300, playerpanel:GetTall(), Color(255, 0, 0, 200))
	draw.RoundedBox(0, 50, playerpanel:GetTall() / 2, 200, 2, Color(255, 255, 255, 25*(1+math.sin(CurTime()*5)*5.2)))
	draw.DrawText("LOADING", "Default", 50, playerpanel:GetTall() / 2 - 10, Color(255, 255, 255, 25*(1+math.sin(CurTime()*5)*5.2)))
end

playerpanel.Think = function()
	if CurTime() >= NextThink2 then
		if playerpanel:GetTall() != 45 then
			playerpanel:SetSize(300, playerpanel:GetTall() + 1)
			NextThink2 = CurTime() + .01
		else
			NextThink2 = 0
		end
	end
end

local playerpanel2 = vgui.Create( "DPanel", basepanel )
playerpanel2:SetPos( 0, 50 )
playerpanel2:SetSize( 300, 0 )
playerpanel2:SetVisible(true)

blackpanel:AddItem(playerpanel2)

playerpanel2.Paint = function()
	--draw.RoundedBox(0, 0, 0, 300, playerpanel2:GetTall(), Color(255, 0, 0, 200))
	draw.RoundedBox(0, 50, playerpanel2:GetTall() / 2, 200, 2, Color(255, 255, 255, 25*(1+math.sin(CurTime()*5)*5.2)))
	draw.DrawText("LOADING", "Default", 50, playerpanel2:GetTall() / 2 - 10, Color(255, 255, 255, 25*(1+math.sin(CurTime()*5)*5.2)))
end

playerpanel2.Think = function()
	if CurTime() >= NextThink2 then
		if playerpanel2:GetTall() != 45 then
			playerpanel2:SetSize(300, playerpanel2:GetTall() + 1)
			NextThink2 = CurTime() + .01
		else
			NextThink2 = 0
		end
	end
end





local playerpanel3 = vgui.Create( "DPanel", basepanel )
playerpanel3:SetPos( 0, 100 )
playerpanel3:SetSize( 300, 45 )
playerpanel3:SetVisible(true)

blackpanel:AddItem(playerpanel3)


playerpanel3.Paint = function()
	draw.DrawText(LocalPlayer():Nick(), "Default", 60, playerpanel3:GetTall() / 2 - 15, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
	draw.RoundedBox(0, 60, playerpanel3:GetTall() / 2, math.Clamp(LocalPlayer():Health()*2, 0, 200), 5, Color(255, 0, 0, 255))	
	draw.RoundedBox(0, 60, playerpanel3:GetTall() / 2 + 10, math.Clamp(LocalPlayer():Armor()*2, 0, 200), 5, Color(0, 0, 255, 255))
end


local Avatar = vgui.Create( "AvatarImage", playerpanel3 )
Avatar:SetSize( 32, 32 )
Avatar:SetPos( 10, playerpanel3:GetTall() / 2 - 16 )
Avatar:SetPlayer( LocalPlayer(), 32 )


end
net.Receive("openhudplayerlist", teamlistderma)
//concommand.Add("opendis", teamlistderma)
