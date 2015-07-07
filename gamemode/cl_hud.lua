
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
		draw.DrawText("$"..Inventory["Money"], "Default", 200, 85, Color(197, 225, 165, 255), TEXT_ALIGN_CENTER)
		
	-- PLAYER COUNT	
		draw.DrawText(#player.GetAll().."\n PLAYERS", "TargetID", ScrW() / 2, ScrH() - 75, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		
		
		
	-- CROSSHAIR
		draw.RoundedBox(0, ScrW() / 2 - 2, ScrH() / 2 + 5, 4, 10, Color(255, 255, 255, 255))
		draw.RoundedBox(0, ScrW() / 2 - 2, ScrH() / 2 - 16, 4, 10, Color(255, 255, 255, 255))
		
		--surface.DrawCircle( ScrW() / 2, ScrH() / 2, 25, Color(255, 255, 255, 255) )
		
		draw.RoundedBox(0, ScrW() / 2 + 5, ScrH() / 2 - 2, 10, 4, Color(255, 255, 255, 255))
		draw.RoundedBox(0, ScrW() / 2 - 16, ScrH() / 2 - 2, 10, 4, Color(255, 255, 255, 255))
		
		
		
	-- BUILD/VERSION
		draw.RoundedBox(0, ScrW() - 150, 25, 125, 30, Color(255, 0, 0, 25)) // DEV
		--draw.RoundedBox(0, ScrW() - 150, 25, 125, 30, Color(0, 0, 255, 25)) // BETA
		--draw.RoundedBox(0, ScrW() - 150, 25, 125, 30, Color(0, 255, 0, 25)) // RELEASE		
		
		draw.DrawText("Build 0.1", "Default", ScrW() - 90, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		draw.DrawText("6/28/15", "Default", ScrW() - 90, 40, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		
	end
end
hook.Add("HUDPaint", "heisthud", heisthud)


local function HideThings( name )
	if(name == "CHudHealth") or (name == "CHudBattery") or (name == "CHudCrosshair") then
             return false
        end

end
hook.Add( "HUDShouldDraw", "HideThings", HideThings )


local meta = FindMetaTable("Panel")

function meta:SetCardPlayer(ply)
	self.CardPlayer = ply
end

function meta:GetCardPlayer()
	return self.CardPlayer
end

local PlayerCard = {}
function PlayerCard:Init()
	self.loading = true
	
	
	self:SetSize(300, 45)
	self:SetPos(0, 100)
	
	timer.Simple(5, function()
		self.loading = false

		self.Avatar = vgui.Create("AvatarImage", self)
		self.Avatar:SetPlayer( self:GetCardPlayer(), 32 )
		self.Avatar:SetSize( 32, 32 )
		self.Avatar:SetPos( 10, self:GetTall() / 2 - 16 )
	
	end)
end

function PlayerCard:Think()
	if ( !IsValid( self:GetCardPlayer() ) ) then
		self:SetZPos( 9999 )
		self:Remove()
		return
	end
end

function PlayerCard:Paint()
	-- LOADING
	
	if self.loading then
	draw.RoundedBox(0, 50, self:GetTall() / 2, 200, 2, Color(255, 255, 255, 25*(1+math.sin(CurTime()*5)*5.2)))
	draw.DrawText("LOADING", "Default", 50, self:GetTall() / 2 - 10, Color(255, 255, 255, 25*(1+math.sin(CurTime()*5)*5.2)))
	return
	end
	
	-- PLAYER CARD
	draw.DrawText(self:GetCardPlayer():Nick(), "Default", 60, self:GetTall() / 2 - 15, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
	
	if !self:GetCardPlayer():Alive() then
		draw.DrawText("DEAD", "HudHintTextLarge", self:GetWide() / 2, self:GetTall() / 2 - 5, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER)
	else
	draw.RoundedBox(0, 60, self:GetTall() / 2, math.Clamp(self:GetCardPlayer():Health()*2, 0, 200), 5, Color(255, 0, 0, 255))	
	draw.RoundedBox(0, 60, self:GetTall() / 2 + 10, math.Clamp(self:GetCardPlayer():Armor()*2, 0, 200), 5, Color(0, 0, 255, 255))
	end
end

PlayerCard = vgui.RegisterTable(PlayerCard, "EditablePanel")


local function teamlistderma()


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
local blackpanel = vgui.Create( "DPanelList", basepanel )
blackpanel:SetPos( 0, 0 )
blackpanel:SetSize( 300, 250 )
blackpanel:SetSpacing(10)
blackpanel:SetPadding(5)
blackpanel:SetVisible(true)
blackpanel:EnableVerticalScrollbar( true )

function blackpanel:Think()
	for k,v in pairs(player.GetAll()) do
		if ( IsValid( v.CardEntry ) ) then continue end
		v.CardEntry = vgui.CreateFromTable( PlayerCard, v.CardEntry )
		v.CardEntry:SetCardPlayer(v)
		
		blackpanel:AddItem( v.CardEntry )
	end
end
blackpanel.Paint = function()
	draw.RoundedBox(0, 0, 0, 300, 250, Color(0, 0, 0, 200))
end
end
net.Receive("openhudplayerlist", teamlistderma)
//concommand.Add("opendis", teamlistderma)



